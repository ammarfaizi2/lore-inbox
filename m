Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRDHAAG>; Sat, 7 Apr 2001 20:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbRDGX75>; Sat, 7 Apr 2001 19:59:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49873 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132101AbRDGX7s>; Sat, 7 Apr 2001 19:59:48 -0400
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        lse-tech-admin@lists.sourceforge.net, nigel@nrg.org,
        rusty@rustcorp.com.au
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF8061E404.7B47083C-ON88256A27.0083BDCC@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Sat, 7 Apr 2001 16:59:15 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/07/2001 05:59:42 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > 2.   Isn't it possible to get in trouble even on a UP if a task
> > > >      is preempted in a critical region?  For example, suppose the
> > > >      preempting task does a synchronize_kernel()?
> > >
> > > Ugly. I guess one way to solve it would be to readd the 2.2 scheduler
> > > taskqueue, and just queue a scheduler callback in this case.
> >
> > Another approach would be to define a "really low" priority that noone
> > other than synchronize_kernel() was allowed to use.  Then the UP
> > implementation of synchronize_kernel() could drop its priority to
> > this level, yield the CPU, and know that all preempted tasks must
> > have obtained and voluntarily yielded the CPU before synchronize_kernel
()
> > gets it back again.
>
> That just would allow nasty starvation, e.g. when someone runs a cpu
intensive
> screensaver or a seti-at-home.

Good point!  I hereby withdraw my suggested use of ultra-low priorities
for UP implementations of synchronize_kernel().  ;-)

> > I still prefer suppressing preemption on the read side, though I
> > suppose one could claim that this is only because I am -really-
> > used to it.  ;-)
>
> For a lot of reader cases non-preemption by threads is guaranteed anyways
--
> e.g.  anything that runs in interrupts, timers, tasklets and network
softirq.
> I think that already covers a lot of interesting cases.

Good point again!  For example, this does cover most of the TCP/IP
cases, right?

                              Thanx, Paul

