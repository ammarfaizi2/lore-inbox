Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265391AbSJWWac>; Wed, 23 Oct 2002 18:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265387AbSJWWaa>; Wed, 23 Oct 2002 18:30:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38385 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265383AbSJWWa2>;
	Wed, 23 Oct 2002 18:30:28 -0400
Message-ID: <3DB7245E.B68D1FF4@mvista.com>
Date: Wed, 23 Oct 2002 15:36:14 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mbs <mbs@mc.com>
CC: jim.houston@ccur.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alternate Posix timer patch
References: <200210230838.g9N8cac00490@linux.local> <3DB6ED10.A81B0429@mvista.com> <3DB6FD0A.74BB3AD0@ccur.com> <200210232112.RAA09961@mc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbs wrote:
> 
> the way I handled this was that the timerid was the (kernel space) address of
> the dynamically allocated timer structure.  this provides a fairly low
> likelyhood of duplicate timerid's value....

Yes, but this is a VERY messy pointer which must be verified
to not cause a kernel fault before it can even be
dereferenced... nuff said.

-g

by the way, the address mbs@mc.com fails.  Maybe you could
use something I can mail to.
> 
> On Wednesday 23 October 2002 15:48, Jim Houston wrote:
> > george anzinger wrote:
> > > Jim Houston wrote:
> > > I have also looked at the timer index stuff and made a few
> > > changes.  If it get it working today, I will include it
> > > also.  My changes mostly revolved around not caring about
> > > reusing a timer id.  Would you care to comment on why you
> > > think reuse is bad?
> > >
> > > With out this feature the code is much simpler and does not
> > > keep around dead trees.
> > >
> > > -g
> >
> > Hi George,
> >
> > I assume the rationale is that not reusing the same id immediately helps
> > catch errors in user code.  Since the id space is global, there
> > is more chance that one process may be manipulating another processes
> > timer.  Reusing the same id makes this sort of problem harder to
> > catch.
> >
> > The main reason I changed this in my patch is to avoid the CONFIG
> > limit on the number of timers.  Since I don't have the fixed array,
> > I need a way to safely translate a user-space id into a kernel pointer.
> >
> > Jim Houston Concurrent Computer Corp.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> --
> /**************************************************
> **   Mark Salisbury       ||      mbs@mc.com     **
> ** If you would like to sponsor me for the       **
> ** Mass Getaway, a 150 mile bicycle ride to for  **
> ** MS, contact me to donate by cash or check or  **
> ** click the link below to donate by credit card **
> **************************************************/
> https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
