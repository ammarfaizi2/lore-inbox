Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbRGJRxQ>; Tue, 10 Jul 2001 13:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbRGJRxG>; Tue, 10 Jul 2001 13:53:06 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:56052 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267008AbRGJRwy>; Tue, 10 Jul 2001 13:52:54 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107101752.f6AHqXUu022141@webber.adilger.int>
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> "from Mike Black at Jul
 10, 2001 05:47:12 am"
To: Mike Black <mblack@csihq.com>
Date: Tue, 10 Jul 2001 11:52:31 -0600 (MDT)
CC: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black writes:
> I started testing 2.4.6 with ext3-2.4-0.9.1-246 yesterday morning and
> immediately hit a wall.
> 
> Testing on a an SMP kernel -- dual IDE RAID1 set the system temporarily
> locked up (telnet window stops until disk I/O is complete).
> Investigating this some I noticed that kswapd was taking a LOT of CPU time
> (althought there was only 10Meg in swap).  The swap files are located on the
> RAID1 IDE set.

Are you saying you have swap _files_ or is that a typo?  Not to say that this
is illegal or anything, but it sure is a waste of CPU/disk performance.  If
you are swapping to a file on a journaled filesystem, you have a huge amount
of unnecessary overhead.  Rather have a swap partition and avoid the fs
altogether.

It is also possible that there are still problems with the core kernel swap
code, and they are just more noticable when swapping on ext3.  What form of
journaling are you using?  Ordered, writeback, or full data journaling?

> Here's my RAID1/IDE benchmark with EXT3
> ..ooops...spoke too soon.
> The tiobench.pl locked up on 8 threads (after doing 1,2, & 4).  Had to do a
> ALT-SYSRQ-B as all windows were dead although I could get a login prompt.

I've CC'd this to ext2-devel, where the core ext3 developers are more likely
to see it.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
