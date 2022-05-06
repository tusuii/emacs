(evil-mode 1)

(setq make-backup-files nil)

;;my default shell and terminal as ansai terminal
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
(global-set-key (kbd "C-x C-t") 'ansi-term)

(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(global-prettify-symbols-mode t)  ;;pretty symbols
(defalias 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq create-lockfiles nil)

(add-hook 'emacs-lisp-mode-hook
  (lambda ()
   (add-hook 'local-write-file-hooks 
	     'check-parens)))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(show-paren-mode 1)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(use-package async
  :ensure t
  :init (dired-async-mode 1))

(use-package projectile
  :ensure t
  :init
    (projectile-mode 1))

(global-set-key (kbd "<f5>") 'projectile-compile-project)

(use-package dashboard
  :ensure t
  :config
    (dashboard-setup-startup-hook)
    (setq dashboard-center-content t)
    (setq dashboard-startup-banner "~/.emacs.d/img/dashLogo.png")
    (setq dashboard-items '((recents  . 5)
                            (projects . 5)
                            (agenda . 5)))
    (setq dashboard-banner-logo-title "“Be tolerant with others and strict with yourself.” – Marcus Aurelius"))
    (setq dashboard-center-content t)

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(use-package avy
  :ensure t
  :bind
    ("M-s" . avy-goto-char))

(defun config-reload ()
  "Reloads ~/.emacs.d/config.org at runtime"
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package flycheck
  :ensure t)

(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :bind
  ("M-g" . magit-status))

(add-hook 'org-mode-hook
	    '(lambda ()
	       (visual-line-mode 1)))

(use-package company
  :ensure t
  :init
  :hook (after-init . global-company-mode))

(use-package vertico
  :ensure t
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

;; eww (the web browser)
(setq eww-download-directory "~/Downloads/"
      eww-desktop-remove-duplicates t
      eww-history-limit 20
      eww-search-prefix "https://lite.duckduckgo.com/lite/?q=")

(use-package simple-httpd
  :ensure t)

(use-package go-mode
  :ensure t
  :config
  (add-to-list 'exec-path "/usr/local/go/bin")
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook
    (lambda () 
	(local-set-key (kbd "C-c d") 'godoc-at-point)))
  (add-hook 'go-mode-hook
	    (lambda () 
	      (local-set-key (kbd "C-c 5") 'recompile)))
  (add-hook 'go-mode-hook
	    (lambda () 
	      (local-set-key (kbd "C-c 6") 'gofmt))))

(use-package company
  :ensure t
  :config
  (company-tng-configure-default)
  (setq company-go-insert-arguments nil)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 0))

(use-package company-go
  :ensure t
  :config
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends)
				 '(company-go))
			    (company-mode))))
