Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTI3Kwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTI3Kwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:52:49 -0400
Received: from gate.perex.cz ([194.212.165.105]:24197 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261293AbTI3Kwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:52:45 -0400
Date: Tue, 30 Sep 2003 12:51:52 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] OSS emulation fixes
Message-ID: <Pine.LNX.4.53.0309301247030.1362@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-09-30.patch.gz

Additional notes:

  Linus, please, merge C: (means changed code block) lines to your
  release change log too - otherwise it's not much readable. Thank you.

The pull command will update the following files:

 include/sound/pcm_oss.h      |    1
 include/sound/rawmidi.h      |    1
 sound/core/control.c         |    3 --
 sound/core/hwdep.c           |    3 +-
 sound/core/init.c            |    2 -
 sound/core/oss/pcm_oss.c     |   59 +++++++++++++++++++++++++++++++------------
 sound/core/pcm_lib.c         |    6 +---
 sound/core/pcm_native.c      |    9 ++----
 sound/core/rawmidi.c         |   32 +++++++++++++----------
 sound/core/seq/seq_lock.c    |   38 ---------------------------
 sound/core/timer.c           |    1
 sound/drivers/dummy.c        |   32 +++++++++++++++++++++++
 sound/isa/sb/emu8000_patch.c |    6 ----
 sound/isa/sb/emu8000_pcm.c   |   10 ++-----
 sound/pci/Kconfig            |   12 ++++----
 sound/pci/via82xx.c          |   21 ++++++++-------
 sound/pci/vx222/vx222_ops.c  |    6 ----
 sound/usb/usbaudio.c         |    1
 sound/usb/usbmixer.c         |   10 +++----
 19 files changed, 132 insertions(+), 121 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/09/30 1.1457)
   ALSA CVS update
   D:2003/09/30 11:15:44
   C:RawMidi Midlevel
   A:Takashi Iwai <tiwai@suse.de>
   F:core/rawmidi.c:1.38->1.39
   L:fixed typos (open_lock -> open_mutex).

<perex@suse.cz> (03/09/30 1.1456)
   ALSA CVS update
   D:2003/09/30 11:12:09
   C:VIA82xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/via82xx.c:1.52->1.53
   L:- fixed the detection of VIA8233A (it was overridden by dxs_support
   L:  option).

<perex@suse.cz> (03/09/30 1.1267.62.6)
   ALSA CVS update
   D:2003/09/30 10:28:26
   C:Control Midlevel,HWDEP Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel
   C:Timer Midlevel,ALSA<-OSS emulation,ALSA sequencer,EMU8000 driver
   C:Digigram VX222 driver,USB generic driver
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/control.c:1.37->1.38
   F:core/hwdep.c:1.21->1.22
   F:core/init.c:1.38->1.39
   F:core/pcm_lib.c:1.43->1.44
   F:core/pcm_native.c:1.81->1.82
   F:core/rawmidi.c:1.37->1.38
   F:core/timer.c:1.46->1.47
   F:core/oss/pcm_oss.c:1.52->1.53
   F:core/seq/seq_lock.c:1.7->1.8
   F:include/rawmidi.h:1.10->1.11
   F:isa/sb/emu8000_patch.c:1.6->1.7
   F:isa/sb/emu8000_pcm.c:1.10->1.11
   F:pci/vx222/vx222_ops.c:1.2->1.3
   F:usb/usbaudio.c:1.65->1.66
   L:Revised schedule() and set_current_state() calls.
   L:Replaced need_resched() with cond_resched() call.

<perex@suse.cz> (03/09/30 1.1267.62.5)
   ALSA CVS update
   D:2003/09/30 09:58:53
   C:Generic drivers
   A:Jaroslav Kysela <perex@suse.cz>
   F:drivers/dummy.c:1.25->1.26
   L:Added emu10k1 emulation by Takashi

<perex@suse.cz> (03/09/30 1.1267.62.4)
   ALSA CVS update
   D:2003/09/30 08:54:19
   C:ALSA<-OSS emulation
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/oss/pcm_oss.c:1.51->1.52
   L:Fixed compilation for the sync code commited by mistake.
   L:Fixed possible race in sync1 code (schedule call) and used schedule_timeout.

<perex@suse.cz> (03/09/30 1.1267.62.3)
   ALSA CVS update
   D:2003/09/29 19:16:18
   C:ALSA<-OSS emulation
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/oss/pcm_oss.c:1.50->1.51
   F:include/pcm_oss.h:1.7->1.8
   L:Fixed oops in oss_sync() routine.

<perex@suse.cz> (03/09/30 1.1267.62.2)
   ALSA CVS update
   D:2003/09/29 08:31:25
   C:PCI drivers
   A:Jaroslav Kysela <perex@suse.cz>
   F:pci/Kconfig:1.8->1.9
   L:Removed GAMEPORT dependency (already handled in drivers)

<perex@suse.cz> (03/09/30 1.1267.62.1)
   ALSA CVS update
   D:2003/09/26 15:29:05
   C:USB generic driver
   A:Takashi Iwai <tiwai@suse.de>
   F:usb/usbmixer.c:1.23->1.24
   L:probe units even under a selector unit which is marked as ignored or has
   L:only a single selector.


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
