Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUCNKs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 05:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUCNKs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 05:48:57 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:56517 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S261710AbUCNKs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 05:48:28 -0500
Date: Sun, 14 Mar 2004 11:46:54 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.58.0403141143400.3332@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-03-14.patch.gz

Additional notes:

  - ALSA DMA API uses dma_alloc_coherent function now
  - moved dependencies from make files to Kconfig files
  - fixed OOPS related to procfs (module removal)
  - added intel8x0m driver (soft modem)
  - added snd-atiixp driver for the ATI IXP150/200/250 AC97 controllers
  - added the au88x0 drivers for Aureal soundcards by Manuel Jander <mjander@embedded.cl>
  - lots updates for existing code (see to Changeset comments)

						Jaroslav


The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   68 
 Documentation/sound/alsa/DocBook/alsa-driver-api.tmpl        |    2 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  172 
 Documentation/sound/alsa/Joystick.txt                        |    3 
 Documentation/sound/alsa/MIXART.txt                          |   96 
 include/sound/ac97_codec.h                                   |    3 
 include/sound/ak4117.h                                       |  191 
 include/sound/asequencer.h                                   |    3 
 include/sound/asound.h                                       |    2 
 include/sound/cs46xx.h                                       |   10 
 include/sound/emu10k1.h                                      |   19 
 include/sound/info.h                                         |    2 
 include/sound/memalloc.h                                     |  152 
 include/sound/pcm.h                                          |   48 
 include/sound/pcm_oss.h                                      |    1 
 include/sound/sndmagic.h                                     |    3 
 include/sound/trident.h                                      |    8 
 include/sound/version.h                                      |    4 
 include/sound/ymfpci.h                                       |    8 
 sound/arm/Kconfig                                            |    1 
 sound/arm/sa11xx-uda1341.c                                   |    6 
 sound/core/Kconfig                                           |   30 
 sound/core/Makefile                                          |  271 -
 sound/core/init.c                                            |   12 
 sound/core/memalloc.c                                        | 1079 +---
 sound/core/oss/pcm_oss.c                                     |   20 
 sound/core/pcm.c                                             |    4 
 sound/core/pcm_lib.c                                         |   23 
 sound/core/pcm_memory.c                                      |  277 -
 sound/core/pcm_misc.c                                        |   32 
 sound/core/seq/oss/seq_oss_init.c                            |    9 
 sound/core/seq/oss/seq_oss_midi.c                            |    5 
 sound/core/seq/oss/seq_oss_synth.c                           |    2 
 sound/core/seq/seq_clientmgr.c                               |   41 
 sound/core/seq/seq_fifo.c                                    |   14 
 sound/core/seq/seq_memory.c                                  |   11 
 sound/core/seq/seq_midi.c                                    |   10 
 sound/core/sgbuf.c                                           |  137 
 sound/drivers/Kconfig                                        |   36 
 sound/drivers/mpu401/Makefile                                |   39 
 sound/drivers/mpu401/mpu401_uart.c                           |    4 
 sound/drivers/opl3/Makefile                                  |   96 
 sound/drivers/opl4/Makefile                                  |   27 
 sound/drivers/vx/Makefile                                    |    5 
 sound/drivers/vx/vx_core.c                                   |   10 
 sound/drivers/vx/vx_mixer.c                                  |    2 
 sound/drivers/vx/vx_pcm.c                                    |    4 
 sound/i2c/other/Makefile                                     |    2 
 sound/i2c/other/ak4117.c                                     |  563 ++
 sound/isa/Kconfig                                            |  148 
 sound/isa/ad1816a/ad1816a_lib.c                              |   10 
 sound/isa/ad1848/ad1848_lib.c                                |   10 
 sound/isa/cmi8330.c                                          |   10 
 sound/isa/cs423x/cs4231_lib.c                                |   20 
 sound/isa/dt019x.c                                           |    4 
 sound/isa/es1688/es1688_lib.c                                |   10 
 sound/isa/es18xx.c                                           |   11 
 sound/isa/gus/gus_pcm.c                                      |   18 
 sound/isa/opti9xx/opti92x-ad1848.c                           |   32 
 sound/isa/sb/sb16_main.c                                     |   10 
 sound/isa/sb/sb8_main.c                                      |   10 
 sound/isa/sscape.c                                           |   42 
 sound/parisc/Kconfig                                         |    1 
 sound/parisc/harmony.c                                       |   12 
 sound/pci/Kconfig                                            |  199 
 sound/pci/Makefile                                           |   19 
 sound/pci/ac97/Makefile                                      |   16 
 sound/pci/ac97/ac97_codec.c                                  |   86 
 sound/pci/ac97/ac97_patch.c                                  |  262 -
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ac97/ac97_pcm.c                                    |   22 
 sound/pci/ac97/ak4531_codec.c                                |    2 
 sound/pci/ali5451/ali5451.c                                  |    7 
 sound/pci/als4000.c                                          |    7 
 sound/pci/atiixp.c                                           | 1569 ++++++
 sound/pci/au88x0/Makefile                                    |    7 
 sound/pci/au88x0/au8810.c                                    |   17 
 sound/pci/au88x0/au8810.h                                    |  221 
 sound/pci/au88x0/au8820.c                                    |   15 
 sound/pci/au88x0/au8820.h                                    |  217 
 sound/pci/au88x0/au8830.c                                    |   18 
 sound/pci/au88x0/au8830.h                                    |  266 +
 sound/pci/au88x0/au88x0.c                                    |  425 +
 sound/pci/au88x0/au88x0.h                                    |  286 +
 sound/pci/au88x0/au88x0_a3d.c                                |  912 +++
 sound/pci/au88x0/au88x0_a3d.h                                |  123 
 sound/pci/au88x0/au88x0_a3ddata.c                            |   91 
 sound/pci/au88x0/au88x0_core.c                               | 2822 +++++++++++
 sound/pci/au88x0/au88x0_eq.c                                 | 1001 +++
 sound/pci/au88x0/au88x0_eq.h                                 |   46 
 sound/pci/au88x0/au88x0_eqdata.c                             |  112 
 sound/pci/au88x0/au88x0_game.c                               |  121 
 sound/pci/au88x0/au88x0_mixer.c                              |   29 
 sound/pci/au88x0/au88x0_mpu401.c                             |  112 
 sound/pci/au88x0/au88x0_pcm.c                                |  509 +
 sound/pci/au88x0/au88x0_sb.h                                 |   40 
 sound/pci/au88x0/au88x0_synth.c                              |  393 +
 sound/pci/au88x0/au88x0_wt.h                                 |   65 
 sound/pci/au88x0/au88x0_xtalk.c                              |  781 +++
 sound/pci/au88x0/au88x0_xtalk.h                              |   62 
 sound/pci/azt3328.c                                          |    7 
 sound/pci/bt87x.c                                            |   38 
 sound/pci/cmipci.c                                           |   23 
 sound/pci/cs4281.c                                           |    7 
 sound/pci/cs46xx/cs46xx_lib.c                                |  107 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1_callback.c                         |    2 
 sound/pci/emu10k1/emu10k1_main.c                             |   35 
 sound/pci/emu10k1/emufx.c                                    |   33 
 sound/pci/emu10k1/emupcm.c                                   |   19 
 sound/pci/emu10k1/emuproc.c                                  |    2 
 sound/pci/emu10k1/memory.c                                   |   33 
 sound/pci/ens1370.c                                          |   35 
 sound/pci/es1938.c                                           |   11 
 sound/pci/es1968.c                                           |   14 
 sound/pci/fm801.c                                            |   10 
 sound/pci/ice1712/amp.c                                      |    1 
 sound/pci/ice1712/aureon.c                                   |    7 
 sound/pci/ice1712/delta.c                                    |    5 
 sound/pci/ice1712/ews.c                                      |    3 
 sound/pci/ice1712/hoontech.c                                 |    1 
 sound/pci/ice1712/ice1712.c                                  |  118 
 sound/pci/ice1712/ice1712.h                                  |    4 
 sound/pci/ice1712/ice1724.c                                  |  306 -
 sound/pci/ice1712/prodigy.c                                  |    1 
 sound/pci/ice1712/revo.c                                     |    1 
 sound/pci/intel8x0.c                                         |   92 
 sound/pci/intel8x0m.c                                        | 1507 +++++
 sound/pci/korg1212/korg1212.c                                |   86 
 sound/pci/maestro3.c                                         |    7 
 sound/pci/mixart/Makefile                                    |    8 
 sound/pci/mixart/mixart.c                                    | 1617 ++++++
 sound/pci/mixart/mixart.h                                    |  250 
 sound/pci/mixart/mixart_core.c                               |  677 ++
 sound/pci/mixart/mixart_core.h                               |  607 ++
 sound/pci/mixart/mixart_hwdep.c                              |  576 ++
 sound/pci/mixart/mixart_hwdep.h                              |  146 
 sound/pci/mixart/mixart_mixer.c                              | 1138 ++++
 sound/pci/mixart/mixart_mixer.h                              |   31 
 sound/pci/rme32.c                                            |   14 
 sound/pci/rme96.c                                            |   16 
 sound/pci/rme9652/hdsp.c                                     |   31 
 sound/pci/rme9652/rme9652.c                                  |   23 
 sound/pci/sonicvibes.c                                       |    7 
 sound/pci/trident/trident_main.c                             |   95 
 sound/pci/trident/trident_memory.c                           |   27 
 sound/pci/trident/trident_synth.c                            |   17 
 sound/pci/via82xx.c                                          |  249 
 sound/pci/ymfpci/ymfpci_main.c                               |   66 
 sound/pcmcia/Kconfig                                         |   16 
 sound/pcmcia/Makefile                                        |    4 
 sound/pcmcia/pdaudiocf/Makefile                              |    8 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |  472 +
 sound/pcmcia/pdaudiocf/pdaudiocf.h                           |  150 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c                      |  317 +
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c                       |  329 +
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c                       |  363 +
 sound/ppc/Kconfig                                            |    1 
 sound/ppc/pmac.c                                             |    4 
 sound/ppc/tumbler.c                                          |   67 
 sound/sparc/Kconfig                                          |    2 
 sound/sparc/amd7930.c                                        |    4 
 sound/sparc/cs4231.c                                         |   10 
 sound/synth/Makefile                                         |   14 
 sound/usb/Kconfig                                            |    2 
 sound/usb/usbaudio.c                                         |   64 
 sound/usb/usbaudio.h                                         |    2 
 sound/usb/usbmidi.c                                          |  114 
 sound/usb/usbmixer.c                                         |   70 
 sound/usb/usbmixer_maps.c                                    |    6 
 sound/usb/usbquirks.h                                        |  159 
 171 files changed, 22384 insertions(+), 2702 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/03/13 1.1636)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core
   fixed the wrong release of id proc file.

<perex@suse.cz> (04/03/13 1.1635)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core
   added the new magic numbers for atiixp and au88x0 drivers.

<perex@suse.cz> (04/03/13 1.1634)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,PCI drivers,Intel8x0-modem driver
   added Intel-compatible onboard MC97 modem driver
   by Sasha Khapyorsky <sashak@smlink.com>

<perex@suse.cz> (04/03/13 1.1633)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,PCI drivers,ATIIXP driver
   added snd-atiixp driver for the ATI IXP150/200/250 AC97 controllers.

<perex@suse.cz> (04/03/13 1.1632)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   MIXART driver
   fixed the compile warning.

<perex@suse.cz> (04/03/13 1.1631)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver
   disabled Dell OEM Emu10k1x from the pci id list.
   the board isn't compatible with the normal emu10k1.

<perex@suse.cz> (04/03/13 1.1630)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   au88x0 driver
   removed EXPORT_NO_SYMBOLS.

<perex@suse.cz> (04/03/13 1.1629)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC Tumbler driver
   fixed the info callback of mixer input source (for enum type).

<perex@suse.cz> (04/03/13 1.1628)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   added fix and workaround for the mixer problem on SB Extigy.

<perex@suse.cz> (04/03/13 1.1627)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   fixed the files to include.

<perex@suse.cz> (04/03/13 1.1626)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   changed the description of the buffer allocation routines
   for the new designed functions.

<perex@suse.cz> (04/03/13 1.1625)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC Tumbler driver
   added input source switch to select mic/line-in.

<perex@suse.cz> (04/03/13 1.1624)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,PCI drivers,au88x0 driver
   added the au88x0 drivers for Aureal soundcards by Manuel Jander <mjander@embedded.cl>

<perex@suse.cz> (04/03/13 1.1623)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   patch was applied wrongly.  fixed the rate restriction of spdif output
   again.

<perex@suse.cz> (04/03/13 1.1622)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   DT019x driver
   Fixed warnings

<perex@suse.cz> (04/03/13 1.1621)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   restrict the PCM sample rates to 32, 44.1 and 48kHz when the SPDIF
   switch is on.

<perex@suse.cz> (04/03/13 1.1620)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   prevent twenty-seconds wait when unplugging USB MIDI device with a port subscription

<perex@suse.cz> (04/03/13 1.1619)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   show one decimal place of momentary frequency in proc file

<perex@suse.cz> (04/03/13 1.1618)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   use MIN_PACKS_URB as lower bound for nrpacks parameter

<perex@suse.cz> (04/03/13 1.1617)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA sequencer,ALSA<-OSS sequencer
   use wrapper function for DELETE_PORT ioctl calls

<perex@suse.cz> (04/03/13 1.1616)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA sequencer
   remove superfluous call to snd_seq_event_port_detach

<perex@suse.cz> (04/03/07 1.1608.56.15)
   ALSA - fix compilation (header files)

<perex@suse.cz> (04/03/07 1.1608.56.14)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver,SPARC AMD7930 driver,SPARC cs4231 driver
   fixed for the new DMA buffer handler.

<perex@suse.cz> (04/03/07 1.1608.56.13)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module,PCM Midlevel,ALSA Core,CMI8330 driver,ES18xx driver
   Sound Scape driver,AD1816A driver,AD1848 driver,CS4231 driver
   ES1688 driver,GUS Library,Opti9xx drivers,SB16/AWE driver,SB8 driver
   ALS4000 driver,AZT3328 driver,BT87x driver,CMIPCI driver,CS4281 driver
   ENS1370/1+ driver,ES1938 driver,ES1968 driver,FM801 driver
   Intel8x0 driver,Maestro3 driver,RME32 driver,RME96 driver
   SonicVibes driver,VIA82xx driver,ALI5451 driver,CS46xx driver
   EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,KORG1212 driver
   MIXART driver,RME HDSP driver,RME9652 driver,Trident driver
   YMFPCI driver,Sound Core PDAudioCF driver,USB generic driver
   - clean up the DMA code again.
     now only struct device pointer is handled for every BUS type.
     the pointer must be given via the corresponding macro snd_dma_xxx_data().
   - added the hack for dma_alloc_coherent() to accept dev = NULL for ISA
     buffers.
   - added the missing include files.

<perex@suse.cz> (04/03/06 1.1608.56.12)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   PCM API is 2.0.6

<perex@suse.cz> (04/03/06 1.1608.56.11)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel
   Fix in playback_silence routine - don't silence whole buffer at start if samples are filled

<perex@suse.cz> (04/03/06 1.1608.56.10)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   fixed the interrupt problem with NForce(2).

<perex@suse.cz> (04/03/06 1.1608.56.9)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core,Intel8x0 driver,VIA82xx driver,CS46xx driver
   - fixed ALC100/P Master/PCM volume handling (h/w bug)
   - added ALC65x JACK quirk
   - disabled IC5 PERL mobo quirk
   - fixed Mic/Center sharing switch on ALC65x.
   - fixed Mic BIAS on ALC650.
   - added extra delay in the resume if needed.
   - renamed 'External Amplifier Power Down' to 'External Amplifier'
   - added a workaround for the reversed EAPD of cs46xx voyetra.

<perex@suse.cz> (04/03/06 1.1608.56.8)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Opti9xx drivers
   fixed the code with obsolete check_region().

<perex@suse.cz> (04/03/06 1.1608.56.7)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS sequencer
   mpkelly - fixed channel settings for input events

<perex@suse.cz> (04/03/06 1.1608.56.6)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1724 driver,ICE1712 driver
   Dirk Kalis <Dirk.Kalis@t-online.de>
   Added num_total_adcs.
   Separated analog input / s/pdif input controls

<perex@suse.cz> (04/03/06 1.1608.56.5)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC Tumbler driver
   - fixed the mic input on snapper.

<perex@suse.cz> (04/03/06 1.1608.56.4)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core
   - show the error message when the given card index is not available.

<perex@suse.cz> (04/03/04 1.1608.56.3)
   ALSA - fixed compilation

<perex@suse.cz> (04/03/04 1.1608.38.30)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   fixes for broken SB Audigy 2 NX descriptors

<perex@suse.cz> (04/03/04 1.1608.38.29)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   - suppress allocation failure warnings with large buffers.

<perex@suse.cz> (04/03/04 1.1608.38.28)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCI drivers,AC97 Codec Core
   - added CONFIG_SND_AC97_CODEC and simplify Kconfig and Makefiles.

<perex@suse.cz> (04/03/04 1.1608.38.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   fixed the missing inclusion.

<perex@suse.cz> (04/03/04 1.1608.38.26)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   - fix non-working control port on Roland U-8
   - more port names
   - new MIDI quirks for Roland MMP-2, V-SYNTH, VariOS, FP-*, GI-20,
     BOSS GS-10, Edirol UR-80, PCR-A, PCR-1

<perex@suse.cz> (04/03/04 1.1608.38.25)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Generic drivers,Digigram VX core,PCI drivers,PCMCIA Kconfig
   More Kconfig and Makefile cleanups following Russell's direction:
   - added SND_VX_LIB tristate

<perex@suse.cz> (04/03/04 1.1608.38.24)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Generic drivers,MPU401 UART,OPL3,OPL4,ISA,PCI drivers
   More Kconfig and Makefile cleanups following Russell's direction:
   - added SND_MP401_UART tristate
   - added SND_OPL3_LIB tristate
   - added SND_OPL4_LIB tristate

<perex@suse.cz> (04/03/04 1.1608.38.23)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core,Generic drivers
   Russell King <rmk+alsa@arm.linux.org.uk>
   
   This is part of a patch series to clean up sound/core/Makefile in Linux
   2.6.4-rc1.
   
   - Add SND_TIMER for drivers which use the snd-timer module.
   - Remove snd-timer from these drivers entries in sound/core/Makefile,
     removing any sound/core/Makefile entries which are left empty.
   - Since the 'top level module dependency' lists are now gone, remove
     the comment.
   - Also, since we only mention objects once, remove the sorting of obj-m

<perex@suse.cz> (04/03/04 1.1608.38.22)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core,ISA,PCI drivers,PCMCIA Kconfig
   Russell King <rmk+alsa@arm.linux.org.uk>
   
   This is part of a patch series to clean up sound/core/Makefile in Linux
   2.6.4-rc1.
   
   - Add SND_HWDEP for drivers which use the snd-hwdep module.
   - Remove snd-hwdep from these drivers entries in sound/core/Makefile,
     removing any sound/core/Makefile entries which are left empty.

<perex@suse.cz> (04/03/04 1.1608.38.21)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core,Generic drivers,ISA,PCI drivers,USB
   Russell King <rmk+alsa@arm.linux.org.uk>
   
   This is part of a patch series to clean up sound/core/Makefile in Linux
   2.6.4-rc1.
   
   - Add SND_RAWMIDI for drivers which use the snd-rawmidi module.
   - Remove snd-rawmidi from these drivers entries in sound/core/Makefile
   - Remove any sound/core/Makefile entries which are left empty.

<perex@suse.cz> (04/03/04 1.1608.38.20)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ARM,ALSA Core,Generic drivers,ISA,PARISC,PCI drivers,PCMCIA Kconfig,PPC
   SPARC,USB
   This is part of a patch series to clean up sound/core/Makefile in Linux
   2.6.4-rc1.
   
   - Add 'select SND_PCM' statements to appropriate Kconfig entries for
     drivers whose configuration symbol is used to build snd-pcm,
     snd-timer, and snd-page-alloc.
   
   - Remove snd-pcm, snd-timer and snd-page-alloc from these in
     sound/core/Makefile.
   
   - Remove snd from these entries as well - all SND_xxx configuration
     symbols depend on CONFIG_SND, so we won't even consider building
     any of these drivers unless SND is already set to 'y' or 'm'.

<perex@suse.cz> (04/03/04 1.1608.38.19)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Intel8x0 driver
   Converted to new DMA allocation API

<perex@suse.cz> (04/03/04 1.1608.38.18)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   - added back the output of PCI dma buffers in proc file.

<perex@suse.cz> (04/03/04 1.1608.38.17)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   - fixed the allocation/release of buffer descriptor table.

<perex@suse.cz> (04/03/04 1.1608.38.16)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ES1968 driver
   - fixed the handling of DMA buffer with the recent API change.

<perex@suse.cz> (04/03/04 1.1608.38.15)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module,ALSA Core
   - fixed the lock up with SG-buffer handler.
   - removed non-existing export symbol.
   - clean up ifdefs.

<perex@suse.cz> (04/03/04 1.1608.38.14)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   Fix for Creamware Noah:
   search class-specific endpoint descriptor in the
   extra descriptors of the sync ep, too

<perex@suse.cz> (04/03/04 1.1608.38.13)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   Russell King <rmk+alsa@arm.linux.org.uk>
   
   This is part of a patch series to clean up sound/core/Makefile in Linux
   2.6.4-rc1.
   
   - Add SND_TIMER, SND_PCM, SND_HWDEP and SND_RAWMIDI configuration symbols.
     These symbols select which modules in sound/core get built, building
     snd-timer, snd-pcm, snd-hwdep and snd-rawmidi respectively.
   
   - Add reverse dependencies (select) to select these symbols for core
     components where necessary.
   
   - Hide SND_OSSEMUL - we can select this when SND_MIXER_OSS, SND_PCM_OSS
     or SND_SEQUENCER_OSS are selected automatically.
   
   - Tweak Makefile to use these new symbols to build these modules.
   
   - Since we now build appropriate modules for core components according
     to the new configuration symbols, (eg, snd-timer if SND_SEQUENCER is
     selected) we can delete these duplications.

<perex@suse.cz> (04/03/04 1.1608.38.12)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   CMI8330 driver,ES18xx driver,AD1816A driver,AD1848 driver,CS4231 driver
   ES1688 driver,GUS Library,Opti9xx drivers,SB16/AWE driver,SB8 driver
   Fixed old function name (snd_pcm_isa_flags -> snd_pcm_dma_flags)

<perex@suse.cz> (04/03/04 1.1608.38.11)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Big DMA cleanup originated by Russell King <rmk+alsa@arm.linux.org.uk>
   * Russel
     - introduced 'struct device' support for 2.6 dma_alloc_coherent()
   * Jaroslav
     - removed all bus-specific allocation functions
     - extended snd_dma_alloc_pages/snd_dma_free_pages to handle all bus types
     - recoded all (or almost all) device drivers
     - sgbuf functions are bus independent now

<perex@suse.cz> (04/03/04 1.1608.38.10)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   FM801 driver
   tea575x can be module, too

<perex@suse.cz> (04/03/01 1.1608.38.9)
   ALSA - 1.0.3

<perex@suse.cz> (04/03/01 1.1608.38.8)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCI drivers
   <akpm@osdl.org>
   fix Kconfig thinko

<perex@suse.cz> (04/02/29 1.1597.2.32)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   OPL3,OPL4,Synth
   Fixed sequencer dependency for opl3, opl4 and emux objects.

<perex@suse.cz> (04/02/29 1.1597.2.31)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCI drivers
   Select CONFIG_VIDEO_DEV when CONFIG_SND_FM801_TEA575X is wanted

<perex@suse.cz> (04/02/29 1.1597.2.30)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AK4531 codec
   Aux Input Route -> Aux Capture Route renaming

<perex@suse.cz> (04/02/29 1.1597.2.29)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Sound Core PDAudioCF driver
   Fixed pcm->name settings

<perex@suse.cz> (04/02/29 1.1597.2.28)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   Fixed snd_info_set_text_ops() wwhen CONFIG_PROC_FS is not defined

<perex@suse.cz> (04/02/29 1.1597.2.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC Tumbler driver
   fixed the resume of bass/treble volumes on snapper.

<perex@suse.cz> (04/02/26 1.1597.2.26)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the dxs_support default for Uniwill laptop.

<perex@suse.cz> (04/02/26 1.1597.2.25)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   - fixed the example code of ctl info callback with enum type.

<perex@suse.cz> (04/02/26 1.1597.2.24)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Sound Core PDAudioCF driver
   akpm@osdl.org
   Fix pdaudiocf_irq.c for gcc-3.5

<perex@suse.cz> (04/02/26 1.1597.2.23)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   EMU10K1/EMU10K2 driver
   James Courtier-Dutton <James@superbug.demon.co.uk>, some additions

<perex@suse.cz> (04/02/26 1.1597.2.22)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added dxs_support default for EPIA MII.

<perex@suse.cz> (04/02/26 1.1597.2.21)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel,Intel8x0 driver
   - added snd_pcm_limit_hw_rates() to determine the min/max rates from
     rates bits.

<perex@suse.cz> (04/02/26 1.1597.2.20)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   MIXART driver
   - fixed the race condition in message flow.
   - removed obsolete debug prints.
   - make prepare callback non-atomic.
   - synchronize with the pending messages in prepare and hw_free callbacks.

<perex@suse.cz> (04/02/26 1.1597.2.19)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the handling of S/PDIF rates.
     the IEC958 status bits are updated according to the current rate.

<perex@suse.cz> (04/02/26 1.1597.2.18)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   - fixed the description for snd-cmipci module option.

<perex@suse.cz> (04/02/26 1.1597.2.17)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CMIPCI driver
   - use 0x201 as the default joystick port address.

<perex@suse.cz> (04/02/26 1.1597.2.16)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALS4000 driver
   - fixed the build without joystick support.

<perex@suse.cz> (04/02/26 1.1597.2.15)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   USB generic driver
   usb_ch9.h is already included in usb.h

<perex@suse.cz> (04/02/23 1.1597.2.14)
   Fixed compilation of PDAudioCF driver

<perex@suse.cz> (04/02/23 1.1597.2.13)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AK4117 receiver
   Added missing ak4117.h file

<perex@suse.cz> (04/02/23 1.1597.2.12)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Serial BUS drivers
   Moved AK4117 from alsa-driver tree to satisfy dependency for PDAudioCF driver

<perex@suse.cz> (04/02/23 1.1597.2.11)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   EMU10K1/EMU10K2 driver
   Fixed page overflow

<perex@suse.cz> (04/02/23 1.1597.2.10)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation,ALSA Core,PCMCIA Kconfig,PCMCIA
   Sound Core PDAudioCF driver
   Added Sound Core PDAudioCF driver

<perex@suse.cz> (04/02/23 1.1597.2.9)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   MIXART driver
   Added missing header file inclusion

<perex@suse.cz> (04/02/23 1.1597.2.8)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA sequencer
   Clemens Ladisch <clemens@ladisch.de>
   - fix typo in port flags
   - add GM2 capability bit

<perex@suse.cz> (04/02/23 1.1597.2.7)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   USB generic driver
   Clemens Ladisch <clemens@ladisch.de>
   - add device-specific port names
   - begin numbering ports at 1

<perex@suse.cz> (04/02/23 1.1597.2.6)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA sequencer
   Clemens Ladisch <clemens@ladisch.de>
   This patch reverses the order of the 'Rawmidi x' and rawmidi name
   parts of client names to enable selecting clients by a unique prefix
   (as snd_seq_parse_address does).

<perex@suse.cz> (04/02/23 1.1597.2.5)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   MPU401 UART
   Clemens Ladisch <clemens@ladisch.de>
   remove unneeded technical information from port names

<perex@suse.cz> (04/02/23 1.1597.2.4)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA sequencer
   Clemens Ladisch <clemens@ladisch.de>
   Timestamping (if enabled on a subscription or a port) is not applied
   to the quoted event but to the quoting event.  This patch adds a
   function to copy only selected fields into the event to be delivered.
   
   - fix KERNEL_QUOTE event timestamping
   - fix typo in port_broadcast_event

<perex@suse.cz> (04/02/23 1.1597.2.3)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   RME HDSP driver
   Fixed wrong assert, added checks for copy_*_user functions

<perex@suse.cz> (04/02/23 1.1597.2.2)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Trident driver
   Fixed s/pdif control initialization

<perex@suse.cz> (04/02/21 1.1588.1.28)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Fixed swap_headphone() when headpone controls do not exist

<perex@suse.cz> (04/02/21 1.1588.1.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   Clemens Ladisch <clemens@ladisch.de>:
   
   - added the quirk for Edirol UA-3FX.

<perex@suse.cz> (04/02/21 1.1588.1.26)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   Fixed oops regarding last period_frames update

<perex@suse.cz> (04/02/21 1.1588.1.25)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel
   Added OSS period frames to proc interface

<perex@suse.cz> (04/02/21 1.1588.1.24)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   Fixed oss.period_frames setup

<perex@suse.cz> (04/02/21 1.1588.1.23)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA<-OSS emulation
   Added period_frames to fix poll behavior

<perex@suse.cz> (04/02/21 1.1588.1.22)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA<-OSS sequencer
   - fixed the behavior of SNDCTL_SEQ_IOCTL.
     (don't close the device).

<perex@suse.cz> (04/02/21 1.1588.1.21)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   - clean up the irq status bit debugging.
   - added nVidia Ck8S support.

<perex@suse.cz> (04/02/21 1.1588.1.20)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   MIXART driver
   - replaced the debug messages with snd_printdd().

<perex@suse.cz> (04/02/21 1.1588.1.19)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the dxs default for MSI KT6 Delta-SR.
   - fixed the calculation of rate bits (based on 0x100000).

<perex@suse.cz> (04/02/21 1.1588.1.18)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Intel8x0 driver
   Added spinlock to pointer callback - ichdev->position is not changed atomically

<perex@suse.cz> (04/02/21 1.1588.1.17)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the initial value of AD_MISC register for AD1885.

<perex@suse.cz> (04/02/21 1.1588.1.16)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA sequencer
   - fixed the race conditions.

<perex@suse.cz> (04/02/21 1.1588.1.15)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   Alain Cretet <cretet@digigram.com>:
   - fixed the 24bit mono recording.

<perex@suse.cz> (04/02/21 1.1588.1.14)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   Alain Cretet <cretet@digigram.com>:
   - fixed the missing input VU meter.

<perex@suse.cz> (04/02/21 1.1588.1.13)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   Clemens Ladisch <clemens@ladisch.de>:
   Terratec PHASE 26 MIDI support

<perex@suse.cz> (04/02/21 1.1588.1.12)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   Clemens Ladisch <clemens@ladisch.de>:
   added AD1888 support.

<perex@suse.cz> (04/02/21 1.1588.1.11)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fix for AD1885
     - set the default MISC register value.
     - disabled 'digital audio mode', which seems problematic on many boards.

<perex@suse.cz> (04/02/21 1.1588.1.10)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - changed the default DXS of GA-7VAXP to NO_VRA.

<perex@suse.cz> (04/02/21 1.1588.1.9)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   - return with IRQ_RETVAL() for the unknown IRQ bits (often found on nForce2)
     with debug messages.

<perex@suse.cz> (04/02/21 1.1588.1.8)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver,ICE1724 driver
   - added the support of independent surround PCM for ice1724.

<perex@suse.cz> (04/02/21 1.1588.1.7)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   - fixed another wrong lock.

<perex@suse.cz> (04/02/21 1.1588.1.6)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ALSA Core,PCI drivers,MIXART driver,IGNORE
   - added snd-mixart driver for Digigram miXart boards.

<perex@suse.cz> (04/02/21 1.1588.1.5)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   - fixed the wrong lock (bug #2052) - use spin_lock_irqsave() now.

<perex@suse.cz> (04/02/21 1.1588.1.4)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   USB generic driver
   - assign PCM unique (sub)streams for each USB format type.
     this will avoid the mix up of format I and format III on M-audio transit.

<perex@suse.cz> (04/02/21 1.1588.1.3)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the detection of surround/LFE VRA on ALC650.

<perex@suse.cz> (04/02/21 1.1588.1.2)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the mic gpio switch handling on the old ALC650.
   - fixed the wrong register initialization on ALC655/658.

<perex@suse.cz> (04/02/21 1.1588.1.1)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   - added the ac97 quirk for Intel D845WN (82801BA)


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
