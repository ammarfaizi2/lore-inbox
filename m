Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137167AbREKQf7>; Fri, 11 May 2001 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137168AbREKQfk>; Fri, 11 May 2001 12:35:40 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:21243 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S137167AbREKQf3>; Fri, 11 May 2001 12:35:29 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105111634.f4BGY8l6015883@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <Pine.GSO.4.21.0105110315480.5863-100000@weyl.math.psu.edu>
 "from Alexander Viro at May 11, 2001 03:19:00 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 11 May 2001 10:34:08 -0600 (MDT)
CC: phillips@bonn-fries.net,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> On Fri, 11 May 2001, Andreas Dilger wrote:
> > I've tested again, now with kdb, and the system loops in ext2_find_entry()
> > or ext2_add_link(), because there is a directory with a zero rec_len.
> > While the actual cause of this problem is elsewhere, the fact that
> > ext2_next_entry() will loop forever with a bad rec_len is a bug not in
> > the old ext2 code.
> 
> No. Bug is that data ends up in pages without being validated. That's
> the real thing to watch for - if ext2_get_page() is the only way to
> get pages in cache you get all checks in one place and done once.

OK, I don't think that Daniel is aware of this, I wasn't either.  He
is using ext2_bread() modified to access the page cache instead of the
buffer cache.

It turns out that in adding the checks for rec_len, I fixed my original
bug, but added another...  Please disregard my previous patch.  

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
