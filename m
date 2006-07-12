Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWGLScG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWGLScG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWGLScG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:32:06 -0400
Received: from gate.perex.cz ([85.132.177.35]:11495 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932302AbWGLScE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:32:04 -0400
Date: Wed, 12 Jul 2006 20:32:00 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] fixes and cleanups
Message-ID: <Pine.LNX.4.61.0607122019580.7856@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-07-12.patch.gz

The following files will be updated:

 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    4 
 include/sound/core.h                                         |    2 
 include/sound/cs46xx.h                                       |    1 
 sound/core/sound.c                                           |    3 
 sound/core/timer.c                                           |    5 
 sound/i2c/cs8427.c                                           |  116 ++++++-----
 sound/isa/cs423x/Makefile                                    |    1 
 sound/isa/gus/gusextreme.c                                   |    2 
 sound/isa/wavefront/wavefront_fx.c                           |   36 +--
 sound/isa/wavefront/wavefront_midi.c                         |    2 
 sound/isa/wavefront/wavefront_synth.c                        |   14 -
 sound/pci/Kconfig                                            |   14 -
 sound/pci/ad1889.c                                           |    8 
 sound/pci/ali5451/ali5451.c                                  |    2 
 sound/pci/als300.c                                           |    2 
 sound/pci/als4000.c                                          |    2 
 sound/pci/atiixp.c                                           |    2 
 sound/pci/atiixp_modem.c                                     |    2 
 sound/pci/au88x0/au8810.c                                    |    2 
 sound/pci/au88x0/au8820.c                                    |    2 
 sound/pci/au88x0/au8830.c                                    |    2 
 sound/pci/au88x0/au88x0.h                                    |    3 
 sound/pci/au88x0/au88x0_a3d.c                                |   29 +-
 sound/pci/au88x0/au88x0_core.c                               |    4 
 sound/pci/azt3328.c                                          |    2 
 sound/pci/bt87x.c                                            |    2 
 sound/pci/ca0106/ca0106_main.c                               |    2 
 sound/pci/cmipci.c                                           |    2 
 sound/pci/cs4281.c                                           |    2 
 sound/pci/cs46xx/cs46xx.c                                    |    2 
 sound/pci/cs46xx/cs46xx_lib.c                                |    7 
 sound/pci/cs5535audio/cs5535audio.c                          |    2 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1_main.c                             |   10 
 sound/pci/emu10k1/emu10k1x.c                                 |   37 ++-
 sound/pci/emu10k1/emumpu401.c                                |   35 ++-
 sound/pci/ens1370.c                                          |    2 
 sound/pci/es1938.c                                           |    2 
 sound/pci/es1968.c                                           |    2 
 sound/pci/fm801.c                                            |    4 
 sound/pci/hda/hda_intel.c                                    |    2 
 sound/pci/hda/patch_analog.c                                 |   19 +
 sound/pci/ice1712/aureon.c                                   |    2 
 sound/pci/ice1712/ice1712.c                                  |    2 
 sound/pci/ice1712/ice1724.c                                  |    2 
 sound/pci/intel8x0.c                                         |    8 
 sound/pci/intel8x0m.c                                        |    2 
 sound/pci/korg1212/korg1212.c                                |    2 
 sound/pci/maestro3.c                                         |   10 
 sound/pci/mixart/mixart.c                                    |    2 
 sound/pci/nm256/nm256.c                                      |    2 
 sound/pci/pcxhr/pcxhr.c                                      |    2 
 sound/pci/riptide/riptide.c                                  |    2 
 sound/pci/rme32.c                                            |    2 
 sound/pci/rme96.c                                            |    2 
 sound/pci/rme9652/hdsp.c                                     |    4 
 sound/pci/rme9652/rme9652.c                                  |    2 
 sound/pci/sonicvibes.c                                       |    2 
 sound/pci/trident/trident.c                                  |    2 
 sound/pci/via82xx.c                                          |    2 
 sound/pci/via82xx_modem.c                                    |    2 
 sound/pci/vx222/vx222.c                                      |    2 
 sound/pci/ymfpci/ymfpci.c                                    |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |    4 
 64 files changed, 272 insertions(+), 186 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] fix the SND_FM801_TEA575X dependencies
      [ALSA] sound/i2c/cs8427.c: don't export a static function
      [ALSA] make sound/isa/gus/gusextreme.c:devices static

Clemens Ladisch:
      [ALSA] wavefront: fix __init/__devinit confusion
      [ALSA] remove unused snd_minor.name field

Eric Sesterhenn:
      [ALSA] Memory leak in sound/pcmcia/pdaudiocf/pdaudiocf.c

Jaroslav Kysela:
      [ALSA] sound/pci/Kconfig - fix broken indenting for SND_FM801_TEA575X

Randy Dunlap:
      [ALSA] Fix no mpu401 interface can cause hard freeze
      [ALSA] Fix undefined (missing) references in ISA MIRO sound driver

Takashi Iwai:
      [ALSA] Reduce the string length of Terratec Aureon 7.1 Universe
      [ALSA] intel8x0 - Add ac97 quirk for Tyan Thunder K8WE board
      [ALSA] trivial: Code clean up of i2c/cs8427.c
      [ALSA] Fix workaround for AD1988A rev2 codec
      [ALSA] Fix section mismatch errors in ALSA PCI drivers
      [ALSA] Fix a deadlock in snd-rtctimer
      [ALSA] hda-codec - Fix missing array terminators in AD1988 codec support


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
