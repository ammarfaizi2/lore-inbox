Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVIAWx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVIAWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbVIAWxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:46 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:40720 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030466AbVIAWxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:35 -0400
Message-Id: <200509012216.j81MGnSH011518@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/12] UML - tty fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:16:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a build breakage introduced by Alan's tty cleanups.  This should
be tied to that patch if possible.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/um/drivers/chan_kern.c	2005-09-01 15:52:25.000000000 -0400
+++ linux-2.6.13-mm1/arch/um/drivers/chan_kern.c	2005-09-01 15:52:31.000000000 -0400
@@ -161,9 +161,6 @@
 		}
 	}
 
-	if((tty->flip.flag_buf_ptr == NULL) || 
-	   (tty->flip.char_buf_ptr == NULL))
-		return;
 	tty_insert_flip_char(tty, ch, TTY_NORMAL);
 }
 
@@ -542,8 +539,8 @@
 		chan = list_entry(ele, struct chan, list);
 		if(!chan->input || (chan->ops->read == NULL)) continue;
 		do {
-			if((tty != NULL) && 
-			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
+			if((tty != NULL) &&
+			   !tty_buffer_request_room(tty, 1)){
 				schedule_work(task);
 				goto out;
 			}
@@ -572,14 +569,3 @@
  out:
 	if(tty) tty_flip_buffer_push(tty);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
 

