Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135887AbRDTS1a>; Fri, 20 Apr 2001 14:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135904AbRDTS1V>; Fri, 20 Apr 2001 14:27:21 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:33519 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135887AbRDTS1L>; Fri, 20 Apr 2001 14:27:11 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104201825.f3KIPo8f031357@webber.adilger.int>
Subject: Re: [Ext2-devel] [PATCH] update ext2 documentation
In-Reply-To: <01042014132609.01958@subspace.radio> "from Daniel Phillips at Apr
 20, 2001 02:07:34 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Fri, 20 Apr 2001 12:25:49 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> To quote Oliver Twist: "Please, Sir, I want some more".  How about a
> explanation of the significance of GOOD_OLD_REV, etc.  In particular, I'm
> curious why CURRENT_REV is defined as GOOD_OLD_REV and not DYNAMIC_REV.

One thing that deserves mentioning (related to your question) is the fact
that unused fields in the superblock, inode, and group descriptor table
are always initialized to zero.  I believe that this has been true for
most (if not all) of ext2's lifetime.

This means that the s_rev_level field could be assumed to be rev 0 when
it was first assigned (some time between kernel 1.1.48 and 1.1.57,
according to your kernel source browser), and remained such for a
considerable time.  The compat fields were added around 1.3.99 - 2.0pre6.

AFAIK, the only difference between a GOOD_OLD_REV filesystem and a
DYNAMIC_REV filesystem is:

- addition of COMPAT flags to superblock
- addition of s_inode_size to superblock (previously fixed at 128 bytes)
- addition of s_first inode to superblock (previously fixed at inode 11)

The s_inode_size and s_first inode fields are still set at the default
values to this day.  Since we still have a bit of room in the inode,
and a couple of reserved inodes left, there is still no reason to change
these yet.


The superblock later grew to include the (not very critical) fields:

- addition of s_block_group_number to indicate superblock backup number
- addition of s_uuid, s_volume_name, and s_last_mounted to identify the fs

The rest of the fields are only valid in combination with a COMPAT flag.


The reason why CURRENT_REV is GOOD_OLD_REV and not DYNAMIC_REV is "none".
It isn't really used anywhere.  In e2fsck, E2FSCK_CURRENT_REV is 1, and
in libext2fs EXT2_LIB_CURRENT_REV is also 1.  Unless we run out of compat
flags or something, I don't see any reason why we would ever want to go
to rev 2.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
