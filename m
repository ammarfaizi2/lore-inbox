Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRDXWKF>; Tue, 24 Apr 2001 18:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbRDXWJ4>; Tue, 24 Apr 2001 18:09:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16124 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132468AbRDXWJr>;
	Tue, 24 Apr 2001 18:09:47 -0400
Date: Tue, 24 Apr 2001 18:09:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <shszod6j6w4.fsf@charged.uio.no>
Message-ID: <Pine.GSO.4.21.0104241805280.9199-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Apr 2001, Trond Myklebust wrote:

> Hi Al,
> 
>   I believe your patch introduces a race for the NFS case. The problem
> lies in the fact that nfs_find_actor() needs to read several of the
> fields from nfs_inode_info. By adding an allocation after the inode
> has been hashed, you are creating a window during which the inode can
> be found by find_inode(), but during which you aren't even guaranteed
> that the nfs_inode_info exists let alone that it's been initialized
> by nfs_fill_inode().

_Ouch_. So what are you going to do if another iget4() comes between
the moment when you hash the inode and set these fields? You are
filling them only after you drop inode_lock, so AFAICS the current
code has the same problem.

