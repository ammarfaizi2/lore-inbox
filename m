Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273361AbRIRKwa>; Tue, 18 Sep 2001 06:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273365AbRIRKwK>; Tue, 18 Sep 2001 06:52:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41117 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273361AbRIRKwA>;
	Tue, 18 Sep 2001 06:52:00 -0400
Date: Tue, 18 Sep 2001 06:52:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918123537.E2723@athlon.random>
Message-ID: <Pine.GSO.4.21.0109180641180.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> > It doesn't have to be fake. See how it's done for sockets or pipes.
> 
> here it's really completly private to the bdev. I mean we could be
> tricky and force a cast on mapping->host to point to bdev and we
> wouldn't need the fake inode. But casts are probably uglier and more
> risky than using the fake_inode (unless we really consdier the host a
> cookie rather than an inode pointer). Comments?

Well, seeing that I had added ->host in the first place... yes, they were
intended to be cookies rather than inode pointers.  Precisely because of
block device applications.  Overridden by Linus several months down the road
and yes, I still think that it was bogus.

Anyway, _if_ we have to have an inode somewhere, we'd better make sure
that it's not a reuse of inode passed by open().  Otherwise we are in for
a lot of fun.

I could live with something similar to the net/socket.c and fs/pipe.c schemes
- minimal superblock and inodes allocated on it.  But then we'd better be
consistent and do that for _all_ uses of blkdev_get().

