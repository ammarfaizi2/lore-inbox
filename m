Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273253AbRIRJbv>; Tue, 18 Sep 2001 05:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273257AbRIRJbm>; Tue, 18 Sep 2001 05:31:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40871 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273253AbRIRJb0>;
	Tue, 18 Sep 2001 05:31:26 -0400
Date: Tue, 18 Sep 2001 05:31:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109180527450.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Sep 2001, Linus Torvalds wrote:

> This also merges the blkdev in page cache patch, and that will hopefully
> make it noticeably easier to do the "do bread() with page cache too", at
> which point a lot of the current ugly synchronization issues will go away.

Umm...  Linus, had you actually read through the fs/block_device.c part
of that?  It's not just ugly as hell, it's (AFAICS) not hard to oops
if you have several inodes sharing major:minor.  ->bd_inode and its
treatment are bogus.  Please, read it through and consider reverting -
in its current state code is an ugly mess.

