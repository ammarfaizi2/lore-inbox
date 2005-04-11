Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVDKWSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVDKWSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVDKWQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:16:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32530 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261964AbVDKWPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:15:32 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix comments in 8250.c
X-Patch-Ref: 01-fixes/04-8250-comments
Message-Id: <E1DL7Bn-0003CC-73@raistlin.arm.linux.org.uk>
Date: Mon, 11 Apr 2005 23:15:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the formatting of some comments in 8250.c, and add a note
that the register_serial / unregister_serial shouldn't be used
in new code.

We do this here in preference to adding to linux/serial.h, since
that is used by a number of non-8250 drivers which pretend to be
8250.  It is not known whether it would be appropriate to do so.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/drivers/serial/8250.c linux/drivers/serial/8250.c
--- orig/drivers/serial/8250.c	Mon Apr  4 22:54:05 2005
+++ linux/drivers/serial/8250.c	Mon Apr 11 20:41:22 2005
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

