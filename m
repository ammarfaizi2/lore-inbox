Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLNAVp>; Wed, 13 Dec 2000 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbQLNAVf>; Wed, 13 Dec 2000 19:21:35 -0500
Received: from zada.math.leidenuniv.nl ([132.229.231.3]:5392 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S129524AbQLNAVV>; Wed, 13 Dec 2000 19:21:21 -0500
Date: Thu, 14 Dec 2000 00:51:14 +0100 (MET)
From: Lennert Buytenhek <buytenh@gnu.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] bsd-style cursor
Message-ID: <Pine.LNX.4.30.0012140043170.17218-100000@mara.math.leidenuniv.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

included a patch against 2.4.0-test9 (should apply against latest but
haven't checked) which adds the config option to have a bsd-style cursor
in VT's by default. I was hoping it might be considered for inclusion so
that I don't have to patch it in myself every time :-)


cheers,
Lennert


--- linux-2.4.0-test9vm/include/linux/console_struct.h.old	Fri Dec  8 11:37:47 2000
+++ linux-2.4.0-test9vm/include/linux/console_struct.h	Fri Dec  8 11:37:29 2000
@@ -9,6 +9,8 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */

+#include <linux/config.h>
+
 #define NPAR 16

 struct vc_data {
@@ -104,6 +106,10 @@
 #define CUR_HWMASK	0x0f
 #define CUR_SWMASK	0xfff0

+#ifndef CONFIG_VT_BSD_CURSOR
 #define CUR_DEFAULT CUR_UNDERLINE
+#else
+#define CUR_DEFAULT 0x7f11
+#endif

 #define CON_IS_VISIBLE(conp) (*conp->vc_display_fg == conp)
--- linux-2.4.0-test9vm/drivers/char/Config.in.old	Fri Dec  8 11:38:29 2000
+++ linux-2.4.0-test9vm/drivers/char/Config.in	Fri Dec  8 11:38:24 2000
@@ -7,6 +7,7 @@
 bool 'Virtual terminal' CONFIG_VT
 if [ "$CONFIG_VT" = "y" ]; then
    bool '  Support for console on virtual terminal' CONFIG_VT_CONSOLE
+   bool '  BSD-style cursor' CONFIG_VT_BSD_CURSOR
 fi
 tristate 'Standard/generic (8250/16550 and compatible UARTs) serial support' CONFIG_SERIAL
 if [ "$CONFIG_SERIAL" = "y" ]; then
--- linux-2.4.0-test9vm/arch/i386/defconfig.old	Fri Dec  8 11:39:19 2000
+++ linux-2.4.0-test9vm/arch/i386/defconfig	Fri Dec  8 11:38:57 2000
@@ -450,6 +450,7 @@
 #
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
+# CONFIG_VT_BSD_CURSOR is not set
 CONFIG_SERIAL=y
 # CONFIG_SERIAL_CONSOLE is not set
 # CONFIG_SERIAL_EXTENDED is not set
--- linux-2.4.0-test9vm/Documentation/Configure.help.old	Fri Dec  8 11:40:47 2000
+++ linux-2.4.0-test9vm/Documentation/Configure.help	Fri Dec  8 11:43:43 2000
@@ -11931,6 +11931,13 @@

   If unsure, say Y.

+BSD-style cursor
+CONFIG_VT_BSD_CURSOR
+  If you say Y here, the cursor style for virtual terminals will default to
+  a non-blinking block (BSD-style).
+
+  If you have a strong dislike of BSD, say N here.
+
 Support for PowerMac keyboard
 CONFIG_MAC_KEYBOARD
   This option allows you to use an ADB keyboard attached to your

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
