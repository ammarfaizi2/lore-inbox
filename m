Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbREFDlj>; Sat, 5 May 2001 23:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbREFDla>; Sat, 5 May 2001 23:41:30 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:18416 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132558AbREFDlN>; Sat, 5 May 2001 23:41:13 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105060338.f463cWai012195@webber.adilger.int>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010506150058.A31393@metastasis.f00f.org> "from Chris Wedgwood
 at May 6, 2001 03:00:58 pm"
To: Chris Wedgwood <cw@f00f.org>
Date: Sat, 5 May 2001 21:38:31 -0600 (MDT)
CC: Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgewood writes:
> As I said, I'm not takling about kernel based fsck, although for
> _VERY_ large filesystems even with journalling I suspect it will be
> required one day (so it can run in the background and do consistency
> checking when the machine is idle).

Actually, I was talking with Ted about this, and we agreed that:
a) kernel-based e2fsck is a pain in the a** (locking issues, etc)
b) you can do an LVM snapshot of your live filesystem and do a read-only
   fsck on that to check if the filesystem is still OK.  For journaled
   filesystems like reiserfs and ext3, they need to use the super method
   write_super_lockfs() to block I/O and flush everything to disk at the
   time of the snapshot, to ensure that they don't need recovery on a
   read-only device.  This makes the LVM snapshot equivalent to unmount
   the filesystem, copy contents to a new device and remount the filesystem.

While (b) doesn't let you fix a filesystem online, unless there is a kernel
bug or hardware problem, you should not have a problem.  If you have either
of those, then fixing the filesystem online is just asking for more problems
in the future.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
