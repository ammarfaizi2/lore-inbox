Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBVHFK>; Thu, 22 Feb 2001 02:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbRBVHFA>; Thu, 22 Feb 2001 02:05:00 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:42998 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129232AbRBVHEn>; Thu, 22 Feb 2001 02:04:43 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102220703.f1M73pD21547@webber.adilger.net>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <3A948F54.EE00BC07@transmeta.com> from "H. Peter Anvin" at "Feb
 21, 2001 08:02:28 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Thu, 22 Feb 2001 00:03:51 -0700 (MST)
CC: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HPA writes:
> Daniel Phillips wrote:
> > I mentioned this earlier but it's worth repeating: the desire to use a
> > small block size is purely an artifact of the fact that ext2 has no
> > handling for tail block fragmentation.  That's a temporary situation -
> > once we've dealt with it your 2,000,000 file directory will be happier
> > with 4K filesystem blocks.  There will be a lot fewer metadata index
> > blocks in your directory file, for one thing.  Another practical matter
> > is that 4K filesystem blocks map directly to 4K PAGE_SIZE and are as a
> > result friendlier to the page cache and memory manager.
> > 
> 
> Well, that's something I really don't expect to see anymore -- this
> "purely temporary situation" is now already 7 years old at least.

Peter, you're barking up the wrong tree - Daniel has had an ext2 tail
merging patch around for 6 months or more...  However, from the sounds
of it, Linus may not want such a thing in ext2 (at least not until he
is convinced otherwise).  It will be interesting to compare ext2 +
ongoing patches vs. new filesystems like reiserfs, XFS, JFS --  not only
speed, but reliability as well.  XFS and JFS have previous implementations
to work with (although the JFS code is not the AIX JFS code), but reiserfs
has a long way to go, just from the standpoint of being run on millions
of machines, and being looked at by thousands of programmers.

I think people will be surprised at how ext2 + patches will continue to
improve.  One of the reasons (despite Linus' misgivings, IMHO) is that
ext2 is continually being improved by small measures, has lots of eyes
on the code, and it offers a stable base for each improvement - which
means each improvement is stable and reliable much quicker than if you
were to code a new filesystem from scratch for each new feature.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
