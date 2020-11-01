(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(org-agenda-files
   (quote
    ("~/Zettelkasten/2020-10-28-1608 daring greatly.org")))
 '(package-selected-packages
   (quote
    (workgroups2 org-ref helm-bibtex zetteldeft helm yasnippet-snippets yasnippet org-bullets deft use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Mono" :foundry "CTDB" :slant normal :weight normal :height 181 :width normal)))))

;; deft

(use-package deft
  :init
  (setq deft-extensions '("txt" "markdown" "md" "org"))
  (setq deft-directory "~/Zettelkasten")
  (setq deft-recursive t)
  (setq deft-extensions '("org"))
  (setq deft-default-extension "org")
  (setq deft-text-mode 'org-mode)
  (setq deft-use-filename-as-title t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-auto-save-interval 10)
  (global-set-key (kbd "C-c d") 'deft)  
  )

(defun refresh-emacs ()
   (interactive)
   (load-file "~/.emacs")
)
(global-set-key (kbd "C-c e") #'refresh-emacs)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(load-theme 'tango-dark)

(use-package yasnippet
  :init
  (yas-global-mode 1)
  (setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/yas")))			       
  (yas-reload-all)
)

(use-package yasnippet-snippets
  :after yasnippet
)

(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring)
	 ("C-x b" . helm-mini))
  :config
  (helm-mode 1))

(setq org-support-shift-select 'always)

(setq inhibit-startup-message t)

(use-package zetteldeft
  :ensure t
  :after deft
  :config (zetteldeft-set-classic-keybindings))

(fset 'yes-or-no-p 'y-or-n-p)

(with-eval-after-load 'deft
  (define-key deft-mode-map (kbd "C-c RET") 'zetteldeft-new-file)
  )
;; (global-set-key (kbd "C-c RET") #'zetteldeft-new-file)

(use-package helm-bibtex
:config
(autoload 'helm-bibtex "helm-bibtex" "" t)
(setq bibtex-completion-bibliography '("~/Zettelkasten/bib.bib"))
;; (setq bibtex-completion-notes-path "~/dev/dotfiles/bib_notes.org")
(setq bibtex-completion-cite-prompt-for-optional-arguments nil)
(setq bibtex-completion-format-citation-functions
'((org-mode      . bibtex-completion-format-citation-org-link-to-PDF)
(latex-mode    . bibtex-completion-format-citation-cite)
(markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
(default       . bibtex-completion-format-citation-pandoc-citeproc)))

;; make bibtex-completion-insert-citation the default action

(helm-delete-action-from-source "Insert citation" helm-source-bibtex)
(helm-add-action-to-source "Insert citation" 'helm-bibtex-insert-citation helm-source-bibtex 0)
(global-set-key (kbd "C-c x") 'helm-bibtex)
)

(use-package org-ref
  :config
  (setq reftex-default-bibliography "~/Zettelkasten/bib.bib")
  (setq org-ref-default-bibliography "~/Zettelkasten/bib.bib")
)

(global-visual-line-mode t)

(setq org-startup-with-inline-images t)

(setq zetteldeft-home-id "2020-10-31-2007")

(require 'workgroups2)

(deft)

(workgroups-mode 1)

