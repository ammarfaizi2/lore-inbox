Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271697AbRIHRT3>; Sat, 8 Sep 2001 13:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271765AbRIHRTT>; Sat, 8 Sep 2001 13:19:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:61773 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271697AbRIHRTE>; Sat, 8 Sep 2001 13:19:04 -0400
Date: Sat, 8 Sep 2001 19:19:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010908191954.C11329@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109072117580.1259-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109072117580.1259-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Sep 07, 2001 at 09:18:47PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 09:18:47PM -0700, Linus Torvalds wrote:
> pre5:
>  - Merge with Alan
>  - Trond Myklebust: NFS fixes - kmap and root inode special case
>  - Al Viro: more superblock cleanups, inode leak in rd.c, minix
>    directories in page cache

"inode leak in rd.c" is correct description, what's wrong is that pre5
is the one introducing the leak, and there was nothing to fix there. The
inode of the initrd must be released with iput because it's a virtual
inode, so if we don't iput it from there we'll lose all references to
it.

There are instead a few initrd bugs that I corrected in the
blkdev-pagecache patch while rewriting the ramdisk/initrd pagecache
backed but I'm too lazy to extract them since they're quite low prio,
I'll just wait for the blkdev in pagecache to be merged instead.

Andrea
