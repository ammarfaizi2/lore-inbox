Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSFEKx7>; Wed, 5 Jun 2002 06:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSFEKx6>; Wed, 5 Jun 2002 06:53:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17608 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315168AbSFEKx5>;
	Wed, 5 Jun 2002 06:53:57 -0400
Date: Wed, 5 Jun 2002 12:53:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
        Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020605105346.GC15883@suse.de>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <20020605103351.GA15883@suse.de> <3CFDEE17.FD1306A0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > On Wed, Jun 05 2002, Xavier Bestel wrote:
> > > Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :
> > >
> > > > Also, it has been suggested that the feature become more fully-fleshed,
> > > > to support desktops with one disk spun down, etc.  It's not really
> > > > rocket science to do that - the `struct backing_dev_info' gives
> > > > a specific communication channel between the high-level VFS code and
> > > > the request queue.  But that would require significantly more surgery
> > > > against the writeback code, so I'm fishing for requirements here.  If
> > > > the current (simple) patch is sufficient then, well, it is sufficient.
> > >
> > > Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
> > > could decide what to do.
> > 
> > And get rid of disk_spun_up(), make it a queue flag instead and signal
> > the spin up before calling the request_fn instead of shoving it inside
> > the driver request_fn's.
> 
> Then writes to the ramdisk would cause a spinup.

No of course not, that is what the queue flag would say (is this a disk
or not, or something to that effect). Besides, ram disk doesn't even use
a request_fn.

> Yes, it could be per-queue.  That would add complexity to
> the already-murky fs/fs-writeback.c.  It that justifiable?

I dunno, it's up to you. I guess this is mainly IDE specific anyways,
but you apply the same logic to just one (for instance) of your disks on
a home desktop system.

-- 
Jens Axboe

