Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274498AbRITN41>; Thu, 20 Sep 2001 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274499AbRITN4S>; Thu, 20 Sep 2001 09:56:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14271 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274498AbRITNz7>;
	Thu, 20 Sep 2001 09:55:59 -0400
Date: Thu, 20 Sep 2001 09:56:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010920014017.E720@athlon.random>
Message-ID: <Pine.GSO.4.21.0109200952350.3498-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> > Umm... Not doing unnecessary work?  Semantics of releasing a block device
> > depends on the kind of use.  BTW, I'm less than sure that fsync_dev() is
> > the right thing for file access now that you've got that in pagecache -
> > __block_fsync() seems to be more correct thing to do.
> 
> Not really, blkdev isn't a filesystem. It will never have a superblock
> and its own inodes and we also need to filemap_fdatasync/wait the
> physical address space.

Had you actually read the fsync_dev()?  Let me make it clear: you are
flushing _buffer_ cache upon blkdev_put(bdev, BDEV_FILE).  It was
the right thing when file access went through buffer cache.  It's
blatantly wrong with page cache.

