Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312428AbSCaU7D>; Sun, 31 Mar 2002 15:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312443AbSCaU6x>; Sun, 31 Mar 2002 15:58:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46015 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312428AbSCaU6p>;
	Sun, 31 Mar 2002 15:58:45 -0500
Date: Sun, 31 Mar 2002 15:58:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking changes in 2.5.7
In-Reply-To: <200203312012.g2VKCom17088@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0203311551590.6721-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Mar 2002, Richard Gooch wrote:

>   Hi, Al. I've noticed that you've made changes to the locking rules
> for the VFS (for example, the inode lookup() method no longer has the
> BKL).
> 
> I also note that you've thrown calls to lock_kernel() and
> unlock_kernel() into the devfs code. Did you check each place you
> added the BKL to devfs that it was needed, or was this just a blind
> global operation? At first glance, it appears that many of the places
> where the BKL was inserted are not needed.

See Documentation/filesystems/porting

BKL had been shifted inside several methods, so that filesystem code itself
had the same locking as it used to (i.e. code that used to be under BKL
stayed under it).  If your code doesn't need BKL - feel free to shrink the
area, but keep in mind that it used to be under BKL.

I didn't _add_ BKL - neither in devfs nor anywhere else.  lock_kernel() is
the boundary of the protected area and all that had happened is that this
area had slightly shrunken, so its boundaries are inside the method instead
of being around its caller.

Again, further shrinking is up to maintainers of the filesystems.

While we are at it, the changes in question had happened quite a couple
of months ago - none of them in 2.5.7...

