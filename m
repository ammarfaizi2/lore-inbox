Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271147AbRIHVRN>; Sat, 8 Sep 2001 17:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271501AbRIHVRE>; Sat, 8 Sep 2001 17:17:04 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38134 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271147AbRIHVQv>; Sat, 8 Sep 2001 17:16:51 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sat, 8 Sep 2001 15:15:39 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010908151539.F32553@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20010908191954.C11329@athlon.random> <Pine.LNX.4.33.0109081028390.936-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109081028390.936-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 08, 2001  10:30 -0700, Linus Torvalds wrote:
> I'll merge the blkdev in pagecache very early in 2.5.x, but I'm a bit
> nervous about merging it in 2.4.x.
> 
> That said, if you'll give a description of how you fixed the aliasing
> issues etc, maybe I'd be less nervous. Putting it in the page cache is
> 100% the right thing to do, so in theory I'd really like to merge it
> earlier rather than later, but...

I think this may have bad interactions with the filesystems, which still
use buffer cache for metadata.  If the block devices move to page cache,
so should the filesystems.

For example, the "tune2fs" program will modify parts of the superblock
from user space (fields that are read-only from the kernel, e.g. label,
reserved blocks count, etc), because it knows that the data read/written
on /dev/hda1 is coherent with that in the kernel for the filesystem
on /dev/hda1.  The same is true with e2fsck - the metadata should be
kept coherent from user-space and kernel-space or bad things happen.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

