Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135782AbRDTCYU>; Thu, 19 Apr 2001 22:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135783AbRDTCYA>; Thu, 19 Apr 2001 22:24:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32459 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135782AbRDTCX6>;
	Thu, 19 Apr 2001 22:23:58 -0400
Date: Thu, 19 Apr 2001 22:23:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: tytso@valinux.com
cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolinux.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
In-Reply-To: <20010419161003.E17837@snap.thunk.org>
Message-ID: <Pine.GSO.4.21.0104192213060.19860-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001 tytso@valinux.com wrote:

> This was a project that was never completed.  I thought at one point
> of allowing the inode size to be not a power of 2, but if you do that,
> you really want to avoid letting an inode cross a block boundary ---
> for reliability and performance reasons if nothing else.   

Agreed.

> In the long run, it probably makes sense to adjust the algorithms to
> allow for non-power-of-two inode sizes, but require an incompatible
> filesystem feature flag (so that older kernels and filesystem
> utilities won't choke when mounting filesystems with non-standard
> sized inodes.

I don't think that it's needed - old kernels (up to -CURRENT ;-) will
simply refuse to mount if ->s_inode_size != 128. Old utilites may be
trickier, though...

I'm somewhat concerned about the following: last block of inode table
fragment may have less inodes than the rest. Reason: number of inodes
per group should be a multiple of 8 and with inodes bigger than 128
bytes it may give such effect. Comments?

I would really, really like to end up with accurate description of
inode table layout somewhere in Documentation/filesystems. Heck, I
volunteer to write it down and submit into the tree ;-)
							Al

