Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281786AbRLBVPr>; Sun, 2 Dec 2001 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLBVPi>; Sun, 2 Dec 2001 16:15:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15400 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S279305AbRLBVP3>; Sun, 2 Dec 2001 16:15:29 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011130181415.C19152@work.bitmover.com>
	<200112012305.fB1N5xf1020409@sleipnir.valparaiso.cl>
	<20011202122940.B2622@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Dec 2001 13:55:47 -0700
In-Reply-To: <20011202122940.B2622@work.bitmover.com>
Message-ID: <m1u1v9wdd8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Sat, Dec 01, 2001 at 08:05:59PM -0300, Horst von Brand wrote:
> > Larry McVoy <lm@bitmover.com> said:
> > 
> > [...]
> > 
> > > Because, just like the prevailing wisdom in the Linux hackers, they thought
> > > it would be relatively straightforward to get SMP to work.  They started at
> > > 2, went to 4, etc., etc.  Noone ever asked them to go from 1 to 100 in one
> > > shot.  It was always incremental.
> > 
> > Maybe that is because 128 CPU machines aren't exactly common... just as
> > SPARC, m68k, S/390 development lags behind ia32 just because there are
> > many, many more of the later around.
> > 
> > Just as Linus said, the development is shaped by its environment.
> 
> Really?  So then people should be designing for 128 CPU machines, right?
> So why is it that 100% of the SMP patches are incremental?  Linux is 
> following exactly the same path taken by every other OS, 1->2, then 2->4,
> then 4->8, etc.  By your logic, someone should be sitting down and saying
> here is how you get to 128.  Other than myself, noone is doing that and
> I'm not really a Linux kernel hack, so I don't count.  
> 
> So why is it that the development is just doing what has been done before?

Hmm.  Meanwhile linux appears to be the platform of choice for new
clusters.  And if you are working on a cluster you can by incremental
improvements reach your design Larry.  In truth a 128 CPU machine is a
modest cluster.  The typical goal for a large system I have seen is a
1000 Node cluster.  Which could mean anywhere from 1000 to 4000
processors.  And I have seen a few serious proposals for even larger
systems.

So with a cluster you start by looking for something that scales, on a
relatively slow interconnect.  Which is simply lots, and lots of
kernels, that don't know each other at all.  And then you figure out
how to get them all talking to each other.

As has been pointed out exporting an interface that looks to the
programmer like a giant SMP.  Tends to make programs share too much
data, and thus get high degrees of lock contention.

The next incremental step is to get some good distributed and parallel
file systems.  So you can share one filesystem across the cluster.
And there is some work going on in those areas.  luster, gfs,
intermezzo.

Eric
