Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135603AbRDSUK3>; Thu, 19 Apr 2001 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135607AbRDSUKU>; Thu, 19 Apr 2001 16:10:20 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:3849 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S135603AbRDSUKH>;
	Thu, 19 Apr 2001 16:10:07 -0400
Date: Thu, 19 Apr 2001 16:10:03 -0400
From: tytso@valinux.com
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolinux.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
Message-ID: <20010419161003.E17837@snap.thunk.org>
Mail-Followup-To: tytso@valinux.com, Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolinux.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Ext2 development mailing list <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20001202014045.F2272@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0104190719240.16930-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104190719240.16930-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 19, 2001 at 07:55:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 07:55:20AM -0400, Alexander Viro wrote:
> 	Erm... Folks, can ->s_inode_size be not a power of 2? Both
> libext2fs and kernel break in that case. 

This was a project that was never completed.  I thought at one point
of allowing the inode size to be not a power of 2, but if you do that,
you really want to avoid letting an inode cross a block boundary ---
for reliability and performance reasons if nothing else.   

It may simply be easiest at this point to require that the inode size
be a power of two, at least as far as going from 128 to 256 bytes,
just for compatibility reasons.  (Although if we do that, the folks
who want to use extra space in the inode will come pooring out of the
woodwork, and we're going to have to careful to control who uses what
parts of the extended inode.)

In the long run, it probably makes sense to adjust the algorithms to
allow for non-power-of-two inode sizes, but require an incompatible
filesystem feature flag (so that older kernels and filesystem
utilities won't choke when mounting filesystems with non-standard
sized inodes.

							- Ted

