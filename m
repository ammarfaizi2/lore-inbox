Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUC3K6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 05:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbUC3K6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 05:58:17 -0500
Received: from ns.suse.de ([195.135.220.2]:40645 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263600AbUC3K6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 05:58:12 -0500
Date: Tue, 30 Mar 2004 12:58:05 +0200
From: Andi Kleen <ak@suse.de>
To: Erich Focht <efocht@hpce.nec.com>
Cc: nickpiggin@yahoo.com.au, mbligh@aracnet.com, mingo@elte.hu,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040330125805.4c62bf36.ak@suse.de>
In-Reply-To: <200403301204.14303.efocht@hpce.nec.com>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<200403300030.25734.efocht@hpce.nec.com>
	<4069384B.9070108@yahoo.com.au>
	<200403301204.14303.efocht@hpce.nec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 12:04:13 +0200
Erich Focht <efocht@hpce.nec.com> wrote:

Hallo Erich,

> On Tuesday 30 March 2004 11:05, Nick Piggin wrote:
> > >exec(), and maybe use a syscall for saying: balance all children a
> > >particular process is going to fork/clone at creation time. Everybody
> > >reached the insight that we can't foresee what's optimal, so there is
> > >only one solution: control the behavior. Give the user a tool to
> > >improve the performance. Just a small inheritable variable in the task
> > >structure is enough. Whether you give the hint at or before run-time
> > >or even at compile-time is not really the point...
> > >
> > >I don't think it's worth to wait and hope that somebody shows up with
> > >a magic algorithm which balances every kind of job optimally.
> >
> > I'm with Martin here, we are just about to merge all this
> > sched-domains stuff. So we should at least wait until after
> > that. And of course, *nothing* gets changed without at least
> > one benchmark that shows it improves something. So far
> > nobody has come up to the plate with that.
> 
> I thought you're talking the whole time about STREAM. That is THE
> benchmark which shows you an impact of balancing at fork. At it is a
> VERY relevant benchmark. Though you shouldn't run it on historical
> machines like NUMAQ, no compute center in the western world will buy
> NUMAQs for high performance... Andy typically runs STREAM on all CPUs
> of a machine. Try on N/2 and N/4 and so on, you'll see the impact.

Actually I run it on 1-4 CPUs (don't have more to try), but didn't 
always bother to report everything.. With the default
mm5 scheduler the bandwidth of 1,2,3,4 is constantly like 1 CPU.

I agree with you that the "balancing on fork is bad" assumption is dubious
at best. For HPC it definitly is wrong, for others it is unproven as well.

As I wrote earlier our own results on HyperThreaded machines running 2.4
were similar. On HT at least early balancing seems to be a win too - 
it's obvious because there is no cache cost to be paid when you move
between two virtual CPUs on the same core.

> > There are other things, like java, ervers, etc that use threads.
> 
> I'm just saying that you should have the choice. The default should be
> as before, balance at exec().

Choice is probably not bad, but a good default is important too.

I'm not really sure doing it by default would be such a bad idea.

A thread allocating some memory on its own is probably not that unusual,
even outside the HPC space. And on a NUMA system you want that already
on the final node.

-Andi
