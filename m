Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288549AbSAHXGs>; Tue, 8 Jan 2002 18:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288541AbSAHXGi>; Tue, 8 Jan 2002 18:06:38 -0500
Received: from Expansa.sns.it ([192.167.206.189]:15114 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288549AbSAHXGU>;
	Tue, 8 Jan 2002 18:06:20 -0500
Date: Wed, 9 Jan 2002 00:02:48 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrea Arcangeli <andrea@suse.de>, Anton Blanchard <anton@samba.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16Nyaf-0000A5-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Daniel Phillips wrote:

> On January 8, 2002 04:29 pm, Andrea Arcangeli wrote:
> > > The preemptible approach is much less of a maintainance headache, since
> > > people don't have to be constantly doing audits to see if something changed,
> > > and going in to fiddle with scheduling points.
> >
> > this yes, it requires less maintainance, but still you should keep in
> > mind the details about the spinlocks, things like the checks the VM does
> > in shrink_cache are needed also with preemptive kernel.
>
> Yes of course, the spinlock regions still have to be analyzed and both
> patches have to be maintained for that.  Long duration spinlocks are bad
> by any measure, and have to be dealt with anyway.
>
> > > Finally, with preemption, rescheduling can be forced with essentially zero
> > > latency in response to an arbitrary interrupt such as IO completion, whereas
> > > the non-preemptive kernel will have to 'coast to a stop'.  In other words,
> > > the non-preemptive kernel will have little lags between successive IOs,
> > > whereas the preemptive kernel can submit the next IO immediately.  So there
> > > are bound to be loads where the preemptive kernel turns in better latency
> > > *and throughput* than the scheduling point hack.
> >
> > The I/O pipeline is big enough that a few msec before or later in a
> > submit_bh shouldn't make a difference, the batch logic in the
> > ll_rw_block layer also try to reduce the reschedule, and last but not
> > the least if the task is I/O bound preemptive kernel or not won't make
> > any difference in the submit_bh latency because no task is eating cpu
> > and latency will be the one of pure schedule call.
>
> That's not correct.  For one thing, you don't know that no task is eating
> CPU, or that nobody is hogging the kernel.  Look at the above, and consider
> the part about the little lags between IOs.
>
> > > Mind you, I'm not devaluing Andrew's work, it's good and valuable.  However
> > > it's good to be aware of why that approach can't equal the latency-busting
> > > performance of the preemptive approach.
> >
> > I also don't want to devaluate the preemptive kernel approch (the mean
> > latency it can reach is lower than the one of the lowlat kernel, however
> > I personally care only about worst case latency and this is why I don't
> > feel the need of -preempt),
>
> This is exactly the case that -preempt handles well.  On the other hand,
> trying to show that scheduling hacks satisfy any given latency bound is
> equivalent to solving the halting problem.
>
> I thought you had done some real time work?
>
> > but I just wanted to make clear that the
> > idea that is floating around that preemptive kernel is all goodness is
> > very far from reality, you get very low mean latency but at a price.
>
> A price lots of people are willing to pay
Probably sometimes they are not making a good business. In the reality
preempt is good in many scenarios, as I said, and I agree that for
desktops, and dedicated servers where just one application runs, and
probably the CPU is idle the most of the time, indeed users have a speed
feeling. Please consider that on eavilly loaded servers, with 40 and more
users, some are running gcc, others g77, others g++ compilations, someone
runs pine or mutt or kmail, and netscape, and mozilla, and emacs (someone
form xterm kde or gnome), and and
and... You can have also 4/8 CPU butthey are not infinite ;) (but I talk
mainly thinking of dualAthlon systems).
there is a lot of memory and disk I/O.
This is not a strange scenary on the interactive servers used at SNS.
Here preempt has a too high price
>
> By the way, have you measured the cost of -preempt in practice?
>
Yes, I did a lot of tests, and with current preempt patch definitelly
I was seeing a too big performance loss.


