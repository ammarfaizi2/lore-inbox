Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbULQAtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbULQAtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbULQAtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:49:23 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:26037 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262310AbULQAqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:46:04 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <1103066516.12659.377.camel@cmn37.stanford.edu>
References: <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>  <20041214132834.GA32390@elte.hu>
	 <1103066516.12659.377.camel@cmn37.stanford.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1103244306.17958.88.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Dec 2004 16:45:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 15:21, Fernando Lopez-Lezcano wrote:
> On Tue, 2004-12-14 at 05:28, Ingo Molnar wrote:
> > i have released the -V0.7.33-0 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > this is mainly a port from -rc2-mm3 to -rc3-mm1. Changes:
> > 
> > - due to 2.6.10 release work the -mm kernel now is in fixes-mostly mode,
> >   but there's one interesting new feature: -rc3-mm1 introduced the
> >   ->unlocked_ioctl method which is now an official way to do BKL-less
> >   ioctls. I changed the ALSA ->ioctl_bkl changes in -RT to use this
> >   facility. The ALSA/sound guys might be interested in these bits. Thus
> >   another chunk of -RT could go upstream.
> > 
> > - IO-APIC/MSI fix from Steven Rostedt.
> > 
> > - fixed a tracer bug which would produce a kernel warning and an empty
> >   /proc/latency_trace if the trace buffer overflows.
> 
> I don't know which change did it, but I have network connectivity in my
> athlon64 test box with 0.7.33-0! Woohoo! [*]

But I'm still having problems with a dual athlon mp machine while trying
to boot 0.7.33-04 (same as before - this has not booted for quite a
while with the realtime patches). This is what I see:

pnp: 00:02: ioport range 0xe400-0xe4fe could not be reserved
BUG: scheduling while atomic: swapper/0x10000000/1
caller is preempt_schedule_irq+0x34/0x50
 [<c021053c3>] dump_stack+0x23/-x30 (20)
 [<c037438c>] __schedule+0xd5c/0xdb0 (124)
 [<c037432b>] preempt_schedul_irq+0x34/0x50 (12)
 [<c010432b>] need_resched+0x20/0x29 (-7416)
---------------------------
| preempt count: 10000001 ]
| 1-level deep critical section nesting:
---------------------------------------
.. [<c01472ed>] .... print_traces+0x1d/0x60
.....[<c01053c3>] .. ( <= dump_stack+0x23/0x30)

BUG at kernel/latency.c:1292!
--------------------[ cut here ]---------------------
kernel BUG at kernel/latency.c:1292!
invalid operand: 0000 [#1]
PREEMPT_SMP

=================
Booting with:
hardirq_preempt=0
softirq_preempt=0

ide1 at 0x170-0x177,0x376 on irq 15
BUG: scheduling while atomic: swapper/0x10000000/1
caller is preempt_schedule_irq+0x34/0x50
 [<>] dump_stack=0x23/0x30 (20)
 [<>] __schedule+0x5dc/0xdb0 (124)
 [<>] preempt_sched_irq+0x34/0x50 (12)
 [<>] need_resched+0x20/0x29 (-7376)
---------------------------
| preempt count: 10000001 ]
| 1-level deep critical section nesting:
---------------------------------------
.. [<c01472ed>] .... print_traces+0x1d/0x60
.....[<c01053c3>] .. ( <= dump_stack+0x23/0x30)

BUG at kernel/latency.c:1292!
--------------------[ cut here ]---------------------
kernel BUG at kernel/latency.c:1292!
invalid operand: 0000 [#1]
PREEMPT_SMP

=============
Booting with:
acpi=off

usbcore: registered new driver hub
BUG scheduling while atomic: swapper......
....
kernel BUG at kernel/latency.c:1292!
invalid operand: 0000 [#1]
PREEMPT_SMP

========
hardirq_preempt=0
softirq_preempt=0
acpi=off

usbcore: registered new driver hub
BUG scheduling while atomic: swapper......
....
kernel BUG at kernel/latency.c:1292!
invalid operand: 0000 [#1]
PREEMPT_SMP

=============
Booting with:
hardirq_preempt=0
softirq_preempt=0
kernel_preempt=0
acpi=off

Same........
Suggestions?
-- Fernando


