Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSGYMaT>; Thu, 25 Jul 2002 08:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSGYMaT>; Thu, 25 Jul 2002 08:30:19 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:41098 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S311749AbSGYMaS>; Thu, 25 Jul 2002 08:30:18 -0400
Date: Thu, 25 Jul 2002 05:30:28 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: rmk@arm.linux.org.uk
Subject: [PATCH] fix unresolved syms for serial drivers, 2.5.28
Message-ID: <Pine.LNX.4.44.0207250520290.17973-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The following two patches seem to be needed to export the requisite 
symbols needed for fully modular builds of the new serial drivers in 
2.5.28.  Sound sane?

--- linux-2.5.28/drivers/serial/core.c~	Wed Jul 24 20:56:15 2002
+++ linux-2.5.28/drivers/serial/core.c	Wed Jul 24 23:40:31 2002
@@ -2469,6 +2469,8 @@
 EXPORT_SYMBOL(uart_unregister_driver);
 EXPORT_SYMBOL(uart_register_port);
 EXPORT_SYMBOL(uart_unregister_port);
+EXPORT_SYMBOL(uart_add_one_port);
+EXPORT_SYMBOL(uart_remove_one_port);
 
 MODULE_DESCRIPTION("Serial driver core");
 MODULE_LICENSE("GPL");


--- linux-2.5.28/drivers/char/tty_io.c~	Wed Jul 24 20:56:01 2002
+++ linux-2.5.28/drivers/char/tty_io.c	Wed Jul 24 23:41:31 2002
@@ -545,6 +545,7 @@
 #endif
 	do_tty_hangup((void *) tty);
 }
+EXPORT_SYMBOL(tty_vhangup);
 
 int tty_hung_up_p(struct file * filp)
 {


They can also be obtained here:
	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.28/


Craig Kulesa
Steward Obs.
Univ. of Arizona

