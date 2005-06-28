Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVF1H5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVF1H5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVF1HzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:55:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:3791 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261995AbVF1Hxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:53:43 -0400
Date: Tue, 28 Jun 2005 03:53:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Daniel Walker <dwalker@mvista.com>
cc: Chuck Harding <charding@llnl.gov>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <1119902991.4794.5.camel@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain>
References: <20050608112801.GA31084@elte.hu>  <20050625091215.GC27073@elte.hu>
  <200506250919.52640.gene.heskett@verizon.net>  <200506251039.14746.gene.heskett@verizon.net>
  <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
 <1119902991.4794.5.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please CC Ingo Molnar on all RT kernel issues]

On Mon, 27 Jun 2005, Daniel Walker wrote:

> On Mon, 2005-06-27 at 12:01 -0700, Chuck Harding wrote:
> > What can be causing the following message to appear in dmesg and
> > how can I fix it?
> >
> > BUG: scheduling with irqs disabled: kapmd/0x00000000/46
> > caller is schedule_timeout+0x51/0x9e
> >   [<c02b3bc9>] schedule+0x96/0xf6 (8)
> >   [<c02b43f7>] schedule_timeout+0x51/0x9e (28)
> >   [<c01222ed>] process_timeout+0x0/0x5 (32)
> >   [<c0112063>] apm_mainloop+0x7a/0x96 (24)
> >   [<c0115e45>] default_wake_function+0x0/0x16 (12)
> >   [<c0115e45>] default_wake_function+0x0/0x16 (32)
> >   [<c0111485>] apm_driver_version+0x1c/0x38 (16)
> >   [<c01126f7>] apm+0x0/0x289 (8)
> >   [<c01127a6>] apm+0xaf/0x289 (8)
> >   [<c010133c>] kernel_thread_helper+0x0/0xb (20)
> >   [<c0101341>] kernel_thread_helper+0x5/0xb (4)
> >
> > This was also present in earlier final-V0.7.50 version I've tried
> > (since -00) I don't get hangs but that doesn't look like it should
> > be happening. Thanks.
>
> If you have PREEMPT_RT enabled, it looks like interrupts are hard
> disabled then there is a schedule_timeout() requested. You could try
> turning off power management and see if you still have problems.
>

Although turning off apm works, this is a fix to the symptom and not a
cure.  Has someone already taken a look at this code? Since
apm_bios_call_simple calls local_save_flags and afterwards
raw_lock_irq_restore is then called.  Shouldn't that have been
raw_local_save_flags?

That apm_bios_call_simple_asm also looks pretty scary!  I haven't yet
figured out how APM_FUNC_VERSION becomes a normal function.

-- Steve

