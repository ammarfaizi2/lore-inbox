Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135213AbREESOm>; Sat, 5 May 2001 14:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbREESOc>; Sat, 5 May 2001 14:14:32 -0400
Received: from [136.159.55.21] ([136.159.55.21]:6024 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S135213AbREESOT>; Sat, 5 May 2001 14:14:19 -0400
Date: Sat, 5 May 2001 12:12:58 -0600
Message-Id: <200105051812.f45ICwd12489@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105051352.PAA14913@cave.bitwizard.nl>
In-Reply-To: <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca>
	<200105051352.PAA14913@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:
> Richard Gooch wrote:
> > 
> > - next boot, init(8) checks the file, and if it exists, opens the root
> >   FS block device and reads in each block listed in the file. The
> >   effect is to warm the buffer cache extremely quickly. The head will
> >   move in one direction, grabbing data as it flys by. I expect this
> >   will take around 1 second
> 
> FYI: 
> 
> Around 1992 or 1993, I rewrote Minix-fsck to do this instead of
> seeking all over the place.
> 
> Cut the total time to fsck my filesystem from around 30 to 28
> seconds. (remember the days of small filesystems?)
> 
> That's when I decided that this was NOT an interesting project: there
> was very little to be gained.
> 
> The explanation is: A seek over a few tracks isn't much slower than a
> seek over hundreds of tracks. Almost any "skip" in linear access
> incurs the average 6ms rotational latency anyway.

Hm. I think the access patterns between boot-up and fsck are quite
different. An fsck has to seek to a large number of tracks. During
bootup, I think the number of tracks accessed is much lower, and there
is probably more data locality as well. Still, only one way to be
sure.

I haven't had time to look closely at this, but one thing that bothers
me is how to find out what is being accessed in the first place. A
C-library wrapper to intercept read(2) calls isn't any good, because a
lot of stuff is memory-mapped (in particular shared libraries). Anyone
have a clean way to do this?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
