Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945948AbWGOAhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945948AbWGOAhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945942AbWGOAhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:37:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36873 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945940AbWGOAhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:37:04 -0400
Date: Sat, 15 Jul 2006 02:37:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] schedule obsolete OSS drivers for removal, 2nd round
Message-ID: <20060715003702.GN3633@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch schedules obsolete OSS drivers (with ALSA drivers that 
support the same hardware) for removal.

A rationale of the patch is in
  http://lkml.org/lkml/2006/7/11/186

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

@Andrew: Please forward this for 2.6.18.

 Documentation/feature-removal-schedule.txt |    7 ++++
 sound/oss/Kconfig                          |   30 +++++++++++++++------
 2 files changed, 29 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc1-mm2-full/Documentation/feature-removal-schedule.txt.old	2006-07-15 00:59:49.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/Documentation/feature-removal-schedule.txt	2006-07-15 01:03:12.000000000 +0200
@@ -112,6 +112,13 @@
 
 ---------------------------
 
+What:  drivers depending on OSS_OBSOLETE_DRIVER
+When:  options in 2.6.20, code in 2.6.22
+Why:   OSS drivers with ALSA replacements
+Who:   Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
 What:	pci_module_init(driver)
 When:	January 2007
 Why:	Is replaced by pci_register_driver(pci_driver).
--- linux-2.6.18-rc1-mm2-full/sound/oss/Kconfig.old	2006-07-15 00:56:43.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/sound/oss/Kconfig	2006-07-15 00:59:32.000000000 +0200
@@ -5,6 +5,20 @@
 #
 # Prompt user for primary drivers.
 
+config OSS_OBSOLETE_DRIVER
+	bool "Obsolete OSS drivers"
+	depends on SOUND_PRIME
+	help
+	  This option enables support for obsolete OSS drivers that
+	  are scheduled for removal in the near future since there
+	  are ALSA drivers for the same hardware.
+
+	  Please contact Adrian Bunk <bunk@stusta.de> if you had to
+	  say Y here because your soundcard is not properly supported
+	  by ALSA.
+
+	  If unsure, say N.
+
 config SOUND_BT878
 	tristate "BT878 audio dma"
 	depends on SOUND_PRIME && PCI
@@ -23,7 +37,7 @@
 
 config SOUND_EMU10K1
 	tristate "Creative SBLive! (EMU10K1)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OSS_OBSOLETE_DRIVER
 	---help---
 	  Say Y or M if you have a PCI sound card using the EMU10K1 chipset,
 	  such as the Creative SBLive!, SB PCI512 or Emu-APS.
@@ -49,7 +63,7 @@
 
 config SOUND_FUSION
 	tristate "Crystal SoundFusion (CS4280/461x)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OSS_OBSOLETE_DRIVER
 	help
 	  This module drives the Crystal SoundFusion devices (CS4280/46xx
 	  series) when wired as native sound drivers with AC97 codecs.  If
@@ -440,7 +454,7 @@
 
 config SOUND_AD1816
 	tristate "AD1816(A) based cards (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS
+	depends on EXPERIMENTAL && SOUND_OSS && OSS_OBSOLETE_DRIVER
 	help
 	  Say M here if you have a sound card based on the Analog Devices
 	  AD1816(A) chip.
@@ -450,21 +464,21 @@
 
 config SOUND_AD1889
 	tristate "AD1889 based cards (AD1819 codec) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS && PCI
+	depends on EXPERIMENTAL && SOUND_OSS && PCI && OSS_OBSOLETE_DRIVER
 	help
 	  Say M here if you have a sound card based on the Analog Devices
 	  AD1889 chip.
 
 config SOUND_ADLIB
 	tristate "Adlib Cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
 	help
 	  Includes ASB 64 4D. Information on programming AdLib cards is
 	  available at <http://www.itsnet.com/home/ldragon/Specs/adlib.html>.
 
 config SOUND_ACI_MIXER
 	tristate "ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20)"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
 	---help---
 	  ACI (Audio Command Interface) is a protocol used to communicate with
 	  the microcontroller on some sound cards produced by miro and
@@ -586,7 +600,7 @@
 
 config SOUND_NM256
 	tristate "NM256AV/NM256ZX audio support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
 	help
 	  Say M here to include audio support for the NeoMagic 256AV/256ZX
 	  chipsets. These are the audio chipsets found in the Sony
@@ -706,7 +720,7 @@
 
 config SOUND_OPL3SA2
 	tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
 	help
 	  Say Y or M if you have a card based on one of these Yamaha sound
 	  chipsets or the "SAx", which is actually a SA3. Read

