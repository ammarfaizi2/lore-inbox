Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262138AbSJNTnD>; Mon, 14 Oct 2002 15:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbSJNTnD>; Mon, 14 Oct 2002 15:43:03 -0400
Received: from gate.perex.cz ([194.212.165.105]:21005 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262138AbSJNTnB>;
	Mon, 14 Oct 2002 15:43:01 -0400
Date: Mon, 14 Oct 2002 21:45:10 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: ALSA update
Message-ID: <Pine.LNX.4.33.0210142139080.7202-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-sound.bkbits.net/linux-sound

This set of changes allows compilation without procfs and fixes next 
problems reported on lkml. The major part of code is reducing stack usage 
in several functions using kmalloc(). Also, USB audio/midi code has been 
updated.

					Jaroslav

This will update the following files:

 include/sound/asound.h                |    3 
 include/sound/core.h                  |    1 
 include/sound/info.h                  |    6 
 include/sound/version.h               |    4 
 sound/core/control.c                  |   34 +-
 sound/core/hwdep.c                    |    8 
 sound/core/info_oss.c                 |    2 
 sound/core/init.c                     |    2 
 sound/core/ioctl32/ioctl32.c          |   76 +++---
 sound/core/ioctl32/ioctl32.h          |   38 +++
 sound/core/ioctl32/pcm32.c            |   52 ++--
 sound/core/memory.c                   |    8 
 sound/core/oss/mixer_oss.c            |  174 +++++++++-----
 sound/core/oss/pcm_oss.c              |    4 
 sound/core/pcm_lib.c                  |   66 ++---
 sound/core/pcm_native.c               |  140 ++++++-----
 sound/core/rawmidi.c                  |   16 -
 sound/core/seq/oss/seq_oss_readq.c    |    7 
 sound/core/seq/oss/seq_oss_synth.c    |    4 
 sound/core/seq/oss/seq_oss_writeq.c   |    4 
 sound/core/seq/seq.c                  |    4 
 sound/core/seq/seq_clientmgr.c        |    8 
 sound/core/seq/seq_fifo.c             |    4 
 sound/core/seq/seq_lock.c             |    2 
 sound/core/seq/seq_lock.h             |    9 
 sound/core/seq/seq_memory.c           |   12 -
 sound/core/sound.c                    |   11 
 sound/core/sound_oss.c                |   12 -
 sound/core/timer.c                    |    4 
 sound/isa/es18xx.c                    |   24 +-
 sound/isa/opl3sa2.c                   |    1 
 sound/isa/sb/emu8000.c                |    2 
 sound/isa/wavefront/wavefront_synth.c |    2 
 sound/pci/Config.help                 |    2 
 sound/pci/Config.in                   |   21 -
 sound/pci/emu10k1/emufx.c             |   27 +-
 sound/pci/ens1370.c                   |    6 
 sound/pci/ymfpci/ymfpci_main.c        |    6 
 sound/usb/usbaudio.c                  |   28 +-
 sound/usb/usbmixer.c                  |  405 ++++++++++++++++++++++------------
 sound/usb/usbmixer_maps.c             |  100 ++++++++
 sound/usb/usbquirks.h                 |   66 ++---
 42 files changed, 922 insertions(+), 483 deletions(-)

through these ChangeSets:

<perex@suse.cz> (02/10/14 1.839)
   ALSA update
     - ES18xx - fixed detection and initialization of opl3 and mpu401
     - ENS1370 - make inclusion of *_codec.h selective for each chipset
     - usb audio
       - unified get_min_max() function to retrieve the min and max values
       - added the debug condition to ignore the error at get/put callbacks
       - quirks - use USB_DEVICE without class interface

<perex@suse.cz> (02/10/14 1.838)
   ALSA update
     - reduced stack usage for functions using >1024+ bytes
     - fixed behaviour when OSS emulation is selected
     - fix in kmod support for sequencer

<perex@suse.cz> (02/10/13 1.837)
   ALSA update
     - compilation fixes without CONFIG_PROC_FS

<perex@suse.cz> (02/10/13 1.836)
   ALSA update
     - USB driver update
       - better extdigi support (mixer)
       - cleanups in the audio code

<perex@suse.cz> (02/10/13 1.835)
   ALSA update
     - added SNDRV_PCM_IOCTL_HWSYNC ioctl
     - changed behaviour of read/write/poll functions
       - prefer waiting than return an error code
     - removed snd_seq_sleep_timeout_in_lock and snd_seq_sleep_in_lock helpers

<perex@suse.cz> (02/10/13 1.834)
   ALSA update
     - fixes for compilation without CONFIG_PROC_FS

<perex@suse.cz> (02/10/13 1.833)
   ALSA update
     - reduced stack usage (>1024 bytes) in ioctl32 routines and PCM routines
     - PCM midlevel - fixed drop in release()
     - OPL3SA2 - removed wrong inclusion of <linux/isapnp.h>
     - EMU8000 - fixed compilation when sequencer is not selected
     - Wavefront - fixed compilation for GCC3
     - fixed gameport dependency in pci/Config.in
     - EMU10K1 - fixed icode peek ioctl in emufx()
     - YMFPCI - added FM legacy volume control

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

