Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268977AbRHGGko>; Tue, 7 Aug 2001 02:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269418AbRHGGke>; Tue, 7 Aug 2001 02:40:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42450 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268977AbRHGGkU>;
	Tue, 7 Aug 2001 02:40:20 -0400
Date: Tue, 7 Aug 2001 02:40:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070636.f776aWi31626@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108070237070.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Richard Gooch wrote:

> > Notice that here you have pointer to 'entry', so there is no problem
> > with passing it. ->read_inode() simply goes away. Besides, that way
> > you don't pollute icache hash chains - devfs inodes stay out of hash.
> 
> Um, what will happen to inode change events? What exactly is the
> purpose of these hash chains?

iget() uses them to find inode by superblock and inode number.
If you don't use iget()...

I'm not sure what do you call an inode change event, though. Stuff
like chmod() and friends? They call ->setattr() (devfs_notify_change(),
in your case) and that has nothing to icache (you already have the
inode). Or had I completely misparsed you?

