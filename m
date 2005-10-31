Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVJaKVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVJaKVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVJaKVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:21:48 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:45449 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932483AbVJaKVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:21:47 -0500
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] serial moxa: cleanup mxser_init
Date: Mon, 31 Oct 2005 13:21:24 +0300
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200510311321.25185.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove explicit tty_driver ops initialisation,
because this is already done by tty_set_operations.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.14/drivers/char/mxser.c
===================================================================
--- linux-2.6.14.orig/drivers/char/mxser.c	2005-10-30 13:57:41.000000000 +0300
+++ linux-2.6.14/drivers/char/mxser.c	2005-10-31 10:19:25.000000000 +0300
@@ -470,6 +470,8 @@
 	.stop = mxser_stop,
 	.start = mxser_start,
 	.hangup = mxser_hangup,
+	.break_ctl = mxser_rs_break,
+	.wait_until_sent = mxser_wait_until_sent,
 	.tiocmget = mxser_tiocmget,
 	.tiocmset = mxser_tiocmset,
 };
@@ -722,24 +724,6 @@
 	mxvar_sdriver->termios = mxvar_termios;
 	mxvar_sdriver->termios_locked = mxvar_termios_locked;
 
-	mxvar_sdriver->open = mxser_open;
-	mxvar_sdriver->close = mxser_close;
-	mxvar_sdriver->write = mxser_write;
-	mxvar_sdriver->put_char = mxser_put_char;
-	mxvar_sdriver->flush_chars = mxser_flush_chars;
-	mxvar_sdriver->write_room = mxser_write_room;
-	mxvar_sdriver->chars_in_buffer = mxser_chars_in_buffer;
-	mxvar_sdriver->flush_buffer = mxser_flush_buffer;
-	mxvar_sdriver->ioctl = mxser_ioctl;
-	mxvar_sdriver->throttle = mxser_throttle;
-	mxvar_sdriver->unthrottle = mxser_unthrottle;
-	mxvar_sdriver->set_termios = mxser_set_termios;
-	mxvar_sdriver->stop = mxser_stop;
-	mxvar_sdriver->start = mxser_start;
-	mxvar_sdriver->hangup = mxser_hangup;
-	mxvar_sdriver->break_ctl = mxser_rs_break;
-	mxvar_sdriver->wait_until_sent = mxser_wait_until_sent;
-
 	mxvar_diagflag = 0;
 	memset(mxvar_table, 0, MXSER_PORTS * sizeof(struct mxser_struct));
 	memset(&mxvar_log, 0, sizeof(struct mxser_log));

