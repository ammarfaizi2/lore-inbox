Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbSLRKjK>; Wed, 18 Dec 2002 05:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLRKjK>; Wed, 18 Dec 2002 05:39:10 -0500
Received: from gate.perex.cz ([194.212.165.105]:56331 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267217AbSLRKjH>;
	Wed, 18 Dec 2002 05:39:07 -0500
Date: Wed, 18 Dec 2002 11:46:21 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA & HP100 update
Message-ID: <Pine.LNX.4.33.0212181133460.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-sound.bkbits.net/linux-sound

the GNU patch is available at

	ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2002-12-18.patch.gz

				Thank you,
					Jaroslav

ALSA summary:

- added hotplug support - disconnection of running devices (USB & PCMCIA)
- added ALSA-Configuration.txt document
- control API - replace global control lock with semaphore
- driver updates
  - ICE1712, USB audio, Trident, CS4281, ENS1371, ALI5451, VIA82xx, HDSP, 
    ALS4000, CMIPCI, CS46xx, ES1968, FM801, Intel8x0

HP100 summary:

- small HP100 driver updates by Pavel Machek
  - coaxial connection detection, compilation fixes

This will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt | 1188 ++++++++++++++++++++++++
 Documentation/sound/alsa/ControlNames.txt       |   82 +
 drivers/net/hp100.c                             |   99 +-
 drivers/net/hp100.h                             |    5 
 include/sound/ac97_codec.h                      |    4 
 include/sound/control.h                         |    2 
 include/sound/core.h                            |   39 
 include/sound/cs46xx.h                          |    2 
 include/sound/cs46xx_dsp_spos.h                 |    6 
 include/sound/initval.h                         |   17 
 include/sound/mixer_oss.h                       |    1 
 include/sound/mpu401.h                          |    6 
 include/sound/opl3.h                            |    1 
 include/sound/pcm.h                             |    5 
 include/sound/pcm_oss.h                         |    1 
 include/sound/sb.h                              |    9 
 include/sound/trident.h                         |   18 
 include/sound/version.h                         |   14 
 sound/arm/sa11xx-uda1341.c                      |    2 
 sound/core/control.c                            |  176 ++-
 sound/core/device.c                             |   40 
 sound/core/info.c                               |    8 
 sound/core/init.c                               |  355 ++++++-
 sound/core/ioctl32/ioctl32.c                    |    1 
 sound/core/ioctl32/rawmidi32.c                  |    1 
 sound/core/ioctl32/seq32.c                      |    1 
 sound/core/ioctl32/timer32.c                    |    1 
 sound/core/oss/mixer_oss.c                      |   74 -
 sound/core/oss/pcm_oss.c                        |   57 -
 sound/core/pcm.c                                |   50 -
 sound/core/pcm_lib.c                            |   12 
 sound/core/pcm_native.c                         |    8 
 sound/core/pcm_sgbuf.c                          |   52 +
 sound/core/rawmidi.c                            |   46 
 sound/core/seq/Makefile                         |   93 -
 sound/core/seq/instr/Makefile                   |    1 
 sound/core/seq/seq.c                            |    2 
 sound/core/seq/seq_device.c                     |   20 
 sound/core/seq/seq_lock.c                       |    2 
 sound/core/seq/seq_lock.h                       |    2 
 sound/core/sound.c                              |   10 
 sound/drivers/mpu401/mpu401.c                   |   14 
 sound/drivers/mpu401/mpu401_uart.c              |    7 
 sound/drivers/mtpav.c                           |   78 -
 sound/drivers/opl3/Makefile                     |   77 -
 sound/drivers/opl3/opl3_lib.c                   |   21 
 sound/drivers/opl3/opl3_seq.c                   |    1 
 sound/drivers/virmidi.c                         |    3 
 sound/isa/cs423x/cs4231_lib.c                   |   70 -
 sound/isa/cs423x/cs4236.c                       |    8 
 sound/isa/es18xx.c                              |  146 +-
 sound/isa/sb/sb16.c                             |   10 
 sound/isa/sb/sb16_main.c                        |    6 
 sound/isa/sb/sb_mixer.c                         |  320 +++++-
 sound/pci/Kconfig                               |    4 
 sound/pci/ac97/ac97_codec.c                     |  236 ++++
 sound/pci/ac97/ac97_id.h                        |    3 
 sound/pci/ac97/ac97_patch.c                     |   14 
 sound/pci/ac97/ac97_patch.h                     |    1 
 sound/pci/ali5451/ali5451.c                     |  141 +-
 sound/pci/als4000.c                             |   55 -
 sound/pci/cmipci.c                              |  453 ++++++++-
 sound/pci/cs4281.c                              |   10 
 sound/pci/cs46xx/cs46xx_lib.c                   |  297 +++---
 sound/pci/cs46xx/cs46xx_lib.h                   |    7 
 sound/pci/cs46xx/dsp_spos.c                     |   90 +
 sound/pci/cs46xx/dsp_spos.h                     |   26 
 sound/pci/cs46xx/dsp_spos_scb_lib.c             |  264 ++---
 sound/pci/emu10k1/emu10k1.c                     |    2 
 sound/pci/ens1370.c                             |   94 +
 sound/pci/es1938.c                              |    6 
 sound/pci/es1968.c                              |   67 -
 sound/pci/fm801.c                               |   62 -
 sound/pci/ice1712/Makefile                      |    2 
 sound/pci/ice1712/ak4524.c                      |   58 -
 sound/pci/ice1712/amp.c                         |   55 +
 sound/pci/ice1712/amp.h                         |   34 
 sound/pci/ice1712/delta.c                       |   32 
 sound/pci/ice1712/envy24ht.h                    |  203 ++++
 sound/pci/ice1712/ews.c                         |   17 
 sound/pci/ice1712/hoontech.c                    |    5 
 sound/pci/ice1712/hoontech.h                    |    8 
 sound/pci/ice1712/ice1712.c                     | 1020 ++++++++++++++++----
 sound/pci/ice1712/ice1712.h                     |    6 
 sound/pci/intel8x0.c                            |    6 
 sound/pci/korg1212/korg1212.c                   |    4 
 sound/pci/rme32.c                               |  182 ++-
 sound/pci/rme96.c                               |    6 
 sound/pci/rme9652/hammerfall_mem.c              |    2 
 sound/pci/rme9652/hdsp.c                        |   62 -
 sound/pci/rme9652/rme9652.c                     |    8 
 sound/pci/trident/trident.c                     |   10 
 sound/pci/trident/trident_main.c                |  676 +++++++------
 sound/pci/via82xx.c                             |    3 
 sound/synth/Makefile                            |    3 
 sound/usb/Kconfig                               |    2 
 sound/usb/usbaudio.c                            |   88 +
 sound/usb/usbaudio.h                            |    8 
 sound/usb/usbmidi.c                             |  131 +-
 sound/usb/usbmixer.c                            |  121 +-
 sound/usb/usbmixer_maps.c                       |    8 
 sound/usb/usbquirks.h                           |  116 ++
 102 files changed, 6111 insertions(+), 1871 deletions(-)

through these ChangeSets:

<perex@suse.cz> (02/12/18 1.885.1.5)
   ALSA update
     - intel8x0 - added NVidia NForce2 Audio PCI ID
     - USB driver - clenaups in the disconnect routine
     - added ALSA-Configuration.txt and ControlNames.txt documents

<perex@suse.cz> (02/12/17 1.885.1.4)
   HP100
     - fixed compilation problem when debug is active

<perex@suse.cz> (02/12/16 1.883.1.40)
   ALSA update
     - fixes in ALI5451 initalization
     - added snd_pci_alloc_page() workaround
     - FM801 - fixed PCI device identification
     - USB mixer - fixed min values for some types

<perex@suse.cz> (02/12/12 1.865.2.5)
   ALSA update
     - fixed compilation problems for rawmidi, sb16, ac97_codec, ens1370
     - ES1968 - added use_pm parameter
     - USB audio
       - complete callback follows 2.5
       - fixed support for FU and PU controls (mixer)
       - updated SB Extigy comments

<perex@suse.cz> (02/12/12 1.865.2.4)
   HP100 network driver - Pavel Machek <pavel@suse.cz>
     - TRUE/FALSE removal
     - detection of Coaxial wire

<perex@suse.cz> (02/12/11 1.865.2.3)
   ALSA update
     - CS46xx
       - volume bug fixes and phase reversal fix
       - AC3 stuff...
       - SPDIF input fix
     - init.c
       - used workqueue for the disconnection job
     - CMIPCI
       - S/PDIF output / PLL updates
     - ICE1712
       - fixed reversed volume for AK4524 and AK4528 codecs
       - added support for Hoontech STA DSP24 Media 7.1
     - USB audio
       - various mixer fixes
       - quirks for Edirol PCR-30/50 keyboards and Midiman hardware

<perex@suse.cz> (02/12/05 1.825.1.23)
   ALSA update
     - ALS4000 - improved mixer support
     - ICE1712 - added ICE1724 (Envy24HT code)
               - fixed Delta410 support
     - usbaudio - added quirks for more Yamaha devices

<perex@suse.cz> (02/12/05 1.825.1.22)
   ALSA update
     - control API - replace global control lock with semaphore
     - ac97 - added VT1616 support
     - add code for PC98 architecture
     - ENS1370/1371 - added gameport code
     - HDSP - fixed oops when device is not detected
     - replace __SMP__ with CONFIG_SMP
   
   
   

<perex@suse.cz> (02/12/04 1.825.1.21)
   ALSA update
     - Added hotplug support - disconnection of devices
     - usbaudio
       - added hotplug support
       - added support for resolution to ALSA mixer
     - ALI5451
       - added initialization for ALi 7101
     - via82xx
       - added rate initialization for all AC97 streams
     - RME HDSP
       - fixed multiface initialization
     - ICE1712
       - spin-lock cleanups

<perex@suse.cz> (02/11/23 1.797.126.1)
   ALSA update
     - CS46xx
       - SPDIF channel status implementation
       - mixer name cleanups
     - Trident
       - added S/PDIF device for SiS 7018
     - CS4281
       - fixed broken loops in suspend/resume routines
     - ENS1370
       - fixed driver names and rights for IEC958 Playback Mask
     - ICE1712
       - added possibility to lock the rate (pro-pcm device)
     - usbaudio
       - fixed rawmidi

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

