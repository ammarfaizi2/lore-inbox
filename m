Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLRMUF>; Mon, 18 Dec 2000 07:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQLRMTz>; Mon, 18 Dec 2000 07:19:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7357 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129325AbQLRMTq>;
	Mon, 18 Dec 2000 07:19:46 -0500
Date: Mon, 18 Dec 2000 06:49:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: trond.myklebust@fys.uio.no, "M.H.VanLeeuwen" <vanl@megsinet.net>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167! -
 reproducible
In-Reply-To: <14909.62565.397454.950907@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0012180631290.22952-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2000, Neil Brown wrote:

> On Monday December 18, trond.myklebust@fys.uio.no wrote:
> > >>>>> " " == M H VanLeeuwen <vanl@megsinet.net> writes:
> > 
> >      > Trond, Neil I don't know if this is a loopback bug or an NFS
> >      > bug but since nfs_fs.h was implicated so I thought one of you
> >      > may be interested.
> >  
> >      > Could you let me know if you know this problem has already been
> >      > fixed or if you need more info.
> > 
> > Hi,
> >  
> > As far as I'm concerned, it's a loopback bug.
> 
> I read it the same way.
> Actually, I cannot see the point of copying the "struct file"!  Why
> not just take a reference to it?  The comment tries to justify it, but
> I don't buy it.

Wish I remembered who had complained when I proposed to kill that copying...
It was introduced back in 2.1.110 and back then comment looked so:

+               /* Backed by a regular file - we need to hold onto
+                  a file structure for this file.  We'll use it to
+                  write to blocks that are not already present in
+                  a sparse file.  We create a new file structure
+                  based on the one passed to us via 'arg'.  This is
+                  to avoid changing the file structure that the
+                  caller is using */
+

I would be happy to get rid of that crap - it was the only reason why I
had to add the sodding file_moveto() and world would be better without it.
If we can kill it off - let's do it and let's take fs/file_table:file_moveto()
along.

IOW, I also think that copying the struct file is wrong. IIRC, complaints were
bogus - losetup requires enough priviliges to make worrying about security
implications somewhat pointless.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
