Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270099AbRHGGrE>; Tue, 7 Aug 2001 02:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270107AbRHGGqy>; Tue, 7 Aug 2001 02:46:54 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15493 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270099AbRHGGqo>; Tue, 7 Aug 2001 02:46:44 -0400
Date: Tue, 7 Aug 2001 00:47:11 -0600
Message-Id: <200108070647.f776lB831865@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108070237070.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108070636.f776aWi31626@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108070237070.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Tue, 7 Aug 2001, Richard Gooch wrote:
> 
> > > Notice that here you have pointer to 'entry', so there is no problem
> > > with passing it. ->read_inode() simply goes away. Besides, that way
> > > you don't pollute icache hash chains - devfs inodes stay out of hash.
> > 
> > Um, what will happen to inode change events? What exactly is the
> > purpose of these hash chains?
> 
> iget() uses them to find inode by superblock and inode number.
> If you don't use iget()...

OK.

> I'm not sure what do you call an inode change event, though. Stuff
> like chmod() and friends?

Yes, that's what I meant.

> They call ->setattr() (devfs_notify_change(), in your case) and that
> has nothing to icache (you already have the inode). Or had I
> completely misparsed you?

You parsed correctly. I know ->setattr() is called. I just wanted to
make sure that the icache didn't have some subtle interaction I was
missing. Such as ->write_inode() not being called.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
