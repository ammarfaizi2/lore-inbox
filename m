Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUIQNX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUIQNX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUIQNX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:23:28 -0400
Received: from barclay.balt.net ([195.14.162.78]:58169 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S268735AbUIQNXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:23:03 -0400
Date: Fri, 17 Sep 2004 16:21:57 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       Ricky Beam <jfbeam@bluetronic.net>, Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
Message-ID: <20040917132157.GA13966@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net> <1095270555.2406.154.camel@krustophenia.net> <41488140.4050109@pobox.com> <4149512E.9040005@hist.no> <20040917080503.GA7634@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917080503.GA7634@gemtek.lt>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:05:04AM +0300, Zilvinas Valinskas wrote:
> On Thu, Sep 16, 2004 at 10:39:10AM +0200, Helge Hafting wrote:
> > Jeff Garzik wrote:
> > 
> > >Lee Revell wrote:
> > >
> > >>Interesting.  Still, this looks like a specific bug that needs fixing,
> > >>it doesn't imply that preemption is a hack.  For many workloads
> > >>preemption is a necessity.
> > >
> > >
> > >
> > >For any workload that you feel preemption is a necessity, that 
> > >indicates a latency problem in the kernel that should be solved.
> > >
> > >Preemption is a hack that hides broken drivers, IMHO.
> > >
> > >I would rather directly address any latency problems that appear.
> > 
> > Current preempt is broken, sure.  But having robust preempt
> > would allow code simplification.  Long loops outside critical
> > sections would be ok - no time or code spent testing for a need for
> > rescheduling because you'll be preempted when necessary anyway.
> 
> Could be the case. This morning I've turned off PREEMPT support in
> linux 2.6.9-rc2 kernel, booted just fine, ran apt-get update ... it
> seemed everything is ok. 
> 
> Then setup IPsec policies, ping remote end, racoon has tried to negotiate 
> with a remote end and ... laptop freezes again (this time without
> PREEMPT).
> 
> At a time I was in X, couldn't capture the OOPS, after reboot
> /var/log/kern.log is empty ... :(

Here is backtrace (with PREEMPT turned off) :

bad: scheduling while atomic!
[<c030cd3e>] schedule+-0x446/0x44b
[<c010595b>] do_IRQ+0xdd/0x14b
[<c0103d36>] work_resched+0x5/0x16

this backtrace is repeated 4x times

bad: scheduling while atomic!
[<c030cd3e>] schedule+0x446/0x44b
[<c0112f82>] sys_sched_yield+0x45/0x57
[<c014ceaa>] coredump_wait+0x32/0x97
[<c014cfd7>] do_coredump+0xc8/0x189
[<c0256b44>] complement_pos+0x1e/0x16e
[<c011cb13>] __dequeue_signal+0xc2/0x154
[<c011cbc8>] dequeue_signal+0x23/0x75
[<c011e12e>] get_signal_to_deliver+0x1d4/0x2c0
[<c0103b04>] do_signal+0x8e/0x10d
[<c010595b>] do_IRQ+0xdd/0x14b
[<c0103e7c>] common_interrupt+0x18/0x20
[<c030cb76>] schedule+0x27e/0x44b
[<c010595b>] do_IRQ+0xdd/0x14b
[<c0110f98>] do_page_fault+0x0/0x544
[<c0103bb8>] do_notify_resume+0x35/0x39
[<c0103d5a>] work_notifysig+0x13/0x15
Kernel panic - not syncing: Aiee, killing interrupt handler!

Any ideas ?


> 
> Doesn't seem it is PREEMPT related I think now.
> > 
> > Or am I missing something?  Other than that current preempt isn't up to
> > this and might be hard to get there?
> > 
> > Helge Hafting
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
