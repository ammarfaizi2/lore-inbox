Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWAPRUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWAPRUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAPRUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:20:46 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56990 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751134AbWAPRUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:20:46 -0500
Subject: PATCH: Remove unused code from rio_linux.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:24:47 +0000
Message-Id: <1137432287.15553.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rio_linux.c linux-2.6.15-git12/drivers/char/rio/rio_linux.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rio_linux.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rio_linux.c	2006-01-16 16:23:09.574952384 +0000
@@ -132,16 +132,6 @@
 */
 #define IRQ_RATE_LIMIT 200
 
-#if 0
-/* Not implemented */
-/* 
- * The following defines are mostly for testing purposes. But if you need
- * some nice reporting in your syslog, you can define them also.
- */
-#define RIO_REPORT_FIFO
-#define RIO_REPORT_OVERRUN
-#endif
-
 
 /* These constants are derived from SCO Source */
 static struct Conf
@@ -573,21 +563,6 @@
 
 	PortP = (struct Port *) ptr;
 	PortP->gs.tty = NULL;
-#if 0
-	port->gs.flags &= ~GS_ACTIVE;
-	if (!port->gs.tty) {
-		rio_dprintk(RIO_DBUG_TTY, "No tty.\n");
-		return;
-	}
-	if (!port->gs.tty->termios) {
-		rio_dprintk(RIO_DEBUG_TTY, "No termios.\n");
-		return;
-	}
-	if (port->gs.tty->termios->c_cflag & HUPCL) {
-		rio_setsignals(port, 0, 0);
-	}
-#endif
-
 	func_exit();
 }
 
@@ -663,11 +638,6 @@
 
 	rc = 0;
 	switch (cmd) {
-#if 0
-	case TIOCGSOFTCAR:
-		rc = put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0), (unsigned int *) arg);
-		break;
-#endif
 	case TIOCSSOFTCAR:
 		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
 			tty->termios->c_cflag = (tty->termios->c_cflag & ~CLOCAL) | (ival ? CLOCAL : 0);
@@ -709,36 +679,6 @@
 		if (access_ok(VERIFY_READ, (void *) arg, sizeof(struct serial_struct)))
 			rc = gs_setserial(&PortP->gs, (struct serial_struct *) arg);
 		break;
-#if 0
-		/*
-		 * note: these IOCTLs no longer reach here.  Use
-		 * tiocmset/tiocmget driver methods instead.  The
-		 * #if 0 disablement predates this comment.
-		 */
-	case TIOCMGET:
-		rc = -EFAULT;
-		if (access_ok(VERIFY_WRITE, (void *) arg, sizeof(unsigned int))) {
-			rc = 0;
-			ival = rio_getsignals(port);
-			put_user(ival, (unsigned int *) arg);
-		}
-		break;
-	case TIOCMBIS:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			rio_setsignals(port, ((ival & TIOCM_DTR) ? 1 : -1), ((ival & TIOCM_RTS) ? 1 : -1));
-		}
-		break;
-	case TIOCMBIC:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			rio_setsignals(port, ((ival & TIOCM_DTR) ? 0 : -1), ((ival & TIOCM_RTS) ? 0 : -1));
-		}
-		break;
-	case TIOCMSET:
-		if ((rc = get_user(ival, (unsigned int *) arg)) == 0) {
-			rio_setsignals(port, ((ival & TIOCM_DTR) ? 1 : 0), ((ival & TIOCM_RTS) ? 1 : 0));
-		}
-		break;
-#endif
 	default:
 		rc = -ENOIOCTLCMD;
 		break;

