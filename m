Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135386AbQLOAqI>; Thu, 14 Dec 2000 19:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135439AbQLOAp6>; Thu, 14 Dec 2000 19:45:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29643 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135386AbQLOApv>;
	Thu, 14 Dec 2000 19:45:51 -0500
Date: Thu, 14 Dec 2000 19:15:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: LA Walsh <law@sgi.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>
Message-ID: <Pine.GSO.4.21.0012141900140.10441-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, LA Walsh wrote:

> So I ran into a snag with that scenario.  Let's suppose we have
> a module developer or a company developing a driver in their own
> /home/nvidia/video/drivers/newcard directory.  Now they need to include
> kernel
> development files and are used to just doing the:
> #include <linux/blahblah.h>
> 
> Which works because in a normal compile environment they have /usr/include
> in their include path and /usr/include/linux points to the directory
> under /usr/src/linux/include.

Huh?
% ls -ld /usr/include/linux
drwxr-xr-x    6 root     root        18432 Sep  2 22:35 /usr/include/linux/

> So if we create a separate /usr/src/linux/include/kernel dir, does that
> imply that we'll have a 2nd link:

What 2nd link? There should be _no_ links from /usr/include to the
kernel tree. Period. Case closed.

Stuff in /usr/include is private libc copy extracted from some kernel
version. Which may have _nothing_ to the kernel you are developing for.

In the situation above they should have -I<wherever_the_tree_lives>/include
in CFLAGS. Always had to. No links, no pain in ass, no interference with
userland compiles.

IOW, let them fix their Makefiles.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
