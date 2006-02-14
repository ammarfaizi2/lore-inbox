Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWBNX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWBNX2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422883AbWBNX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:28:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49675 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422882AbWBNX2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:28:43 -0500
Date: Wed, 15 Feb 2006 00:28:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] update OBSOLETE_OSS_DRIVER schedule and dependencies
Message-ID: <20060214232831.GA3595@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the schedule for the removal of drivers depending on 
OBSOLETE_OSS_DRIVER as follows:
- adjust OBSOLETE_OSS_DRIVER dependencie
- from the release of 2.6.16 till the release of 2.6.17:
  approx. two months for users to report problems with the ALSA
  drivers for the same hardware
- after the release of 2.6.17 (and before 2.6.18):
  remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
  known regressions in the ALSA drivers for the same hardware

Additionally, it corrects some OBSOLETE_OSS_DRIVER dependencies.
A rationale of the changes is in
  http://lkml.org/lkml/2006/1/28/135


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Feb 2006

 Documentation/feature-removal-schedule.txt |    2 +-
 sound/oss/Kconfig                          |   16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.16-rc2-mm1-full/Documentation/feature-removal-schedule.txt.old	2006-02-11 15:25:07.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/Documentation/feature-removal-schedule.txt	2006-02-11 15:26:04.000000000 +0100
@@ -26,7 +26,7 @@
 ---------------------------
 
 What:	drivers depending on OBSOLETE_OSS_DRIVER
-When:	January 2006
+When:	before 2.6.18
 Why:	OSS drivers with ALSA replacements
 Who:	Adrian Bunk <bunk@stusta.de>
 
--- linux-2.6.16-rc2-mm1-full/sound/oss/Kconfig.old	2006-02-11 15:20:12.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/sound/oss/Kconfig	2006-02-11 15:24:06.000000000 +0100
@@ -21,7 +21,7 @@
 
 config SOUND_BT878
 	tristate "BT878 audio dma"
-	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
+	depends on SOUND_PRIME && PCI
 	---help---
 	  Audio DMA support for bt878 based grabber boards.  As you might have
 	  already noticed, bt878 is listed with two functions in /proc/pci.
@@ -76,7 +76,7 @@
 
 config SOUND_EMU10K1
 	tristate "Creative SBLive! (EMU10K1)"
-	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
+	depends on SOUND_PRIME && PCI
 	---help---
 	  Say Y or M if you have a PCI sound card using the EMU10K1 chipset,
 	  such as the Creative SBLive!, SB PCI512 or Emu-APS.
@@ -102,7 +102,7 @@
 
 config SOUND_FUSION
 	tristate "Crystal SoundFusion (CS4280/461x)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  This module drives the Crystal SoundFusion devices (CS4280/46xx
 	  series) when wired as native sound drivers with AC97 codecs.  If
@@ -140,7 +140,7 @@
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
@@ -571,7 +571,7 @@
 
 config SOUND_AD1889
 	tristate "AD1889 based cards (AD1819 codec) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS && PCI
+	depends on EXPERIMENTAL && SOUND_OSS && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say M here if you have a sound card based on the Analog Devices
 	  AD1889 chip.
@@ -742,7 +742,7 @@
 
 config SOUND_NM256
 	tristate "NM256AV/NM256ZX audio support"
-	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
+	depends on SOUND_OSS
 	help
 	  Say M here to include audio support for the NeoMagic 256AV/256ZX
 	  chipsets. These are the audio chipsets found in the Sony
@@ -919,7 +919,7 @@
 
 config SOUND_YM3812
 	tristate "Yamaha FM synthesizer (YM3812/OPL-3) support"
-	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
+	depends on SOUND_OSS
 	---help---
 	  Answer Y if your card has a FM chip made by Yamaha (OPL2/OPL3/OPL4).
 	  Answering Y is usually a safe and recommended choice, however some
@@ -947,7 +947,7 @@
 
 config SOUND_OPL3SA2
 	tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a card based on one of these Yamaha sound
 	  chipsets or the "SAx", which is actually a SA3. Read

