Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269595AbRHGAeS>; Mon, 6 Aug 2001 20:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269601AbRHGAeH>; Mon, 6 Aug 2001 20:34:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:762 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269595AbRHGAdy>;
	Mon, 6 Aug 2001 20:33:54 -0400
Date: Mon, 6 Aug 2001 20:34:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108062350.f76NokT26152@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108062033190.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Richard Gooch wrote:

> This patch has the following ugly construct:
> 
> > +	/*  Ensure table size is enough  */
> > +	while (fs_info.num_inodes >= fs_info.table_size) {
> 
> Putting the allocation inside a while loop is horrible, and isn't a

Why, exactly? I can show you quite a few places where we do exactly that
(allocate and if somebody else had done it before us - free and repeat).
Pretty common for situations when we want low-contention spinlocks
to protect actual reassignment of buffer (in this case BKL acts as such).

> perfect solution anyway. I'm fixing this (and other races) with proper
> locking. If you went to the trouble to start patching, why at least
> didn't you do it cleanly with a lock?

Because it means adding a per-superblock lock for no good reason.
 
> Furthermore, the patch makes gratuitous formatting changes (which made
> it harder to see what it actually *changed*).

_Gratitious_?  You want your style (which, BTW, flies in the face of
Documentation/CodingStyle) - you do it in some vaguely reasonable time.
Excuse me, but I might be inclined to follow your style half a year
ago.  By now, IMO, you've lost any grounds for complaining.  There is a
bunch of holes.  Holes that need fixing.  If you "have other priorities"
for that long - expect other folks to start fixing them without any
respect to your opinion on style.

/me is sorely tempted to say "screw it" and just do fork'n'rewrite...

PS: ObYourPropertyManager: karmic retribution?

