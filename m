Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRHBOhv>; Thu, 2 Aug 2001 10:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268961AbRHBOhb>; Thu, 2 Aug 2001 10:37:31 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:4623 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268958AbRHBOhT>; Thu, 2 Aug 2001 10:37:19 -0400
Date: Thu, 2 Aug 2001 08:37:20 -0600
Message-Id: <200108021437.f72EbKw18361@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs
In-Reply-To: <200108020751.f727pnMf010874@webber.adilger.int>
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
	<200108020751.f727pnMf010874@webber.adilger.int>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> Richard writes:
> >   Hi, all. Below is my second cut of a patch that adds support for
> > large numbers of SCSI discs (approximately 2144). I'd like people to
> > try this out. I've fixed a couple of "minor" typos that happened to
> > disable sd detection. I've also tested this patch: it works fine on my
> > 3 drive system. In addition, I've switched to using vmalloc() for key
> > data structures, so the kmalloc() limitations shouldn't hit us. I've
> > added an in_interrupt() test to sd_init() just in case.
> 
> The real question is whether this code is limited to adding only SCSI
> major numbers, or if it could be used to assign major numbers to
> other subsystems (sorry I haven't looked at the code yet)?

This patch leverages some new infrastructure that I developed in a
recent devfs patch, and Linus included that in 2.4.7. The key
functions are <devfs_alloc_major> and <devfs_dealloc_major>. I wrote
these functions primarily for block drivers (although you can allocate
char majors as well, keeping in mind there are far fewer left
unassigned), which due to our aging block I/O layer require majors.

So, yes, you can already patch other subsystems to dynamically assign
major numbers in 2.4.7. I'd like to see people do that. My patch for
sd.c can also serve as a demonstration on how to use the new API.

>  From our discussion last week, it _should_ be able to assign major
> numbers to other systems like EVMS, which you would probably want to
> use on top of those 2144 SCSI disks anyways.  However, since you are
> billing this as the "2144 SCSI disk patch", I thought I would
> confirm.

This patch only touches sd.c. But everything you need for other
drivers is already in 2.4.7. Go forth and allocate!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
