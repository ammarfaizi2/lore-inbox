Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUGQBE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUGQBE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 21:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUGQBE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 21:04:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60830 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266666AbUGQBEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 21:04:25 -0400
Subject: Re: XRUN traces
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713235655.263ce5f3.akpm@osdl.org>
References: <1089758294.2747.4.camel@mindpipe>
	 <20040713161004.37a4654e.akpm@osdl.org> <1089787542.3360.11.camel@mindpipe>
	 <20040713235655.263ce5f3.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1090026275.2852.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 21:04:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 02:56, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > This is the only one I am still seeing that does not involve
> >  get_user_pages().  I am seeing quite a lot with get_user_pages, but very
> >  few of these:
> 
> get_user_pages() shold be fixed in rc1-mm1.  But that kernel is busted, so
> wait until I have a fix.
> 
> 

With 2.6.8-rc1-mm1, when I have started a jackd process in the playback
direction, and launch another in the capture direction, I can reliably
trigger a ~150ms XRUN in the first process.  The duration of the XRUN 
is exactly the same each time, it is probably a funciton of the amount
of memory being mlockall()'ed.

Otherwise this kernel seems pretty good.

Jul 16 20:57:29 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 16 20:57:29 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 16 20:57:29 mindpipe kernel:  [__crc_totalram_pages+115469/3518512] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 16 20:57:29 mindpipe kernel:  [__crc_totalram_pages+180567/3518512] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 16 20:57:29 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 16 20:57:29 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 16 20:57:29 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 16 20:57:29 mindpipe kernel:  [__alloc_pages+167/816] __alloc_pages+0xa7/0x330
Jul 16 20:57:29 mindpipe kernel:  [do_anonymous_page+96/384] do_anonymous_page+0x60/0x180
Jul 16 20:57:29 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 16 20:57:29 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 16 20:57:29 mindpipe kernel:  [get_user_pages+337/960] get_user_pages+0x151/0x3c0
Jul 16 20:57:29 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 16 20:57:29 mindpipe kernel:  [mlock_fixup+141/176] mlock_fixup+0x8d/0xb0
Jul 16 20:57:29 mindpipe kernel:  [do_mlockall+112/144] do_mlockall+0x70/0x90
Jul 16 20:57:29 mindpipe kernel:  [sys_mlockall+150/160] sys_mlockall+0x96/0xa0
Jul 16 20:57:29 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Lee

