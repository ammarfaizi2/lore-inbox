Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132134AbRACEKY>; Tue, 2 Jan 2001 23:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132088AbRACEKO>; Tue, 2 Jan 2001 23:10:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4344 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129572AbRACEJ7>;
	Tue, 2 Jan 2001 23:09:59 -0500
Date: Tue, 2 Jan 2001 22:37:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@enel.ucalgary.ca>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <200101030147.f031lPa21470@webber.adilger.net>
Message-ID: <Pine.GSO.4.21.0101022216250.13824-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Andreas Dilger wrote:

> This predates me by a while, but I suspect that it is done this way on
> the assumption it is easier to seek forward on the disk while reading
> a file rather than seeking backwards.  Also, since with new inodes the
> goal is initially the first block of the group where the inode lives,
> the blocks at the start of a group will generally be allocated already,
> so it is usually a waste of time checking the start of the group for
> free blocks.

Umm... OK, the last argument is convincing. Thanks...

BTW, what was the reason behind doing preallocation for directories on
ext2_bread() level? We both buy ourselves an oddity in directory structure
(preallocated blocks become refered from the inode immediately and they
are beyond i_size) and get more complicated ext2_alloc_block(). What do
we win here?
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
