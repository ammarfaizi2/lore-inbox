Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135463AbREIVZR>; Wed, 9 May 2001 17:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135580AbREIVZF>; Wed, 9 May 2001 17:25:05 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:64760 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135463AbREIVYf>; Wed, 9 May 2001 17:24:35 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105092122.f49LMAVL019186@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <01050701135600.07657@starship> "from Daniel Phillips at May 7,
 2001 01:16:27 am"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Wed, 9 May 2001 15:22:10 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, Albert Cranford <ac9410@bellsouth.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes [re index directories]:
> This is lightly tested and apparently stable.

I was looking at the new patch, and I saw something that puzzles me.
Why do you set the EXT2_INDEX_FL on a new (empty) directory, rather
than only setting it when the dx_root index is created?

Setting the flag earlier than that makes it mostly useless, since it
will be set on basically every directory.  Not setting it would also
make your is_dx() check simply a check for the EXT2_INDEX_FL bit (no
need to also check size).

Also no need to set EXT2_COMPAT_DIR_INDEX until such a time that we have
a (real) directory with an index, to avoid gratuitous incompatibility
with e2fsck.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
