Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSIBKN2>; Mon, 2 Sep 2002 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSIBKN2>; Mon, 2 Sep 2002 06:13:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33482 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318259AbSIBKN0>;
	Mon, 2 Sep 2002 06:13:26 -0400
Date: Mon, 02 Sep 2002 03:11:23 -0700 (PDT)
Message-Id: <20020902.031123.04737167.davem@redhat.com>
To: phillips@arcor.de
Cc: wli@holomorphy.com, rml@tech9.net, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17loGE-0004gS-00@starship>
References: <E17loBW-0004gM-00@starship>
	<20020902.030553.14354294.davem@redhat.com>
	<E17loGE-0004gS-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Mon, 2 Sep 2002 12:16:45 +0200
   
   Admit it, you never wrote a line of lisp ;-)
   
Oh contraire:

;;  The most important function in this file. Use it wisely.
(defun grrr (object)
  "Growl at OBJECT"
  (interactive "sWhat are you mad at: ")
  (if (equal object "")
      (message "You growl at %s" (buffer-name))
    (message "You growl at %s" object)))

(defun xyzzy () (interactive) (message "nothing happens"))

;;  Defun needed for rmail growling hack below.
;;
(defun growl-at-from ()
  "Search for from header in mail and growl at that person"
  (save-excursion
    (save-excursion
      (goto-char 0)
      (let ((case-fold-search t))
	(setq from-location (search-forward "From:" nil))
	(setq from-location (+ from-location 1))
	(end-of-line)
	(setq end-of-from-string (point))
	(grrr (buffer-substring from-location end-of-from-string))))))

(add-hook 'rmail-show-message-hook 'growl-at-from)

;;  Magic defun to grrr at people who send you mail.
(defun rmail-maybe-set-message-counters ()
  "Same as normal defun in rmail.el except here
we growl at whoever the mail is from.  Pretty crufty eh?"
  (if (not (and rmail-deleted-vector
		rmail-message-vector
		rmail-current-message
		rmail-total-messages))
      (rmail-set-message-counters))
  (growl-at-from))
