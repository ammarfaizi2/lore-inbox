Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317666AbSGOTry>; Mon, 15 Jul 2002 15:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317667AbSGOTrx>; Mon, 15 Jul 2002 15:47:53 -0400
Received: from iris.mc.com ([192.233.16.119]:31987 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S317666AbSGOTru>;
	Mon, 15 Jul 2002 15:47:50 -0400
Message-Id: <200207151950.PAA11566@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>
Subject: Re: HZ, preferably as small as possible
Date: Mon, 15 Jul 2002 15:52:37 -0400
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207151151200.19586-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0207151151200.19586-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 15 July 2002 14:56, Linus Torvalds wrote:
> On 15 Jul 2002, Robert Love wrote:
> > A cleaner solution to this issue is a higher resolution timer, e.g. the
> > high-res-timers project which has high resolution POSIX timers.
>
> But that really doesn't solve the problem either.
>
> You still need to have some limit on the timer resolution. Whether you
> call that limit "HZ" or something else is irrelevant in the end. Just
> calling them "high-resolution" doesn't make the problem go away, you still
> have some resolution (*).
>
> So once you set some magic limit on the fine-grained resolution (let's
> call that "MAX_FINE_HZ"), you might as well realize that that really is
> 100% equivalent to just making HZ _be_ that value. Together with possibly
> making the actual timer tick happen at a slower rate according to some
> other heuristics (ie "the system doesn't need timers right now, let's just
> not do them").
>
> 		Linus
>
> (*) Which is a lot less than the hw can generate, since you mustn't allow
> users to bog down the system in timer interrupts by just using
> "itimer(ITIMER_REAL, .. fine-resolution..)".

actually, that is an interesting philosophical argument.

in an embedded system, it is sometimes more useful to not put artificial 
constraints on the system and allow the clock and timer system to work in hw 
increments, but document the hell out of it.

this is the "give 'em enough rope to hang themselves, but tell them the 
precise length of the rope" model.

in an embedded system a "tickless" system is sometimes preferable to a ticked 
system.  there is often only one or a very small number of processes/threads 
running and the extra overhead of 10 surplus clock ticks per process quantum 
is a waste of cycles. (also when using a ppc or similar modern chip(flame 
on;-), there is no need to keep a software wall clock, as the cpu has a 64bit 
free running counter)  

I had this discussion with george A. early in the posix timers project and I 
argued/begged for a compile time config option giving the option of ticked 
and tickless versions.  George chose to go with a ticked system, because it 
benchmarked better in a general purpose system, particlularly under high 
loads, and he didn't have time to implement two systems.   he made the right 
choice for the general purpose kernel and for probably 80% of the embedded 
market. (I'm in the other 20%) 

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
**************************************************/
