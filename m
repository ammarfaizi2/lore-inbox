Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137066AbREKHT2>; Fri, 11 May 2001 03:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137069AbREKHTT>; Fri, 11 May 2001 03:19:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7559 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S137066AbREKHTC>;
	Fri, 11 May 2001 03:19:02 -0400
Date: Fri, 11 May 2001 03:19:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: adilger@webber.adilger.int, phillips@bonn-fries.net,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <200105110710.f4B7ArA9001543@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0105110315480.5863-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 May 2001, Andreas Dilger wrote:
 
> I've tested again, now with kdb, and the system loops in ext2_find_entry()
> or ext2_add_link(), because there is a directory with a zero rec_len.
> While the actual cause of this problem is elsewhere, the fact that
> ext2_next_entry() will loop forever with a bad rec_len is a bug not in
> the old ext2 code.

No. Bug is that data ends up in pages without being validated. That's
the real thing to watch for - if ext2_get_page() is the only way to
get pages in cache you get all checks in one place and done once.

