Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136106AbRDVNPk>; Sun, 22 Apr 2001 09:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136104AbRDVNPa>; Sun, 22 Apr 2001 09:15:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52726 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136102AbRDVNPP>;
	Sun, 22 Apr 2001 09:15:15 -0400
Date: Sun, 22 Apr 2001 09:15:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Races in affs_unlink(), affs_rmdir() and affs_rename()
In-Reply-To: <3AE2D53C.827DB3CE@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0104220907100.28681-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Apr 2001, Roman Zippel wrote:

> instead they can be taken when needed. Also unlink/rename of files/dirs
> are no specially cases anymore (at least locking wise).
> VFS would just operate on dentries and the fs works with the inodes.
> With affs I tried to show how it could look on the fs side.

I will believe it when I see it. So far the code is racy and I don't
see a way to fix the rmdir()/unlink() one without holding two locks at
once.

> > By the way, how would you detect the attempts to detach a subtree by
> > rmdir()/rename() with the multiple links on directories? Again, forget about
> > the VFS side of that business, the question is how to check that
> > required change doesn't make on-disk data structures inconsistent.
> 
> Do you have an example? At the affs side there is no big difference
> between link to files or dirs.

Loop creation:

/A/B and /C/D are links to the same directory. mv /A /C/D/A creates a loop.

Once you have a loop you either have it forever (all directories invloved
are non-empty) _or_ you have to check whether rmdir() is going to make
graph disconnected and I'd like to see how you do it.

