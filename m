Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262050AbREPSs3>; Wed, 16 May 2001 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbREPSsU>; Wed, 16 May 2001 14:48:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20100 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262050AbREPSsG>;
	Wed, 16 May 2001 14:48:06 -0400
Date: Wed, 16 May 2001 14:48:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.LNX.4.21.0105161010200.4738-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105161434420.26191-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 May 2001, Linus Torvalds wrote:

> 
> On Wed, 16 May 2001, Alexander Viro wrote:
> >
> > 	Linus, patch is the first chunk of rootfs stuff. I've tried to
> > get it as small as possible - all it does is addition of absolute root
> > on ramfs and necessary changes to mount_root/change_root/sys_pivot_root
> > and follow_dotdot. Real root is mounted atop of the "absolute" one.
> 
> Looks ok, but it also feels like 2.5.x stuff to me. 

Umm... It might be, but
	* it makes fixing races in fs/super.c easier and we will need that
in 2.4 (or, at least, backported to 2.4 at some point)
	* it's backwards-compatible.
	* it allows to kill tons of the ugliness in rd.c in obviously
correct way, for values of obviously correct equal to "provably equivalent
behaviour to the old code"

I think that it's OK for 2.4, but then I'm obviously biased (mostly by
the fact that I know how much it allows to clean up without breaking any
compatibility, including binary compatibility in the kernel). Up to you,
indeed.
 
> Also, there's the question of whether to make ramfs just built-in, or make
> _tmpfs_ built in - ramfs is certainly simpler, but tmpfs does the same
> things and you need that one for shared mappings etc.
> 
> Comments?

Well, since all I actually use in the full variant of patch is sys_mknod(),
sys_chdir() and sys_mkdir()... IMO tmpfs is an overkill here. Maybe we
really need minimal rootfs in the kernel (no regular files) and let
ramfs, tmpfs, whatever-device-fs use it as a library.
								Al

