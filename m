Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274042AbRISMyX>; Wed, 19 Sep 2001 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274043AbRISMyN>; Wed, 19 Sep 2001 08:54:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26205 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274042AbRISMxz>; Wed, 19 Sep 2001 08:53:55 -0400
Date: Wed, 19 Sep 2001 14:54:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre11aa1
Message-ID: <20010919145417.R720@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0109190420510.28824-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0109190800590.28824-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109190800590.28824-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Sep 19, 2001 at 08:07:30AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:07:30AM -0400, Alexander Viro wrote:
> BTW, what's to stop shrink_cache() from picking a page out of ramdisk
> pagecache and calling ->writepage() on it?  The thing will immediately

it's the same trick that ramfs uses also, so it is the right way as far
as ramfs isn't broken too (and quite frankly these days ramfs is much
more important than ramdisk given our heavy use of logical caches).

> If you get a lot of stuff in ramdisks, things can get rather insteresting...

under heavy memory pressure possibly, that applies to ramfs also as said
above. Anyways this was a clean approch and the new vm make sure not to
get confused by writepage marking the page dirty again, the worst thing
that can happen is some cpu cycle wasted, _but_ we save cpu cycles in
not having special checks  when ramfs isn't in use and the fact there are no
special cases also make the code cleaner.

Now, I'm fine to add special cases if this sort out to be too much cpu
wasted [check how much shrink_cache show up on the profiling to be sure]
(of course not just for ramdisk that isn't very important, but for ramfs
too which is much more critical to be very efficient).

Andrea
