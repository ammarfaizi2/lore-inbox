Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTDYG6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 02:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTDYG6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 02:58:24 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4224 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263132AbTDYG6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 02:58:22 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304250713.h3P7Ddp6000359@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: root@chaos.analogic.com
Date: Fri, 25 Apr 2003 08:13:39 +0100 (BST)
Cc: stewartsmith@mac.com (Stewart Smith), john@grabjohn.com (John Bradford),
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.53.0304242027350.3180@chaos> from "Richard B. Johnson" at Apr 24, 2003 08:52:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> I wonder whether it would be a good idea to give the linux-fs
> > >> (namely my preferred reiser and ext2 :-) some fault-tolerance.
> > >
> > > Fault tollerance should be done at a lower level than the filesystem.
> >
> > I would (partly) disagree. On the FS level, you would still have to
> > deal with the data having gone away (or become corrupted). Simply
> > passing a (known) corrupted block to a FS isn't going to do anything
> > useful. Having the FS know that "this data is known crap" could tell it
> > to
> > a) go look at a backup structure (e.g. one of the many superblock
> > copies)
> > b) guess (e.g. in disk allocation bitmap, just think of them all as
> > used)
> > c) fail with error (e.g. "cannot read directory due to a physical
> > problem with the disk"
> > d) try to reconstruct the data (e.g. search around the disk for magic
> > numbers)
> >
> > <snip>
> > > The filesystem doesn't know or care what device it is stored on, and
> > > therefore shouldn't try to predict likely failiures.
> >
> > but it should be tolerant of them and able to recover to some extent.
> > Generally, the first sign that a disk is dying (to an end user) is when
> > really-weird-stuff(tm) starts happening. A nice error message from the
> > file system when they try to go into the directory (or whatever) would
> > be a lot nicer.
> >
> > You could generalize the failure down to an extents type record (i.e.
> > offset and length) which would suit 99.9% of cases (i think :). In the
> > case of post-detection of error, the extra effort is probably worth it.
> >
> > these kinda issues are coming up in my honors thesis too, so there
> > might even be the (dreaded) code and discussion sometime near the end
> > of the year :)
> > ------------------------------
> > Stewart Smith
> > stewartsmith@mac.com
> > Ph: +61 4 3884 4332
> > ICQ: 6734154
> 
> With most devices used for file-systems most all writes succeed.
> So the file-system doesn't even know that there was some error
> until it tries to read the data, probably next week. Through the
> ages, attempts to fix this have destroyed any real I/O capability.

The fix is to dispense with the disk device altogether, and have a
huge battery-backed RAM.  It's practical already - two gigs of ECC RAM
and some logic to make it appear as an IDE or SCSI device would cost
very little to build.

Infact, you don't even need to do that.

Just put three gigs of RAM in an existing machine, and set it to boot
from CD with the root filesystem on a RAM disk, and use further RAM
disks for all of your partitions.  Copy the contents of the RAM disk
containing user data over the LAN to another box every 30 minutes.
Patch the kernel to dump the contents of the RAM disks to another box
over the LAN if it oopses.

I've actually thought of co-locating a machine and running a webserver
entirely from RAM this way.

John.
