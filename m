Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268678AbTCCR7P>; Mon, 3 Mar 2003 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268680AbTCCR7P>; Mon, 3 Mar 2003 12:59:15 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:58817
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S268678AbTCCR7O>; Mon, 3 Mar 2003 12:59:14 -0500
Date: Mon, 3 Mar 2003 13:09:32 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: torvalds@transmeta.com
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] small tty irq race fix
Message-ID: <Pine.LNX.4.44.0303031305130.31566-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.63/drivers/char/tty_io.c.orig	Mon Feb 24 14:05:34 2003
+++ linux-2.5.63/drivers/char/tty_io.c	Mon Mar  3 13:02:31 2003
@@ -1947,17 +1947,17 @@
 	if (tty->flip.buf_num) {
 		cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
-		tty->flip.buf_num = 0;
 
 		local_irq_save(flags); // FIXME: is this safe?
+		tty->flip.buf_num = 0;
 		tty->flip.char_buf_ptr = tty->flip.char_buf;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	} else {
 		cp = tty->flip.char_buf;
 		fp = tty->flip.flag_buf;
-		tty->flip.buf_num = 1;
 
 		local_irq_save(flags); // FIXME: is this safe?
+		tty->flip.buf_num = 1;
 		tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
 		tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
 	}


Nicolas


