Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbRGPFjH>; Mon, 16 Jul 2001 01:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbRGPFir>; Mon, 16 Jul 2001 01:38:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43230 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267200AbRGPFii>;
	Mon, 16 Jul 2001 01:38:38 -0400
Date: Mon, 16 Jul 2001 01:38:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Adam <adam@eax.com>, Alex Buell <alex.buell@tahallah.demon.co.uk>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib
In-Reply-To: <200107160516.f6G5Gew324783@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0107160128320.26491-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Jul 2001, Albert D. Cahalan wrote:

> Adam writes:
> 
> >> /lib
> >>    4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
> >>    4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..
> >>
> >> How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.
> >
> > first it is not a pair directories, but a directory and a file.
> > 
> > second, are you sure both of the mare just ".." for example
> 
> I don't think so! Look at the "4" on the left. If that is the
> inode number from "ls -lia /lib", his disk is seriously messed up.
> The inode number for "/lib/.." should be 2, and an inode may not
> be shared between a file and a directory.

Erm... It _can't_ be an inode number. Something is very fishy there.
	a) names are different, otherwise stat() would give the same
results both times it had been called. It didn't.
	b) actual inumbers are also different - see above for the reason
why.
	c) it might be an effect of getdents() returning crap (i.e.
giving bogus inumbers which ls(1) trusts). However, I don't see any
obvious ways to get corrupted directory tricking getdents() into that
output.

	Alex, could you do strace of that? It would clarify the situation.

