Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWJ3UFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWJ3UFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWJ3UFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:05:14 -0500
Received: from [198.99.130.12] ([198.99.130.12]:13710 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030588AbWJ3UFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:07 -0500
Message-Id: <200610302103.k9UL304S006244@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/3] UML - fix ->set_termios declaration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Oct 2006 16:03:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'old' argument of tty_operations->set_termios changed from struct
termios to struct ktermios.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2006-10-30 12:57:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2006-10-30 12:59:16.000000000 -0500
@@ -246,7 +246,7 @@ out_up:
 	return ret;
 }
 
-void line_set_termios(struct tty_struct *tty, struct termios * old)
+void line_set_termios(struct tty_struct *tty, struct ktermios * old)
 {
 	/* nothing */
 }
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-10-30 12:57:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2006-10-30 12:59:16.000000000 -0500
@@ -76,7 +76,7 @@ extern int line_setup(struct line *lines
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
 extern void line_put_char(struct tty_struct *tty, unsigned char ch);
-extern void line_set_termios(struct tty_struct *tty, struct termios * old);
+extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
 extern int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);

