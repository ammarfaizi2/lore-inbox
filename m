Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTBLNtj>; Wed, 12 Feb 2003 08:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBLNti>; Wed, 12 Feb 2003 08:49:38 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:37504 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267221AbTBLNr6>; Wed, 12 Feb 2003 08:47:58 -0500
Date: Wed, 12 Feb 2003 22:56:40 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (20/34) input-update
Message-ID: <20030212135640.GU1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (20/34).

Updates input driver for PC98 in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/drivers/input/keyboard/Kconfig linux98-2.5.54/drivers/input/keyboard/Kconfig
--- linux-2.5.50-ac1/drivers/input/keyboard/Kconfig	2003-01-04 10:47:57.000000000 +0900
+++ linux98-2.5.54/drivers/input/keyboard/Kconfig	2003-01-04 15:28:14.000000000 +0900
@@ -92,7 +92,7 @@
 
 config KEYBOARD_98KBD
 	tristate "NEC PC-9800 Keyboard support"
-	depends on PC9800 && INPUT && INPUT_KEYBOARD && SERIO
+	depends on X86_PC9800 && INPUT && INPUT_KEYBOARD && SERIO
 	help
 	  Say Y here if you want to use the NEC PC-9801/PC-9821 keyboard (or
 	  compatible) on your system. 
diff -Nru linux-2.5.50-ac1/drivers/input/mouse/98busmouse.c linux98-2.5.52/drivers/input/mouse/98busmouse.c
--- linux-2.5.50-ac1/drivers/input/mouse/98busmouse.c	2002-12-17 09:07:10.000000000 +0900
+++ linux98-2.5.52/drivers/input/mouse/98busmouse.c	2002-12-17 13:58:53.000000000 +0900
@@ -31,15 +31,16 @@
  * 
  */
 
-#include <asm/io.h>
-#include <asm/irq.h>
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
 
 MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
 MODULE_DESCRIPTION("PC-9801 busmouse driver");
diff -Nru linux-2.5.50-ac1/drivers/input/mouse/Kconfig linux98-2.5.54/drivers/input/mouse/Kconfig
--- linux-2.5.50-ac1/drivers/input/mouse/Kconfig	2003-01-04 10:47:57.000000000 +0900
+++ linux98-2.5.54/drivers/input/mouse/Kconfig	2003-01-04 15:31:55.000000000 +0900
@@ -123,7 +123,7 @@
 
 config MOUSE_PC9800
 	tristate "NEC PC-9800 busmouse"
-	depends on PC9800 && INPUT && INPUT_MOUSE && ISA
+	depends on X86_PC9800 && INPUT && INPUT_MOUSE && ISA
 	help
 	  Say Y here if you have NEC PC-9801/PC-9821 computer and want its
 	  native mouse supported.
diff -Nru linux-2.5.50-ac1/drivers/input/serio/98kbd-io.c linux98-2.5.52/drivers/input/serio/98kbd-io.c
--- linux-2.5.50-ac1/drivers/input/serio/98kbd-io.c	2002-12-17 09:07:10.000000000 +0900
+++ linux98-2.5.52/drivers/input/serio/98kbd-io.c	2002-12-17 14:01:05.000000000 +0900
@@ -11,16 +11,17 @@
  * the Free Software Foundation.
  */
 
-#include <asm/io.h>
-
+#include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/serio.h>
 #include <linux/sched.h>
 
+#include <asm/io.h>
+
 MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
 MODULE_DESCRIPTION("NEC PC-9801 keyboard controller driver");
 MODULE_LICENSE("GPL");
diff -Nru linux-2.5.50-ac1/drivers/input/serio/Kconfig linux98-2.5.57/drivers/input/serio/Kconfig
--- linux-2.5.50-ac1/drivers/input/serio/Kconfig	2003-01-14 09:33:34.000000000 +0900
+++ linux98-2.5.57/drivers/input/serio/Kconfig	2003-01-14 10:19:27.000000000 +0900
@@ -109,7 +109,7 @@
 
 config SERIO_98KBD
 	tristate "NEC PC-9800 keyboard controller"
-	depends on PC9800 && SERIO
+	depends on X86_PC9800 && SERIO
 	help
 	  Say Y here if you have the NEC PC-9801/PC-9821 and want to use its
 	  standard keyboard connected to its keyboard controller.
