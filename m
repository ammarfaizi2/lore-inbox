Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUGMUiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUGMUiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGMUiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:38:02 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34179 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265800AbUGMUhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:37:47 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040713022919.67c991db.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089707483.20381.33.camel@mindpipe>
	 <20040713014316.2ce9181d.akpm@osdl.org>
	 <1089708818.20381.36.camel@mindpipe>
	 <20040713020025.7400c648.akpm@osdl.org>
	 <1089710638.20381.41.camel@mindpipe>
	 <20040713022919.67c991db.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089751077.22175.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 16:37:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 05:29, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Tue, 2004-07-13 at 05:00, Andrew Morton wrote:
> > > Lee Revell <rlrevell@joe-job.com> wrote:
> > > >
> > > > > framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
> > > >  > vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
> > > >  > but make sure you're wearing ear protection.
> > > >  > 
> > > > 
> > > >  OK, I figured this was not an easy one.  I can just not do that.
> > > 
> > > Why not?  You can certainly try removing those [un]lock_kernel() calls.
> > > 
> > 
> > Maybe I missed something.  What exactly do you mean by 'make sure you're
> > wearing ear protection'?
> > 
> 
> It might go boom.  If it does screw up, it probably won't be very seriously
> bad - maybe some display glitches.  Just an experiment.

Heh, I thought you literally meant it could destroy my speakers.  I have
a pretty loud amp hooked up to this thing!  I will try that.

Meanwhile, here are some more XRUS traces from the same test, run
overnight, without any significant network activity.  I believe updatedb
may have caused these.  I left out the reiserfs related ones because
that seems to be a known issue.

Jul 13 06:22:07 mindpipe kernel:
Jul 13 06:22:07 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 06:22:07 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 06:22:07 mindpipe kernel:  [do_pollfd+125/144] do_pollfd+0x7d/0x90
Jul 13 06:22:07 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 06:22:07 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 06:22:07 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 06:22:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 06:22:07 mindpipe kernel:
Jul 13 06:22:07 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 06:22:07 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 06:22:07 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 06:22:07 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 06:22:07 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 06:22:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 06:22:07 mindpipe kernel:  [__kmalloc+110/160] __kmalloc+0x6e/0xa0
Jul 13 06:22:07 mindpipe kernel:  [sys_poll+209/560] sys_poll+0xd1/0x230
Jul 13 06:22:07 mindpipe kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Jul 13 06:22:07 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 06:22:07 mindpipe kernel:
Jul 13 06:22:19 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 06:22:19 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 06:22:19 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 06:22:19 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 06:22:19 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 06:22:19 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 06:22:19 mindpipe kernel:
Jul 13 06:26:13 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 06:26:13 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 06:26:13 mindpipe kernel:  [__crc_totalram_pages+2260290/5353478] find_attr+0xdc/0x250 [ntfs]
Jul 13 06:26:13 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 06:26:13 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 06:26:13 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 06:26:13 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 06:26:13 mindpipe kernel:  [__crc_totalram_pages+2275930/5353478] ntfs_readdir+0xd24/0xfe0 [ntfs]
Jul 13 06:26:13 mindpipe kernel:  [filldir64+0/256] filldir64+0x0/0x100
Jul 13 06:26:13 mindpipe kernel:  [vfs_readdir+133/160] vfs_readdir+0x85/0xa0
Jul 13 06:26:13 mindpipe kernel:  [filldir64+0/256] filldir64+0x0/0x100
Jul 13 06:26:13 mindpipe kernel:  [sys_getdents64+102/163] sys_getdents64+0x66/0xa3
Jul 13 06:26:13 mindpipe kernel:  [filldir64+0/256] filldir64+0x0/0x100
Jul 13 06:26:13 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 06:26:13 mindpipe kernel:

Lee

