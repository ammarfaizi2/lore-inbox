Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274600AbRITSdg>; Thu, 20 Sep 2001 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274601AbRITSd0>; Thu, 20 Sep 2001 14:33:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31395 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274600AbRITSdM>;
	Thu, 20 Sep 2001 14:33:12 -0400
Date: Thu, 20 Sep 2001 14:33:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010920201832.M729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109201418450.3498-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> > > +				truncate_inode_pages(rd_inode[minor]->i_mapping, 0);
> > >  				rd_inode[minor] = NULL;
> > >  				rd_blocksizes[minor] = rd_blocksize;
> > > +			unlock:
> > >  				up(&bdev->bd_sem);
> > 
> > Now think what happens if you go through that code twice.  What argument will
> > be passed to iput() the second time you call it?
> 
> the second time we won't go through that code.

IOW, subsequent calls of ioctl(fd, BLKFLSBUF) will not work.  Which is
better than oopsing, but doesn't look right.

Question: why the hell do we bother with iput() and decrementing counters
at all?


