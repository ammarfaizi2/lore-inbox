Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRAUAI1>; Sat, 20 Jan 2001 19:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132135AbRAUAIS>; Sat, 20 Jan 2001 19:08:18 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:30726 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132101AbRAUAII>;
	Sat, 20 Jan 2001 19:08:08 -0500
Date: Sat, 20 Jan 2001 17:05:27 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <andrewm@uow.edu.au>
Cc: nigel@nrg.org, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010120170527.A15918@hq.fsmlabs.com>
In-Reply-To: <200101110519.VAA02784@pizda.ninka.net> <Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org> <3A5F0706.6A8A8141@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3A5F0706.6A8A8141@uow.edu.au>; from Andrew Morton on Sat, Jan 13, 2001 at 12:30:46AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let me just point out that Nigel (I think) has previously stated that
the purpose of this approach is to bring the stunning success of 
IRIX style "RT" to Linux. Since some of us believe that IRIX is a virtual
handbook of OS errors, it really comes down to a design style. I think
that simplicity and "does the main job well" wins every time over 
"really cool algorithms" and "does everything badly". Others 
disagree.


On Sat, Jan 13, 2001 at 12:30:46AM +1100, Andrew Morton wrote:
> Nigel Gamble wrote:
> > 
> > Spinlocks should not be held for lots of time.  This adversely affects
> > SMP scalability as well as latency.  That's why MontaVista's kernel
> > preemption patch uses sleeping mutex locks instead of spinlocks for the
> > long held locks.
> 
> Nigel,
> 
> what worries me about this is the Apache-flock-serialisation saga.
> 
> Back in -test8, kumon@fujitsu demonstrated that changing this:
> 
> 	lock_kernel()
> 	down(sem)
> 	<stuff>
> 	up(sem)
> 	unlock_kernel()
> 
> into this:
> 
> 	down(sem)
> 	<stuff>
> 	up(sem)
> 
> had the effect of *decreasing* Apache's maximum connection rate
> on an 8-way from ~5,000 connections/sec to ~2,000 conn/sec.
> 
> That's downright scary.
> 
> Obviously, <stuff> was very quick, and the CPUs were passing through
> this section at a great rate.
> 
> How can we be sure that converting spinlocks to semaphores
> won't do the same thing?  Perhaps for workloads which we
> aren't testing?
> 
> So this needs to be done with caution.
> 
> As davem points out, now we know where the problems are
> occurring, a good next step is to redesign some of those
> parts of the VM and buffercache.  I don't think this will
> be too hard, but they have to *want* to change :)
> 
> Some of those algorithms are approximately O(N^2), for huge
> values of N.
> 
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
