Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDKEJM>; Wed, 11 Apr 2001 00:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131157AbRDKEJD>; Wed, 11 Apr 2001 00:09:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15325 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131158AbRDKEIr>; Wed, 11 Apr 2001 00:08:47 -0400
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
To: nigel@nrg.org
Cc: ak@suse.de, Dipankar Sarma <dipankar.sarma@in.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Suparna Bhattacharya <bsuparna@in.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFC444FA4A.28BB0BC6-ON88256A2B.0016B71E@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 10 Apr 2001 21:08:16 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/10/2001 10:08:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 10 Apr 2001, Paul McKenney wrote:
> > The algorithms we have been looking at need to have absolute guarantees
> > that earlier activity has completed.  The most straightforward way to
> > guarantee this is to have the critical-section activity run with
preemption
> > disabled.  Most of these code segments either take out locks or run
> > with interrupts disabled anyway, so there is little or no degradation
of
> > latency in this case.  In fact, in many cases, latency would actually
be
> > improved due to removal of explicit locking primitives.
> >
> > I believe that one of the issues that pushes in this direction is the
> > discovery that "synchronize_kernel()" could not be a nop in a UP kernel
> > unless the read-side critical sections disable preemption (either in
> > the natural course of events, or artificially if need be).  Andi or
> > Rusty can correct me if I missed something in the previous exchange...
> >
> > The read-side code segments are almost always quite short, and, again,
> > they would almost always otherwise need to be protected by a lock of
> > some sort, which would disable preemption in any event.
> >
> > Thoughts?
>
> Disabling preemption is a possible solution if the critical section is
short
> - less than 100us - otherwise preemption latencies become a problem.

Seems like a reasonable restriction.  Of course, this same limit applies
to locks and interrupt disabling, right?

> The implementation of synchronize_kernel() that Rusty and I discussed
> earlier in this thread would work in other cases, such as module
> unloading, where there was a concern that it was not practical to have
> any sort of lock in the read-side code path and the write side was not
> time critical.

True, but only if the synchronize_kernel() implementation is applied to UP
kernels, also.

                    Thanx, Paul

> Nigel Gamble                                    nigel@nrg.org
> Mountain View, CA, USA.                         http://www.nrg.org/
>
> MontaVista Software                             nigel@mvista.com

