Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286734AbSAEE1d>; Fri, 4 Jan 2002 23:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSAEE1Y>; Fri, 4 Jan 2002 23:27:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5874 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286734AbSAEE1Q>;
	Fri, 4 Jan 2002 23:27:16 -0500
Date: Fri, 4 Jan 2002 23:27:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [FIX] missing piece from fs/super.c in -pre8
In-Reply-To: <Pine.LNX.4.33.0201042017410.1371-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201042321200.27334-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Linus Torvalds wrote:

> 
> On Fri, 4 Jan 2002, Alexander Viro wrote:
> >
> > Linus, I doubt that making the thing inline was a good idea.  Reason: for
> > filesystems like NFS we almost definitely want something like server name
> > + root path to identify the superblock.  And that can easily grow past
> > 32 bytes.
> 
> Since it is only used for printouts, I'd much rather have simpler code.
> Especially since I couldn't convince myself that all users in your version
> even initialized the dang pointer.

Set to NULL when we allocate superblock.
Allocated and set by get_sb_bdev() (which takes care of block filesystems)
Allocated and set by nfs_read_super() (which takes care of NFS).
That covers all users...
 
> There is nothing wrong with having a requirement that informational stuff
> be limited to X characters..

In principle - yes...

