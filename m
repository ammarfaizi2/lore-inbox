Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRDGXzg>; Sat, 7 Apr 2001 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRDGXz0>; Sat, 7 Apr 2001 19:55:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24273 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132109AbRDGXzN>; Sat, 7 Apr 2001 19:55:13 -0400
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        lse-tech-admin@lists.sourceforge.net, nigel@nrg.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF42269F5F.CDF56B0F-ON88256A27.0083566F@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Sat, 7 Apr 2001 16:54:52 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/07/2001 05:55:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I see your point here, but need to think about it.  One question:
> > isn't it the case that the alternative to using synchronize_kernel()
> > is to protect the read side with explicit locks, which will themselves
> > suppress preemption?  If so, why not just suppress preemption on the
read
> > side in preemptible kernels, and thus gain the simpler implementation
> > of synchronize_kernel()?  You are not losing any preemption latency
> > compared to a kernel that uses traditional locks, in fact, you should
> > improve latency a bit since the lock operations are more expensive than
> > are simple increments and decrements.  As usual, what am I missing
> > here?  ;-)
>
> Already preempted tasks.

But if you are suppressing preemption in all read-side critical sections,
then wouldn't any already-preempted tasks be guaranteed to -not- be in
a read-side critical section, and therefore be guaranteed to be unaffected
by the update (in other words, wouldn't such tasks not need to be waited
for)?

> > Another approach would be to define a "really low" priority that noone
> > other than synchronize_kernel() was allowed to use.  Then the UP
> > implementation of synchronize_kernel() could drop its priority to
> > this level, yield the CPU, and know that all preempted tasks must
> > have obtained and voluntarily yielded the CPU before synchronize_kernel
()
> > gets it back again.
>
> Or "never", because I'm running RC5 etc. 8(.

Ummmm...  Good point!  Never mind use of low priorities in UP kernels
for synchronize_kernel()...

                                   Thanx, Paul

