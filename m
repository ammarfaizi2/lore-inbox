Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274564AbRITQnL>; Thu, 20 Sep 2001 12:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274565AbRITQnC>; Thu, 20 Sep 2001 12:43:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40429 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274564AbRITQms>;
	Thu, 20 Sep 2001 12:42:48 -0400
Date: Thu, 20 Sep 2001 12:43:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <703500000.1001000688@tiny>
Message-ID: <Pine.GSO.4.21.0109201201590.3498-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Chris Mason wrote:

> > <nod>  And if you add Andrea's (perfectly valid) observation re having no
> > need to sync any fs structures we might have for that device, you get
> > __block_fsync().  After that it's easy to merge blkdev_close() code into
> > blkdev_put().
> > 
> >
> 
> Ok, __block_fsync is much better than just fsync_dev.
> 
> Are there other parts of blkdev_close you want merged into 
> blkdev_put? Without changing the reread blocks on last close 
> semantics, I think this is all we can do.
> 
> As far as I can tell, bdev->bd_inode is valid to send 
> to __block_fsync, am I missing something?

Eventually that will be the right thing, but only after we allocate
bd_inode upon blkdev_get()/blkdev_open() instead of trying to cannibalize
the inode passed to blkdev_open().

I'm testing that chunk right now (it also kills all the fake_inode crap in
block_dev.c).

When we cut the lifetime of block_device down we'll be able to get it
even simpler - allocate and free ->bd_inode at the same time as block_device,
but that's several chunks later.

