Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUHJCGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUHJCGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 22:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUHJCGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 22:06:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8399 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267397AbUHJCGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 22:06:08 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040809190201.64dab6ea@mango.fruits.de>
References: <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092103522.761.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 22:06:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 13:02, Florian Schmidt wrote:
> On Mon, 9 Aug 2004 15:05:58 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > (the APIC bug has not been found yet so either turn off all APIC
> > > options in .config or use noapic if you intend to use
> > > voluntary_preempt=3.)
> > 
> > but it would be nice if those experiencing APIC lockups could test the
> > following: does the lockup still occur with -O4 if
> > kernel_preemption=0?(while keeping voluntary_preemption=3)
> 
> I don't use APIC, since it never worked good for me.. But i wanted to
> report that the mlockall latency still seems to be there.. I can easily
> trigger it with mlockall'ing > ~10000kb. Need to recompile with the
> preempt-timing patch, but here's an xrun trace that happened when
> mlockall'ing 20000kb:
> 

Same results here, the mlockall problem is not fixed by -O4:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139:
XRUN: pcmC0D2c
 [<c0106717>] dump_stack+0x17/0x20
 [<de93664b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de9571d1>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c011a7d3>] generic_handle_IRQ_event+0x33/0x60
 [<c01079c2>] do_IRQ+0xb2/0x180
 [<c01062d8>] common_interrupt+0x18/0x20
 [<c013e2ee>] do_anonymous_page+0x7e/0x190
 [<c013e44e>] do_no_page+0x4e/0x310
 [<c013e8d1>] handle_mm_fault+0xc1/0x170
 [<c013d2a0>] get_user_pages+0x130/0x3b0
 [<c013ea28>] make_pages_present+0x68/0x90
 [<c01401d8>] do_mmap_pgoff+0x3f8/0x640
 [<c010b656>] sys_mmap2+0x76/0xb0
 [<c01060b7>] syscall_call+0x7/0xb
(jackd/778): 10984us non-preemptible critical section violated 1100 us
preempt threshold starting at kmap_atomic+0x10/0x60 and ending at
kunmap_atomic+0x8/0x20
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c0111ce8>] kunmap_atomic+0x8/0x20
 [<c013e2fb>] do_anonymous_page+0x8b/0x190
 [<c013e44e>] do_no_page+0x4e/0x310
 [<c013e8d1>] handle_mm_fault+0xc1/0x170
 [<c013d2a0>] get_user_pages+0x130/0x3b0
 [<c013ea28>] make_pages_present+0x68/0x90
 [<c01401d8>] do_mmap_pgoff+0x3f8/0x640
 [<c010b656>] sys_mmap2+0x76/0xb0
 [<c01060b7>] syscall_call+0x7/0xb

Lee


