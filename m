Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUIOBCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUIOBCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUIOBCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:02:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15015 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266204AbUIOBCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:02:03 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914150316.GN4180@dualathlon.random>
References: <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu>
	 <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu>
	 <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random>
	 <41470021.1030205@yahoo.com.au>  <20040914150316.GN4180@dualathlon.random>
Content-Type: text/plain
Message-Id: <1095210126.2406.70.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 21:02:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 11:03, Andrea Arcangeli wrote:
> On Wed, Sep 15, 2004 at 12:28:49AM +1000, Nick Piggin wrote:
> > Well I don't know how good an argument the crashes one is these days,
> > but generally (as far as I know) those who really care about latency
> > shouldn't mind about some extra overheads.
> 
> sure, that's especially true for the hardirq and softirq total scheduler
> offloading. The real question is where a generic desktop positions. I
> doubt on a generic desktop a latency over 1msec matters much,
> top performance of repetitive tasks that sums up like hardirqs for a NIC
> sounds more sensible to me.
> 
> And for the other usages RTAI or any other hard realtime sounds safer
> anyways.
> 

For a generic desktop I don't think any of this makes much of a
difference; AFAIK none of the VP testers have reported a perceptible
difference in system responsiveness.  A good point of comparison here is
what Microsoft OS'es can do.  My Windows XP setup works pretty well with
a latency of 2.66ms or 128 frames at 48KHZ, and is rock solid at 256
frames or 5.33ms.

However for low latency audio Mac OS X is our real competition.  OS X
can deliver audio latencies of probably 0.5ms.  There is not much point
in going much lower than this because the difference becomes
imperceptible and the more frequent cache thrashing becomes an issue;
this is close enough to the limits of what sound hardware is capable of
anyway.

With Ingo's patches the worst case latency on the same machine as my XP
example is about 150 usecs.  So, it seems to me that Ingo's patches can
achieve results as good or better than OSX even without the one or two
"dangerous" changes, like the removal of lock_kernel around
do_tty_write.

Lee

