Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUKOUj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUKOUj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKOUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:39:23 -0500
Received: from gate.perex.cz ([82.113.61.162]:19910 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261692AbUKOUfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:35:39 -0500
Date: Mon, 15 Nov 2004 21:34:35 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ALSA 1.0.7
Message-ID: <Pine.LNX.4.58.0411150737280.2160@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-11-13.patch.gz

Additional notes:

  This patch contains mainly bugfixes. Especially, the emu10k1/2 structure
  to handle the DSP code was updated (it's now bellow 8kB now).

  Also the OSS PCI API emulation returns -EBUSY in open() now by default
  (it does not block).

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |    1 
 Documentation/sound/alsa/Bt87x.txt                           |   78 +
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   10 
 Documentation/sound/alsa/OSS-Emulation.txt                   |   11 
 include/sound/ad1848.h                                       |    5 
 include/sound/ainstr_fm.h                                    |    2 
 include/sound/ainstr_gf1.h                                   |    2 
 include/sound/ainstr_iw.h                                    |    2 
 include/sound/ainstr_simple.h                                |    2 
 include/sound/asound.h                                       |    3 
 include/sound/core.h                                         |    1 
 include/sound/emu10k1.h                                      |   18 
 include/sound/es1688.h                                       |    2 
 include/sound/version.h                                      |    4 
 sound/Kconfig                                                |    2 
 sound/core/info.c                                            |   15 
 sound/core/init.c                                            |    3 
 sound/core/oss/pcm_oss.c                                     |    2 
 sound/core/seq/instr/ainstr_fm.c                             |    5 
 sound/core/seq/instr/ainstr_gf1.c                            |    5 
 sound/core/seq/instr/ainstr_iw.c                             |    5 
 sound/core/seq/instr/ainstr_simple.c                         |    5 
 sound/core/seq/oss/seq_oss_timer.c                           |    2 
 sound/core/seq/seq_clientmgr.c                               |    2 
 sound/core/sound.c                                           |    1 
 sound/isa/ad1848/ad1848_lib.c                                |   18 
 sound/isa/cs423x/cs4231_lib.c                                |   21 
 sound/isa/es1688/es1688_lib.c                                |    3 
 sound/isa/gus/gus_sample.c                                   |    2 
 sound/pci/Kconfig                                            |    5 
 sound/pci/au88x0/au88x0.c                                    |   15 
 sound/pci/au88x0/au88x0.h                                    |    6 
 sound/pci/au88x0/au88x0_core.c                               |   29 
 sound/pci/au88x0/au88x0_eq.c                                 |   58 
 sound/pci/au88x0/au88x0_mixer.c                              |    4 
 sound/pci/au88x0/au88x0_pcm.c                                |    4 
 sound/pci/bt87x.c                                            |  149 +-
 sound/pci/emu10k1/Makefile                                   |    2 
 sound/pci/emu10k1/emu10k1.c                                  |    6 
 sound/pci/emu10k1/emufx.c                                    |  265 ++-
 sound/pci/emu10k1/irq.c                                      |    4 
 sound/pci/emu10k1/timer.c                                    |   99 +
 sound/pci/es1968.c                                           |    6 
 sound/pci/trident/trident_synth.c                            |    2 
 sound/pci/via82xx.c                                          |    1 
 sound/pci/vx222/vx222.c                                      |    4 
 sound/sparc/cs4231.c                                         |   17 
 sound/usb/usbmixer.c                                         |   68 
 sound/usb/usx2y/usX2Yhwdep.c                                 |   10 
 sound/usb/usx2y/usbusx2y.c                                   |   25 
 sound/usb/usx2y/usbusx2y.h                                   |   45 
 sound/usb/usx2y/usbusx2yaudio.c                              |  769 +++++------
 52 files changed, 1096 insertions(+), 729 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/11/11 1.2103)
   ALSA 1.0.7

<perex@suse.cz> (04/11/11 1.2102)
   [ALSA] nonblock_open=1 by default for OSS PCM API emulation
   
   Documentation,ALSA<-OSS emulation
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2101)
   [ALSA] fix parsing of mixer unit descriptors
   
   USB generic driver
   MU descriptor parsing code completely rewritten; the old code confused
   the number of input audio channel clusters and the number of input
   channels.  Furthermore, check all bmControls bits so that mixer
   controls are created even if the first output channel doesn't have
   a control.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2100)
   [ALSA] read bmControls array in correct order
   
   USB generic driver
   The driver used some code from audio.c that reads the bmControl array
   backwards; this would not work here as we get a pointer to the
   beginning of the array.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2099)
   [ALSA] handle missing control bitmap when parsing MUDs
   
   USB generic driver
   The AudioTrak Maya44 USB has a mixer unit descriptor without a
   bmControl field; handle this as if all bits are zero.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2098)
   [ALSA] emu10k1 - fixed remaining problems with new DSP code loading
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2097)
   [ALSA] [emu10k1] add interval timer support
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2096)
   [ALSA] Fixed issues with Abit AV8
   
   VIA82xx driver
   Added Abit AV8 sound card to the white list to use
   VIA_DXS_NO_VRA by default. This resolves issues with
   programs wanting to use 41k streams. It also fixes
   gstreamer issue with alsasink module interaction.
   
   Signed-off-by: Jerone Young <jerone@gmail.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2095)
   [ALSA] Add subvendor ID to the pci id table of vx222 driver
   
   Digigram VX222 driver
   The subsystem ID is added to the pci id table of vx222 driver
   to make the matching more strict since it (PLX) conflicts with
   other devices.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2094)
   [ALSA] removes unneeded spin_lock_irqsave()s from snd-es1968
   
   ES1968 driver
   spin_lock_irqsave(&chip->reg_lock) was called a second time in sequence from
   snd_es1968_bob_start() called from es1968_measure_clock().
   While this didn't cause harm on my UP laptop with mainline kernels,
   it made 'insmod snd-es1968' hang on kernel 2.6.9-mm1-RT-V0.6.9.
   The patch assumes that 2 callpaths don't need explicit spinlock protection:
   1: The trigger callback, because it is called with IRQs disabled.
   2. PM's suspend/resume callbacks, because  those are called while ortdinary
      user processes are frozen.
      Thus the spin_lock_irqsave(&chip->reg_lock)  calls in snd_es1968_bob_start()
      / snd_es1968_bob_stop() are not needed.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2093)
   [ALSA] Fixed the description of module_parm_array()
   
   Documentation
   Fixed the description about module_param_array() for the latest change.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2092)
   [ALSA] remove snd_seq_simple_id
   
   Instrument layer,GUS Library,Trident driver
   remove uses of the snd_seq_simple_id symbol because it is
   no longer exported
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2091)
   [ALSA] Added SNDRV_HWDEP_IFACE_BLUETOOTH
   
   ALSA Core
   
   
   Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2090)
   [ALSA] emu10k1 - another attempt to correct the new emufx DSP code
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2089)
   [ALSA] replace schedule_timeout() with msleep()
   
   SPARC cs4231 driver
   Uses msleep() instead of schedule_timeout() to guarantee the task
   delays as expected.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2088)
   [ALSA] replace schedule_timeout() with msleep()
       
   CS4231 driver
   Uses msleep() instead of schedule_timeout() to guarantee
   the task delays as expected. This lead to several related changes, as
   the current code assumes the value of HZ is 100. Use timeout as an
   iteration variable to count out how many 10ms delays should be used.
       
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/30 1.2026.40.2)
   [ALSA] emu10k1 - fixes against the last emufx changes
   
   EMU10K1/EMU10K2 driver
   The indirect pointers are allocated correctly now for default DSP code.
   Also, one bug in emu10k1_fx8010_code_t has been fixed as well.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.16)
   [ALSA] fixed emu10k1_fx8010_code_t structure to be less than 8192 bytes
   
   EMU10K1/EMU10K2 driver
   This patch fixes emu10k1_fx8010_code_t structure using indirect pointers
   to be less than 8192 bytes to follow the ioctl semantics.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.15)
   [ALSA] remove kernel version info from proc file
   
   ALSA Core
   The kernel version information isn't necessary for the driver
   in the kernel tree, so move it to the alsa-driver package.
   
   This removes a dependency to <linux/version.h>.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.14)
   [ALSA] Limit parity error messages
   
   BT87x driver
   Some systems generate tons of PCI parity errors, so shut up
   when more than 20 have been detected.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.13)
   [ALSA] remove dead exports
   
   ALSA Core,Instrument layer,AD1848 driver,ES1688 driver
   Alsa currently has tons of dead exports, often with totally unused
   functions behind them.
   This removes some of them.
   
   Signed-off-by: Christoph Hellwig <hch@lst.de>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.12)
   [ALSA] remove old compatibility code
   
   USB USX2Y
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.11)
   [ALSA] fix data type mismatch in sign_invert
   
   au88x0 driver
   the last sign_invert cleanup introduced a data type mismatch
   (an unsigned value can never be negative)
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.10)
   [ALSA] au88x0: comment and whitespace cleanup
   
   au88x0 driver
   Remove an obsolete comment and cleanup up some whitespace a bit
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.9)
   [ALSA] au88x0: name typo
   
   au88x0 driver
   Fix the spelling of my name
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.8)
   [ALSA] au88x0: sign_invert cleanup
   
   au88x0 driver
   Remove unecessary ' & 0xffff'ing of the result of sign_invert
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.7)
   [ALSA] au88x0: set-levels cleanup
   
   au88x0 driver
   Cleanup vortex_EqHw_SetLevels and add a bit of documentation
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.6)
   [ALSA] au88x0: fix is-quad oops
   
   au88x0 driver
   Fixes an oops on module removal caused by dereferencing the codec pointer.
   This is not the best solution, but it is the easiest and fixes things for
   now.
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.5)
   [ALSA] au88x0: add resetup dma
   
   au88x0 driver
   Add adbdma_resetup for refreshing the hw page table on pcm start
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.4)
   [ALSA] snd-usb-usx2y - crash fix for OHCI USB-HCDs
   
   USB USX2Y
   Version: 0.8.6
   Work on this started, when rumors spread that OHCI equipped machines would
   crash. This was due to me missing two facts:
   1) Ohci has a bigger usb frame number wrap around.
   2) It only supports URB_ISO_ASAP when submitting iso urbs.
   These issues are fixed now.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.39.3)
   [ALSA] rearrange OSS SPARC dependencies
   
   Sound Core
   rearrange the SPARC symbols in the OSS dependencies to
   prevent alsa-driver's mod-deps from throwing up
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.2)
   [ALSA] fix sequencer sleeping in interrupt context
   
   ALSA sequencer,ALSA<-OSS sequencer
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.39.1)
   [ALSA] use blacklist/whitelist for (non-)audio Bt878 cards
   
   Documentation,PCI drivers,BT87x driver
   Some Bt87x cards use PCI function 1 for MPEG data instead of
   audio data, so we blacklist those in the audio driver.
   
   Further add a whitelist for cards where audio is known to work
   (many other cards do not implement the audio connection).
   Unknown cards can be enabled manually.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
