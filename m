Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRIRKfk>; Tue, 18 Sep 2001 06:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273332AbRIRKfb>; Tue, 18 Sep 2001 06:35:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8976 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273337AbRIRKfS>; Tue, 18 Sep 2001 06:35:18 -0400
Date: Tue, 18 Sep 2001 12:35:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918123537.E2723@athlon.random>
In-Reply-To: <20010918121716.D2723@athlon.random> <Pine.GSO.4.21.0109180622350.25323-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109180622350.25323-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 18, 2001 at 06:28:11AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 06:28:11AM -0400, Alexander Viro wrote:
> 
> 
> On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> 
> > > > If we need to avoid the bumping of i_count and to allocate something
> > > > dynamically that will be the bd_mapping address space, we don't need a
> > > > new fake_inode there too, we just need to share the new physical
> > > > pagecahce address space. Such physical i_mapping address space is the
> > > 
> > > What are you going to use as mapping->host for it?
> > 
> > the only info we'd need from the host is the host->i_rdev, so why can't
> > we get it from the file->f_dentry->d_inode->i_rdev? In general I don't
> 
> In ->writepage()?  Good luck.  BTW, at some point use of ->i_rdev will have

I would have noticed if I actually wrote the code ;)

static int blkdev_writepage(struct page * page)
{

no file...

> It doesn't have to be fake. See how it's done for sockets or pipes.

here it's really completly private to the bdev. I mean we could be
tricky and force a cast on mapping->host to point to bdev and we
wouldn't need the fake inode. But casts are probably uglier and more
risky than using the fake_inode (unless we really consdier the host a
cookie rather than an inode pointer). Comments?

Andrea
