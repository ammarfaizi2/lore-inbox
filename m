Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269684AbRHCXQO>; Fri, 3 Aug 2001 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269679AbRHCXQF>; Fri, 3 Aug 2001 19:16:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22196 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269683AbRHCXP4>;
	Fri, 3 Aug 2001 19:15:56 -0400
Date: Fri, 3 Aug 2001 19:15:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804110905.B17925@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031911230.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> On Fri, Aug 03, 2001 at 06:45:47PM -0400, Alexander Viro wrote:
> 
>     nfs_fsync().
> 
> Ah, well... then I'm not sure how the loop should look.  I use
> f->fsync(file, dentry, ...) where file references the original file
> not any of the parent path components.
> 
> Obviously, for ext2 and reiserfs (which is what I have here) this
> won't matter --- will it for NFS?  If so, so I need to open/etc. for
> each parent component to get a valid struct file*?

<shrug> credentials cache. 2.5 fodder. Notice that with NFS you don't
have fsync for directories. At all. So that's not a problem in that
particular case - you can pass NULL on all subsequent iterations.
On the first step you need struct file * - NFS needs credentials
to pass to the server.

