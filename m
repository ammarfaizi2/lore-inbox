Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135809AbRDTFiU>; Fri, 20 Apr 2001 01:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135810AbRDTFiL>; Fri, 20 Apr 2001 01:38:11 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:23790 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135809AbRDTFhw>; Fri, 20 Apr 2001 01:37:52 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104200535.f3K5Ze82017093@webber.adilger.int>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
In-Reply-To: <Pine.GSO.4.21.0104192213060.19860-100000@weyl.math.psu.edu>
 "from Alexander Viro at Apr 19, 2001 10:23:39 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 19 Apr 2001 23:35:40 -0600 (MDT)
CC: tytso@valinux.com, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@turbolinux.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> I don't think that it's needed - old kernels (up to -CURRENT ;-) will
> simply refuse to mount if ->s_inode_size != 128. Old utilites may be
> trickier, though...

Probably would need an incompat flag for changing the inode size anyways,
so old utilities wouldn't set that anyways.

> I'm somewhat concerned about the following: last block of inode table
> fragment may have less inodes than the rest. Reason: number of inodes
> per group should be a multiple of 8 and with inodes bigger than 128
> bytes it may give such effect. Comments?

I don't _think_ that there is a requirement for a multiple-of-8 inodes
per group.  OK, looking into mke2fs (actually lib/ext2fs/initialize.c)
it _does_ show that it needs to be a multiple of 8, but I'm not sure
exactly what the "bitmap splicing code" mentioned in the comment is.

In the end, it doesn't really matter much - if we go with multiple-of-2
inode sizes, all it means is that we may need to have multiple-of-2 (or
possibly 4 for 512-byte inodes in a 1k block filesystem) inode table
blocks in each group.  Not a big deal.  The code already handles this.

> I would really, really like to end up with accurate description of
> inode table layout somewhere in Documentation/filesystems. Heck, I
> volunteer to write it down and submit into the tree ;-)

I can write a few words as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
