Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVDLLK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVDLLK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVDLLKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:10:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:64714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262293AbVDLKdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:55 -0400
Message-Id: <200504121033.j3CAXeBv005944@shell0.pdx.osdl.net>
Subject: [patch 195/198] serial: fix comments in 8250.c
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rmk@arm.linux.org.uk
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Russell King <rmk+lkml@arm.linux.org.uk>

Fix the formatting of some comments in 8250.c, and add a note that the
register_serial / unregister_serial shouldn't be used in new code.

We do this here in preference to adding to linux/serial.h, since that is used
by a number of non-8250 drivers which pretend to be 8250.  It is not known
whether it would be appropriate to do so.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/serial/8250.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff -puN drivers/serial/8250.c~serial-fix-comments-in-8250c drivers/serial/8250.c
--- 25/drivers/serial/8250.c~serial-fix-comments-in-8250c	2005-04-12 03:21:49.797566520 -0700
+++ 25-akpm/drivers/serial/8250.c	2005-04-12 03:21:49.801565912 -0700
@@ -1065,8 +1065,10 @@ receive_chars(struct uart_8250_port *up,
 				tty_flip_buffer_push(tty);
 				spin_lock(&up->port.lock);
 			}
-			/* If this failed then we will throw away the
-			   bytes but must do so to clear interrupts */
+			/*
+			 * If this failed then we will throw away the
+			 * bytes but must do so to clear interrupts
+			 */
 		}
 		ch = serial_inp(up, UART_RX);
 		flag = TTY_NORMAL;
@@ -1106,7 +1108,7 @@ receive_chars(struct uart_8250_port *up,
 				up->port.icount.overrun++;
 
 			/*
-			 * Mask off conditions which should be ingored.
+			 * Mask off conditions which should be ignored.
 			 */
 			lsr &= up->port.read_status_mask;
 
@@ -2570,6 +2572,9 @@ MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
  *	If this fails an error is returned.
  *
  *	On success the port is ready to use and the line number is returned.
+ *
+ *	Note: this function is deprecated - use serial8250_register_port
+ *	instead.
  */
 int register_serial(struct serial_struct *req)
 {
@@ -2624,6 +2629,9 @@ EXPORT_SYMBOL(register_serial);
  *
  *	Remove one serial port.  This may not be called from interrupt
  *	context.  We hand the port back to our local PM control.
+ *
+ *	Note: this function is deprecated - use serial8250_unregister_port
+ *	instead.
  */
 void unregister_serial(int line)
 {
_
