Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRDFMCL>; Fri, 6 Apr 2001 08:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRDFMBs>; Fri, 6 Apr 2001 08:01:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45575 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131563AbRDFMBk>; Fri, 6 Apr 2001 08:01:40 -0400
Date: Fri, 6 Apr 2001 14:00:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: softirq buggy [Re: Serial port latency]
Message-ID: <20010406140052.A16871@atrey.karlin.mff.cuni.cz>
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)> <000401c0b828$bbdf7380$5517fea9@local> <20010331003645.F1579@atrey.karlin.mff.cuni.cz> <3AC6559E.575C4BAA@colorfullife.com> <20010404010759.A102@bug.ucw.cz> <000901c0bd4c$c16fd5f0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <000901c0bd4c$c16fd5f0$5517fea9@local>; from manfred@colorfullife.com on Wed, Apr 04, 2001 at 11:18:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok, there are 2 bugs that are (afaics) impossible to fix without
> > > checking for pending softirq's in cpu_idle():
> > >
> > > a)
> > > queue_task(my_task1, tq_immediate);
> > > mark_bh();
> > > schedule();
> > > ;within schedule: do_softirq()
> > > ;within my_task1:
> > > mark_bh();
> > > ; bh returns, but do_softirq won't loop
> > > ; do_softirq returns.
> > > ; schedule() clears current->need_resched
> > > ; idle thread scheduled.
> > > --> idle can run although softirq's are pending
> >
> > Or anything else can run altrough softirqs are pending. If it is
> > computation job, softinterrupts are delayed quiet a bit, right?
> >
> > So right fix seems to be "loop in do_softirq".
> >
> No, it's the wrong fix.
> A network server under high load would loop forever within the softirq,
> never returning to process level.
> 
> do_softirq cannot loop, the right fix is "check often for pending
> softirq's".
> It's checked before a process returns to user space, it's checked when a
> process schedules. What's missing is that the idle functions must check
> for pending softirqs, too.

Ok. I was missing the fact it is checked on going userspace.

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
