Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUGXARJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUGXARJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 20:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268196AbUGXARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 20:17:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9600 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268197AbUGXARA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 20:17:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rudo Thomas <rudo@matfyz.cz>, Matt Heler <lkml@lpbproductions.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040723112842.GA5133@elte.hu>
References: <20040722160055.GA4837@ss1000.ms.mff.cuni.cz>
	 <20040722161941.GA23972@elte.hu>
	 <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
	 <20040722175457.GA5855@ss1000.ms.mff.cuni.cz>
	 <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu>
	 <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu>
	 <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu>
	 <20040723112842.GA5133@elte.hu>
Content-Type: text/plain
Message-Id: <1090628218.1471.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 20:16:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 07:28, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> there's one more new version:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I4
> 

With I4, it looks like there are still problems with get_user_pages(),
select(), and mlockall().  The PS/2 Caps/Scroll/Num Lock problem is also
still present.  Here are the resulting XRUN traces.  I have omitted the
trace for the Caps Lock problem, as that one seems to be well understood
already.

Jul 23 20:07:10 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 23 20:07:10 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 23 20:07:10 mindpipe kernel:  [__crc_totalram_pages+78717/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 23 20:07:10 mindpipe kernel:  [__crc_totalram_pages+254909/3197748] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 23 20:07:10 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 23 20:07:10 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 23 20:07:10 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 23 20:07:10 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 23 20:07:10 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 23 20:07:10 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 23 20:07:10 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
Jul 23 20:07:10 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 23 20:07:10 mindpipe kernel:  [mlock_fixup+141/176] mlock_fixup+0x8d/0xb0
Jul 23 20:07:10 mindpipe kernel:  [do_mlockall+112/144] do_mlockall+0x70/0x90
Jul 23 20:07:10 mindpipe kernel:  [sys_mlockall+153/160] sys_mlockall+0x99/0xa0
Jul 23 20:07:10 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 23 20:07:10 mindpipe kernel: IRQ: delay =  69821400 cycles, jitter = 69421103 - missed an interrupt?
Jul 23 20:07:10 mindpipe kernel: IRQ: delay =  398769 cycles, jitter = 69422631 - missed an interrupt?
Jul 23 20:07:10 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 23 20:07:10 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 23 20:07:10 mindpipe kernel:  [__crc_totalram_pages+78717/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 23 20:07:10 mindpipe kernel:  [__crc_totalram_pages+254295/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 23 20:07:10 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 23 20:07:10 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 23 20:07:10 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 23 20:07:10 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 23 20:07:10 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 23 20:07:10 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 23 20:07:10 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
Jul 23 20:07:10 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 23 20:07:10 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
Jul 23 20:07:10 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 23 20:07:10 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 23 20:07:10 mindpipe kernel: IRQ: delay =  6361006 cycles, jitter = 5962552 - missed an interrupt?
Jul 23 20:07:10 mindpipe kernel: IRQ: delay =  38254 cycles, jitter = 6322752 - missed an interrupt?
Jul 23 20:07:10 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 23 20:07:10 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 23 20:07:10 mindpipe kernel:  [__crc_totalram_pages+78717/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 23 20:07:10 mindpipe kernel:  [__crc_totalram_pages+254909/3197748] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 23 20:07:10 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 23 20:07:10 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 23 20:07:10 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 23 20:07:10 mindpipe kernel: IRQ: delay =  1538153 cycles, jitter = 1499899 - missed an interrupt?
Jul 23 20:07:10 mindpipe kernel: IRQ: delay =  399332 cycles, jitter = 1138821 - missed an interrupt?

Jul 23 20:07:14 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 23 20:07:14 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 23 20:07:14 mindpipe kernel:  [__crc_totalram_pages+78717/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 23 20:07:14 mindpipe kernel:  [__crc_totalram_pages+254295/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 23 20:07:14 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 23 20:07:14 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 23 20:07:14 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 23 20:07:14 mindpipe kernel:  [schedule+727/1424] schedule+0x2d7/0x590
Jul 23 20:07:14 mindpipe kernel:  [schedule_timeout+87/160] schedule_timeout+0x57/0xa0
Jul 23 20:07:14 mindpipe kernel:  [do_select+338/672] do_select+0x152/0x2a0
Jul 23 20:07:14 mindpipe kernel:  [sys_select+678/1216] sys_select+0x2a6/0x4c0
Jul 23 20:07:14 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Lee



