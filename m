Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUHIQx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUHIQx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUHIQx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:53:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:61106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266741AbUHIQwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:52:04 -0400
X-Authenticated: #4399952
Date: Mon, 9 Aug 2004 19:02:01 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-Id: <20040809190201.64dab6ea@mango.fruits.de>
In-Reply-To: <20040809130558.GA17725@elte.hu>
References: <1090795742.719.4.camel@mindpipe>
	<20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040809130558.GA17725@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 15:05:58 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > (the APIC bug has not been found yet so either turn off all APIC
> > options in .config or use noapic if you intend to use
> > voluntary_preempt=3.)
> 
> but it would be nice if those experiencing APIC lockups could test the
> following: does the lockup still occur with -O4 if
> kernel_preemption=0?(while keeping voluntary_preemption=3)

I don't use APIC, since it never worked good for me.. But i wanted to
report that the mlockall latency still seems to be there.. I can easily
trigger it with mlockall'ing > ~10000kb. Need to recompile with the
preempt-timing patch, but here's an xrun trace that happened when
mlockall'ing 20000kb:

Aug  9 18:53:51 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug  9 18:53:51 mango kernel:  [<c010636e>] dump_stack+0x1e/0x20
Aug  9 18:53:51 mango kernel:  [<f08befae>]
snd_pcm_period_elapsed+0x2ee/0x460 [snd_pcm]
Aug  9 18:53:51 mango kernel:  [<f08e1b84>]
snd_cs46xx_interrupt+0x1b4/0x1f0 [snd_cs46xx]
Aug  9 18:53:51 mango kernel:  [<c011a5db>]
generic_handle_IRQ_event+0x3b/0x70
Aug  9 18:53:51 mango kernel:  [<c0107725>] do_IRQ+0xa5/0x150
Aug  9 18:53:51 mango kernel:  [<c0105f88>] common_interrupt+0x18/0x20
Aug  9 18:53:51 mango kernel:  [<c013cc4a>] get_user_pages+0xca/0x380
Aug  9 18:53:51 mango kernel:  [<c013e33d>] make_pages_present+0x8d/0xb0
Aug  9 18:53:51 mango kernel:  [<c013e7e6>] mlock_fixup+0xa6/0xc0
Aug  9 18:53:51 mango kernel:  [<c013eadb>] do_mlockall+0x7b/0x90
Aug  9 18:53:51 mango kernel:  [<c013eb8e>] sys_mlockall+0x9e/0xb0
Aug  9 18:53:51 mango kernel:  [<c0105e1b>] syscall_call+0x7/0xb

I can also see some of these [sparse they are though]:

Aug  9 18:58:08 mango kernel: ALSA sound/core/pcm_lib.c:199: Unexpected
hw_pointer value [1] (stream = 0, delta: -32, max jitter = 64): wrong
interrupt acknowledge?
Aug  9 18:58:08 mango kernel:  [<c010636e>] dump_stack+0x1e/0x20
Aug  9 18:58:08 mango kernel:  [<f08bee8d>]
snd_pcm_period_elapsed+0x1cd/0x460 [snd_pcm]
Aug  9 18:58:08 mango kernel:  [<f08e1b84>]
snd_cs46xx_interrupt+0x1b4/0x1f0 [snd_cs46xx]
Aug  9 18:58:08 mango kernel:  [<c011a5db>]
generic_handle_IRQ_event+0x3b/0x70
Aug  9 18:58:08 mango kernel:  [<c0107725>] do_IRQ+0xa5/0x150
Aug  9 18:58:08 mango kernel:  [<c0105f88>] common_interrupt+0x18/0x20

Flo


-- 
Palimm Palimm!
http://affenbande.org/~tapas/

