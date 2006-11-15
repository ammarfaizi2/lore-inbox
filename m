Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030769AbWKORvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030769AbWKORvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030768AbWKORvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:51:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28420 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030766AbWKORvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:51:42 -0500
Date: Wed, 15 Nov 2006 18:51:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.20 patch] the scheduled removal of some OSS options
Message-ID: <20061115175140.GH5824@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of the OSS drivers depending 
on OSS_OBSOLETE_DRIVER.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/radio/Kconfig |   32 ----------
 sound/oss/Kconfig           |  115 ------------------------------------
 2 files changed, 147 deletions(-)

--- linux-2.6.19-rc5-mm2/sound/oss/Kconfig.old	2006-11-14 23:31:42.000000000 +0100
+++ linux-2.6.19-rc5-mm2/sound/oss/Kconfig	2006-11-14 23:34:27.000000000 +0100
@@ -5,20 +5,6 @@
 #
 # Prompt user for primary drivers.
 
-config OSS_OBSOLETE_DRIVER
-	bool "Obsolete OSS drivers"
-	depends on SOUND_PRIME
-	help
-	  This option enables support for obsolete OSS drivers that
-	  are scheduled for removal in the near future since there
-	  are ALSA drivers for the same hardware.
-
-	  Please contact Adrian Bunk <bunk@stusta.de> if you had to
-	  say Y here because your soundcard is not properly supported
-	  by ALSA.
-
-	  If unsure, say N.
-
 config SOUND_BT878
 	tristate "BT878 audio dma"
 	depends on SOUND_PRIME && PCI
@@ -35,40 +21,6 @@
 	  To compile this driver as a module, choose M here: the module will
 	  be called btaudio.
 
-config SOUND_EMU10K1
-	tristate "Creative SBLive! (EMU10K1)"
-	depends on SOUND_PRIME && PCI && OSS_OBSOLETE_DRIVER
-	---help---
-	  Say Y or M if you have a PCI sound card using the EMU10K1 chipset,
-	  such as the Creative SBLive!, SB PCI512 or Emu-APS.
-
-	  For more information on this driver and the degree of support for
-	  the different card models please check:
-
-		<http://sourceforge.net/projects/emu10k1/>
-
-	  It is now possible to load dsp microcode patches into the EMU10K1
-	  chip.  These patches are used to implement real time sound
-	  processing effects which include for example: signal routing,
-	  bass/treble control, AC3 passthrough, ...
-	  Userspace tools to create new patches and load/unload them can be
-	  found in the emu-tools package at the above URL.
-
-config MIDI_EMU10K1
-	bool "Creative SBLive! MIDI (EXPERIMENTAL)"
-	depends on SOUND_EMU10K1 && EXPERIMENTAL && ISA_DMA_API
-	help
-	  Say Y if you want to be able to use the OSS /dev/sequencer
-	  interface.  This code is still experimental.
-
-config SOUND_FUSION
-	tristate "Crystal SoundFusion (CS4280/461x)"
-	depends on SOUND_PRIME && PCI && OSS_OBSOLETE_DRIVER
-	help
-	  This module drives the Crystal SoundFusion devices (CS4280/46xx
-	  series) when wired as native sound drivers with AC97 codecs.  If
-	  this driver does not work try the CS4232 driver.
-
 config SOUND_BCM_CS4297A
 	tristate "Crystal Sound CS4297a (for Swarm)"
 	depends on SOUND_PRIME && SIBYTE_SWARM
@@ -448,47 +400,6 @@
 
 	  Say Y unless you have 16MB or more RAM or a PCI sound card.
 
-config SOUND_AD1816
-	tristate "AD1816(A) based cards (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS && OSS_OBSOLETE_DRIVER
-	help
-	  Say M here if you have a sound card based on the Analog Devices
-	  AD1816(A) chip.
-
-	  If you compile the driver into the kernel, you have to add
-	  "ad1816=<io>,<irq>,<dma>,<dma2>" to the kernel command line.
-
-config SOUND_AD1889
-	tristate "AD1889 based cards (AD1819 codec) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SOUND_OSS && PCI && OSS_OBSOLETE_DRIVER
-	help
-	  Say M here if you have a sound card based on the Analog Devices
-	  AD1889 chip.
-
-config SOUND_ADLIB
-	tristate "Adlib Cards"
-	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
-	help
-	  Includes ASB 64 4D. Information on programming AdLib cards is
-	  available at <http://www.itsnet.com/home/ldragon/Specs/adlib.html>.
-
-config SOUND_ACI_MIXER
-	tristate "ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20)"
-	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
-	---help---
-	  ACI (Audio Command Interface) is a protocol used to communicate with
-	  the microcontroller on some sound cards produced by miro and
-	  Cardinal Technologies.  The main function of the ACI is to control
-	  the mixer and to get a product identification.
-
-	  This VoxWare ACI driver currently supports the ACI functions on the
-	  miroSOUND PCM1-pro, PCM12 and PCM20 radio. On the PCM20 radio, ACI
-	  also controls the radio tuner. This is supported in the video4linux
-	  miropcm20 driver (say M or Y here and go back to "Multimedia
-	  devices" -> "Radio Adapters").
-
-	  This driver is also available as a module and will be called aci.
-
 config SOUND_CS4232
 	tristate "Crystal CS4232 based (PnP) cards"
 	depends on SOUND_OSS
@@ -594,18 +505,6 @@
 	  If you compile the driver into the kernel, you have to add
 	  "mpu401=<io>,<irq>" to the kernel command line.
 
-config SOUND_NM256
-	tristate "NM256AV/NM256ZX audio support"
-	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
-	help
-	  Say M here to include audio support for the NeoMagic 256AV/256ZX
-	  chipsets. These are the audio chipsets found in the Sony
-	  Z505S/SX/DX, some Sony F-series, and the Dell Latitude CPi and CPt
-	  laptops. It includes support for an AC97-compatible mixer and an
-	  apparently proprietary sound engine.
-
-	  See <file:Documentation/sound/oss/NM256> for further information.
-
 config SOUND_PAS
 	tristate "ProAudioSpectrum 16 support"
 	depends on SOUND_OSS
@@ -714,20 +613,6 @@
 
 	  If unsure, say Y.
 
-config SOUND_OPL3SA2
-	tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
-	depends on SOUND_OSS && OSS_OBSOLETE_DRIVER
-	help
-	  Say Y or M if you have a card based on one of these Yamaha sound
-	  chipsets or the "SAx", which is actually a SA3. Read
-	  <file:Documentation/sound/oss/OPL3-SA2> for more information on
-	  configuring these cards.
-
-	  If you compile the driver into the kernel and do not also
-	  configure in the optional ISA PnP support, you will have to add
-	  "opl3sa2=<io>,<irq>,<dma>,<dma2>,<mssio>,<mpuio>" to the kernel
-	  command line.
-
 config SOUND_UART6850
 	tristate "6850 UART support"
 	depends on SOUND_OSS
--- linux-2.6.19-rc5-mm2/drivers/media/radio/Kconfig.old	2006-11-14 23:34:49.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/media/radio/Kconfig	2006-11-14 23:35:08.000000000 +0100
@@ -173,38 +173,6 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-maestro.
 
-config RADIO_MIROPCM20
-	tristate "miroSOUND PCM20 radio"
-	depends on ISA && VIDEO_V4L1 && SOUND_ACI_MIXER
-	---help---
-	  Choose Y here if you have this FM radio card. You also need to say Y
-	  to "ACI mixer (miroSOUND PCM1-pro/PCM12/PCM20 radio)" (in "Sound")
-	  for this to work.
-
-	  In order to control your radio card, you will need to use programs
-	  that are compatible with the Video For Linux API.  Information on
-	  this API and pointers to "v4l" programs may be found at
-	  <file:Documentation/video4linux/API.html>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called miropcm20.
-
-config RADIO_MIROPCM20_RDS
-	tristate "miroSOUND PCM20 radio RDS user interface (EXPERIMENTAL)"
-	depends on RADIO_MIROPCM20 && EXPERIMENTAL
-	---help---
-	  Choose Y here if you want to see RDS/RBDS information like
-	  RadioText, Programme Service name, Clock Time and date, Programme
-	  Type and Traffic Announcement/Programme identification.
-
-	  It's not possible to read the raw RDS packets from the device, so
-	  the driver cant provide an V4L interface for this.  But the
-	  availability of RDS is reported over V4L by the basic driver
-	  already.  Here RDS can be read from files in /dev/v4l/rds.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called miropcm20-rds.
-
 config RADIO_SF16FMI
 	tristate "SF16FMI Radio"
 	depends on ISA && VIDEO_V4L2

