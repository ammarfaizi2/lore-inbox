Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVGZPNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVGZPNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVGZPKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:10:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27909 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261878AbVGZPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:08:48 -0400
Date: Tue, 26 Jul 2005 17:08:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com
Subject: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050726150837.GT3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch schedules obsolete OSS drivers (with ALSA drivers that 
support the same hardware) for removal.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

I've Cc'ed the people listed in MAINTAINERS as being responsible for one 
or more of these drivers, and I've also Cc'ed the ALSA people.

Please tell if any my driver selections is wrong.

 Documentation/feature-removal-schedule.txt |    7 +
 sound/oss/Kconfig                          |   79 ++++++++++++---------
 2 files changed, 54 insertions(+), 32 deletions(-)

--- linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-07-26 16:50:05.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt	2005-07-26 16:51:24.000000000 +0200
@@ -44,0 +45,7 @@
+What:	drivers depending on OBSOLETE_OSS_DRIVER
+When:	October 2005
+Why:	OSS drivers with ALSA replacements
+Who:	Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
--- linux-2.6.13-rc3-mm1-modular/sound/oss/Kconfig.old	2005-07-23 21:04:56.000000000 +0200
+++ linux-2.6.13-rc3-mm1-modular/sound/oss/Kconfig	2005-07-24 01:22:11.000000000 +0200
@@ -4,9 +4,24 @@
 # More hacking for modularisation.
 #
 # Prompt user for primary drivers.
+
+config OBSOLETE_OSS_DRIVER
+	bool "Obsolete OSS drivers"
+	depends on SOUND_PRIME
+	help
+	  This patch enables support for obsolete OSS drivers that
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
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && OBSOLETE_OSS_DRIVER
 	---help---
 	  Audio DMA support for bt878 based grabber boards.  As you might have
 	  already noticed, bt878 is listed with two functions in /proc/pci.
@@ -22,7 +37,7 @@
 
 config SOUND_CMPCI
 	tristate "C-Media PCI (CMI8338/8738)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a PCI sound card using the CMI8338
 	  or the CMI8738 chipset.  Data on these chips are available at
@@ -61,7 +76,7 @@
 
 config SOUND_EMU10K1
 	tristate "Creative SBLive! (EMU10K1)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	---help---
 	  Say Y or M if you have a PCI sound card using the EMU10K1 chipset,
 	  such as the Creative SBLive!, SB PCI512 or Emu-APS.
@@ -95,7 +110,7 @@
 
 config SOUND_CS4281
 	tristate "Crystal Sound CS4281"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && OBSOLETE_OSS_DRIVER
 	help
 	  Picture and feature list at
 	  <http://www.pcbroker.com/crystal4281.html>.
@@ -112,7 +127,7 @@
 
 config SOUND_ES1370
 	tristate "Ensoniq AudioPCI (ES1370)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1370 chipset, such as Ensoniq's AudioPCI (non-97). To find
@@ -125,7 +140,7 @@
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
@@ -138,7 +153,7 @@
 
 config SOUND_ESSSOLO1
 	tristate "ESS Technology Solo1" 
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a PCI sound card utilizing the ESS Technology
 	  Solo1 chip. To find out if your sound card uses a
@@ -149,7 +164,7 @@
 
 config SOUND_MAESTRO
 	tristate "ESS Maestro, Maestro2, Maestro2E driver"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a sound system driven by ESS's Maestro line
 	  of PCI sound chips.  These include the Maestro 1, Maestro 2, and
@@ -158,28 +173,28 @@
 
 config SOUND_MAESTRO3
 	tristate "ESS Maestro3/Allegro driver (EXPERIMENTAL)"
-	depends on SOUND_PRIME && PCI && EXPERIMENTAL
+	depends on SOUND_PRIME && PCI && EXPERIMENTAL && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a sound system driven by ESS's Maestro 3
 	  PCI sound chip.
 
 config SOUND_ICH
 	tristate "Intel ICH (i8xx) audio support"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Support for integral audio in Intel's I/O Controller Hub (ICH)
 	  chipset, as used on the 810/820/840 motherboards.
 
 config SOUND_HARMONY
 	tristate "PA Harmony audio driver"
-	depends on GSC_LASI && SOUND_PRIME
+	depends on GSC_LASI && SOUND_PRIME && OBSOLETE_OSS_DRIVER
 	help
 	  Say 'Y' or 'M' to include support for Harmony soundchip
 	  on HP 712, 715/new and many other GSC based machines.
 
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a PCI sound card utilizing the S3
 	  SonicVibes chipset. To find out if your sound card uses a
@@ -218,7 +233,7 @@
 
 config SOUND_AU1000
 	tristate "Au1000 Sound"
-	depends on SOUND_PRIME && (SOC_AU1000 || SOC_AU1100 || SOC_AU1500)
+	depends on SOUND_PRIME && (SOC_AU1000 || SOC_AU1100 || SOC_AU1500) && OBSOLETE_OSS_DRIVER
 
 config SOUND_AU1550_AC97
 	tristate "Au1550 AC97 Sound"
@@ -492,7 +507,7 @@
 
 config SOUND_VIA82CXXX
 	tristate "VIA 82C686 Audio Codec"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y here to include support for the audio codec found on VIA
 	  82Cxxx-based chips. Typically these are built into a motherboard.
@@ -546,7 +561,7 @@
 
 config SOUND_AD1816
 	tristate "AD1816(A) based cards (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS
+	depends on EXPERIMENTAL && SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say M here if you have a sound card based on the Analog Devices
 	  AD1816(A) chip.
@@ -563,7 +578,7 @@
 
 config SOUND_SGALAXY
 	tristate "Aztech Sound Galaxy (non-PnP) cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  This module initializes the older non Plug and Play sound galaxy
 	  cards from Aztech. It supports the Waverider Pro 32 - 3D and the
@@ -599,7 +614,7 @@
 
 config SOUND_CS4232
 	tristate "Crystal CS4232 based (PnP) cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y here if you have a card based on the Crystal CS4232 chip set,
 	  which uses its own Plug and Play protocol.
@@ -613,7 +628,7 @@
 
 config SOUND_SSCAPE
 	tristate "Ensoniq SoundScape support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Answer Y if you have a sound card based on the Ensoniq SoundScape
 	  chipset. Such cards are being manufactured at least by Ensoniq, Spea
@@ -625,7 +640,7 @@
 
 config SOUND_GUS
 	tristate "Gravis Ultrasound support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y here for any type of Gravis Ultrasound card, including the GUS
 	  or GUS MAX.  See also <file:Documentation/sound/oss/ultrasound> for more
@@ -727,7 +742,7 @@
 
 config SOUND_NM256
 	tristate "NM256AV/NM256ZX audio support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say M here to include audio support for the NeoMagic 256AV/256ZX
 	  chipsets. These are the audio chipsets found in the Sony
@@ -739,7 +754,7 @@
 
 config SOUND_MAD16
 	tristate "OPTi MAD16 and/or Mozart based cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	---help---
 	  Answer Y if your card has a Mozart (OAK OTI-601) or MAD16 (OPTi
 	  82C928 or 82C929 or 82C931) audio interface chip. These chips are
@@ -860,7 +875,7 @@
 
 config SOUND_AWE32_SYNTH
 	tristate "AWE32 synth"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y here if you have a Sound Blaster SB32, AWE32-PnP, SB AWE64 or
 	  similar sound card. See <file:Documentation/sound/oss/README.awe>,
@@ -870,7 +885,7 @@
 
 config SOUND_WAVEFRONT
 	tristate "Full support for Turtle Beach WaveFront (Tropez Plus, Tropez, Maui) synth/soundcards"
-	depends on SOUND_OSS && m
+	depends on SOUND_OSS && m && OBSOLETE_OSS_DRIVER
 	help
 	  Answer Y or M if you have a Tropez Plus, Tropez or Maui sound card
 	  and read the files <file:Documentation/sound/oss/Wavefront> and
@@ -878,7 +893,7 @@
 
 config SOUND_MAUI
 	tristate "Limited support for Turtle Beach Wave Front (Maui, Tropez) synthesizers"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y here if you have a Turtle Beach Wave Front, Maui, or Tropez
 	  sound card.
@@ -904,7 +919,7 @@
 
 config SOUND_YM3812
 	tristate "Yamaha FM synthesizer (YM3812/OPL-3) support"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	---help---
 	  Answer Y if your card has a FM chip made by Yamaha (OPL2/OPL3/OPL4).
 	  Answering Y is usually a safe and recommended choice, however some
@@ -920,7 +935,7 @@
 
 config SOUND_OPL3SA1
 	tristate "Yamaha OPL3-SA1 audio controller"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a Yamaha OPL3-SA1 sound chip, which is
 	  usually built into motherboards. Read
@@ -932,7 +947,7 @@
 
 config SOUND_OPL3SA2
 	tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a card based on one of these Yamaha sound
 	  chipsets or the "SAx", which is actually a SA3. Read
@@ -946,7 +961,7 @@
 
 config SOUND_YMFPCI
 	tristate "Yamaha YMF7xx PCI audio (native mode)"
-	depends on SOUND_OSS && PCI
+	depends on SOUND_OSS && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Support for Yamaha cards including the YMF711, YMF715, YMF718,
 	  YMF719, YMF724, Waveforce 192XG, and Waveforce 192 Digital.
@@ -1088,11 +1103,11 @@
 
 config SOUND_ALI5455
 	tristate "ALi5455 audio support"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 
 config SOUND_FORTE
 	tristate "ForteMedia FM801 driver"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you want driver support for the ForteMedia FM801 PCI
 	  audio controller (Abit AU10, Genius Sound Maker, HP Workstation
@@ -1100,7 +1115,7 @@
 
 config SOUND_RME96XX
 	tristate "RME Hammerfall (RME96XX) support"
-	depends on SOUND_PRIME && PCI
+	depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
 	help
 	  Say Y or M if you have a Hammerfall or Hammerfall light
 	  multichannel card from RME. If you want to access advanced
@@ -1108,7 +1123,7 @@
 
 config SOUND_AD1980
 	tristate "AD1980 front/back switch plugin"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && OBSOLETE_OSS_DRIVER
 
 config SOUND_SH_DAC_AUDIO
 	tristate "SuperH DAC audio support"

