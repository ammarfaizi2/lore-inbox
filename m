Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273298AbRIRKRI>; Tue, 18 Sep 2001 06:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273299AbRIRKQ6>; Tue, 18 Sep 2001 06:16:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2568 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273298AbRIRKQx>; Tue, 18 Sep 2001 06:16:53 -0400
Date: Tue, 18 Sep 2001 12:17:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918121716.D2723@athlon.random>
In-Reply-To: <20010918115713.C2723@athlon.random> <Pine.GSO.4.21.0109180558150.25323-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109180558150.25323-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 18, 2001 at 06:02:27AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 06:02:27AM -0400, Alexander Viro wrote:
> 
> 
> On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Sep 18, 2001 at 05:44:18AM -0400, Alexander Viro wrote:
> > > Bumping ->i_count on inode is _not_ an option - think what it does if
> > > you umount the first fs.
> > 
> > what it does? Unless I'm missing something the fs never cares and never
> > sees the bd_inode. the fs just does a bdget and then it works only on
> > the bdev. What should I run to get the oops exactly?
> 
> It sees an active inode for superblock we are destroying.  _Not_ a good
> thing, for very obvious reasons.  There is a reason for "Self-destruct in
> 5 seconds" printk...
>  

very clear now, thanks. I though the fs you were talking about was
mounted on the blkdev, while it is instead the one where the blkdev
inode cames from. Usually people keeps bldkev in /dev and nobody
unmounts /dev that's why I didn't noticed and thought about it, sorry.

> > If we need to avoid the bumping of i_count and to allocate something
> > dynamically that will be the bd_mapping address space, we don't need a
> > new fake_inode there too, we just need to share the new physical
> > pagecahce address space. Such physical i_mapping address space is the
> 
> What are you going to use as mapping->host for it?

the only info we'd need from the host is the host->i_rdev, so why can't
we get it from the file->f_dentry->d_inode->i_rdev? In general I don't
like very much the fake inodes with the zillon of unused fields (they
just looks confusing due their unused fields), but well if you for
whatever reason prefer to keep doing page->mapping->host->i_rdev or if
file->f_dentry->d_inode->i_rdev has a problem I'm pretty much ok with
the fake_inode there too.

Andrea
