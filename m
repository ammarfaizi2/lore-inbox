Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVAPRsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVAPRsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 12:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVAPRsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 12:48:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10952 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262552AbVAPRsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 12:48:45 -0500
Date: Sun, 16 Jan 2005 12:45:51 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoiding fragmentation through different allocator V2
Message-ID: <20050116144551.GG7397@logos.cnet>
References: <Pine.LNX.4.58.0501131552400.31154@skynet> <20050114213619.GA3336@logos.cnet> <Pine.LNX.4.58.0501151858360.17278@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501151858360.17278@skynet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 07:18:42PM +0000, Mel Gorman wrote:
> On Fri, 14 Jan 2005, Marcelo Tosatti wrote:
> 
> > On Thu, Jan 13, 2005 at 03:56:46PM +0000, Mel Gorman wrote:
> > > The patch is against 2.6.11-rc1 and I'm willing to stand by it's
> > > stability. I'm also confident it does it's job pretty well so I'd like it
> > > to be considered for inclusion.
> >
> > This is very interesting!
> >
> 
> Thanks
> 
> > Other than the advantage of decreased fragmentation which you aim, by
> > providing clustering of different types of allocations you might have a
> > performance gain (or loss :))  due to changes in cache colouring
> > effects.
> >
> 
> That is possible but it I haven't thought of a way of measuring the cache
> colouring effects (if any). There is also the problem that the additional
> complexity of the allocator will offset this benefit. The two main loss
> points of the allocator are increased complexity and the increased size of
> the zone struct.
> 
> > It depends on the workload/application mix and type of cache of course,
> > but I think there will be a significant measurable difference on most
> > common workloads.
> >
> 
> If I could only measure it :/
> 
> > Have you done any investigation with that respect? IMHO such
> > verification is really important before attempting to merge it.
> >
> 
> No unfortunately. Do you know of a test I can use?

Some STP reaim results have significant performance increase in general, a few
small regressions. 

I think that depending on the type of access pattern of the application(s) there
will be either performance gain or loss, but the result is interesting anyway. :)

I'll different more tests later on.

AIM OVERVIEW
The AIM Multiuser Benchmark - Suite VII tests and measures the performance of
Open System multiuser computers. Multiuser computer environments typically have
the following general characteristics in common:

- A large number of tasks are run concurrently
- Disk storage increases dramatically as the number of users increase.
- Complex numerically intense applications are performed infrequently
- An important amount of time is spent sorting and searching through large
  amounts of data.
- After data is used it is placed back on disk because it is a shared resource.
- A large amount of time is spent in common runtime libraries.




NORMAL LOAD 4-way-SMP:


kernel: patch-2.6.11-rc1
plmid: 4066
Host: stp4-000
Reaim test
http://khack.osdl.org/stp/300031
kernel: 4066
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 4881.87 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 4961.19 (average of 3 runs)

kernel: mel-v3-fixed
plmid: 4077
Host: stp4-001
Reaim test
http://khack.osdl.org/stp/300056
kernel: 4077
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 5065.93 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 5294.48 (average of 3 runs)


NORMAL LOAD 1-WAY:

kernel: patch-2.6.11-rc1
plmid: 4066
Host: stp1-003
Reaim test
http://khack.osdl.org/stp/300029
kernel: 4066
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 993.13 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 983.11 (average of 3 runs)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.


kernel: mel-v3-fixed
plmid: 4077
Host: stp1-002
Reaim test
http://khack.osdl.org/stp/300055
kernel: 4077
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 982.69 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 1008.06 (average of 3 runs)


COMPUTE LOAD 2way (this is more CPU intensive than NORMAL reaim load):

kernel: patch-2.6.11-rc1
plmid: 4066
Host: stp2-001
Reaim test
http://khack.osdl.org/stp/300060
kernel: 4066
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 1482.45 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 1487.20 (average of 3 runs)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

kernel: mel-v3-fixed
plmid: 4077
Host: stp2-000
Reaim test
http://khack.osdl.org/stp/300058
kernel: 4077
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 1501.47 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 1462.11 (average of 3 runs)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.








