Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135905AbRDZUMp>; Thu, 26 Apr 2001 16:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135907AbRDZUM0>; Thu, 26 Apr 2001 16:12:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135905AbRDZULy>; Thu, 26 Apr 2001 16:11:54 -0400
Date: Thu, 26 Apr 2001 22:06:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426220606.D819@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0104261455530.15385-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0104261510290.15385-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0104261510290.15385-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 26, 2001 at 03:17:54PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 03:17:54PM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 26 Apr 2001, I wrote:
> 
> > On Thu, 26 Apr 2001, Linus Torvalds wrote:
> >  
> > > I see the race, but I don't see how you can actually trigger it.
> > > 
> > > Exactly _who_ does the "read from device" part? Somebody doing a
> > > "fsck" while the filesystem is mounted read-write and actively written
> > > to? Yeah, you'd get disk corruption that way, but you'll get it regardless
> > > of this bug.
> 
> OK, I think I've a better explanation now:
> 
> Suppose /dev/hda1 is owned by root.disks and permissions are 640.
> It is mounted read-write.
> 
> Process foo belongs to pfy.staff. PFY is included into disks, but doesn't
> have root. I claim that he should be unable to cause fs corruption on
> /dev/hda1.
> 
> Currently foo _can_ cause such corruption, even though it has nothing
> resembling write permissions for device in question.
> 
> IMO it is wrong. I'm not saying that it's a real security problem. I'm
> not saying that PFY is not idiot or that his actions make any sense.
> However, I think that situation when he can do that without write
> access to device is just plain wrong.
> 
> Does the above make sense?

Sure. And as said `dump` has the same issues.

Andrea
