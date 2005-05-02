Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVEBBuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVEBBuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVEBBuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:50:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45840 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261704AbVEBBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:33 -0400
Date: Mon, 2 May 2005 03:47:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] change the SOUND_PRIME handling
Message-ID: <20050502014728.GI3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SOUND_PRIME (for OSS) is a tristate.

This doesn't make much sense if most users are checking for 
SOUND_PRIME!=0.

This patch changes the semantics of SOUND_PRIME to being a limit for all 
OSS modules, IOW: SOUND_PRIME=m does now say that all OSS drivers can 
only be modular.

As a side effect, since SOUND_PRIME already depends on SOUND, there's no 
longer a reason for drivers depending on SOUND_PRIME to additionally 
depend on SOUND.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Apr 2005
- 19 Mar 2005

 sound/oss/Kconfig |   62 +++++++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

--- linux-2.6.11-mm4-full/sound/oss/Kconfig.old	2005-03-19 13:49:39.000000000 +0100
+++ linux-2.6.11-mm4-full/sound/oss/Kconfig	2005-03-19 13:53:59.000000000 +0100
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
 
 config SOUND_BCM_CS4297A
 	tristate "Crystal Sound CS4297a (for Swarm)"
-	depends on SOUND_PRIME!=n && SIBYTE_SWARM && SOUND
+	depends on SOUND_PRIME && SIBYTE_SWARM
 	help
 	  The BCM91250A has a Crystal CS4297a on synchronous serial
 	  port B (in addition to the DB-9 serial port).  Say Y or M
@@ -112,7 +112,7 @@
 
 config SOUND_ES1370
 	tristate "Ensoniq AudioPCI (ES1370)"
-	depends on SOUND_PRIME!=n && SOUND && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1370 chipset, such as Ensoniq's AudioPCI (non-97). To find
@@ -125,7 +125,7 @@
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME!=n && SOUND && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
@@ -138,7 +138,7 @@
 
 config SOUND_ESSSOLO1
 	tristate "ESS Technology Solo1" 
-	depends on SOUND_PRIME!=n && SOUND && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the ESS Technology
 	  Solo1 chip. To find out if your sound card uses a
@@ -149,7 +149,7 @@
 
 config SOUND_MAESTRO
 	tristate "ESS Maestro, Maestro2, Maestro2E driver"
-	depends on SOUND_PRIME!=n && SOUND && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a sound system driven by ESS's Maestro line
 	  of PCI sound chips.  These include the Maestro 1, Maestro 2, and
@@ -158,28 +158,28 @@
 
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
-	depends on GSC_LASI && SOUND_PRIME!=n
+	depends on GSC_LASI && SOUND_PRIME
 	help
 	  Say 'Y' or 'M' to include support for Harmony soundchip
 	  on HP 712, 715/new and many other GSC based machines.
 
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	help
 	  Say Y or M if you have a PCI sound card utilizing the S3
 	  SonicVibes chipset. To find out if your sound card uses a
@@ -190,7 +190,7 @@
 
 config SOUND_VWSND
 	tristate "SGI Visual Workstation Sound"
-	depends on SOUND_PRIME!=n && X86_VISWS && SOUND
+	depends on SOUND_PRIME && X86_VISWS
 	help
 	  Say Y or M if you have an SGI Visual Workstation and you want to be
 	  able to use its on-board audio.  Read
@@ -199,18 +199,18 @@
 
 config SOUND_HAL2
 	tristate "SGI HAL2 sound (EXPERIMENTAL)"
-	depends on SOUND_PRIME!=n && SOUND && SGI_IP22 && EXPERIMENTAL
+	depends on SOUND_PRIME && SGI_IP22 && EXPERIMENTAL
 	help
 	  Say Y or M if you have an SGI Indy system and want to be able to
 	  use it's on-board A2 audio system.
 
 config SOUND_IT8172
 	tristate "IT8172G Sound"
-	depends on SOUND_PRIME!=n && (MIPS_ITE8172 || MIPS_IVR) && SOUND
+	depends on SOUND_PRIME && (MIPS_ITE8172 || MIPS_IVR)
 
 config SOUND_VRC5477
 	tristate "NEC Vrc5477 AC97 sound"
-	depends on SOUND_PRIME!=n && DDB5477 && SOUND
+	depends on SOUND_PRIME && DDB5477
 	help
 	  Say Y here to enable sound support for the NEC Vrc5477 chip, an
 	  integrated, multi-function controller chip for MIPS CPUs.  Works
@@ -218,15 +218,15 @@
 
 config SOUND_AU1000
 	tristate "Au1000 Sound"
-	depends on SOUND_PRIME!=n && (SOC_AU1000 || SOC_AU1100 || SOC_AU1500) && SOUND
+	depends on SOUND_PRIME && (SOC_AU1000 || SOC_AU1100 || SOC_AU1500)
 
 config SOUND_AU1550_AC97
 	tristate "Au1550 AC97 Sound"
-	depends on SOUND_PRIME!=n && SOC_AU1550 && SOUND
+	depends on SOUND_PRIME && SOC_AU1550
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	---help---
 	  Say Y or M if you have a PCI sound card utilizing the Trident
 	  4DWave-DX/NX chipset or your mother board chipset has SiS 7018
@@ -267,7 +267,7 @@
 
 config SOUND_MSNDCLAS
 	tristate "Support for Turtle Beach MultiSound Classic, Tahiti, Monterey"
-	depends on SOUND_PRIME!=n && SOUND && (m || !STANDALONE)
+	depends on SOUND_PRIME && (m || !STANDALONE)
 	help
 	  Say M here if you have a Turtle Beach MultiSound Classic, Tahiti or
 	  Monterey (not for the Pinnacle or Fiji).
@@ -331,7 +331,7 @@
 
 config SOUND_MSNDPIN
 	tristate "Support for Turtle Beach MultiSound Pinnacle, Fiji"
-	depends on SOUND_PRIME!=n && SOUND && (m || !STANDALONE)
+	depends on SOUND_PRIME && (m || !STANDALONE)
 	help
 	  Say M here if you have a Turtle Beach MultiSound Pinnacle or Fiji.
 	  See <file:Documentation/sound/oss/MultiSound> for important information
@@ -492,7 +492,7 @@
 
 config SOUND_VIA82CXXX
 	tristate "VIA 82C686 Audio Codec"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y here to include support for the audio codec found on VIA
 	  82Cxxx-based chips. Typically these are built into a motherboard.
@@ -512,7 +512,7 @@
 
 config SOUND_OSS
 	tristate "OSS sound modules"
-	depends on SOUND_PRIME!=n && SOUND
+	depends on SOUND_PRIME
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
 	  sound programming easier since they provide a common API.  Say Y or
@@ -1077,7 +1077,7 @@
 
 config SOUND_TVMIXER
 	tristate "TV card (bt848) mixer support"
-	depends on SOUND_PRIME!=n && SOUND && I2C
+	depends on SOUND_PRIME && I2C
 	help
 	  Support for audio mixer facilities on the BT848 TV frame-grabber
 	  card.
@@ -1088,11 +1088,11 @@
 
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
@@ -1100,7 +1100,7 @@
 
 config SOUND_RME96XX
 	tristate "RME Hammerfall (RME96XX) support"
-	depends on SOUND_PRIME!=n && PCI
+	depends on SOUND_PRIME && PCI
 	help
 	  Say Y or M if you have a Hammerfall or Hammerfall light
 	  multichannel card from RME. If you want to access advanced
@@ -1108,11 +1108,11 @@
 
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

