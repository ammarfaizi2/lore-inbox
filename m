Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266375AbUAHUWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUAHUWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:22:50 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:28106 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S266375AbUAHUVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:21:48 -0500
Date: Thu, 8 Jan 2004 21:15:07 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ALSA 1.0.1
Message-ID: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The ALSA 1.0.1 code for 2.6 kernels is available. I think that this update
might be included into -mm or standard 2.6 kernels.

BitKeeper:

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-01-08.patch.gz

Summary:

  - use pci_set_consistent_dma_mask()
  - control midlevel - added user control elements, fixes
  - timer midlevel - fixes
  - OSS PCM emulation - fixes and updates
  - joystick support selectable using module parameter
  - AC'97 code - introduced ac97_bus_t and pcm support code
  - USB audio driver updated
  - VIA82xx driver updated
  - EMU10K1 driver updated
  - ICE1712 driver updated
  - CMIPCI driver updated
  - AD1848 driver updated
  - Digigram VX library updated
  - HDSP driver updated

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |  266 -
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  123 
 Documentation/sound/alsa/Joystick.txt                        |   97 
 Documentation/sound/alsa/OSS-Emulation.txt                   |    3 
 include/sound/ac97_codec.h                                   |  109 
 include/sound/asequencer.h                                   |    2 
 include/sound/asound.h                                       |    7 
 include/sound/asound_fm.h                                    |    4 
 include/sound/cs46xx.h                                       |    1 
 include/sound/emu10k1.h                                      |   30 
 include/sound/hdsp.h                                         |   21 
 include/sound/i2c.h                                          |   10 
 include/sound/info.h                                         |    5 
 include/sound/initval.h                                      |   36 
 include/sound/minors.h                                       |    3 
 include/sound/pcm.h                                          |    2 
 include/sound/pcm_oss.h                                      |    2 
 include/sound/sb.h                                           |    3 
 include/sound/seq_kernel.h                                   |    2 
 include/sound/sndmagic.h                                     |    2 
 include/sound/sscape_ioctl.h                                 |    4 
 include/sound/trident.h                                      |    1 
 include/sound/version.h                                      |   16 
 include/sound/ymfpci.h                                       |   13 
 sound/core/control.c                                         |  312 ++
 sound/core/hwdep.c                                           |    3 
 sound/core/info_oss.c                                        |    1 
 sound/core/init.c                                            |   24 
 sound/core/memalloc.c                                        |   28 
 sound/core/memory.c                                          |    1 
 sound/core/misc.c                                            |    6 
 sound/core/oss/mixer_oss.c                                   |   44 
 sound/core/oss/pcm_oss.c                                     |  119 
 sound/core/pcm.c                                             |   78 
 sound/core/pcm_lib.c                                         |  106 
 sound/core/pcm_native.c                                      |   71 
 sound/core/rawmidi.c                                         |    1 
 sound/core/seq/oss/seq_oss.c                                 |    3 
 sound/core/seq/seq.c                                         |    4 
 sound/core/seq/seq_clientmgr.c                               |    4 
 sound/core/seq/seq_clientmgr.h                               |    2 
 sound/core/seq/seq_device.c                                  |    3 
 sound/core/seq/seq_dummy.c                                   |    2 
 sound/core/seq/seq_fifo.c                                    |    2 
 sound/core/seq/seq_fifo.h                                    |    2 
 sound/core/seq/seq_info.c                                    |    2 
 sound/core/seq/seq_info.h                                    |    2 
 sound/core/seq/seq_memory.c                                  |    2 
 sound/core/seq/seq_memory.h                                  |    2 
 sound/core/seq/seq_midi.c                                    |    4 
 sound/core/seq/seq_ports.c                                   |    2 
 sound/core/seq/seq_ports.h                                   |    2 
 sound/core/seq/seq_prioq.c                                   |    2 
 sound/core/seq/seq_prioq.h                                   |    2 
 sound/core/seq/seq_queue.c                                   |    2 
 sound/core/seq/seq_queue.h                                   |    2 
 sound/core/seq/seq_system.c                                  |    2 
 sound/core/seq/seq_system.h                                  |    2 
 sound/core/seq/seq_timer.c                                   |    4 
 sound/core/seq/seq_timer.h                                   |    4 
 sound/core/sound.c                                           |   23 
 sound/core/sound_oss.c                                       |    1 
 sound/core/timer.c                                           |  116 
 sound/drivers/mpu401/mpu401.c                                |    2 
 sound/drivers/mtpav.c                                        |    2 
 sound/drivers/opl3/opl3_synth.c                              |    1 
 sound/drivers/opl4/opl4_proc.c                               |   13 
 sound/drivers/serial-u16550.c                                |  120 
 sound/drivers/vx/vx_core.c                                   |    2 
 sound/drivers/vx/vx_pcm.c                                    |    8 
 sound/i2c/cs8427.c                                           |   13 
 sound/i2c/i2c.c                                              |    2 
 sound/i2c/l3/uda1341.c                                       |    6 
 sound/i2c/other/ak4xxx-adda.c                                |   12 
 sound/isa/ad1816a/ad1816a.c                                  |    6 
 sound/isa/ad1848/ad1848.c                                    |    2 
 sound/isa/ad1848/ad1848_lib.c                                |    2 
 sound/isa/als100.c                                           |   10 
 sound/isa/azt2320.c                                          |   10 
 sound/isa/cmi8330.c                                          |    4 
 sound/isa/cs423x/cs4231.c                                    |   13 
 sound/isa/cs423x/cs4236.c                                    |   40 
 sound/isa/cs423x/pc98.c                                      |   14 
 sound/isa/dt019x.c                                           |   14 
 sound/isa/es1688/es1688.c                                    |    4 
 sound/isa/es18xx.c                                           |    6 
 sound/isa/gus/gus_irq.c                                      |    2 
 sound/isa/gus/gus_mem.c                                      |    2 
 sound/isa/gus/gus_pcm.c                                      |   23 
 sound/isa/gus/gusclassic.c                                   |    2 
 sound/isa/gus/gusextreme.c                                   |    6 
 sound/isa/gus/gusmax.c                                       |    2 
 sound/isa/gus/interwave.c                                    |   14 
 sound/isa/opl3sa2.c                                          |   10 
 sound/isa/opti9xx/opti92x-ad1848.c                           |   39 
 sound/isa/sb/emu8000.c                                       |    2 
 sound/isa/sb/es968.c                                         |    2 
 sound/isa/sb/sb16.c                                          |   17 
 sound/isa/sb/sb16_csp.c                                      |    4 
 sound/isa/sb/sb8.c                                           |    2 
 sound/isa/sb/sb_common.c                                     |    4 
 sound/isa/sgalaxy.c                                          |    8 
 sound/isa/sscape.c                                           |    9 
 sound/isa/wavefront/wavefront.c                              |   23 
 sound/pci/ac97/Makefile                                      |    2 
 sound/pci/ac97/ac97_codec.c                                  |  593 +---
 sound/pci/ac97/ac97_local.h                                  |    8 
 sound/pci/ac97/ac97_patch.c                                  |  356 ++
 sound/pci/ac97/ac97_patch.h                                  |    4 
 sound/pci/ac97/ac97_pcm.c                                    |  739 ++++-
 sound/pci/ac97/ac97_proc.c                                   |   77 
 sound/pci/ac97/ak4531_codec.c                                |    2 
 sound/pci/ali5451/ali5451.c                                  |   22 
 sound/pci/als4000.c                                          |   83 
 sound/pci/azt3328.c                                          |  130 
 sound/pci/cmipci.c                                           |  119 
 sound/pci/cs4281.c                                           |   68 
 sound/pci/cs46xx/cs46xx_lib.c                                |   62 
 sound/pci/emu10k1/emu10k1_main.c                             |   16 
 sound/pci/emu10k1/emufx.c                                    |  200 -
 sound/pci/emu10k1/emumixer.c                                 |   56 
 sound/pci/emu10k1/emupcm.c                                   |    2 
 sound/pci/emu10k1/emuproc.c                                  |    2 
 sound/pci/ens1370.c                                          |  230 -
 sound/pci/es1938.c                                           |    2 
 sound/pci/es1968.c                                           |  116 
 sound/pci/fm801.c                                            |   22 
 sound/pci/ice1712/Makefile                                   |    2 
 sound/pci/ice1712/ak4xxx.c                                   |   12 
 sound/pci/ice1712/aureon.c                                   |   13 
 sound/pci/ice1712/delta.c                                    |   27 
 sound/pci/ice1712/ice1712.c                                  |   31 
 sound/pci/ice1712/ice1712.h                                  |    2 
 sound/pci/ice1712/ice1724.c                                  |   18 
 sound/pci/ice1712/prodigy.c                                  |  738 +++++
 sound/pci/ice1712/prodigy.h                                  |   67 
 sound/pci/intel8x0.c                                         |  543 +--
 sound/pci/korg1212/korg1212.c                                |    2 
 sound/pci/maestro3.c                                         |   16 
 sound/pci/nm256/nm256.c                                      |   15 
 sound/pci/rme32.c                                            |   18 
 sound/pci/rme96.c                                            |   22 
 sound/pci/rme9652/hdsp.c                                     | 1519 ++++++++---
 sound/pci/rme9652/rme9652.c                                  |    3 
 sound/pci/sonicvibes.c                                       |    4 
 sound/pci/trident/trident_main.c                             |   19 
 sound/pci/via82xx.c                                          |  223 -
 sound/pci/ymfpci/ymfpci.c                                    |  144 -
 sound/pci/ymfpci/ymfpci_main.c                               |  349 +-
 sound/pcmcia/Kconfig                                         |    4 
 sound/pcmcia/vx/vx_entry.c                                   |    4 
 sound/ppc/daca.c                                             |    3 
 sound/ppc/tumbler.c                                          |    3 
 sound/sound_core.c                                           |    6 
 sound/usb/usbaudio.c                                         |  270 +
 sound/usb/usbquirks.h                                        |  269 -
 156 files changed, 6369 insertions(+), 3119 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/01/08 1.1575)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the DXS support for ABIT KD7(-RAID)

<perex@suse.cz> (04/01/08 1.1574)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA sequencer
   - new e-mail address of Frank van de Pol.

<perex@suse.cz> (04/01/08 1.1573)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,CMIPCI driver
   - changed joystick option to joystick_port option for cmipci driver.
   - mentioning alsa-firmware package together with alsa-tools package
     for firmware loading.
   - fixed the description of auto-invokation of vxloader for 2.6 kernels.

<perex@suse.cz> (04/01/08 1.1572)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the white list for avance logic mobo.

<perex@suse.cz> (04/01/08 1.1571)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   EMU10K1/EMU10K2 driver
   Georgi Georgiev <chutz@gg3.net>
   Line2 LiveDrive Capture Volume control fix

<perex@suse.cz> (04/01/08 1.1570)
   ALSA - added missing module_init and module_exit functions to cs8427 and ak4xxx modules

<perex@suse.cz> (03/12/30 1.1531.3.18)
   ALSA 1.0.1

<perex@suse.cz> (03/12/30 1.1531.3.17)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation
   More complete PCM device example

<perex@suse.cz> (03/12/30 1.1531.3.16)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   VIA82xx driver
   Added Easy Note 3171, Packard Bell - VIA_DXS_ENABLE

<perex@suse.cz> (03/12/30 1.1531.3.15)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation,ALSA<-OSS emulation
   - changed whole-frag (default again) => partial-frag
   - small corrections in snd_pcm_oss_get_ptr() - atomic hw_ptr and info.bytes

<perex@suse.cz> (03/12/30 1.1531.3.14)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1712 driver
   DFS bit must be handled also for Delta1010 and Delta2496

<perex@suse.cz> (03/12/30 1.1531.3.13)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   petter wahlman <petter.wahlman@chello.no>
   vsnprintf does not copy more than 'size' bytes _including_ '\0'

<perex@suse.cz> (03/12/30 1.1531.3.12)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation
   Added read_size comment for snd_info_set_text_ops()

<perex@suse.cz> (03/12/30 1.1531.3.11)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   A try to fix get_id() function - use alloc_bootmem()

<perex@suse.cz> (03/12/30 1.1531.3.10)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA sequencer
   Fixed typo

<perex@suse.cz> (03/12/30 1.1531.3.9)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   GUS Library
   Fixed race - scheduling in interrupt

<perex@suse.cz> (03/12/30 1.1531.3.8)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Control Midlevel
   Added snd_ctl_find_hole() function.
   Added printk when control already exists.

<perex@suse.cz> (03/12/30 1.1531.3.7)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   RME9652 driver
   Removed duplicated ADAT3 Sync control

<perex@suse.cz> (03/12/30 1.1531.3.6)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   USB generic driver
   Clemens Ladisch <clemens@ladisch.de>
   deactivate_urbs didn't return the number of still-active URBs when not
   unlinking asynchronously, which would prevent calling wait_clear_urbs
   when some URBs actually are being unlinked asynchronously, so these
   URBs would be freed while still in use.
   
   I removed deactivate_urb's return value because wait_clear_urbs does
   its own counting anyway.

<perex@suse.cz> (03/12/30 1.1531.3.5)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Timer Midlevel
   An attempt to fix the system timer behaviour (lost jiffy ticks)

<perex@suse.cz> (03/12/30 1.1531.3.4)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AMD InterWave driver
   Fixed typo

<perex@suse.cz> (03/12/30 1.1531.3.3)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   EMU10K1/EMU10K2 driver
   <pzad@pobox.sk>
   Center is initialized to analog to prevent noise at startup (SB Live)

<perex@suse.cz> (03/12/30 1.1531.3.2)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   - added OSS_ALSAEMULVER ioctl
   - cleanups for put_user()

<perex@suse.cz> (03/12/05 1.1496.11.14)
   ALSA version 1.0.0rc2

<perex@suse.cz> (03/12/04 1.1496.11.13)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Commented out debugging printk

<perex@suse.cz> (03/12/04 1.1496.11.12)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added a quirk for ASRock K7VM2.

<perex@suse.cz> (03/12/04 1.1496.11.11)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - dxs_support=4 seems ok for the ASRock board.

<perex@suse.cz> (03/12/04 1.1496.11.10)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added a dxs_support list entry for ASRock K7VM2.

<perex@suse.cz> (03/12/04 1.1496.11.9)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the detection of rates due to collision with the spdif slots.
   - fixed the typo in the error message.
   - replaced the numbers with constants.

<perex@suse.cz> (03/12/04 1.1496.11.8)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - don't break the probing even when ac97_reset_wait() returns error.
     in many cases, it's not critical (e.g. SB audigy).

<perex@suse.cz> (03/12/04 1.1496.11.7)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core,Intel8x0 driver
   - added spdif field to struct ac97_pcm.
   - snd_ac97_set_rate() accepts AC97_SPDIF.
   - allow fixed rate mic capture.
   - optimized the loop in snd_ac97_pcm_open.

<perex@suse.cz> (03/12/04 1.1496.11.6)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   - replaced 8 with SNDRV_CARDS.

<perex@suse.cz> (03/12/04 1.1496.11.5)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Generic drivers
   Steve deRosier <derosier@pianodisc.com>:
   
   * There is a user selectable flag droponfull.  Set to 1 and
     any new bytes delivered to the driver after the buffer fills
     up will be discarded until the buffer is able to flush some
     bytes.
   * If droponfull==0 (or is not set, the default is 0), the driver
     proceeds to block further input by not calling
     snd_rawmidi_transmit_ack() and aborting the attempt.  It will
     try again later.
   * I've redone a bit of the interface for the buffer routines.
     This was done to support the proper blocking/non-blocking methods
     as spelled out above, and to try to protect the buffer data a bit.

<perex@suse.cz> (03/12/04 1.1496.11.4)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the missing '\n' to proc output.

<perex@suse.cz> (03/12/04 1.1496.11.3)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added quirks for another ASUS board and FSC notebook.

<perex@suse.cz> (03/12/04 1.1496.11.2)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA<-OSS emulation
   - fixed the bytes field of GETxPTR ioctl in the mmap mode.
   - fixed the bytes field of GETxSPACE ioctl.
   - don't count the negative delay values.

<perex@suse.cz> (03/12/01 1.1489.3.106)
   ALSA 1.0.0rc1

<perex@suse.cz> (03/12/01 1.1489.3.105)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Fixed AC97 slot allocation for 2nd+ PCM in assign function

<perex@suse.cz> (03/12/01 1.1489.3.104)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   fixed typo

<perex@suse.cz> (03/12/01 1.1489.3.103)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the rates detection for capture.

<perex@suse.cz> (03/12/01 1.1489.3.102)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   - fixed for the new ac97_bus struct.

<perex@suse.cz> (03/12/01 1.1489.3.101)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver
   fixes by Apostolos Dimitromanolakis <apostolos@aei.ca>:
   - fixed the pop noise at the start up of aureon boards.
   - update of prodigy driver (modifed by ti).

<perex@suse.cz> (03/12/01 1.1489.3.100)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   RME HDSP driver
   fix by Thomas Charbonnel <thomas@undata.org>:
   
   The attach patch fixes problems with speed modes for H9632 cards (many
   thanks to Pentti Ala-Vannesluoma for testing the driver and helping
   finding bugs), and the AutoSync mode issue (for all cards) reported by
   Anders Torger at the end of september.

<perex@suse.cz> (03/12/01 1.1489.3.99)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Clemens Ladisch <clemens@ladisch.de>
   fix compiler warnings

<perex@suse.cz> (03/12/01 1.1489.3.98)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core,Intel8x0 driver
   - fixed the wrong sized allocation of snd_ac97_pcm.
   - fixed the probing of multiple codecs on intel8x0.
   - fixed the computation of rates bits.

<perex@suse.cz> (03/12/01 1.1489.3.97)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed oops.

<perex@suse.cz> (03/12/01 1.1489.3.96)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core,Intel8x0 driver
   Moved AC97 slot allocation from intel8x0 to ac97_pcm.c.

<perex@suse.cz> (03/12/01 1.1489.3.95)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver
   removed unnecessary codes, which causes compilation error with gcc-2.9.x.

<perex@suse.cz> (03/12/01 1.1489.3.94)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver,ICE1724 driver
   Apostolos Dimitromanolakis <apostolos@aei.ca>:
   
   - added the partial support of AudioTrak prodigy 7.1

<perex@suse.cz> (03/12/01 1.1489.3.93)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   RME HDSP driver
   Thomas Charbonnel <thomas@undata.org>:
   
   The attached patch at last fixes the long lasting firmware loading error
   after boot, and includes a small cosmetic fix for H9632 cards (fixes
   SPDIF external rate reporting in /proc/asound/cardX/hdsp and amixer
   outputs).

<perex@suse.cz> (03/12/01 1.1489.3.92)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   RME HDSP driver
   Thomas Charbonnel <thomas@undata.org>:
   
   The attached patch fixes matrix mixer and metering problems spotted by
   Pentti Ala-Vannesluoma for H9632 cards and gcc 2.9x compile errors
   reported by Martin Langer.

<perex@suse.cz> (03/12/01 1.1489.3.91)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   RME HDSP driver
   Thomas Charbonnel <thomas@undata.org>:
   
   - include support for hdsp 9632 cards and bugfixes for hdsp
     9652 cards.

<perex@suse.cz> (03/12/01 1.1489.3.90)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ES1968 driver,AC97 Codec Core
   fixed the compilation with the recent ac97 and info changes.

<perex@suse.cz> (03/12/01 1.1489.3.89)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   HWDEP Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel,Timer Midlevel
   Digigram VX core,L3 drivers,AC97 Codec Core,CS46xx driver
   Trident driver,YMFPCI driver,GUS Library,SB16/AWE driver,CMIPCI driver
   CS4281 driver,ENS1370/1+ driver,FM801 driver,Intel8x0 driver
   Maestro3 driver,RME32 driver,RME96 driver,SonicVibes driver
   VIA82xx driver,AK4531 codec,ALI5451 driver,EMU10K1/EMU10K2 driver
   ICE1712 driver,ICE1724 driver,KORG1212 driver,NM256 driver
   RME HDSP driver,RME9652 driver,USB generic driver
   - AC97 code
     - introduced ac97_bus_t structure
     - moved attached codecs to /proc/asound/card?/codec97#? directory
     - merged snd_ac97_modem() to snd_ac97_mixer()
   - proc cleanups - removed already initialized variables
   - enhanced snd_info_set_text_ops() syntax

<perex@suse.cz> (03/12/01 1.1489.3.88)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Control Midlevel,ALSA Core,EMU8000 driver,SB16/AWE driver
   EMU10K1/EMU10K2 driver
   - added support for user control elements (untested)
   - fixed locking for snd_ctl_remove() function

<perex@suse.cz> (03/12/01 1.1489.3.87)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   YMFPCI driver
   Clemens Ladisch <clemens@ladisch.de>:
   
   - This patch adds a control to enable S/PDIF direct recording (without
     resampling) on the YMF754.

<perex@suse.cz> (03/12/01 1.1489.3.86)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   YMFPCI driver
   Clemens Ladisch <clemens@ladisch.de>:
   
   - added the support for the timer on ymfpci chips.

<perex@suse.cz> (03/12/01 1.1489.3.85)
   ALSA CVS update - version 1.0.0pre3

<perex@suse.cz> (03/12/01 1.1489.3.84)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   VIA82xx driver
   Added EPoX EP-8K9A default settings (VIA_DXS_ENABLE)

<perex@suse.cz> (03/12/01 1.1489.3.83)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA<-OSS emulation
   - reset auto-silence in the OSS mmap mode.

<perex@suse.cz> (03/12/01 1.1489.3.82)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA<-OSS emulation
   fixed the calculation of bytes.  this will fix GETxSPACE, GETxPTR,
   GETODELAY ioctls.

<perex@suse.cz> (03/12/01 1.1489.3.81)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AMD InterWave driver
   - fixed the detection of STB board via pnp.

<perex@suse.cz> (03/12/01 1.1489.3.80)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver
   - fixed double entries of the same controls.

<perex@suse.cz> (03/12/01 1.1489.3.79)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX Pocket driver
   - added the missing licesne and descriptions.

<perex@suse.cz> (03/11/26 1.1489.3.78)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   - added the proc files to show ids.

<perex@suse.cz> (03/11/26 1.1489.3.77)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel,ALSA Core,USB generic driver
   - prepare callback can sleep if a flag is given in pcm->info_flags.
   - usbaudio driver uses non-atomic prepare callback for synchronization
     of pending unlinked urbs.
   - async_unlink option of usbaudio driver is enabled as default now.
   - fixed the initialization of pseudo-dma pointers in usbaudio.

<perex@suse.cz> (03/11/26 1.1489.3.76)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   - clear the status record before calling snd_pcm_status() in proc read.
     this will prevent to show bogus values when status = OPEN.

<perex@suse.cz> (03/11/26 1.1489.3.75)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   - added hw_constraint to align 4bytes.
     this will solve the 24bit problem on vx222.

<perex@suse.cz> (03/11/26 1.1489.3.74)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   fix by Clemens Ladisch <clemens@ladisch.de>:
   
   - don't clear active_mask bits until it's clear that the URB is _not_
     resubmitted, to prevent a race with unlinking
   - initialize active_mask and unlink_mask each time before URBs are
     started
   - don't call sleeping functions in trigger callback

<perex@suse.cz> (03/11/26 1.1489.3.73)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   - clear unlink_mask bit in the complete callback.
   - make sure to deactivate urbs before starting streams.

<perex@suse.cz> (03/11/26 1.1489.3.72)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - added new patch codes for ALC655/658.
   - fixed reset wait loop in the resume phase.
   - fixed resume of AD1981 multi codecs.

<perex@suse.cz> (03/11/26 1.1489.3.71)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,Memalloc module,ALS4000 driver,AZT3328 driver
   ES1938 driver,ES1968 driver,Maestro3 driver,SonicVibes driver
   ALI5451 driver,EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver
   Trident driver
   - use pci_set_consistent_dma_mask().

<perex@suse.cz> (03/11/26 1.1489.3.70)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   YMFPCI driver
   - fixed possible (but rare) deadlock.

<perex@suse.cz> (03/11/26 1.1489.3.69)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - fixed the (syntax) description of dxs_support module option.

<perex@suse.cz> (03/11/26 1.1489.3.68)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   GUS Library
   Omited to remove old code

<perex@suse.cz> (03/11/26 1.1489.3.67)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   GUS Library
   Fixed duplicate control IDs (PCM Playback Volume) for cards with the codec chip

<perex@suse.cz> (03/11/26 1.1489.3.66)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   - added a workaround for M-Audio Audiophile USB.
   - avoid async out and adaptive in if other methods are available.
   - fixed the hw_constraint check for 24bit formats.

<perex@suse.cz> (03/11/26 1.1489.3.65)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   - added async_unlink option.
     the default bahevior is not changed yet.
   - added some comments.

<perex@suse.cz> (03/11/26 1.1489.3.64)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   I2C lib core
   - fixed sleep in lock.  use mutex for the locking.

<perex@suse.cz> (03/11/26 1.1489.3.63)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CS4236+ driver
   - fixed the detection of combination of pnp and non-pnp devices.

<perex@suse.cz> (03/11/26 1.1489.3.62)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Added IC Ensemble/KS Waves ID for stereo enhancement

<perex@suse.cz> (03/11/26 1.1489.3.61)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CMIPCI driver
   - set XCHGDAC bit implicitly on MC4/6 models for fixing wrong
     playback on some boards.
   - removed 'Exchange DAC' control from such a model.

<perex@suse.cz> (03/11/26 1.1489.3.60)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver
   Peter Zubaj <pzad@pobox.sk>:
    - disable routing from AC97 line out to front speakers.
    - AC97 ADC is used only for Mic playback and recording
    - Philips ADC is used for other analog playback and recording
     (Analog Mix Playback Volume, Analog Mix Capture Volume)
    - removes unused AC97 controls (is phone used ???)
   
   Takashi Iwai <tiwai@suse.de>:
    - removed the duplicated IEC958 control on Dell's board.

<perex@suse.cz> (03/11/26 1.1489.3.59)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   Fixed semantics in snd_pcm_oss_bytes() function.

<perex@suse.cz> (03/11/26 1.1489.3.58)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   OPL4
   Clemens Ladisch <clemens@ladisch.de>
   oops - use vfree in error paths, too

<perex@suse.cz> (03/11/26 1.1489.3.57)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Fixed cut & paste bug

<perex@suse.cz> (03/11/26 1.1489.3.56)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   added the quirk for ASUS A7V600.

<perex@suse.cz> (03/11/26 1.1489.3.55)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Clemens Ladisch <clemens@ladisch.de>
   new controls for AD1981A/B/1980/1985

<perex@suse.cz> (03/11/26 1.1489.3.54)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   OPL4
   Clemens Ladisch <clemens@ladisch.de>
   use vmalloc instead of kmalloc for temp buffer in proc read()/write()

<perex@suse.cz> (03/11/26 1.1489.3.53)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Opti9xx drivers
   - fixed the detection of opti92x-ad1848 pnp.

<perex@suse.cz> (03/11/26 1.1489.3.52)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   OSS device core,ALSA Core
   - take MODULE_ALIAS_CHARDEV_MAJOR() back.
   - added missing inclusion of linux/device.h.

<perex@suse.cz> (03/11/26 1.1489.3.51)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core,ALS100 driver,AZT2320 driver,DT019x driver,CS4231 driver
   CS4236+ driver,PC98(CS423x) driver,Opti9xx drivers,SB16/AWE driver
   Wavefront drivers
   use the standard port address, 0 = disable, 1 = auto-probe, others manual.
   negative values are accepted as disable, too.

<perex@suse.cz> (03/11/26 1.1489.3.50)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   OSS device core,Documentation,ALSA Core,ALSA<-OSS emulation
   ALSA<-OSS sequencer,ALSA Minor Numbers
   Rusty Russell <rusty@rustcorp.com.au>:
   - added MODULE_ALIAS for sound services.
     clean up the document.
     modified by Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (03/11/26 1.1489.3.49)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ALSA Core
   - cards_limit=1 as default instead of 8.
   - cards_limit means the number of auto-loaded cards.  not limits the
     actual card numbers for manual loading (e.g. hotplug).

<perex@suse.cz> (03/11/26 1.1489.3.48)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   Fixed read for partial OSS period buffer contents

<perex@suse.cz> (03/11/26 1.1489.3.47)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AD1848 driver
   Robert Harris <robert.f.harris@blueyonder.co.uk>
   Fixed spinlocks

<perex@suse.cz> (03/11/26 1.1489.3.46)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   - avail_min is now 1
   - fixed read1() function for avail_min == 1
   - fixed conversion between ALSA and OSS position
   - fixed info.blocks computing in get_ptr() (included fixup)
   - fixed get_space() function (included fixup)

<perex@suse.cz> (03/11/26 1.1489.3.45)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ALS4000 driver,AZT3328 driver,CMIPCI driver
   ENS1370/1+ driver,VIA82xx driver,YMFPCI driver
   - use consistent values for specifying the port address
     (0 = disable, 1 = auto-detect, others = manual)
   - fixed the auto-detection of joystick port.

<perex@suse.cz> (03/11/26 1.1489.3.44)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   YMFPCI driver
   fixed the auto-detection of joystick port.

<perex@suse.cz> (03/11/26 1.1489.3.43)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CS46xx driver
   fixed the 4channel mode of another CS429x codec (0x592b).

<perex@suse.cz> (03/11/26 1.1489.3.42)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   Ted.Wen@ite.com.tw:
   
   - added patch for IT2646.

<perex@suse.cz> (03/11/26 1.1489.3.41)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core
   - fixed oops at resume.
   - block also the non-blocking devices until the resume is finished.

<perex@suse.cz> (03/11/26 1.1489.3.40)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ALS4000 driver,ENS1370/1+ driver,YMFPCI driver
   added auto-detection of joystick port.

<perex@suse.cz> (03/11/26 1.1489.3.39)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   Zinx Verituse <zinx@epicsol.org>:
   
   fixed the calculation of the port for 'Capture Source' control switch.

<perex@suse.cz> (03/11/26 1.1489.3.38)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel
   - don't print debug messages for low count of periods
   - added right path for one period to the update pointer routine (interrupt)

<perex@suse.cz> (03/11/26 1.1489.3.37)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   HWDEP Midlevel
   allow dsp_load callback without dsp_status callback.

<perex@suse.cz> (03/11/26 1.1489.3.36)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   - don't hold power lock while draining
   - call trigger callback when suspending/resuming a draining substream

<perex@suse.cz> (03/11/26 1.1489.3.35)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   removed the export of snd_pcm_lock().  replaced with the normal mutex.

<perex@suse.cz> (03/11/26 1.1489.3.34)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   minor corrections for the recent updates.

<perex@suse.cz> (03/11/26 1.1489.3.33)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Timer Midlevel
   fixed the unbalanced spinlock at the error path.

<perex@suse.cz> (03/11/26 1.1489.3.32)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver
   - take back the old definition of FXBUS_PCM_LEFT/RIGHT for sb live.
   - fixed the audigy routing with the new definition.

<perex@suse.cz> (03/11/26 1.1489.3.31)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   don't call kfree with NULL pointer (constraint rules is not always allocated).

<perex@suse.cz> (03/11/26 1.1489.3.30)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Timer Midlevel
   - fixed problem with hw slave source (PCM timer & dmix plugin)
   - fixes for slave instances
   - moved active callback check to snd_timer_close() function

<perex@suse.cz> (03/11/26 1.1489.3.29)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   added the DXS whitelist for twinhead mobo.

<perex@suse.cz> (03/11/26 1.1489.3.28)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   fixed typo in the last AD198x fix.

<perex@suse.cz> (03/11/26 1.1489.3.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver,VIA82xx driver,AC97 Codec Core
   - use ADI-compatible mode on AD1980 for more better controls.
   - swap master and headphone on AD1980 and AD1985 as default.
   - export remove_ctl, swap_ctl and rename_ctl for patch functions.
   - removed AD1980/AD1985 master-swap quirks (since it's set as default).

<perex@suse.cz> (03/11/26 1.1489.3.26)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA<-OSS emulation
   added fallback device selection for OSS mixer.

<perex@suse.cz> (03/11/26 1.1489.3.25)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Maestro3 driver
   don't enable MPU401 irq.

<perex@suse.cz> (03/11/26 1.1489.3.24)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   added ALC655 entry (compatible with ALC650).

<perex@suse.cz> (03/11/26 1.1489.3.23)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CS4281 driver,RME32 driver,RME96 driver,CS46xx driver,NM256 driver
   - fixed compile warnings with cast for memcpy_fromio/toio.
   - use copy_to_user_fromio() in proc output.

<perex@suse.cz> (03/11/26 1.1489.3.22)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,SB drivers,YMFPCI driver,ALS4000 driver,AZT3328 driver
   CMIPCI driver,ENS1370/1+ driver,ES1968 driver,Intel8x0 driver
   VIA82xx driver
   - removed joystick control from the card control API.
     added joystick (or joystick_port) module option instead.
   - updated documents for this joystick fix.
   - moved resource management for ALS4000 from sb-common header
     to the als4000 local code.

<perex@suse.cz> (03/11/26 1.1489.3.21)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Generic drivers,MPU401 UART,ALSA Core,ALS100 driver,AZT2320 driver
   CMI8330 driver,DT019x driver,ES18xx driver,OPL3SA2 driver
   Sound Galaxy driver,Sound Scape driver,AD1816A driver,AD1848 driver
   CS4231 driver,CS4236+ driver,PC98(CS423x) driver,ES1688 driver
   GUS Classic driver,GUS Extreme driver,GUS MAX driver
   AMD InterWave driver,Opti9xx drivers,ES968 driver,SB16/AWE driver
   SB8 driver,Wavefront drivers,CMIPCI driver,VIA82xx driver,YMFPCI driver
   - fixed the boot parameters with long ints for non-intel architectures.
   - added get_option_long() for parsing the parameter.

<perex@suse.cz> (03/11/26 1.1489.3.20)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Intel8x0 driver
   Added mpu_port initialization from the kernel command line

<perex@suse.cz> (03/11/26 1.1489.3.19)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver
   Peter Zubaj <pzad@pobox.sk>:
   - redesigned the default DSP routing of audigy1/2 boards.
     the normal PCM output is sent through 'Stereo Mix', while
     the independent pcm streams can be attenuated by 'PCM Front',
     'PCM Rear', and 'PCM Center/LFE' volumes.

<perex@suse.cz> (03/11/26 1.1489.3.18)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   OPL3,Raw OPL FM,ES1968 driver
   removed obsolete __SND_OSS_COMPAT__.

<perex@suse.cz> (03/11/26 1.1489.3.17)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Sound Scape driver
   Chris Rankin <rankincj@yahoo.com> - use #define rather than value for the microcode size

<perex@suse.cz> (03/11/26 1.1489.3.16)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   removed a wrong entry for gigabyte mobos.

<perex@suse.cz> (03/11/26 1.1489.3.15)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   Clemens Ladisch <clemens@ladisch.de>:
   
   - add support for M-Audio OmniStudio MIDI

<perex@suse.cz> (03/11/26 1.1489.3.14)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   - fixed the compilation without PCI support.
     added ifdef CONFIG_PCI around preallocate_cards().

<perex@suse.cz> (03/11/26 1.1489.3.13)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,PCMCIA Kconfig
   - added CONFIG_ISA restriction to vxpocket and vxp440 drivers.

<perex@suse.cz> (03/11/26 1.1489.3.12)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   Clemens Ladisch <clemens@ladisch.de>:
   
   - fix Edirol comment
   - use special macros for Yamaha devices
   - add support for Yamaha MOTIF-R, CVP-204, CVP-206, CVP-208, CVP-210,
     PSR-1100, PSR-2100, PSR-K1, EZ-250i, MOTIF ES 6, MOTIF ES 7,
     MOTIF ES 8, CS1D, DSP1D, ACU16-C, NHB32-C, DM1000, 01V96

<perex@suse.cz> (03/11/26 1.1489.3.11)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - clean up the rate lock routine.
   - added another gigabyte mobo entry.

<perex@suse.cz> (03/11/26 1.1489.3.10)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core,Timer Midlevel,ALSA sequencer,PPC DACA driver
   PPC Tumbler driver
   - check rootfs before calling request_module() to avoid annoying
     error messages at the boot time.

<perex@suse.cz> (03/11/26 1.1489.3.9)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Timer Midlevel,ALSA sequencer
   Clemens Ladisch <clemens@ladisch.de>:
   
   - fixed timer resolution calculations
     Some functions assumed that timer->hw.resolution is in Hz, while it's
     actually in ns/tick.

<perex@suse.cz> (03/11/26 1.1489.3.8)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,VIA82xx driver
   - added dxs_support=4 option.  no VRA is used for DXS channels in this case.
   - fixed the quirk for ASUS A7V8-X.
   - added the quirk for Gigabyte mobo.
   - removed the error message in codec_valid().

<perex@suse.cz> (03/11/26 1.1489.3.7)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - fixed the misuse of long pointer for getting the int value in
     boot parameter.

<perex@suse.cz> (03/11/26 1.1489.3.6)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel
   Simplified snd_pcm_update_hw_ptr*() functions

<perex@suse.cz> (03/11/26 1.1489.3.5)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   fixes by James Courtier-Dutton <James@superbug.demon.co.uk>:
   
   - fixed the wrong detection of SPDIF output.  SPDIF-out is enabled
     on all chip revisions.
   - fixed the ac97 codec name shown in proc file, using ac97->id.

<perex@suse.cz> (03/11/26 1.1489.3.4)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver,AC97 Codec Core
   - fixed typos in the last change to snd_ac97_set_rate().
     the correct flag to check is ac97->scaps.
   - removed dxs_fixed=1 on VIA8233A (for SPDIF).
   - added quirks for ASUS A7V8-X and MSI KT4V.

<perex@suse.cz> (03/11/26 1.1489.3.3)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   fixed snd_ac97_set_rate() to accept surround and LFE sample rates, too.

<perex@suse.cz> (03/11/26 1.1489.3.2)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver
   use the standard control names for RCA and optical spdif on audigy.

<perex@suse.cz> (03/11/26 1.1489.3.1)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1712 driver
   Moved spdif.setup_rate to snd_ice1712_set_pro_rate() function


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
