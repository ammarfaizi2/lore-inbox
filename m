Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263024AbTCSMXD>; Wed, 19 Mar 2003 07:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263019AbTCSMVR>; Wed, 19 Mar 2003 07:21:17 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:54408 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263006AbTCSMSl>;
	Wed, 19 Mar 2003 07:18:41 -0500
Date: Wed, 19 Mar 2003 13:29:39 +0100 (MET)
Message-Id: <200303191229.h2JCTdd01021@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] console_initcall() return type
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix return type (must be int, not void) of *_console_init() after introduction
of console_initcall() in 2.5.x.

--- linux-2.5.x/drivers/char/amiserial.c	Tue Mar 18 13:06:15 2003
+++ linux-m68k-2.5.x/drivers/char/amiserial.c	Tue Mar 18 15:40:48 2003
@@ -2305,9 +2305,10 @@
 /*
  *	Register console.
  */
-static void __init amiserial_console_init(void)
+static int __init amiserial_console_init(void)
 {
 	register_console(&sercons);
+	return 0;
 }
 console_initcall(amiserial_console_init);
 #endif
--- linux-2.5.x/drivers/char/decserial.c	Tue Mar 18 11:27:22 2003
+++ linux-m68k-2.5.x/drivers/char/decserial.c	Tue Mar 18 15:43:01 2003
@@ -75,7 +75,7 @@
 /* serial_console_init handles the special case of starting
  *   up the console on the serial port
  */
-static void __init decserial_console_init(void)
+static int __init decserial_console_init(void)
 {
 #if defined(CONFIG_ZS) && defined(CONFIG_DZ)
     if (IOASIC)
@@ -93,6 +93,7 @@
 #endif
 
 #endif
+    return 0;
 }
 console_initcall(decserial_console_init);
 
--- linux-2.5.x/drivers/char/serial167.c	Tue Mar 18 11:27:23 2003
+++ linux-m68k-2.5.x/drivers/char/serial167.c	Tue Mar 18 15:43:19 2003
@@ -2836,7 +2836,7 @@
 };
 
 
-static void __init serial167_console_init(void)
+static int __init serial167_console_init(void)
 {
 	if (vme_brdtype == VME_TYPE_MVME166 ||
 			vme_brdtype == VME_TYPE_MVME167 ||
@@ -2844,6 +2844,7 @@
 		mvme167_serial_console_setup(0);
 		register_console(&sercons);
 	}
+	return 0;
 }
 console_initcall(serial167_console_init);
 
--- linux-2.5.x/drivers/char/serial_tx3912.c	Tue Mar 18 11:27:23 2003
+++ linux-m68k-2.5.x/drivers/char/serial_tx3912.c	Tue Mar 18 15:43:35 2003
@@ -1054,9 +1054,10 @@
 	.index    = -1
 };
 
-static void __init tx3912_console_init(void)
+static int __init tx3912_console_init(void)
 {
 	register_console(&sercons);
+	return 0;
 }
 console_initcall(tx3912_console_init);
 
--- linux-2.5.x/drivers/char/sh-sci.c	Tue Mar 18 11:27:23 2003
+++ linux-m68k-2.5.x/drivers/char/sh-sci.c	Tue Mar 18 15:43:51 2003
@@ -1275,7 +1275,7 @@
 extern void sh_console_unregister (void);
 #endif
 
-static void __init sci_console_init(void)
+static int __init sci_console_init(void)
 {
 	register_console(&sercons);
 #ifdef CONFIG_SH_EARLY_PRINTK
@@ -1284,6 +1284,7 @@
 	 */
 	sh_console_unregister();
 #endif
+	return 0;
 }
 console_initcall(sci_console_init);
 
--- linux-2.5.x/drivers/char/vme_scc.c	Tue Mar 18 11:27:23 2003
+++ linux-m68k-2.5.x/drivers/char/vme_scc.c	Tue Mar 18 15:44:08 2003
@@ -1091,7 +1091,7 @@
 };
 
 
-static void __init vme_scc_console_init(void)
+static int __init vme_scc_console_init(void)
 {
 	if (vme_brdtype == VME_TYPE_MVME147 ||
 			vme_brdtype == VME_TYPE_MVME162 ||
@@ -1099,5 +1099,6 @@
 			vme_brdtype == VME_TYPE_BVME4000 ||
 			vme_brdtype == VME_TYPE_BVME6000)
 		register_console(&sercons);
+	return 0;
 }
 console_initcall(vme_scc_console_init);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
