Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270168AbRHGKVQ>; Tue, 7 Aug 2001 06:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270173AbRHGKVF>; Tue, 7 Aug 2001 06:21:05 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:64201 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270168AbRHGKU5>; Tue, 7 Aug 2001 06:20:57 -0400
Date: Tue, 7 Aug 2001 11:21:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070517.f775HEw30547@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.SOL.3.96.1010807111835.6737A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Richard Gooch wrote:
> Alexander Viro writes:
> > On Mon, 6 Aug 2001, Richard Gooch wrote:
> > For local-domain socket you get _two_ kinds of inodes, both with
> > S_IFSOCK in ->i_mode: one on the filesystem (acting like an meeting
> > place) and another - bearing the actual socket and used for all IO.
> > 
> > In other words, the only kind you can get from mknod(2) never uses
> > ->i_socket. It's used only by bind() and connect() - and only as
> > a place in namespace. The only thing we ever look at is ownership
> > and permissions - they determine who can bind()/connect() here.
> > 
> > So ->u.generic_ip is safe.
> 
> Great! That table is toast! All I need is a spinlock-protected
> incrementing counter :-)

If you are introducing a spinlock for the sole purpose of protecting
a counter, I would suggest to drop the spinlock, make the counter an 
atomic_t and just use atomic operations on it. That should be both faster
and generate shorter code.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

