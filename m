Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135823AbRDTGf4>; Fri, 20 Apr 2001 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRDTGfr>; Fri, 20 Apr 2001 02:35:47 -0400
Received: from THINK.THUNK.ORG ([216.175.175.162]:25351 "EHLO think.thunk.org")
	by vger.kernel.org with ESMTP id <S135821AbRDTGfg>;
	Fri, 20 Apr 2001 02:35:36 -0400
Date: Fri, 20 Apr 2001 02:35:28 -0400
From: Theodore Tso <tytso@valinux.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: tytso@valinux.com, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@turbolinux.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] ext2 inode size (on-disk)
Message-ID: <20010420023528.D5417@think>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolinux.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Ext2 development mailing list <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20010419161003.E17837@snap.thunk.org> <Pine.GSO.4.21.0104192213060.19860-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21.0104192213060.19860-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 19, 2001 at 10:23:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 10:23:39PM -0400, Alexander Viro wrote:
> 
> I'm somewhat concerned about the following: last block of inode table
> fragment may have less inodes than the rest. Reason: number of inodes
> per group should be a multiple of 8 and with inodes bigger than 128
> bytes it may give such effect. Comments?

Yup, that's right.  That shouldn't be too bad, though, since we
already calculate things by dividing by INODES_PER_BLOCK_GROUP.  So
the fact that the last block of the inode table may have some unused
space shouldn't be a problem.

> I would really, really like to end up with accurate description of
> inode table layout somewhere in Documentation/filesystems. Heck, I
> volunteer to write it down and submit into the tree ;-)

The "design and implementation of ext2" paper has a pretty good
explanation of the inode table, but of course it assumed a convenient
inode size of 128, and didn't really go into the issues of what might
happen if the inode size were larger, or not a power of two.

So yeah, getting something which explains how things work now that
things have gotten a bit more complicated would be a good thing.

						- Ted


