Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137072AbREKHHe>; Fri, 11 May 2001 03:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137068AbREKHH0>; Fri, 11 May 2001 03:07:26 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S137073AbREKHG5>;
	Fri, 11 May 2001 03:06:57 -0400
Date: Mon, 7 May 2001 18:42:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Chris Wedgwood <cw@f00f.org>, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010507184224.A32@(none)>
In-Reply-To: <20010506153218.A11911@tapu.f00f.org> <Pine.GSO.4.21.0105052338580.26799-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0105052338580.26799-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, May 05, 2001 at 11:59:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gHi!

> >     It's not exactly "kernel-based fsck". What I've been talking about
> >     is secondary filesystem providing coherent access to primary fs
> >     metadata.  I.e. mount -t ext2meta -o master=/usr none /mnt and
> >     then access through /mnt/super, /mnt/block_bitmap, etc.
> > 
> > Call me stupid --- but what exactly does the above actually achieve?
> > Why would you do this?
> 
> Coherent access to metadata? Well, for one thing, it allows stuff like
> tunefs and friends on mounted fs. What's more useful, it allows to
> do things like access to boot code, which is _not_ safe to do through
> device access - usually you have superblock in vicinity and no warranties
> about the things that will be overwritten on umount. Same for debugging
> stuff, IO stats, etc. - access through secondary tree is much saner
> than inventing tons of ioctls for dealing with that. Moreover, it allows
> fsck and friends to get rid of code duplication - while the repair
> logics, etc. stays in userland (where it belongs) layout information
> is already handled in the kernel. No need to duplicate it in userland...

OTOH with current way if you make mistake in kernel, fsck will not
automatically inherit it; therefore fsck is likely to work even if
kernel ext2 is b0rken [and that's fairly important]

> Besides, with moving bitmaps, etc. into pagecache it becomes trivial
> to implement.
> 
> BTW, we have another ugly chunk of code - duplicated between kernel
> and userland and nasty in both incarnations. I mean handling of the
> partition tables. Kernel should be able to read and parse them -
> otherwise they are useless, right? Now, we have a bunch of userland

No. You might want to see (via fdisk) partition table, even through
*your* kernel can not read it.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

