Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136091AbRDVM6H>; Sun, 22 Apr 2001 08:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136090AbRDVM5r>; Sun, 22 Apr 2001 08:57:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26382 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S136091AbRDVM5f>;
	Sun, 22 Apr 2001 08:57:35 -0400
Message-ID: <3AE2D53C.827DB3CE@linux-m68k.org>
Date: Sun, 22 Apr 2001 14:57:32 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Races in affs_unlink(), affs_rmdir() and affs_rename()
In-Reply-To: <Pine.GSO.4.21.0104220142150.27021-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alexander Viro wrote:

> > all and just show them as empty/readonly dirs. For 2.4 that's probably
> > safer, as it would require a lot of locking changes in vfs and the other
> > fs to support this properly, particularly moving most of the locking
> > from vfs into the fs.
> 
> And all that to support a misfeature present in one legacy filesystem?
> Don't forget that find et.al. are going to die on loops in directory
> tree, so you'd also need to change large chunk of userland code.

It's not the only reason, but right now I can't even offer it as a mount
option. On the other hand I could also export them as symlinks.
Anyway, the major reason I'd like to see it is, that it IMO could
simplify locking. All possible locks don't need to be taken in advance,
instead they can be taken when needed. Also unlink/rename of files/dirs
are no specially cases anymore (at least locking wise).
VFS would just operate on dentries and the fs works with the inodes.
With affs I tried to show how it could look on the fs side.

> By the way, how would you detect the attempts to detach a subtree by
> rmdir()/rename() with the multiple links on directories? Again, forget about
> the VFS side of that business, the question is how to check that
> required change doesn't make on-disk data structures inconsistent.

Do you have an example? At the affs side there is no big difference
between link to files or dirs.

bye, Roman
