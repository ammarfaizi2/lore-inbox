Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbUCTNOK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbUCTNOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:14:10 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:17812 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263401AbUCTNOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:14:06 -0500
Date: Sat, 20 Mar 2004 18:43:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040320131316.GA4554@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org> <s5hbrmuc6ed.wl@alsa2.suse.de> <20040318221006.74246648.akpm@osdl.org> <20040319172203.GB4537@in.ibm.com> <20040320122411.GB9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320122411.GB9009@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 01:24:11PM +0100, Andrea Arcangeli wrote:
> On Fri, Mar 19, 2004 at 10:52:03PM +0530, Dipankar Sarma wrote:
> > the overall problem, IMO. I am collecting some instrumentation
> > data to understand softirq/rcu behavior during heavy loads and
> > ways to counter long running softirqs.
> > 
> > Latency isn't the only issue. DoS on route cache is another
> > issue that needs to be addressed. I have been experimenting
> > with Robert Olsson's router test and should have some more results
> > out soon.
> 
> why don't you simply interrupt rcu_do_batch after a dozen of callbacks?
> if it gets interrupted you then go ahead and you splice the remaining
> entries into another list for a tasklet, then the tasklet will be a
> reentrant one, so the ksoftirqd will take care of the latency.
> 
> the only valid reason to use the timer irq instead of the tasklet in the
> first place is to delay the rcu invocation and coalesce the work
> together, but if there's too much work to do you must go back to the
> tasklet way that has always been scheduler-friendy.

Andrea, I *am* working on a throttling mechanism for rcu/softirqs.
I just didn't see the point in publishing it until I had the
measurement results in hand :)

I will publish the results under both router DoS and filesystem workload.

Thanks
Dipankar
