Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRACRyV>; Wed, 3 Jan 2001 12:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbRACRyL>; Wed, 3 Jan 2001 12:54:11 -0500
Received: from zeus.kernel.org ([209.10.41.242]:49418 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129226AbRACRyI>;
	Wed, 3 Jan 2001 12:54:08 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101030147.f031lPa21470@webber.adilger.net>
Subject: Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <Pine.GSO.4.21.0101021817140.13824-100000@weyl.math.psu.edu>
 "from Alexander Viro at Jan 2, 2001 06:33:29 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 2 Jan 2001 18:47:25 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, you write:
> 	Folks, there is a pretty strange detail of the allocation policy -
> if cylinder group has no free blocks past the goal ext2 tries very hard to
> avoid allocation in the beginning of the group. I.e. order looks so:
> 
> 	* goal
> 	* goal .. (goal+63) & ~63
> 	* goal .. end of cylinder group
> 	* cylinder groups past one that contains goal
> 	* cylinder groups before one that contains goal
> 	* beginning of cylinder group..goal-1
> 
> It looks somewhat fishy. What's the reason for such policy?

This predates me by a while, but I suspect that it is done this way on
the assumption it is easier to seek forward on the disk while reading
a file rather than seeking backwards.  Also, since with new inodes the
goal is initially the first block of the group where the inode lives,
the blocks at the start of a group will generally be allocated already,
so it is usually a waste of time checking the start of the group for
free blocks.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
