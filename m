Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275527AbRJJL77>; Wed, 10 Oct 2001 07:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275530AbRJJL7t>; Wed, 10 Oct 2001 07:59:49 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:64263 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S275527AbRJJL7e>; Wed, 10 Oct 2001 07:59:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Wed, 10 Oct 2001 08:00:04 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <20011010072607.P726@athlon.random> <20011010114132Z275506-760+23131@vger.kernel.org>
In-Reply-To: <20011010114132Z275506-760+23131@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010115941Z275527-760+23137@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, i copied the mp3 into /dev/shm and without any renicing of anything it 
plays fine during dbench 32.  so the problem is disk access taking too long.  

Which is strange since i'm running dbench on a separate hdd on a totally 
different controller. 




On Wednesday 10 October 2001 07:41, safemode wrote:
> On Wednesday 10 October 2001 01:26, Andrea Arcangeli wrote:
> > On Tue, Oct 09, 2001 at 10:13:58PM -0700, Andrew Morton wrote:
> > >
> > > Oh.  And always remember to `renice -19' your X server.
>
> Blah,  You shouldn't need to. You shouldn't have anything able to lag your
> X server unless you're running so many programs your cpu time slices are
> too small for it's needs ( or memory).
>
> > I don't renice my X server (I rather renice all cpu hogs to +19 and I
> > left -20 for something that really needs to run as fast as possible
> > regardless of the X server).
> >
> > Andrea
>
> freeamp runs with no noticable cpu usage, meaning it's 0.0 nearly 100% of
> the time and i have 256K of input buffer and 16K of output.   Then i have a
> process like dbench create a bunch of threads (32) and cause freeamp to
> skip. Now how is that a fair spread of cpu?  The point is that this doesn't
> have to do with cpu spread and getting locked out of cpu.  It just has to
> do with dbench holding the kernel for too long in places and the kernel
> should know that and tell it to wait  since other processes are behaving.  
> There needs to be a threshhold of kernel usage before the kernel will begin
> to preempt that task for all the ones within the threshhold unless YOU want
> that kernel hogger to run at full speed. In which case you can renice it to
> a lower nice (higher priority).  Dbench is getting it's share of cpu maybe,
> but it's getting for too much of it's share of kernel time and that needs
> to be stopped and it's unfair in a multi-user multiprocessing system.  
> That's what i meant earlier.
>
> It's just my opinion that kernel hoggers should need to be given user
> defined higher priority to hog the kernel and not everything else to just
> run because you're running a kernel hogger.
