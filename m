Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268508AbUHLLAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268508AbUHLLAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 07:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268509AbUHLLAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 07:00:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11259 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268508AbUHLK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 06:59:46 -0400
Date: Thu, 12 Aug 2004 12:59:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: Alex DeVries <alex@linuxcare.com>
Subject: simplify SOUND_PRIME dependencies
Message-ID: <20040812105941.GA13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below simplifies some SOUND_PRIME dependencies.

SOUND_PRIME=m no longer allow e.g. SOUND_BT878=y, but if this was 
intended SOUND_PRIME should better be a bool.
 
I've also added the missing dependency of SOUND_HARMONY on SOUND_PRIME.


diffstat output:
 sound/oss/Kconfig |   54 +++++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 27 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full-3.4/sound/oss/Kconfig.old	2004-08-12 10:40:06.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full-3.4/sound/oss/Kconfig	2004-08-12 10:46:19.000000000 +0200
@@ -6,7 +6,7 @@
 # Prompt user for primary drivers.
 config SOUND_BT878
 	tristate "BT878 audio dma"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	---help---
 	  Audio DMA support for bt878 based grabber boards.  As you might have
 	  already noticed, bt878 is listed with two functions in /proc/pci.
@@ -22,7 +22,7 @@
 
 config SOUND_CMPCI
 	tristate "C-Media PCI (CMI8338/8738)"
-	depends on SOUND_PRIME!=n && SOUND && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a PCI sound card using the CMI8338
 	  or the CMI8738 chipset.  Data on these chips are available at
@@ -61,7 +61,7 @@
 
 config SOUND_EMU10K1
 	tristate "Creative SBLive! (EMU10K1)"
-	depends on SOUND_PRIME!=n && SOUND && PCI
+	depends on SOUND_PRIME && PCI
 	---help---
 	  Say Y or M if you have a PCI sound card using the EMU10K1 chipset,
 	  such as the Creative SBLive!, SB PCI512 or Emu-APS.
@@ -87,7 +87,7 @@
 
 config SOUND_FUSION
 	tristate "Crystal SoundFusion (CS4280/461x)"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	help
 	  This module drives the Crystal SoundFusion devices (CS4280/46xx
 	  series) when wired as native sound drivers with AC97 codecs.  If
@@ -95,14 +95,14 @@
 
 config SOUND_CS4281
 	tristate "Crystal Sound CS4281"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	help
 	  Picture and feature list at
 	  <http://www.pcbroker.com/crystal4281.html>.
 
 config SOUND_ES1370
 	tristate "Ensoniq AudioPCI (ES1370)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && SOUND_GAMEPORT
+	depends on SOUND_PRIME && PCI && SOUND_GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1370 chipset, such as Ensoniq's AudioPCI (non-97). To find
@@ -115,7 +115,7 @@
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && SOUND_GAMEPORT
+	depends on SOUND_PRIME && PCI && SOUND_GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
@@ -128,7 +128,7 @@
 
 config SOUND_ESSSOLO1
 	tristate "ESS Technology Solo1"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME && SOUND_GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the ESS Technology
 	  Solo1 chip. To find out if your sound card uses a
@@ -139,7 +139,7 @@
 
 config SOUND_MAESTRO
 	tristate "ESS Maestro, Maestro2, Maestro2E driver"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	help
 	  Say Y or M if you have a sound system driven by ESS's Maestro line
 	  of PCI sound chips.  These include the Maestro 1, Maestro 2, and
@@ -148,25 +148,25 @@
 
 config SOUND_MAESTRO3
 	tristate "ESS Maestro3/Allegro driver (EXPERIMENTAL)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && EXPERIMENTAL
+	depends on SOUND_PRIME && PCI && EXPERIMENTAL
 	help
 	  Say Y or M if you have a sound system driven by ESS's Maestro 3
 	  PCI sound chip.
 
 config SOUND_ICH
 	tristate "Intel ICH (i8xx) audio support"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Support for integral audio in Intel's I/O Controller Hub (ICH)
 	  chipset, as used on the 810/820/840 motherboards.
 
 config SOUND_HARMONY
 	tristate "PA Harmony audio driver"
-	depends on GSC_LASI && SOUND
+	depends on GSC_LASI && SOUND_PRIME
 
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME && SOUND_GAMEPORT
 	help
 	  Say Y or M if you have a PCI sound card utilizing the S3
 	  SonicVibes chipset. To find out if your sound card uses a
@@ -177,7 +177,7 @@
 
 config SOUND_VWSND
 	tristate "SGI Visual Workstation Sound"
-	depends on SOUND_PRIME!=n && X86_VISWS && SOUND
+	depends on SOUND_PRIME && X86_VISWS
 	help
 	  Say Y or M if you have an SGI Visual Workstation and you want to be
 	  able to use its on-board audio.  Read
@@ -186,14 +186,14 @@
 
 config SOUND_HAL2
 	tristate "SGI HAL2 sound (EXPERIMENTAL)"
-	depends on SOUND_PRIME!=n && SOUND && SGI_IP22 && EXPERIMENTAL
+	depends on SOUND_PRIME && SGI_IP22 && EXPERIMENTAL
 	help
 	  Say Y or M if you have an SGI Indy system and want to be able to
 	  use it's on-board A2 audio system.
 
 config SOUND_VRC5477
 	tristate "NEC Vrc5477 AC97 sound"
-	depends on SOUND_PRIME!=n && DDB5477 && SOUND
+	depends on SOUND_PRIME && DDB5477
 	help
 	  Say Y here to enable sound support for the NEC Vrc5477 chip, an
 	  integrated, multi-function controller chip for MIPS CPUs.  Works
@@ -201,7 +201,7 @@
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME && SOUND_GAMEPORT
 	---help---
 	  Say Y or M if you have a PCI sound card utilizing the Trident
 	  4DWave-DX/NX chipset or your mother board chipset has SiS 7018
@@ -242,7 +242,7 @@
 
 config SOUND_MSNDCLAS
 	tristate "Support for Turtle Beach MultiSound Classic, Tahiti, Monterey"
-	depends on SOUND_PRIME!=n && SOUND && (m || !STANDALONE)
+	depends on SOUND_PRIME && (m || !STANDALONE)
 	help
 	  Say M here if you have a Turtle Beach MultiSound Classic, Tahiti or
 	  Monterey (not for the Pinnacle or Fiji).
@@ -306,7 +306,7 @@
 
 config SOUND_MSNDPIN
 	tristate "Support for Turtle Beach MultiSound Pinnacle, Fiji"
-	depends on SOUND_PRIME!=n && SOUND && (m || !STANDALONE)
+	depends on SOUND_PRIME && (m || !STANDALONE)
 	help
 	  Say M here if you have a Turtle Beach MultiSound Pinnacle or Fiji.
 	  See <file:Documentation/sound/oss/MultiSound> for important information
@@ -467,7 +467,7 @@
 
 config SOUND_VIA82CXXX
 	tristate "VIA 82C686 Audio Codec"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y here to include support for the audio codec found on VIA
 	  82Cxxx-based chips. Typically these are built into a motherboard.
@@ -487,7 +487,7 @@
 
 config SOUND_OSS
 	tristate "OSS sound modules"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
 	  sound programming easier since they provide a common API.  Say Y or
@@ -1052,7 +1052,7 @@
 
 config SOUND_TVMIXER
 	tristate "TV card (bt848) mixer support"
-	depends on SOUND_PRIME!=n && SOUND && I2C
+	depends on SOUND_PRIME && I2C
 	help
 	  Support for audio mixer facilities on the BT848 TV frame-grabber
 	  card.
@@ -1063,11 +1063,11 @@
 
 config SOUND_ALI5455
 	tristate "ALi5455 audio support"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 
 config SOUND_FORTE
 	tristate "ForteMedia FM801 driver"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you want driver support for the ForteMedia FM801 PCI
 	  audio controller (Abit AU10, Genius Sound Maker, HP Workstation
@@ -1075,7 +1075,7 @@
 
 config SOUND_RME96XX
 	tristate "RME Hammerfall (RME96XX) support"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a Hammerfall or Hammerfall light
 	  multichannel card from RME. If you want to acess advanced
@@ -1083,11 +1083,11 @@
 
 config SOUND_AD1980
 	tristate "AD1980 front/back switch plugin"
-	depends on SOUND_PRIME!=n
+	depends on SOUND_PRIME
 
 config SOUND_SH_DAC_AUDIO
 	tristate "SuperH DAC audio support"
-	depends on SOUND_PRIME!=n && SOUND && CPU_SH3
+	depends on SOUND_PRIME && CPU_SH3
 
 config SOUND_SH_DAC_AUDIO_CHANNEL
 	int "    DAC channel"

