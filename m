Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQKUNDs>; Tue, 21 Nov 2000 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbQKUNDh>; Tue, 21 Nov 2000 08:03:37 -0500
Received: from mail.sonytel.be ([193.74.243.200]:46823 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S130406AbQKUND0>;
	Tue, 21 Nov 2000 08:03:26 -0500
Date: Tue, 21 Nov 2000 13:32:49 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Config.in fixes
Message-ID: <Pine.GSO.4.10.10011211327400.14139-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch fixes various Config.in files for the m68k platform.

Changes:
  - Fix indentation in drivers/ide/Config.in
  - Add Q40 IDE driver to drivers/ide/Config.in
  - Add Amiga SCSI drivers to drivers/scsi/Config.in (all protected by tests
    for CONFIG_AMIGA or CONFIG_ZORRO)
  - Fix incorrect test for CONFIG_FB_PM2 (it can be modular) in
    drivers/video/Config.in
  - Fix indentation for Sun3 frame buffers in drivers/video/Config.in

diff -urN linux-2.4.0-test11/drivers/ide/Config.in geert-2.4.0-test11/drivers/ide/Config.in
--- linux-2.4.0-test11/drivers/ide/Config.in	Thu Oct 26 23:11:39 2000
+++ geert-2.4.0-test11/drivers/ide/Config.in	Tue Nov 21 13:27:12 2000
@@ -93,17 +93,20 @@
 	 dep_bool '    RapIDE interface support' CONFIG_BLK_DEV_IDE_RAPIDE $CONFIG_ARCH_ACORN
       fi
       if [ "$CONFIG_AMIGA" = "y" ]; then
-	 dep_bool '    Amiga Gayle IDE interface support' CONFIG_BLK_DEV_GAYLE $CONFIG_AMIGA
-	 dep_mbool '      Amiga IDE Doubler support (EXPERIMENTAL)' CONFIG_BLK_DEV_IDEDOUBLER $CONFIG_BLK_DEV_GAYLE $CONFIG_EXPERIMENTAL
+	 dep_bool '  Amiga Gayle IDE interface support' CONFIG_BLK_DEV_GAYLE $CONFIG_AMIGA
+	 dep_mbool '    Amiga IDE Doubler support (EXPERIMENTAL)' CONFIG_BLK_DEV_IDEDOUBLER $CONFIG_BLK_DEV_GAYLE $CONFIG_EXPERIMENTAL
       fi
       if [ "$CONFIG_ZORRO" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 dep_mbool '    Buddha/Catweasel IDE interface support (EXPERIMENTAL)' CONFIG_BLK_DEV_BUDDHA $CONFIG_ZORRO $CONFIG_EXPERIMENTAL
+	 dep_mbool '  Buddha/Catweasel IDE interface support (EXPERIMENTAL)' CONFIG_BLK_DEV_BUDDHA $CONFIG_ZORRO $CONFIG_EXPERIMENTAL
       fi
       if [ "$CONFIG_ATARI" = "y" ]; then
-	 dep_bool '    Falcon IDE interface support' CONFIG_BLK_DEV_FALCON_IDE $CONFIG_ATARI
+	 dep_bool '  Falcon IDE interface support' CONFIG_BLK_DEV_FALCON_IDE $CONFIG_ATARI
       fi
       if [ "$CONFIG_MAC" = "y" ]; then
-	 dep_bool '    Macintosh Quadra/Powerbook IDE interface support' CONFIG_BLK_DEV_MAC_IDE $CONFIG_MAC
+	 dep_bool '  Macintosh Quadra/Powerbook IDE interface support' CONFIG_BLK_DEV_MAC_IDE $CONFIG_MAC
+      fi
+      if [ "$CONFIG_Q40" = "y" ]; then
+	 dep_bool '  Q40/Q60 IDE interface support' CONFIG_BLK_DEV_Q40IDE $CONFIG_Q40
       fi
 
       bool '  Other IDE chipset support' CONFIG_IDE_CHIPSETS
diff -urN linux-2.4.0-test11/drivers/scsi/Config.in geert-2.4.0-test11/drivers/scsi/Config.in
--- linux-2.4.0-test11/drivers/scsi/Config.in	Tue Nov  7 19:59:43 2000
+++ geert-2.4.0-test11/drivers/scsi/Config.in	Tue Nov 21 13:27:12 2000
@@ -194,6 +194,30 @@
    bool 'MIPS JAZZ FAS216 SCSI support' CONFIG_JAZZ_ESP
 fi
 
+if [ "$CONFIG_AMIGA" = "y" ]; then
+   dep_tristate 'A3000 WD33C93A support' CONFIG_A3000_SCSI $CONFIG_SCSI
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      bool 'A4000T SCSI support (EXPERIMENTAL)' CONFIG_A4000T_SCSI
+   fi
+fi
+if [ "$CONFIG_ZORRO" = "y" ]; then
+   dep_tristate 'A2091/A590 WD33C93A support' CONFIG_A2091_SCSI $CONFIG_SCSI
+   dep_tristate 'GVP Series II WD33C93A support' CONFIG_GVP11_SCSI $CONFIG_SCSI
+   dep_tristate 'CyberStorm SCSI support' CONFIG_CYBERSTORM_SCSI $CONFIG_SCSI
+   dep_tristate 'CyberStorm Mk II SCSI support' CONFIG_CYBERSTORMII_SCSI $CONFIG_SCSI
+   dep_tristate 'Blizzard 2060 SCSI support' CONFIG_BLZ2060_SCSI $CONFIG_SCSI
+   dep_tristate 'Blizzard 1230IV/1260 SCSI support' CONFIG_BLZ1230_SCSI $CONFIG_SCSI
+   dep_tristate 'Fastlane SCSI support' CONFIG_FASTLANE_SCSI $CONFIG_SCSI
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      bool 'A4091 SCSI support (EXPERIMENTAL)' CONFIG_A4091_SCSI
+      bool 'WarpEngine SCSI support (EXPERIMENTAL)' CONFIG_WARPENGINE_SCSI
+      bool 'Blizzard PowerUP 603e+ SCSI (EXPERIMENTAL)' CONFIG_BLZ603EPLUS_SCSI
+      dep_tristate 'BSC Oktagon SCSI support (EXPERIMENTAL)' CONFIG_OKTAGON_SCSI $CONFIG_SCSI
+#      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
+#      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
+   fi
+fi
+
 endmenu
 
 if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then
diff -urN linux-2.4.0-test11/drivers/video/Config.in geert-2.4.0-test11/drivers/video/Config.in
--- linux-2.4.0-test11/drivers/video/Config.in	Tue Sep 19 00:15:22 2000
+++ geert-2.4.0-test11/drivers/video/Config.in	Tue Nov 21 13:27:12 2000
@@ -16,7 +16,7 @@
       if [ "$CONFIG_AMIGA" = "y" -o "$CONFIG_PCI" = "y" ]; then
 	 tristate '  Cirrus Logic support (EXPERIMENTAL)' CONFIG_FB_CLGEN
 	 tristate '  Permedia2 support (EXPERIMENTAL)' CONFIG_FB_PM2
-	 if [ "$CONFIG_FB_PM2" = "y" ]; then
+	 if [ "$CONFIG_FB_PM2" != "n" ]; then
 	    if [ "$CONFIG_PCI" = "y" ]; then
 	       bool '    enable FIFO disconnect feature' CONFIG_FB_PM2_FIFO_DISCONNECT
 	       bool '    generic Permedia2 PCI board support' CONFIG_FB_PM2_PCI
@@ -92,10 +92,10 @@
       define_bool CONFIG_BUS_I2C y
    fi
    if [ "$CONFIG_SUN3" = "y" -o "$CONFIG_SUN3X" = "y" ]; then
-      bool 'Sun3 framebuffer support' CONFIG_FB_SUN3
+      bool '  Sun3 framebuffer support' CONFIG_FB_SUN3
       if [ "$CONFIG_FB_SUN3" != "n" ]; then
-         bool '  BWtwo support' CONFIG_FB_BWTWO
-         bool '  CGsix (GX,TurboGX) support' CONFIG_FB_CGSIX
+         bool '    BWtwo support' CONFIG_FB_BWTWO
+         bool '    CGsix (GX,TurboGX) support' CONFIG_FB_CGSIX
       fi
    fi
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
