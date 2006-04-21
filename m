Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWDUB1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWDUB1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 21:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWDUB1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 21:27:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932202AbWDUB1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 21:27:18 -0400
Date: Thu, 20 Apr 2006 18:25:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: suresh.b.siddha@intel.com, efault@gmx.de, nickpiggin@yahoo.com.au,
       mingo@elte.hu, kernel@kolivas.org, kenneth.w.chen@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly
 loaded for balancing
Message-Id: <20060420182553.7cd206d7.akpm@osdl.org>
In-Reply-To: <44482712.5030401@bigpond.net.au>
References: <20060328185202.A1135@unix-os.sc.intel.com>
	<442A0235.1060305@bigpond.net.au>
	<20060329145242.A11376@unix-os.sc.intel.com>
	<442B1AE8.5030005@bigpond.net.au>
	<20060329165052.C11376@unix-os.sc.intel.com>
	<442B3111.5030808@bigpond.net.au>
	<20060401204824.A8662@unix-os.sc.intel.com>
	<442F7871.4030405@bigpond.net.au>
	<20060419182444.A5081@unix-os.sc.intel.com>
	<444719F8.2050602@bigpond.net.au>
	<20060420095408.A10267@unix-os.sc.intel.com>
	<20060420164936.5988460d.akpm@osdl.org>
	<44482712.5030401@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> Andrew Morton wrote:
> > "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >> updated patch appended. thanks.
> > 
> > Where are we up to with smpnice now?  Are there still any known
> > regressions/problems/bugs/etc?
> 
> One more change to move_tasks() is required to address an issue raised 
> by Suresh w.r.t. the possibility unnecessary movement of the highest 
> priority task from the busiest queue (possible because of the 
> active/expired array mechanism).  I hope to forward a patch for this 
> later today.

OK.

> After that the only thing I would like to do at this stage is modify 
> try_to_wake_up() so that it tries harder to distribute high priority 
> tasks across the CPUs.  I wouldn't classify this as absolutely necessary 
> as it's really just a measure that attempts to reduce latency for high 
> priority tasks as it should get them onto a CPU more quickly than just 
> sticking them anywhere and waiting for load balancing to kick in if 
> they've been put on a CPU with a higher priority task already running. 
> Also it's only really necessary when there a lot of high priority tasks 
> running.  So this isn't urgent and probably needs to be coordinated with 
> Ingo's RT load balancing stuff anyway.

Sure, we can leave things like that until later.

> >  Has sufficient testing been done for us to
> > know this?

I should have said "testing for regressions".  We know that smpnice
improves some things.  My concern is that it doesn't cause any non-silly
workloads to worsen.  Once we're at that stage I think we're ready to go.

IOW: at this stage we should concentrate upon not taking any workloads
backwards, rather than upon taking even more workloads even more forwards. 
That can come later.

> I run smpnice kernels on all of my SMP machines all of the time.  But I 
> don't have anything with more than 2 CPUs so I've been relying on their 
> presence in -mm to get wider testing on larger machines.

Sure.  A mortal doesn't have the hardware and isn't set up to test certain
high-value workloads...

> As load balancing is inherently probabilistic I don't think that we 
> should hold out for "perfect".

Sure.  "same or better" is the aim here.
