Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271834AbRIIA7S>; Sat, 8 Sep 2001 20:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIIA7I>; Sat, 8 Sep 2001 20:59:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24688 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271834AbRIIA6x>; Sat, 8 Sep 2001 20:58:53 -0400
Date: Sun, 9 Sep 2001 02:59:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909025943.F11329@athlon.random>
In-Reply-To: <20010908191954.C11329@athlon.random> <Pine.LNX.4.33.0109081028390.936-100000@penguin.transmeta.com> <20010908151539.F32553@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010908151539.F32553@turbolinux.com>; from adilger@turbolabs.com on Sat, Sep 08, 2001 at 03:15:39PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 03:15:39PM -0600, Andreas Dilger wrote:
> On Sep 08, 2001  10:30 -0700, Linus Torvalds wrote:
> > I'll merge the blkdev in pagecache very early in 2.5.x, but I'm a bit
> > nervous about merging it in 2.4.x.
> > 
> > That said, if you'll give a description of how you fixed the aliasing
> > issues etc, maybe I'd be less nervous. Putting it in the page cache is
> > 100% the right thing to do, so in theory I'd really like to merge it
> > earlier rather than later, but...
> 
> I think this may have bad interactions with the filesystems, which still
> use buffer cache for metadata.  If the block devices move to page cache,
> so should the filesystems.
> 
> For example, the "tune2fs" program will modify parts of the superblock
> from user space (fields that are read-only from the kernel, e.g. label,
> reserved blocks count, etc), because it knows that the data read/written
> on /dev/hda1 is coherent with that in the kernel for the filesystem
> on /dev/hda1.  The same is true with e2fsck - the metadata should be
> kept coherent from user-space and kernel-space or bad things happen.

the patch takes care of that transparently of course, if it didn't you
would keep doing long fsck of the root filesystem forever.

Andrea
