Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135716AbRDXSxB>; Tue, 24 Apr 2001 14:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135718AbRDXSwv>; Tue, 24 Apr 2001 14:52:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6833 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135716AbRDXSwh>;
	Tue, 24 Apr 2001 14:52:37 -0400
Date: Tue, 24 Apr 2001 14:52:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, Ed Tomlinson <tomlins@cam.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104241847.f3OIlc7T016933@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104241449561.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Andreas Dilger wrote:

> While I applaud your initiative, you made an unfortunate choice of
> filesystems to convert.  The iso_inode_info is only 4*__u32, as is
> proc_inode_info.  Given that we still need to keep a pointer to the
> external info structs, and the overhead of the slab cache itself
> (both CPU usage and memory overhead, however small), I don't think
> it is worthwhile to have isofs and procfs in separate slabs.
> 
> On the other hand, sockets and shmem are both relatively large...
> Watch out that the *_inode_info structs have all of the fields
> initialized, because the union field is zeroed for us, but slab is not.

Frankly, I'd rather start with encapsulation part. It's easy to
verify, it can go in right now and it makes separate allocation
part uncluttered. Besides, it simply makes code cleaner, so it
makes sense even if don't want to go for separate allocation for
that particular fs.

