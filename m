Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281283AbRKLGr0>; Mon, 12 Nov 2001 01:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281286AbRKLGrR>; Mon, 12 Nov 2001 01:47:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:682 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281283AbRKLGrF>;
	Mon, 12 Nov 2001 01:47:05 -0500
Date: Mon, 12 Nov 2001 01:47:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nathan Scott <nathans@sgi.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
In-Reply-To: <20011112172113.A636371@wobbly.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0111120132080.19192-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Cc'd to Linus since API changes on that level definitely require his
approval]

On Mon, 12 Nov 2001, Nathan Scott wrote:

> +static long
> +extattr_inode(struct inode *i, int cmd, char *name, void *value, size_t size)

Broken.
	a) passing inode is an obvious mistake.  dentry or vfsmount/dentry.

	b) for crying out loud, what's that with SGI and ioctl-like abortions?

Rule of the tumb: if your function got a "cmd" argument - it's broken.
ioctl(2).  fcntl(2).  prctl(2).  quotactl(2).  sysfs(2).  Missed'em'V IPC
syscalls.  Enough, already.

	Folks, it's not a rocket science.  Let a function do _one_ thing,
don't turn it into a multiplexed monstrosity.  Yes, you've used only 3
syscalls.  But actually you've managed to hide ~20 of them in that code
and the fact that you've spent only 3 syscall table entries doesn't make
the things better.

	Please, come up with a decent API.

