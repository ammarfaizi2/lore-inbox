Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVA0Hq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVA0Hq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVA0Hq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:46:56 -0500
Received: from gate.perex.cz ([82.113.61.162]:43453 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261969AbVA0HqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:46:12 -0500
Date: Thu, 27 Jan 2005 08:45:22 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ALSA PATCH] Intel HDA driver
Message-ID: <Pine.LNX.4.58.0501270823050.1743@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2005-01-26.patch.gz

Additional notes:

  - added Intel HDA driver (Azalia) - snd-hda-intel module
  - added support for compat/unlocked f_ops ioctl callbacks
  - removed obsolete sound/core/ioctl32 code
  - other small fixes

The pull command will update the following files:

 sound/core/ioctl32/Makefile                                  |   11 
 sound/core/ioctl32/hwdep32.c                                 |   73 
 sound/core/ioctl32/ioctl32.c                                 |  433 --
 sound/core/ioctl32/ioctl32.h                                 |  102 
 sound/core/ioctl32/pcm32.c                                   |  464 --
 sound/core/ioctl32/rawmidi32.c                               |   91 
 sound/core/ioctl32/seq32.c                                   |  116 
 sound/core/ioctl32/timer32.c                                 |  105 
 Documentation/sound/alsa/ALSA-Configuration.txt              |   33 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   29 
 Documentation/sound/alsa/VIA82xx-mixer.txt                   |    8 
 Documentation/sound/alsa/hda_codec.txt                       |  299 +
 include/sound/ak4117.h                                       |    6 
 include/sound/control.h                                      |    7 
 include/sound/hwdep.h                                        |    1 
 sound/core/Kconfig                                           |   14 
 sound/core/Makefile                                          |    1 
 sound/core/control.c                                         |  176 -
 sound/core/control_compat.c                                  |  412 ++
 sound/core/hwdep.c                                           |   25 
 sound/core/hwdep_compat.c                                    |   77 
 sound/core/init.c                                            |    2 
 sound/core/ioctl32/ioctl32.c                                 |    5 
 sound/core/ioctl32/pcm32.c                                   |    3 
 sound/core/memory.c                                          |    4 
 sound/core/oss/mixer_oss.c                                   |   21 
 sound/core/oss/pcm_oss.c                                     |   22 
 sound/core/pcm.c                                             |    2 
 sound/core/pcm_compat.c                                      |  513 +++
 sound/core/pcm_memory.c                                      |    2 
 sound/core/pcm_native.c                                      |   37 
 sound/core/rawmidi.c                                         |   34 
 sound/core/rawmidi_compat.c                                  |  120 
 sound/core/seq/oss/seq_oss.c                                 |   21 
 sound/core/seq/oss/seq_oss_midi.c                            |    2 
 sound/core/seq/oss/seq_oss_synth.c                           |    2 
 sound/core/seq/seq_clientmgr.c                               |   20 
 sound/core/seq/seq_compat.c                                  |  137 
 sound/core/seq/seq_queue.c                                   |    2 
 sound/core/sound.c                                           |    4 
 sound/core/timer.c                                           |   25 
 sound/core/timer_compat.c                                    |  119 
 sound/drivers/vx/vx_core.c                                   |   13 
 sound/drivers/vx/vx_hwdep.c                                  |    1 
 sound/isa/gus/gus_pcm.c                                      |    1 
 sound/isa/gus/gus_reset.c                                    |    7 
 sound/isa/sb/emu8000.c                                       |    4 
 sound/isa/wavefront/wavefront_synth.c                        |    1 
 sound/pci/Kconfig                                            |   12 
 sound/pci/Makefile                                           |    1 
 sound/pci/ac97/ac97_codec.c                                  |   73 
 sound/pci/ac97/ac97_local.h                                  |    6 
 sound/pci/ac97/ac97_patch.c                                  |   26 
 sound/pci/atiixp.c                                           |    6 
 sound/pci/atiixp_modem.c                                     |   23 
 sound/pci/hda/Makefile                                       |    7 
 sound/pci/hda/hda_codec.c                                    | 1731 +++++++++++
 sound/pci/hda/hda_codec.h                                    |  602 +++
 sound/pci/hda/hda_generic.c                                  |  898 +++++
 sound/pci/hda/hda_intel.c                                    | 1455 +++++++++
 sound/pci/hda/hda_local.h                                    |  159 +
 sound/pci/hda/hda_patch.h                                    |   14 
 sound/pci/hda/hda_proc.c                                     |  298 +
 sound/pci/hda/patch_cmedia.c                                 |  614 +++
 sound/pci/hda/patch_realtek.c                                | 1174 +++++++
 sound/pci/ice1712/vt1720_mobo.c                              |    9 
 sound/pci/ice1712/vt1720_mobo.h                              |    4 
 sound/pci/intel8x0.c                                         |   20 
 sound/pci/rme9652/hdsp.c                                     |    2 
 sound/pci/vx222/vx222_ops.c                                  |    1 
 sound/pcmcia/vx/vxp_ops.c                                    |    1 
 sound/usb/usbaudio.c                                         |    2 
 sound/usb/usbaudio.h                                         |    3 
 sound/usb/usbquirks.h                                        |   81 
 75 files changed, 9124 insertions(+), 1708 deletions(-)

through these ChangeSets:

<perex@suse.cz> (05/01/25 1.1983.1.27)
   [ALSA] replace schedule_timeout() with msleep()
   
   EMU8000 driver
   Use msleep() instead of schedule_timeout() to guarantee the task
   delays as expected.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.26)
   [ALSA] insert set_current_state() before schedule_timeout()
   
   Wavefront drivers
   Insert set_current_state() before schedule_timeout(). Without the
   insertion, schedule_timeout() returns immediately, resulting in an
   effective busy-wait.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.25)
   [ALSA] replace schedule_timeout() with msleep_interruptible()
   
   GUS Library
   Use msleep_interruptible() instead of custom wait code involving
   schedule_timeout() to guarantee the task delays as expected. This also
   removes a dependence on the value of HZ.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.24)
   [ALSA] insert set_current_state() before schedule_timeout()
   
   GUS Library
   Insert set_current_state() before schedule_timeout(). Without the
   insertion, schedule_timeout() returns immediately.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.23)
   [ALSA] replace schedule_timeout() with msleep()
   
   Digigram VX core
   Use msleep() instead of schedule_timeout() to guarantee the task
   delays as expected.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.22)
   [ALSA] replace schedule_timeout() with msleep()
   
   RawMidi Midlevel
   Use msleep instead of schedule_timeout() to guarantee the task delays
   as expected. This also removes a dependence on the value of HZ.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.21)
   [ALSA] Special AC97 patch for ASUS W1000/CMI9739 laptop
   
   AC97 Codec
   This patch fixes sound output on the ASUS W1000 laptop with the CMI9739
   chip. It wrongly reports that it has a SPDIF in, when in fact we wish to
   use the EAPD pin.
   
   Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.20)
   [ALSA] Warning doc about VIA82xx recording
   
   Documentation
   Add warning about the consequences of adjusting the 'Input Source Select'
   of VIA82xx.
   
   Signed-off-by: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1983.1.19)
   [ALSA] fix usage of preprocessor directive inside macro
   
   HDA Intel driver
   gcc-2 complains about preprocessor directives inside a macro argument list
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/25 1.1983.1.18)
   [ALSA] add more Yamaha USB MIDI quirks
   
   USB generic driver
   add support for Yamaha UC-MX, UC-KX, CLP-175, SPX2000
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/20 1.1983.1.17)
   [ALSA] remove obsolete sound/core/ioctl32 directory
   
   The compatibility layer is integrated to ALSA midlevel code now.

<perex@suse.cz> (05/01/20 1.1975.47.31)
   [ALSA] Use DEFINE_SPINLOCK(), DEFINE_RWLOCK() macros
   
   ALSA Core,PCM Midlevel,Timer Midlevel,ALSA sequencer
   ALSA<-OSS sequencer
   Replace spin/rwlock definitions with DEFINE_SPINLOCK() and DEFINE_RWLOCK()
   macros.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.30)
   [ALSA] Remove snd-ioctl32 entry
   
   ALSA Core
   Remove the entry for snd-ioctl32.  The 32bit wrapper is built in the core
   module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.29)
   [ALSA] Export new register/unregister functions
   
   ALSA Core
   Export new register/unregister functions for compat control-ioctls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.28)
   [ALSA] unlocked/compat_ioctl rewrite for OSS compatible drivers
   
   ALSA<-OSS emulation,ALSA<-OSS sequencer
   The ioctl handlers for OSS compatible drivers are rewritten using
   unlocked/compat_ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.27)
   [ALSA] unlocked/compat_ioctl rewrite for hwdep, rawmidi, timer and sequencer API
   
   HWDEP Midlevel,RawMidi Midlevel,Timer Midlevel,ALSA sequencer
   The ioctl handler for hwdep, rawmidi, timer and sequencer API are rewritten
   using unlocked/compat_ioctl.
   The 32bit wrapper is merged to the core module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.26)
   [ALSA] unlocked/compat_ioctl rewrite for PCM API
   
   PCM Midlevel
   The ioctl handler for PCM API is rewritten using unlocked/compat_ioctl.
   The 32bit wrapper is merged to the core module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.25)
   [ALSA] unlocked/compat_ioctl rewrite for control API
   
   Control Midlevel
   ioctl handler for control API is rewritten using unlocked/compat_ioctl.
   The 32bit wrapper is merged to the core module.
   
   Added a new register/unregister function for compat control ioctls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.24)
   [ALSA] Add Intel HDA driver
   
   Documentation,PCI drivers,HDA generic driver,HDA Codec driver
   HDA Intel driver
   Added a new Intel High-Definition audio driver.
   The driver consists of two separate modules: the generic support
   module for HD codecs (snd-hda-codec), and the driver for Intel ICH6/7
   chipset (snd-hda-intel).  The snd-hda-intel was called formerly
   snd-azx in the ALSA 1.0.8 rlease.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.23)
   [ALSA] Enable HP jack sense for FSC Scenic-W
   
   AC97 Codec
   Enable 'Headphone Jack Sense' control on FSC Scenic-W as default, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.22)
   [ALSA] Add quirk for HP nc8000
   
   Intel8x0 driver
   Added ac97 quirk for HP nc8000.
   The list is sorted again.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.21)
   [ALSA] Add quirk for HP pavilion ZV5030US
   
   ATIIXP driver
   Added ac97 quirk for HP Pavilion ZV5030US to bind the control with
   mute-LED.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.20)
   [ALSA] Simplify the general ac97 volume/switch callback
   
   AC97 Codec
   Simplified the control callbacks of general AC97 volumes/switches.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.19)
   [ALSA] Add missing inclusion of linux/device.h
   
   Digigram VX core,Digigram VX222 driver,Digigram VX Pocket driver
   Added the missing inclusion of <linux/device.h>
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.18)
   [ALSA] Add workaround for buggy ATI IXP hardwares
   
   ATIIXP-modem driver
   Added a workaround for buggy ATI IXP hardwares which returns
   bogus DMA pointer register value.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.17)
   [ALSA] Add support for Chaintech 9CJS
   
   ICE1712 driver
   Added the support for Chaintech 9CJS by Delmaire Maxime.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.16)
   [ALSA] AK4117 code - fixed cosmetic typos
   
   AK4117 receiver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/01/20 1.1975.47.15)
   [ALSA] don't use broken legacy interfaces on M-Audio Quattro/Omnistudio
   
   USB generic driver
   Interfaces 0-2 of M-Audio Quattro/Omnistudio devices duplicate functionality
   of interfaces 3-5 and cause errors when used with those.  Add a quirk to
   tell the driver not to use them.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/20 1.1975.47.14)
   [ALSA] Fix silent output on some machines with AD1981x codecs
   
   AC97 Codec
   Fixed the default state of 'Headphone Jack Sense' switch on AD1981x
   codecs.  Setting this on affects the output of some machines (e.g.
   Thindpads).
   
   The default value is set on only hardwares which are known to work.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.13)
   [ALSA] AC'97 Audio support for Intel ICH7
   
   Intel8x0 driver
   This patch adds the ICH7 AC'97 DID the the intel8x0.c AC'97 audio
   driver. This patch was build against 2.6.11-rc1.
   
   Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.12)
   [ALSA] Fix compilation on big-endian arch
   
   RME HDSP driver
   Fixed typo in the code for big-endian architectures.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.11)
   [ALSA] Show firmware loading state in proc file
   
   Digigram VX core
   Show the firmware loading state in proc file.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.10)
   [ALSA] Fix struct size mismatch
   
   IOCTL32 emulation
   Fixed the struct size mismatch - should work on SPARC64 now, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.9)
   [ALSA] Add missing FORWARD ioctl
   
   IOCTL32 emulation
   Added the missing FORWARD ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.8)
   [ALSA] Fix struct alignment on PPC64
   
   IOCTL32 emulation
   Fixed the struct size mismatch (due to alignment) of
   snd_ctl_elem_value_t for PPC64.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.7)
   [ALSA] fix typo
   
   Documentation
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/20 1.1975.47.6)
   [ALSA] Fix typos in doc
   
   Documentation
   Fixed typos in the document by Kirill Smelkov <kirr@mns.spb.ru>
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1975.47.5)
   ALSA CVS update
   PCM Midlevel
   Sumary: Fix comment of snd_pcm_lib_malloc_pages()
   
   Fixed comment of snd_pcm_lib_malloc_pages() by
   Kirill Smelkov <kirr@mns.spb.ru>.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
