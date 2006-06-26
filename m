Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWFZOke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWFZOke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWFZOke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:40:34 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:5573
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030237AbWFZOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:40:33 -0400
Subject: [PATCH] tty fix TCSBRK comment
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 09:40:26 -0500
Message-Id: <1151332826.5186.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix TCSBRK comment to prevent confusion or accidental removal.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/tty_io.c	2006-06-23 15:46:55.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-06-26 09:34:09.000000000 -0500
@@ -2617,10 +2617,9 @@ int tty_ioctl(struct inode * inode, stru
 			tty->driver->break_ctl(tty, 0);
 			return 0;
 		case TCSBRK:   /* SVID version: non-zero arg --> no break */
-			/*
-			 * XXX is the above comment correct, or the
-			 * code below correct?  Is this ioctl used at
-			 * all by anyone?
+			/* non-zero arg means wait for all output data
+			 * to be sent (performed above) but don't send break.
+			 * This is used by the tcdrain() termios function.
 			 */
 			if (!arg)
 				return send_break(tty, 250);


