Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUGMH5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUGMH5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 03:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUGMH5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 03:57:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25318 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264206AbUGMH5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 03:57:11 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040712205917.47d1d58b.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089705440.20381.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 03:57:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 23:59, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Here are a few more:
> > 
> >  Jul 12 22:20:41 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
> >  Jul 12 22:20:41 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
> >  Jul 12 22:20:41 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
> >  Jul 12 22:20:41 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
> >  Jul 12 22:20:41 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
> >  Jul 12 22:20:41 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> >  Jul 12 22:20:41 mindpipe kernel:  [unix_stream_recvmsg+135/1088] unix_stream_recvmsg+0x87/0x440
> >  Jul 12 22:20:41 mindpipe kernel:  [avc_has_perm+72/96] avc_has_perm+0x48/0x60
> >  Jul 12 22:20:41 mindpipe kernel:  [sock_aio_read+155/176] sock_aio_read+0x9b/0xb0
> >  Jul 12 22:20:41 mindpipe kernel:  [do_sync_read+125/192] do_sync_read+0x7d/0xc0
> >  Jul 12 22:20:41 mindpipe kernel:  [do_select+435/752] do_select+0x1b3/0x2f0
> >  Jul 12 22:20:41 mindpipe kernel:  [vfs_read+223/256] vfs_read+0xdf/0x100
> >  Jul 12 22:20:42 mindpipe kernel:  [sys_read+45/80] sys_read+0x2d/0x50
> >  Jul 12 22:20:42 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> >  Jul 12 22:20:42 mindpipe kernel:
> >  Jul 12 22:20:44 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
> >  Jul 12 22:20:44 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
> >  Jul 12 22:20:44 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
> >  Jul 12 22:20:44 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
> >  Jul 12 22:20:44 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
> >  Jul 12 22:20:44 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> 
> Oh dear, these don't make much sense.
> 
> You'll have the best chance of getting decent traces with
> CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n, but I'm not sure that this
> will help a lot.  Are you sure that CONFIG_PREEMPT is enabled on that
> kernel?

Yes:

root@mindpipe:/home/rlrevell/kernel-source/kernel-source-2.6.7# grep . /proc/sys/kernel/*_preemption
/proc/sys/kernel/kernel_preemption:1
/proc/sys/kernel/voluntary_preemption:1

My testing also uncovered a possible bug in the emu10k1 driver, I am
looking into this.  I don't think it's related because the log entries
are spaced minutes apart.  Could this be a driver problem?  Hardware?

Just as a reference point, what do you think is the longest delay I
*should* be seeing?  I recall hearing that BEOS guaranteed that
interrupts are never disabled for more than 50 usecs.  This seems
achievable, as the average delay I am seeing is 15 usecs.

I will set CONFIG_FRAME_POINTER=Y and CONFIG_4KSTACKS=n and test some
more.

Lee

