Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313816AbSDJUxW>; Wed, 10 Apr 2002 16:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313818AbSDJUxV>; Wed, 10 Apr 2002 16:53:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38825 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313816AbSDJUxU>;
	Wed, 10 Apr 2002 16:53:20 -0400
Date: Wed, 10 Apr 2002 16:53:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB48F8A.DF534834@zip.com.au>
Message-ID: <Pine.GSO.4.21.0204101649450.17078-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Apr 2002, Andrew Morton wrote:

[I'll answer to the rest when I get some sleep]

> The one thing which does worry me a bit is why __mark_inode_dirty
> tests for a null ->i_sb.  If the inode doesn't have a superblock
> then its pages are hidden from the writeback functions.
> 
> This is not fatal per-se.  The pages are still visible to the VM
> via the LRU, and presumably the filesystem knows how to sync
> its own stuff.  But for memory-balancing and throttling purposes,
> I'd prefer that the null ->i_sb not be allowed.  Where can this
> occur?

In rather old kernels.  IOW, these checks are atavisms - these days
_all_ inodes have (constant) ->i_sb.  The only way to create an
in-core inode is alloc_inode(superblock) and requires superblock
to be non-NULL.  After that ->i_sb stays unchanged (and non-NULL)
until struct inode is freed.

