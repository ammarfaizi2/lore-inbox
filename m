Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270071AbRHGFRJ>; Tue, 7 Aug 2001 01:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRHGFQ7>; Tue, 7 Aug 2001 01:16:59 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65156 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270071AbRHGFQu>; Tue, 7 Aug 2001 01:16:50 -0400
Date: Mon, 6 Aug 2001 23:17:14 -0600
Message-Id: <200108070517.f775HEw30547@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108062203170.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108070200.f77202G27928@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108062203170.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 6 Aug 2001, Richard Gooch wrote:
> 
> > Again, historical reasons. When I wrote devfs, the pipe data trampled
> > the inode->u.generic_ip pointer. So that's no good. I see that the
> > pipe data has been moved away. Good. Hm. But there's still the
> > inode->u.socket_i structure. I'd need to check where that gets
> > trampled.
> 
> It isn't. socket_i is used only in inodes allocated by sock_alloc().
> It is not used in the inodes that live on any fs other than sockfs.

OK. Although, where is sockfs?

> For local-domain socket you get _two_ kinds of inodes, both with
> S_IFSOCK in ->i_mode: one on the filesystem (acting like an meeting
> place) and another - bearing the actual socket and used for all IO.
> 
> In other words, the only kind you can get from mknod(2) never uses
> ->i_socket. It's used only by bind() and connect() - and only as
> a place in namespace. The only thing we ever look at is ownership
> and permissions - they determine who can bind()/connect() here.
> 
> So ->u.generic_ip is safe.

Great! That table is toast! All I need is a spinlock-protected
incrementing counter :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
