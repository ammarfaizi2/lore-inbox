Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbTBRGGy>; Tue, 18 Feb 2003 01:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbTBRGFU>; Tue, 18 Feb 2003 01:05:20 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:64936 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267674AbTBRGFN>; Tue, 18 Feb 2003 01:05:13 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Handle null OLD argument in nb85e_uart's nb85e_uart_set_termios function
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061509.2F73E37CC@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:09 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.62-uc0.orig/drivers/serial/nb85e_uart.c linux-2.5.62-uc0/drivers/serial/nb85e_uart.c
--- linux-2.5.62-uc0.orig/drivers/serial/nb85e_uart.c	2003-01-22 10:13:09.000000000 +0900
+++ linux-2.5.62-uc0/drivers/serial/nb85e_uart.c	2003-02-18 11:41:08.000000000 +0900
@@ -472,7 +472,8 @@
 	/* Restrict flags to legal values.  */
 	if ((cflags & CSIZE) != CS7 && (cflags & CSIZE) != CS8)
 		/* The new value of CSIZE is invalid, use the old value.  */
-		cflags = (cflags & ~CSIZE) | (old->c_cflag & CSIZE);
+		cflags = (cflags & ~CSIZE)
+			| (old ? (old->c_cflag & CSIZE) : CS8);
 
 	termios->c_cflag = cflags;
 
