Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSKJUkJ>; Sun, 10 Nov 2002 15:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSKJUkJ>; Sun, 10 Nov 2002 15:40:09 -0500
Received: from gate.perex.cz ([194.212.165.105]:37386 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265169AbSKJUkI>;
	Sun, 10 Nov 2002 15:40:08 -0500
Date: Sun, 10 Nov 2002 21:44:22 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: ALSA update
Message-ID: <Pine.LNX.4.33.0211102142260.748-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

	ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2002-11-10.patch.gz

					Jaroslav

This will update the following files:

 include/sound/core.h                |    6 
 include/sound/cs4231.h              |   45 ++
 include/sound/cs46xx.h              |   83 ---
 include/sound/cs46xx_dsp_spos.h     |   45 +-
 include/sound/info.h                |    3 
 include/sound/pcm.h                 |    4 
 include/sound/pcm_sgbuf.h           |    2 
 include/sound/version.h             |    2 
 sound/core/info.c                   |   19 
 sound/core/init.c                   |  102 +++-
 sound/core/oss/pcm_oss.c            |   10 
 sound/core/pcm_native.c             |   16 
 sound/core/pcm_sgbuf.c              |   24 -
 sound/core/rawmidi.c                |    4 
 sound/core/seq/seq_prioq.c          |    1 
 sound/i2c/l3/uda1341.c              |    4 
 sound/isa/cs423x/cs4231_lib.c       |  247 ++++++++---
 sound/isa/es18xx.c                  |    8 
 sound/isa/sb/emu8000_pcm.c          |   22 -
 sound/pci/ac97/ac97_codec.c         |   31 +
 sound/pci/ac97/ac97_id.h            |    1 
 sound/pci/ac97/ac97_patch.c         |   12 
 sound/pci/ac97/ac97_patch.h         |    1 
 sound/pci/ali5451/ali5451.c         |    9 
 sound/pci/cs46xx/cs46xx.c           |   17 
 sound/pci/cs46xx/cs46xx_lib.c       |  751 +++++++++++++++++++++++++++++-------
 sound/pci/cs46xx/cs46xx_lib.h       |   33 +
 sound/pci/cs46xx/dsp_spos.c         |  125 +++--
 sound/pci/cs46xx/dsp_spos.h         |   25 +
 sound/pci/cs46xx/dsp_spos_scb_lib.c |  326 +++++++++++++--
 sound/pci/ens1370.c                 |  305 ++++++++++----
 sound/pci/ice1712/ak4524.c          |  178 ++++++--
 sound/pci/ice1712/delta.c           |   26 +
 sound/pci/ice1712/delta.h           |    6 
 sound/pci/ice1712/ews.c             |    3 
 sound/pci/ice1712/ice1712.c         |   46 --
 sound/pci/ice1712/ice1712.h         |    6 
 sound/pci/rme9652/hammerfall_mem.c  |    3 
 sound/pci/via82xx.c                 |   56 +-
 sound/sparc/amd7930.c               |    1 
 sound/usb/usbaudio.c                |   76 ++-
 sound/usb/usbaudio.h                |   11 
 sound/usb/usbmidi.c                 |  111 +++--
 43 files changed, 2069 insertions(+), 737 deletions(-)

through these ChangeSets:

<perex@suse.cz> (02/11/10 1.809)
   ALSA update
      - CS4231 - added sparc support to merge sparc/cs4231.c code
      - ICE1712
        - added support for AK4529
        - added support for Midiman M-Audio Delta410
      - USB driver
        - fixed against newer USB API but allow compilation under 2.4

<perex@suse.cz> (02/11/10 1.808)
   ALSA update
      - CS46xx driver
        - DSP is started after initializing AC97 codecs
        - rewrite SPDIF output stuff
        - variable period size support on playback and capture
        - DAC volume mechanism  rewrite
        - IEC958 input volume mechanism rewrite
        - added "AC3 Mode Switch" in mixer
        - code cleanups
      - ENS1371 driver
        - added definitions for the ES1373 chip
        - added code to control IEC958 (S/PDIF) channel status register

<perex@suse.cz> (02/11/10 1.807)
   ALSA update
     - Moved initialization of card->id to card_register() function.
       The new default id is composed from the shortname given by driver.
     - ES18xx - Fixed power management defines
     - VIA82xx - The SG table is build inside hw_params (outside spinlock - memory allocation).

<perex@suse.cz> (02/11/10 1.806)
   ALSA update - small patches
     - added kmalloc_nocheck and vmalloc_nocheck macros
     - PCM
       - the page callback returns 'struct page *'
       - fixed delay function (moved put_user call outside spinlock)
     - OSS PCM emulation
       - fixed read() lock when stream was terminated and no data is available
     - EMU8000
      - added 'can schedule' condition to snd_emu8000_write_wait()
     - AC'97
      - added ALC650 support
     - ALI5451
       - removed double free

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

