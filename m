Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSFEKvW>; Wed, 5 Jun 2002 06:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSFEKvV>; Wed, 5 Jun 2002 06:51:21 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:9737 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S315414AbSFEKvU>; Wed, 5 Jun 2002 06:51:20 -0400
Message-ID: <3CFDEE17.FD1306A0@zip.com.au>
Date: Wed, 05 Jun 2002 03:55:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Xavier Bestel <xavier.bestel@free.fr>,
        Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <20020605103351.GA15883@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Wed, Jun 05 2002, Xavier Bestel wrote:
> > Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :
> >
> > > Also, it has been suggested that the feature become more fully-fleshed,
> > > to support desktops with one disk spun down, etc.  It's not really
> > > rocket science to do that - the `struct backing_dev_info' gives
> > > a specific communication channel between the high-level VFS code and
> > > the request queue.  But that would require significantly more surgery
> > > against the writeback code, so I'm fishing for requirements here.  If
> > > the current (simple) patch is sufficient then, well, it is sufficient.
> >
> > Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
> > could decide what to do.
> 
> And get rid of disk_spun_up(), make it a queue flag instead and signal
> the spin up before calling the request_fn instead of shoving it inside
> the driver request_fn's.

Then writes to the ramdisk would cause a spinup.

Yes, it could be per-queue.  That would add complexity to
the already-murky fs/fs-writeback.c.  It that justifiable?

-
