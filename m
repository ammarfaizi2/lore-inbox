Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277188AbRJVR3S>; Mon, 22 Oct 2001 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277210AbRJVR3I>; Mon, 22 Oct 2001 13:29:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:402 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277188AbRJVR3F>;
	Mon, 22 Oct 2001 13:29:05 -0400
Date: Mon, 22 Oct 2001 13:29:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
        BitKeeper Development Source <dev@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
In-Reply-To: <20011022101212.B24778@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0110221323050.4117-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Larry McVoy wrote:

> 		for (;;) {
> 			lstat(dir);
> 			while (e = readdir(..)) save(e->d_name);
> 			lstat(dir)
> 			if (dir size && dir mtime have NOT changed) break;
> 			cleanup the array and go start over
> 		}
> 		sort entries
> 		return sorted list
> 
> The basic idea being that we first of all narrow the race window and
> second of all detect the race in all cases where the mods to the dir
> result in either a changed mtime or a changed size.  So yes, that leaves
> us open to cases where the size didn't change but the contents did but
> I'll be ding danged if I can see a way around that.

There's none.  Notice that if you want a coherent view of directory,
you need something like the variant above anyway - even with FFS.  New
entry could've been added into slack in one of the entries you've
already seen.

