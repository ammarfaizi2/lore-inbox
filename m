Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265620AbRGOBuV>; Sat, 14 Jul 2001 21:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265592AbRGOBuL>; Sat, 14 Jul 2001 21:50:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:23557 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265571AbRGOBuC>; Sat, 14 Jul 2001 21:50:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Sun, 15 Jul 2001 03:53:54 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <0107142211300W.00409@starship> <3B50F000.53EAB651@uow.edu.au>
In-Reply-To: <3B50F000.53EAB651@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01071503535411.00409@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 July 2001 03:21, Andrew Morton wrote:
> Daniel Phillips wrote:
> > On Saturday 14 July 2001 16:50, Chris Wedgwood wrote:
> > > On Sat, Jul 14, 2001 at 09:45:44AM +0100, Alan Cox wrote:
> > >
> > >     As far as I can tell none of them at least in the IDE world
> > >
> > > SCSI disk must, or at least some... if not, how to peopel like
> > > NetApp get these cool HA certifications?
> >
> > Atomic commit.  The superblock, which references the updated
> > version of the filesystem, carries a sequence number and a
> > checksum.  It is written to one of two alternating locations.  On
> > restart, both locations are read and the highest numbered
> > superblock with a correct checksum is chosen as the new filesystem
> > root.
>
> But this assumes that it is the most-recently-written sector/block
> which gets lost in a power failure.
>
> The disk will be reordering writes - so when it fails it may have
> written the commit block but *not* the data which that block is
> committing.
>
> You need a barrier or a full synchronous flush prior to writing
> the commit block.  A `don't-reorder-past-me' barrier is very much
> preferable, of course.

Oh yes, absolutely, that's very much part of the puzzle.  Any disk
that doesn't support a real write barrier or write cache flush is
fundamentally broken as far as failsafe operation goes.  A disk that
claims to provide such support and doesn't is an even worse offender.
I find Alan's comment there worrisome.  We need to know which disks
devliver on this and which don't.

--
Daniel
