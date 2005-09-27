Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVI0PUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVI0PUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVI0PUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:20:34 -0400
Received: from serv01.siteground.net ([70.85.91.68]:54938 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964960AbVI0PUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:20:32 -0400
Date: Tue, 27 Sep 2005 08:20:26 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050927152026.GC3822@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de> <20050907192747.GC3769@localhost.localdomain> <20050907193422.GS4785@suse.de> <58cb370e050927063674bb47a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050927063674bb47a7@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 03:36:40PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On 9/7/05, Jens Axboe <axboe@suse.de> wrote:
> > On Wed, Sep 07 2005, Ravikiran G Thirumalai wrote:
> > > On Wed, Sep 07, 2005 at 11:19:24AM +0200, Jens Axboe wrote:
> > > > On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> > > > > The following patchset breaks down the global ide_lock to per-hwgroup lock.
> > > > > We have taken the following approach.
> > > >
> > > > Curious, what is the point of this?
> > > >
> > >
> >
> > I'm asking because I've never heard anyone complain about IDE lock
> > contention and a proper patch usually comes with analysis of why it is
> > needed.
> 
> Since ide_lock spinlock is used for all drives as queue lock and for all
> controllers as IDE lock I guess that with multiple controllers there is a lot
> contention on it...
> 
> Breaking ide_lock is fine with me however seeing numbers would
> greatly help in getting wider acceptance for this change, Ravikiran?
> 

With the lock breakdown, Iozone read performance went up by 5.5% on a 2 way
x86 xeon box, with two hwifs and two processes reading from disks connected
to each hwif.  There seems to be a small  regression on Iozone write
tests -- about 1.5%.  Maybe this is measurement noise as there is no apparent
reason for this.  We plan to run more tests to see if the regression for
writes is statistically significant.

Btw, there was some problem with the moving of tuning code in this patchset
causing disks not to work in DMA mode. We were fixing that; will publish a
newer patchset with test results soon.

Thanks,
Kiran
