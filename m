Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSAVBzk>; Mon, 21 Jan 2002 20:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSAVBz3>; Mon, 21 Jan 2002 20:55:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38788 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287798AbSAVBzT>;
	Mon, 21 Jan 2002 20:55:19 -0500
Date: Mon, 21 Jan 2002 20:55:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Linux 2.5.3-pre3
In-Reply-To: <Pine.LNX.4.33.0201211728170.1263-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201212044270.12228-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jan 2002, Linus Torvalds wrote:

> The inode thing has left umsdos broken, but Al promises to have that fixed
> soonish.

Umm...  Actually in -pre3 UMSDOS is still functional (and ->u.umsdos_inode_info
is still there).  I'll break it in the next series of patches ;-)

BTW, maintainers of filesystems are welcome to send patches.  Stuff in
ftp.math.psu.edu/pub/viro/MA* should be enough to figure it out - everything
is fairly straightforward.

Two notes:
*	unlike the ->u, private components of inode are _not_
zeroed out by VFS in the new scheme, so you need to do explicit
initialization in foo_read_inode()/foo_new_inode.
*	please, call the generic part 'vfs_inode'.  In this case it's
more than just being consistent - it avoids tons of false positives
in sanity checks (in general a structure with struct inode as a field
is bad news)

