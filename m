Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWARN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWARN3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWARN3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:29:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932538AbWARN3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:29:44 -0500
Subject: [RFC] Moving snd-bt87x and btaudio to drivers/media
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>,
       alsa devel <alsa-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Johannes Stezenbach <js@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Manu Abraham <abraham.manu@gmail.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 11:29:28 -0200
Message-Id: <1137590968.32449.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee/Andrew/Linus/Takashi and others,

	Currently, we have some audio modules for multimedia devices under
drivers/media and others under sound. They also appear under different
points at Kconfig menus. 

	So, for BTTV support, current structure at linus -git is (from Kconfig
perspective):

	Sound/ALSA/PCI Devices/Bt87x Audio capture
		sound/snd-bt87x.ko - ALSA audio for bttv boards
	Sound/OSS/TV Card (bt848) mixer support
		drivers/media/video/tvmixer.ko

	Multimedia/V4L/BT848 V4L
		drivers/media/video/bttv.ko
	Multimedia/V4L/BT848 V4L/DVB-ATSC support
		drivers/media/dvb/bt8xx/bt878.ko
		drivers/media/dvb/bt8xx/dvb-bt8xx.o

	This I couldn't found at any Kconfig (but module exists, and also an
entry at Makefile):
sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    += btaudio.o

	For SAA7134 and CX88, all are under Multimedia/V4L. All
OSS/ALSA/DVB/MPEG options are under the driver name.

	IMHO, from users perspective, it makes much more sense if all BTTV
moules (even sound ones) being under bttv video driver. Current module
allows using audio driver without video, but this doesn't make sense,
since audio will be only available, in practice, after selecting a
video/audio input or tuning a channel. These functionalities are
provided by bttv. So, we could even disable audio modules if bttv were
not compiled.

	Also, bug 5995 showed a problem when user have a bttv card and dvb is
also probed. dvb also handles audio, so, currently, it is mutually
exclusive with snd-bt87x audio.

	So, my proposal is to move sound/snd-bt87x.ko to drivers/media, moving
also its menu, and moving tvmixer menu also. After it, should move some
related code at bttv dvb modules, to reduce or eliminate mutually
exclusiveness between the two. 

	We might keep supporting btaudio, but I think this is already obsoleted
by alsa one, so, IMHO, we can just drop it. We intend to do the same
with saa7134-oss after some time (kernel 2.6.15 is the first with this
module, so we may remove it on 2.6.18 to give some time for testing).

Cheers, 
Mauro.

