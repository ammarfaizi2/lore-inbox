Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286471AbRLTXwd>; Thu, 20 Dec 2001 18:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286474AbRLTXwY>; Thu, 20 Dec 2001 18:52:24 -0500
Received: from ns01.netrox.net ([64.118.231.130]:57318 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S286471AbRLTXwN>;
	Thu, 20 Dec 2001 18:52:13 -0500
Subject: [PATCH] G550 config entry/help
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 18:50:42 -0500
Message-Id: <1008892244.938.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was confused how to get the framebuffer working on my Matrox G550
until Dave Jones kindly pointed out that the G450 driver works. 
Additionally, there are other issues wrt to the second head and analog
output that should be documented.

The attached patch, which applies to 2.4.17-rc2 and 2.5.2-pre1, updates
the configure entry and help appropriately.  Linus and Marcelo, please
apply.

	Robert Love

diff -urN linux-2.4.17-rc2/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.17-rc2/Documentation/Configure.help	Wed Dec 19 03:18:34 2001
+++ linux/Documentation/Configure.help	Thu Dec 20 18:34:59 2001
@@ -4350,11 +4350,9 @@
 
 Matrox unified accelerated driver
 CONFIG_FB_MATROX
-  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
-  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
-  Mystique G200, Matrox Millennium G200, Matrox Marvel G200 video,
-  Matrox G400 or G450 card in your box. At this time, support for the
-  G100 is untested and support for G450 is highly experimental.
+  Say Y here if you have a Matrox Millennium, Millennium II, Mystique,
+  Mystique 220, Productiva G100, Mystique G200, Millennium G200,
+  Marvel G200 video, G400, G450, or G550 card in your box.
 
   This driver is also available as a module ( = code which can be
   inserted and removed from the running kernel whenever you want).
@@ -4381,12 +4379,12 @@
   packed pixel and 32 bpp packed pixel. You can also use font widths
   different from 8.
 
-Matrox G100/G200/G400/G450 support
+Matrox G100/G200/G400/G450/G550 support
 CONFIG_FB_MATROX_G100
-  Say Y here if you have a Matrox G100, G200, G400 or G450 based
-  video card. If you select "Advanced lowlevel driver options", you
-  should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp packed
-  pixel and 32 bpp packed pixel. You can also use font widths
+  Say Y here if you have a Matrox G100, G200, G400, G450, or G550
+  based video card. If you select "Advanced lowlevel driver options",
+  you should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp
+  packed pixel and 32 bpp packed pixel. You can also use font widths
   different from 8.
 
   If you need support for G400 secondary head, you must first say Y to
@@ -4394,6 +4392,9 @@
   section, and then to "Matrox I2C support" and "G400 second head
   support" here in the framebuffer section.
 
+  If you need support for G450 or G550 secondary head, say Y to
+  "Matrox G450/G550 second head support" below.
+
 Matrox I2C support
 CONFIG_FB_MATROX_I2C
   This drivers creates I2C buses which are needed for accessing the
@@ -4440,7 +4441,7 @@
 Matrox G450 second head support
 CONFIG_FB_MATROX_G450
   Say Y or M here if you want to use a secondary head (meaning two
-  monitors in parallel) on G450.
+  monitors in parallel) on G450 or G550.
 
   If you compile it as module, two modules are created,
   matroxfb_crtc2.o and matroxfb_g450.o. Both modules are needed if you
@@ -4452,6 +4453,9 @@
   primary and secondary head outputs.  Secondary head driver always
   start in 640x480 resolution and you must use fbset to change it.
 
+  Note on most G550 cards the analog output is the secondary head,
+  so you will need to say Y here to use it.
+
   Also do not forget that second head supports only 16 and 32 bpp
   packed pixels, so it is a good idea to compile them into the kernel
   too. You can use only some font widths, as the driver uses generic
diff -urN linux-2.4.17-rc2/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.4.17-rc2/drivers/video/Config.in	Wed Dec 19 03:17:57 2001
+++ linux/drivers/video/Config.in	Thu Dec 20 17:23:57 2001
@@ -121,14 +121,14 @@
 	 if [ "$CONFIG_FB_MATROX" != "n" ]; then
 	    bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
 	    bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
-	    bool '    G100/G200/G400/G450 support' CONFIG_FB_MATROX_G100
+	    bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G100
             if [ "$CONFIG_I2C" != "n" ]; then
 	       dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
 	       if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
 	          dep_tristate '      G400 second head support' CONFIG_FB_MATROX_MAVEN $CONFIG_FB_MATROX_I2C
 	       fi
             fi
-            dep_tristate '      G450 second head support' CONFIG_FB_MATROX_G450 $CONFIG_FB_MATROX_G100
+            dep_tristate '      G450/G550 second head support' CONFIG_FB_MATROX_G450 $CONFIG_FB_MATROX_G100
 	    bool '    Multihead support' CONFIG_FB_MATROX_MULTIHEAD
 	 fi
 	 tristate '  ATI Mach64 display support (EXPERIMENTAL)' CONFIG_FB_ATY

