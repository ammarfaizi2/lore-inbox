Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273324AbRIRK2K>; Tue, 18 Sep 2001 06:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273328AbRIRK17>; Tue, 18 Sep 2001 06:27:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10489 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273324AbRIRK1s>;
	Tue, 18 Sep 2001 06:27:48 -0400
Date: Tue, 18 Sep 2001 06:28:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918121716.D2723@athlon.random>
Message-ID: <Pine.GSO.4.21.0109180622350.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> > > If we need to avoid the bumping of i_count and to allocate something
> > > dynamically that will be the bd_mapping address space, we don't need a
> > > new fake_inode there too, we just need to share the new physical
> > > pagecahce address space. Such physical i_mapping address space is the
> > 
> > What are you going to use as mapping->host for it?
> 
> the only info we'd need from the host is the host->i_rdev, so why can't
> we get it from the file->f_dentry->d_inode->i_rdev? In general I don't

In ->writepage()?  Good luck.  BTW, at some point use of ->i_rdev will have
to go - we need to be able to use ->i_bdev instead.

> like very much the fake inodes with the zillon of unused fields (they
> just looks confusing due their unused fields), but well if you for
> whatever reason prefer to keep doing page->mapping->host->i_rdev or if
> file->f_dentry->d_inode->i_rdev has a problem I'm pretty much ok with
> the fake_inode there too.

It doesn't have to be fake. See how it's done for sockets or pipes.

