Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUCVKCC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUCVKAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:00:39 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:53338 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261857AbUCVKAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:00:19 -0500
Date: Mon, 22 Mar 2004 11:00:17 +0100
Message-Id: <200403221000.i2MA0Hgt004133@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 151] M68k keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing definitions for pc_keyb.c, which is used on Mac if the input
core is enabled (from Joshua Thompson, Ray Knight, and David D. Kilzer), and
fix up a resulting conflict with the Q40/Q60 keyboard driver.

--- linux-2.4.26-pre5/include/asm-m68k/keyboard.h	2003-08-26 12:22:41.000000000 +0200
+++ linux-m68k-2.4.26-pre5/include/asm-m68k/keyboard.h	2004-02-09 20:27:38.000000000 +0100
@@ -117,6 +117,11 @@
 #define kbd_request_region()
 #define kbd_request_irq(handler)
 
+/* How to access the keyboard macros on this platform.  */
+#define kbd_read_input() in_8(KBD_DATA_REG)
+#define kbd_read_status() in_8(KBD_STATUS_REG)
+#define kbd_write_output(val) out_8(KBD_DATA_REG, val)
+#define kbd_write_command(val) out_8(KBD_CNTL_REG, val)
 extern unsigned int SYSRQ_KEY;
 
 #endif	/* !CONFIG_TEKXP */
--- linux-2.4.26-pre5/drivers/char/q40_keyb.c	2002-09-13 10:16:02.000000000 +0200
+++ linux-m68k-2.4.26-pre5/drivers/char/q40_keyb.c	2004-02-27 10:09:39.000000000 +0100
@@ -400,7 +400,7 @@
 #define KBD_NO_DATA	(-1)	/* No data */
 #define KBD_BAD_DATA	(-2)	/* Parity or other error */
 
-static int __init kbd_read_input(void)
+static int __init q40kbd_read_input(void)
 {
 	int retval = KBD_NO_DATA;
 	unsigned char status;
@@ -421,7 +421,7 @@
 	int maxread = 100;	/* Random number */
 
 	do {
-		if (kbd_read_input() == KBD_NO_DATA)
+		if (q40kbd_read_input() == KBD_NO_DATA)
 			break;
 	} while (--maxread);
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
