Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269490AbRHGWON>; Tue, 7 Aug 2001 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269481AbRHGWOE>; Tue, 7 Aug 2001 18:14:04 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33159 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269490AbRHGWN4>; Tue, 7 Aug 2001 18:13:56 -0400
Date: Tue, 7 Aug 2001 16:13:59 -0600
Message-Id: <200108072213.f77MDxR09844@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108071457010.18565-100000@weyl.math.psu.edu>
In-Reply-To: <200108071855.f77Itl207144@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108071457010.18565-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Tue, 7 Aug 2001, Richard Gooch wrote:
> 
> > Hm. strace suggests my pwd is walking up the path. But WTF would it
> > break? 2.4.7 was fine. What did I break?
> 
> Walking the path works so:
> 
> open ..
> read it, entry by entry
> find an entry that would have inode number equal to that of our directory.
> We had found the last component of our name. Lather, rinse, repeat.

Yes, I know the algorithm.

> It relies on numbers from stat() and numbers from readdir() being
> in sync.  It's not true on so many filesystems that this algorithm
> is laughable.  Anything with synthetic inode numbers breaks it.

Sure, but devfs does keep inums in sync. So it shouldn't be an issue.

[From another reply]
> So fix getcwd(3) in libc5.

Well, I might just do that one day. But I've got some devfs races to
fix first :-)

> Or use your ->dentry in devfs_readdir() - then you can get the
> consistency you want for existing inodes and that will allow b0rken
> getcwd() to work.

Yes, devfs_readdir() already uses de->inode.ino. Anyway, when I get
back to that machine I'll be able to dig further.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
