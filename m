Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268872AbRHBKAQ>; Thu, 2 Aug 2001 06:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268873AbRHBKAG>; Thu, 2 Aug 2001 06:00:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37456 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268872AbRHBJ7w>; Thu, 2 Aug 2001 05:59:52 -0400
Date: Thu, 2 Aug 2001 12:00:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010802120012.P29065@athlon.random>
In-Reply-To: <20010802084259.H29065@athlon.random> <andrea@suse.de> <10108020031.ZM229058@classic.engr.sgi.com> <20010802094517.I29065@athlon.random> <10108020110.ZM232959@classic.engr.sgi.com> <20010802102431.L29065@athlon.random> <10108020142.ZM233422@classic.engr.sgi.com> <20010802111150.N29065@athlon.random> <andrea@suse.de> <10108020225.ZM236505@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10108020225.ZM236505@classic.engr.sgi.com>; from jeremy@classic.engr.sgi.com on Thu, Aug 02, 2001 at 02:25:48AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 02:25:48AM -0700, Jeremy Higdon wrote:
> On Aug 2, 11:11am, Andrea Arcangeli wrote:
> > 
> > > At 13000 IOPS, when allocating and freeing on every I/O request,
> > > the allocate/free overhead was approximately .6% on a 2 CPU system,
> > > where the total overhead was about 25%.  So I would theoretically
> > > gain 3% (maybe a little better since there is locking involved) if
> > > I could avoid the alloc/free.
> > 
> > Ok good.
> > 
> > Andrea
> 
> 
> So one more question for now:
> 
> Where do I get the O_DIRECT patch?

I will upload a new one today in my ftp area on kernel.org against
2.4.8pre3. (the current one has a silly bug spotted by Ken Preslan while
testing O_DIRECT on GFS)

> Oh, and is there a plan to get it into 2.4.X?

The one I will upload today is stable enough to be ok for inclusion and
it generates good numbers. Infact the O_DIRECT way on top of the fs will
be the prefered way for storing DB files compared to rawio on lvm that
people uses today (except when using the shared storage but even for it
I just had feedback from the GFS folks that just verified GFS to work
correctly with the O_DIRECT patch). The only detail left for some DB
that wants to use 2k I/O granularity also on a 4k blocksized-fs is to
relax the granularity of the I/O from the softblocksize to the
hardblocksize but it will be tricky to do that without losing any
performance (however I don't see that as a requirement to make use of
O_DIRECT, infact other people is using it without seeing the
softblocksize constraint as a problem) but we'll have to relax that
constraint eventually to make everybody happy.

Andrea
