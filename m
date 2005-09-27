Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVI0P0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVI0P0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVI0P0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:26:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53539 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964972AbVI0P0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:26:20 -0400
Date: Tue, 27 Sep 2005 17:26:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050927152641.GF2811@suse.de>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de> <20050907192747.GC3769@localhost.localdomain> <20050907193422.GS4785@suse.de> <58cb370e050927063674bb47a7@mail.gmail.com> <20050927152026.GC3822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927152026.GC3822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27 2005, Ravikiran G Thirumalai wrote:
> On Tue, Sep 27, 2005 at 03:36:40PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On 9/7/05, Jens Axboe <axboe@suse.de> wrote:
> > > On Wed, Sep 07 2005, Ravikiran G Thirumalai wrote:
> > > > On Wed, Sep 07, 2005 at 11:19:24AM +0200, Jens Axboe wrote:
> > > > > On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> > > > > > The following patchset breaks down the global ide_lock to per-hwgroup lock.
> > > > > > We have taken the following approach.
> > > > >
> > > > > Curious, what is the point of this?
> > > > >
> > > >
> > >
> > > I'm asking because I've never heard anyone complain about IDE lock
> > > contention and a proper patch usually comes with analysis of why it is
> > > needed.
> > 
> > Since ide_lock spinlock is used for all drives as queue lock and for all
> > controllers as IDE lock I guess that with multiple controllers there is a lot
> > contention on it...
> > 
> > Breaking ide_lock is fine with me however seeing numbers would
> > greatly help in getting wider acceptance for this change, Ravikiran?
> > 
> 
> With the lock breakdown, Iozone read performance went up by 5.5% on a 2 way
> x86 xeon box, with two hwifs and two processes reading from disks connected
> to each hwif.  There seems to be a small  regression on Iozone write
> tests -- about 1.5%.  Maybe this is measurement noise as there is no apparent
> reason for this.  We plan to run more tests to see if the regression for
> writes is statistically significant.

You should run it eg 10 times on each kernel to get a feel for the
variance of the results. Were you testing 2 or 4 disks?

Some profile information for both kernels would also be paramount.

> Btw, there was some problem with the moving of tuning code in this patchset
> causing disks not to work in DMA mode. We were fixing that; will publish a
> newer patchset with test results soon.

I take it the numbers posted were for DMA enabled on all disks?

-- 
Jens Axboe

