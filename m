Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUEaJXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUEaJXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUEaJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:23:18 -0400
Received: from gate.perex.cz ([82.113.61.162]:39366 "EHLO
	outgoing.perex-int.cz") by vger.kernel.org with ESMTP
	id S264585AbUEaJW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:22:29 -0400
Date: Mon, 31 May 2004 11:27:12 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] update to ALSA 1.0.5
Message-ID: <Pine.LNX.4.58.0405311103190.1799@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-05-31.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt |    5 
 include/sound/ac97_codec.h                      |    6 
 include/sound/core.h                            |    4 
 include/sound/seq_kernel.h                      |    3 
 include/sound/version.h                         |    4 
 include/sound/vx_core.h                         |    8 
 sound/core/memalloc.c                           |    4 
 sound/core/seq/oss/seq_oss_timer.c              |    2 
 sound/core/seq/seq.c                            |    1 
 sound/core/seq/seq_clientmgr.c                  |   18 -
 sound/drivers/vx/vx_core.c                      |    3 
 sound/drivers/vx/vx_mixer.c                     |   51 ++++
 sound/drivers/vx/vx_pcm.c                       |   13 -
 sound/drivers/vx/vx_uer.c                       |   15 -
 sound/isa/wavefront/wavefront_synth.c           |    6 
 sound/parisc/harmony.c                          |   44 ++-
 sound/pci/ac97/ac97_codec.c                     |  254 +++++++++++++--------
 sound/pci/ac97/ac97_id.h                        |    7 
 sound/pci/ac97/ac97_local.h                     |   14 -
 sound/pci/ac97/ac97_patch.c                     |  285 ++++++++++++++++++------
 sound/pci/ac97/ac97_patch.h                     |    1 
 sound/pci/ac97/ac97_proc.c                      |   10 
 sound/pci/atiixp.c                              |   16 -
 sound/pci/ice1712/Makefile                      |    2 
 sound/pci/ice1712/ice1724.c                     |   31 --
 sound/pci/ice1712/vt1720_mobo.c                 |   97 ++++++++
 sound/pci/ice1712/vt1720_mobo.h                 |   35 ++
 sound/pci/via82xx.c                             |   54 +---
 28 files changed, 717 insertions(+), 276 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/05/31 1.1766)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   Fixed mutex deadlocks.

<perex@suse.cz> (04/05/30 1.1764)
   ALSA 1.0.5

<perex@suse.cz> (04/05/30 1.1763)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   Fixed warnings for pci PM callbacks when not CONFIG_PCI

<perex@suse.cz> (04/05/28 1.1762)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - Added the single mixer control with AC97 2.3 paging.
   - Handle the paging for some ALC655/658 registers.
   - Added the experimental support for ALC850.

<perex@suse.cz> (04/05/28 1.1761)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   Avoid warning message during codec probing in case SKIP_AUDIO flag is not set.

<perex@suse.cz> (04/05/28 1.1760)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver
   fixed typos.

<perex@suse.cz> (04/05/28 1.1759)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Signed-off-by: Kevin Mack <kevmack@accesscomm.ca>
   For Gateway M675 notebook - this will direct mixer
   output to speaker, headphone and line-out instead
   of just the front(DAC-A) signal.

<perex@suse.cz> (04/05/28 1.1758)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - use snd_pcm_limit_hw_rates() and removed redundant codes.
   - fixed the rate constraints when 'IEC958 Output Switch' is on.
   - check the SPDIF support on AC97 and don't build IEC958 stuffs if not available.

<perex@suse.cz> (04/05/28 1.1757)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   added ac97_can_spdif() for checking the SPDIF support.

<perex@suse.cz> (04/05/28 1.1756)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   added the DXS entry for Mitac/Vobis/Yakumo laptop.

<perex@suse.cz> (04/05/28 1.1755)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   Wavefront drivers
   fix possible buffer overflow in wavefront_download_firmware()

<perex@suse.cz> (04/05/28 1.1754)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1724 driver
   avoid to change the AC97 rate registers.  this seems conflicting
   with the rate conversion on VT172x.

<perex@suse.cz> (04/05/28 1.1753)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   added 'Clock Mode' control to choose the clock source.

<perex@suse.cz> (04/05/28 1.1752)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   fixed the compile warnings due to the last change.

<perex@suse.cz> (04/05/28 1.1751)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver
   - fixed the buffer handling without dma_alloc_coherent support.

<perex@suse.cz> (04/05/28 1.1750)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   fixed sleep while atomic in the trigger callback.

<perex@suse.cz> (04/05/28 1.1749)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - added the global mutex for ac97_t (ad18xx mutex is removed).
     used to protect paging and AD18xx multi-codecs.
   - set PAGE_INT register explicitly before accessing (for STAC9758).
   - moved ALC650 revision check to patch_alc650().
   - support stereo Mic playback.
   - moved STAC9708 quirk to patch_stac9708().
   - don't clear PC_BEEP high bits (ac97 2.3 sets frequency there).
   - avoid the unnecessary RESET-waiting for audio/modem codec.
   - fixed the evaluation of modem codec to call mpatch callback properly.
   - determine the SPDIF rate in the build path.
   - added suffix argument to snd_ac97_rename|remove|swap_ctl().
   - added snd_ac97_rename_vol_ctl().

<perex@suse.cz> (04/05/28 1.1748)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   - added ifdef CONFIG_PCI around the enable module option to avoid the compile
     warnings without PCI support.

<perex@suse.cz> (04/05/28 1.1747)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ICE1712 driver,ICE1724 driver
   - fixed the description of model module parameters for ice1712 and ice1724
     drivers.
   - added the support of VT1720-based mobo.
     (still experimental and supporting AC97 only)

<perex@suse.cz> (04/05/28 1.1746)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ATIIXP driver
   - continue to probe other codecs even if a codec returns error
     (instead of breaking the probing).
     this will fix some cases with both AC97 and MC97 codecs.

<perex@suse.cz> (04/05/28 1.1745)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA sequencer,ALSA<-OSS sequencer
   export snd_seq_set_queue_tempo() for OSS to prevent calling
   snd_seq_kernel_client_ctl() (using copy_from_user()) in interrupt
   context


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
