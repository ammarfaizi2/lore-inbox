Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273289AbRIRJ5O>; Tue, 18 Sep 2001 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273290AbRIRJ5F>; Tue, 18 Sep 2001 05:57:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:53364 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273289AbRIRJ4t>; Tue, 18 Sep 2001 05:56:49 -0400
Date: Tue, 18 Sep 2001 11:57:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918115713.C2723@athlon.random>
In-Reply-To: <20010918113938.B2723@athlon.random> <Pine.GSO.4.21.0109180540320.25323-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109180540320.25323-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 18, 2001 at 05:44:18AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:44:18AM -0400, Alexander Viro wrote:
> Bumping ->i_count on inode is _not_ an option - think what it does if
> you umount the first fs.

what it does? Unless I'm missing something the fs never cares and never
sees the bd_inode. the fs just does a bdget and then it works only on
the bdev. What should I run to get the oops exactly?

> _If_ you need an inode for block_device - allocate a new one instead of
> reusing the inode that had been passed to ->open().

If we need to avoid the bumping of i_count and to allocate something
dynamically that will be the bd_mapping address space, we don't need a
new fake_inode there too, we just need to share the new physical
pagecahce address space. Such physical i_mapping address space is the
same thing that the buffer cache will have to use to map its legacy
buffer cache buffer headers on top of it (then we can cleanup away the
few lines in blkdev_close that do the update_buffers() and checks the
MS_RDONLY bit).

Andrea
