Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131506AbRC0TcA>; Tue, 27 Mar 2001 14:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRC0Tbv>; Tue, 27 Mar 2001 14:31:51 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:577 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131507AbRC0Tbk>; Tue, 27 Mar 2001 14:31:40 -0500
Date: Tue, 27 Mar 2001 13:30:58 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103271930.NAA35751@tomcat.admin.navo.hpc.mil>
To: law@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com>:
> Ion Badulescu wrote:
> > Compile option or not, 64-bit arithmetic is unacceptable on IA32. The
> > introduction of LFS was bad enough, we don't need yet another proof that
> > IA32 sucks. Especially when there *are* better alternatives.
> ===
>         So if it is a compile option -- the majority of people
> wouldn't be affected, is that in agreement?  Since the default would
> be to use the same arithmetic as we use  now.
> 
>         In fact, I posit that if anything, the majority of the people
> might be helped as the block_nr becomes a a 'typed' value -- and
> perhaps the sector_nr as well.  They remain the same size, but as
> a typed value the kernel gains increased integrity from the increased
> type checking.  At worst, it finds no new bugs and there is no impact
> in speed.  Are we in agreement so far?
> 
>         Now lets look at the sites want to process terabytes of
> data -- perhaps files systems up into the Pentabyte range.  Often I
> can see these being large multi-node (think 16-1024 clusters as 
> are in use today for large super-clusters).  If I was to characterize
> the performance of them, I'd likely see the CPU pegged at 100% 
> with 99% usage in user space.  Let's assume that increasing the
> block size decreases disk accesses by as much as 10% (you'll have
> to admit -- using a 64bit quantity vs. 32bit quantity isn't going
> to even come close to increasing disk access times by 1 millisecond,
> really, so it really is going to be a much smaller fraction when
> compared to the actual disk latency).  

Relatively small quibble - Current large clusters (SP3, 330 node 4cpu/node)
gets around 85% to 90% (real user) user mode total cpu. The rest is user
mode is attributed to overhead. Why:
    1. Inter-node communication/synchronization
    2. Memory bus saturation
    3. Users usually use only 3 cpus/node and allow the last cpu to handle
       filesystem/network/administration/batch handling functions. Using the
       last cpu in the node for part of the job reduces the overall throughput

>         Ok...but for the sake of
> argument using 10% -- that's still only 10% of 1% spent in the system.
> or a slowdown of .1%.  Now that's using a really liberal figure
> of 10%.  If you look at the actual speed of 64 bit arithmatic vs.
> 32, we're likely talking -- upper bound, 10x the clocks for 
> disk block arithmetic.  Disk block arithmetic is a small fraction
> of time spent in the kernel.  We have to be looking at *maximum*
> slowdowns in the range of a few hundred maybe a few thousand extra clocks.
> A 1000 extra clocks on a 1G machine is 1 microsecond, or approx
> 1/5000th your average seek latency on a *fast* hard disk.  So
> instead of 10% slowdown we are talking slowdowns in the 1/1000 range
> or less.  Now that's a slowdown in the 1% that was being spent in
> the kernel, so now we've slowdown the total program speed by .001%
> at the increase benefit (to that site) of being able to process
> those mega-gig's (Pentabytes) of information.  For a hit that is
> not noticable to human perception, they go from not being able to
> use super-clusters of IA32 machines (for which HW and SW is cheap), 
> to being able to use it.  That's quite a cost savings for them.
> 
>         Is there some logical flaw in the above reasoning?

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
