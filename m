Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132529AbRDKIUV>; Wed, 11 Apr 2001 04:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132531AbRDKIUM>; Wed, 11 Apr 2001 04:20:12 -0400
Received: from nrg.org ([216.101.165.106]:53573 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132529AbRDKITv>;
	Wed, 11 Apr 2001 04:19:51 -0400
Date: Wed, 11 Apr 2001 01:19:43 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Paul McKenney <Paul.McKenney@us.ibm.com>
cc: ak@suse.de, Dipankar Sarma <dipankar.sarma@in.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Suparna Bhattacharya <bsuparna@in.ibm.com>
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <OFC444FA4A.28BB0BC6-ON88256A2B.0016B71E@LocalDomain>
Message-ID: <Pine.LNX.4.05.10104110109210.17755-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Paul McKenney wrote:
> > Disabling preemption is a possible solution if the critical section
> > is
> short
> > - less than 100us - otherwise preemption latencies become a problem.
> 
> Seems like a reasonable restriction.  Of course, this same limit
> applies to locks and interrupt disabling, right?

That's the goal I'd like to see us achieve in 2.5.  Interrupts are
already in this range (with a few notable exceptions), but there is
still the big kernel lock and a few other long held spin locks to deal
with.  So I want to make sure that any new locking scheme like the ones
under discussion play nicely with the efforts to achieve low-latency
Linux such as the preemptible kernel.

> > The implementation of synchronize_kernel() that Rusty and I
> > discussed earlier in this thread would work in other cases, such as
> > module unloading, where there was a concern that it was not
> > practical to have any sort of lock in the read-side code path and
> > the write side was not time critical.
> 
> True, but only if the synchronize_kernel() implementation is applied
> to UP kernels, also.

Yes, that is the idea.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

