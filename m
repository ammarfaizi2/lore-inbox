Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRDJXtu>; Tue, 10 Apr 2001 19:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRDJXtl>; Tue, 10 Apr 2001 19:49:41 -0400
Received: from nrg.org ([216.101.165.106]:17212 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132485AbRDJXta>;
	Tue, 10 Apr 2001 19:49:30 -0400
Date: Tue, 10 Apr 2001 16:49:06 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Paul McKenney <Paul.McKenney@us.ibm.com>
cc: ak@suse.de, Dipankar Sarma <dipankar.sarma@in.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Suparna Bhattacharya <bsuparna@in.ibm.com>
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <OF6C3EA7C6.99519DF9-ON88256A2A.0079A408@LocalDomain>
Message-ID: <Pine.LNX.4.05.10104101613010.17287-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Paul McKenney wrote:
> The algorithms we have been looking at need to have absolute guarantees
> that earlier activity has completed.  The most straightforward way to
> guarantee this is to have the critical-section activity run with preemption
> disabled.  Most of these code segments either take out locks or run
> with interrupts disabled anyway, so there is little or no degradation of
> latency in this case.  In fact, in many cases, latency would actually be
> improved due to removal of explicit locking primitives.
>
> I believe that one of the issues that pushes in this direction is the
> discovery that "synchronize_kernel()" could not be a nop in a UP kernel
> unless the read-side critical sections disable preemption (either in
> the natural course of events, or artificially if need be).  Andi or
> Rusty can correct me if I missed something in the previous exchange...
> 
> The read-side code segments are almost always quite short, and, again,
> they would almost always otherwise need to be protected by a lock of
> some sort, which would disable preemption in any event.
> 
> Thoughts?

Disabling preemption is a possible solution if the critical section is short
- less than 100us - otherwise preemption latencies become a problem.

The implementation of synchronize_kernel() that Rusty and I discussed
earlier in this thread would work in other cases, such as module
unloading, where there was a concern that it was not practical to have
any sort of lock in the read-side code path and the write side was not
time critical.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

