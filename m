Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQKKFSk>; Sat, 11 Nov 2000 00:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQKKFSU>; Sat, 11 Nov 2000 00:18:20 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:2308 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129655AbQKKFRq>;
	Sat, 11 Nov 2000 00:17:46 -0500
Date: Fri, 10 Nov 2000 23:17:44 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: linux-kernel@vger.kernel.org
Subject: patch for pas16 configuration in 2.4
Message-ID: <Pine.LNX.4.21.0011102304040.626-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows someone to select only Pro Audio Spectrum
configuration and get both PAS and SB emulation, as intended.  Small
changes were also made to documentation.

It appears that it is too late for inclusion before 2.4 final, but is
submitted now for comments.

diff -urN linux.old/Documentation/Configure.help linux.new1/Documentation/Configure.help
--- linux.old/Documentation/Configure.help	Wed Nov  8 08:48:53 2000
+++ linux.new1/Documentation/Configure.help	Wed Nov  8 10:29:26 2000
@@ -13861,6 +13861,8 @@
   16 or Logitech SoundMan 16 sound card. Answer N if you have some
   other card made by Media Vision or Logitech since those are not
   PAS16 compatible. Please read Documentation/sound/PAS16.
+  It is not necessary to add Sound Blaster support separately; it
+  is included in PAS support.
 
   If you compile the driver into the kernel, you have to add
   "pas2=<io>,<irq>,<dma>,<dma2>,<sbio>,<sbirq>,<sbdma>,<sbdma2>
diff -urN linux.old/Documentation/sound/PAS16 linux.new1/Documentation/sound/PAS16
--- linux.old/Documentation/sound/PAS16	Sun Apr  2 17:38:53 2000
+++ linux.new1/Documentation/sound/PAS16	Wed Nov  8 11:06:37 2000
@@ -1,7 +1,7 @@
 Pro Audio Spectrum 16 for 2.3.99 and later
 =========================================
 by Thomas Molina (tmolina@home.com)
-last modified 26 Mar 2000
+last modified 8 Nov 2000
 Acknowledgement to Axel Boldt (boldt@math.ucsb.edu) for stuff taken
 from Configure.help, Riccardo Facchetti for stuff from README.OSS,
 and others whose names I could not find.
@@ -48,14 +48,6 @@
           if you want to use the SB emulation of PAS16. It's also possible to
           the emulation if you want to use a true SB card together with PAS16
           (there is another question about this that is asked later).
-  "Sound Blaster support",
-        - Answer 'y' if you have an original SB card made by Creative Labs
-          or a full 100% hardware compatible clone (like Thunderboard or
-          SM Games). If your card was in the list of supported cards (above),
-          please look at the card specific instructions later in this file
-          before answering this question. For an unknown card you may answer
-          'y' if the card claims to be SB compatible.
-         Enable this option also with PAS16.
 
   "Generic OPL2/OPL3 FM synthesizer support",
         - Answer 'y' if your card has a FM chip made by Yamaha (OPL2/OPL3/OPL4).
@@ -113,27 +105,13 @@
   Answer Y only if you have a Pro Audio Spectrum 16, ProAudio Studio
   16 or Logitech SoundMan 16 sound card. Don't answer Y if you have
   some other card made by Media Vision or Logitech since they are not
-  PAS16 compatible.
+  PAS16 compatible.  It is not necessary to enable the  separate 
+  Sound Blaster support; it is included in the PAS driver.
+
   If you compile the driver into the kernel, you have to add
   "pas2=<io>,<irq>,<dma>,<dma2>,<sbio>,<sbirq>,<sbdma>,<sbdma2>
   to the kernel command line.
 
-100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support
-CONFIG_SOUND_SB
-  Answer Y if you have an original Sound Blaster card made by Creative
-  Labs or a 100% hardware compatible clone (like the Thunderboard or
-  SM Games). For an unknown card you may answer Y if the card claims
-  to be Sound Blaster-compatible.  The PAS16 has 8-bit Soundblaster
-  support, so you can answer Y here for it.
-
-  Please read the file Documentation/sound/Soundblaster.
-
-  If you compile the driver into the kernel and don't want to use isapnp,
-  you have to add "sb=<io>,<irq>,<dma>,<dma2>" to the kernel command line.
-
-  You can say M here to compile this driver as a module; the module is
-  called sb.o.
-
 FM Synthesizer (YM3812/OPL-3) support
 CONFIG_SOUND_YM3812
   Answer Y if your card has a FM chip made by Yamaha (OPL2/OPL3/OPL4).
@@ -167,7 +145,7 @@
 CONFIG_SOUND_TRACEINIT=y
 CONFIG_SOUND_DMAP=y
 CONFIG_SOUND_PAS=y
-CONFIG_SOUND_SB=y
+CONFIG_SOUND_SB=n
 CONFIG_SOUND_YM3812=m
 
 I have also included the following append line in /etc/lilo.conf:
diff -urN linux.old/drivers/sound/Makefile linux.new1/drivers/sound/Makefile
--- linux.old/drivers/sound/Makefile	Mon Sep 25 14:32:54 2000
+++ linux.new1/drivers/sound/Makefile	Wed Nov  8 09:58:56 2000
@@ -48,7 +48,7 @@
 obj-$(CONFIG_SOUND_CS4232)	+= cs4232.o uart401.o
 obj-$(CONFIG_SOUND_OPL3SA2)	+= opl3sa2.o ad1848.o mpu401.o
 obj-$(CONFIG_SOUND_MSS)		+= ad1848.o
-obj-$(CONFIG_SOUND_PAS)		+= pas2.o sb_lib.o uart401.o
+obj-$(CONFIG_SOUND_PAS)		+= pas2.o sb.o sb_lib.o uart401.o
 obj-$(CONFIG_SOUND_SB)		+= sb.o sb_lib.o uart401.o
 obj-$(CONFIG_SOUND_WAVEFRONT)	+= wavefront.o
 obj-$(CONFIG_SOUND_MAUI)	+= maui.o mpu401.o

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
