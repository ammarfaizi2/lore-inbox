Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTJFJa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTJFJ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:27:59 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:63963 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263987AbTJFJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:26:49 -0400
Date: Mon, 6 Oct 2003 11:26:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/7): ctc driver.
Message-ID: <20031006092600.GE1786@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Janitors: remove unnecessary calls to verify_area.

diffstat:
 drivers/s390/net/ctctty.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-s390/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	Sun Sep 28 02:50:28 2003
+++ linux-2.6-s390/drivers/s390/net/ctctty.c	Mon Oct  6 10:59:26 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.12 2003/06/17 11:36:44 mschwide Exp $
+ * $Id: ctctty.c,v 1.13 2003/09/26 14:48:36 mschwide Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -758,7 +758,7 @@
 			printk(KERN_DEBUG "%s%d ioctl TIOCGSOFTCAR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
-			error = verify_area(VERIFY_WRITE, (void *) arg, sizeof(long));
+			error = put_user(C_CLOCAL(tty) ? 1 : 0, (ulong *) arg);
 			if (error)
 				return error;
 			put_user(C_CLOCAL(tty) ? 1 : 0, (ulong *) arg);
@@ -768,10 +768,9 @@
 			printk(KERN_DEBUG "%s%d ioctl TIOCSSOFTCAR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
-			error = verify_area(VERIFY_READ, (void *) arg, sizeof(long));
+			error = get_user(arg, (ulong *) arg);
 			if (error)
 				return error;
-			get_user(arg, (ulong *) arg);
 			tty->termios->c_cflag =
 			    ((tty->termios->c_cflag & ~CLOCAL) |
 			     (arg ? CLOCAL : 0));
