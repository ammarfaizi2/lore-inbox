Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUGXE6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUGXE6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 00:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUGXE6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 00:58:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30871 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268280AbUGXE6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 00:58:46 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040720121905.GG1651@suse.de>
References: <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de>
Content-Type: text/plain
Message-Id: <1090645125.956.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 00:58:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 08:19, Jens Axboe wrote:
> On Tue, Jul 20 2004, Ingo Molnar wrote:
> > > How much I/O do you allow to be in flight at once?  It seems like by
> > > decreasing the maximum size of I/O that you handle in one interrupt
> > > you could improve this quite a bit.  Disk throughput is good enough,
> > > anyone in the real world who would feel a 10% hit would just throw
> > > hardware at the problem.
> > 
> > i'm not sure whether this particular value (max # of sg-entries per IO
> > op) is runtime tunable. Jens? Might make sense to enable elvtune-alike
> > tunability of this value.
> 
> elvtune is long dead :-)
> 

This one occured several times while bonnie was cleaning up after
itself:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169:
XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de935377>] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
 [<de945211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c3>] handle_IRQ_event+0x33/0x60
 [<c0107c05>] do_IRQ+0xa5/0x170
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0161b81>] shrink_dcache_parent+0x21/0x30
 [<c0159d69>] d_unhash+0x39/0xb0
 [<c0159e4c>] vfs_rmdir+0x6c/0x1b0
 [<c015a05f>] sys_rmdir+0xcf/0xf0
 [<c0106047>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169:
XRUN: pcmC0D0p
 [<c01066a7>] dump_stack+0x17/0x20
 [<de935377>] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
 [<de945477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c01078c3>] handle_IRQ_event+0x33/0x60
 [<c0107c05>] do_IRQ+0xa5/0x170
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0161b81>] shrink_dcache_parent+0x21/0x30
 [<c0159d69>] d_unhash+0x39/0xb0
 [<c0159e4c>] vfs_rmdir+0x6c/0x1b0
 [<c015a05f>] sys_rmdir+0xcf/0xf0
 [<c0106047>] syscall_call+0x7/0xb

Lee


