Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312443AbSCaVDx>; Sun, 31 Mar 2002 16:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312461AbSCaVDn>; Sun, 31 Mar 2002 16:03:43 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23977 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312443AbSCaVDd>; Sun, 31 Mar 2002 16:03:33 -0500
Date: Sun, 31 Mar 2002 14:03:30 -0700
Message-Id: <200203312103.g2VL3Ub17836@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking changes in 2.5.7
In-Reply-To: <Pine.GSO.4.21.0203311551590.6721-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> On Sun, 31 Mar 2002, Richard Gooch wrote:
> 
> >   Hi, Al. I've noticed that you've made changes to the locking rules
> > for the VFS (for example, the inode lookup() method no longer has the
> > BKL).
> > 
> > I also note that you've thrown calls to lock_kernel() and
> > unlock_kernel() into the devfs code. Did you check each place you
> > added the BKL to devfs that it was needed, or was this just a blind
> > global operation? At first glance, it appears that many of the places
> > where the BKL was inserted are not needed.
> 
> See Documentation/filesystems/porting

Ah. Useful.

> BKL had been shifted inside several methods, so that filesystem code
> itself had the same locking as it used to (i.e. code that used to be
> under BKL stayed under it).  If your code doesn't need BKL - feel
> free to shrink the area, but keep in mind that it used to be under
> BKL.

OK, that's what I figured. Thanks for the confirmation.

> I didn't _add_ BKL - neither in devfs nor anywhere else.  lock_kernel() is
> the boundary of the protected area and all that had happened is that this
> area had slightly shrunken, so its boundaries are inside the method instead
> of being around its caller.
> 
> Again, further shrinking is up to maintainers of the filesystems.

Fair enough. I'll start looking at that.

> While we are at it, the changes in question had happened quite a
> couple of months ago - none of them in 2.5.7...

Well, 2.5.7 is the first I've checked in a while: I've been mostly
focussed on 2.4.x recently.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
