Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273133AbRIJBy5>; Sun, 9 Sep 2001 21:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273136AbRIJBys>; Sun, 9 Sep 2001 21:54:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:48753 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273133AbRIJByo>; Sun, 9 Sep 2001 21:54:44 -0400
Date: Mon, 10 Sep 2001 03:55:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010910035519.B11329@athlon.random>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org> <Pine.LNX.4.33.0109091724120.22033-100000@penguin.transmeta.com> <20010910030405.A11329@athlon.random> <1299510000.1000086297@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299510000.1000086297@tiny>; from mason@suse.com on Sun, Sep 09, 2001 at 09:45:01PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 09:45:01PM -0400, Chris Mason wrote:
> 
> 
> On Monday, September 10, 2001 03:04:05 AM +0200 Andrea Arcangeli
> <andrea@suse.de> wrote:
> 
> > On Sun, Sep 09, 2001 at 05:38:14PM -0700, Linus Torvalds wrote:
> >> It would definitely make all the issues with Andrea's pagecache code just
> >> go away completely.
> > 
> > I also recommend to write it on top of the blkdev in pagecache patch
> > since there I just implemented the "physical address space" abstraction,
> > I had to write it to make the mknod hda and mknod hda.new to share the
> > same cache transparently.
> > 
> 
> Hi guys,
> 
> I some code on top of the writepage for all io patch (2.4.2 timeframe),
> that implemented getblk_mapping, get_hash_table_mapping and bread_mapping,
> which gave the same features as the original but took an address space as
> one of the args.  
> 
> The idea is more or less what has been discussed, but it did assume one
> blocksize per mapping.  Of course, set_blocksize and invalidate_buffers

hmm, this sounds a bit odd, there must be only one "physical address
space", the whole point of the change is to have only one and to kill
all the aliasing issues this way. In turn also set_blocksize will be
nearly a noop and it won't matter anymore the granularity of the I/O,
there won't be alias allowed anymore because the backing store of the
cache (the "physical address space") will be shared by all the users
regardless of the blocksize.

getblk should unconditionally alloc a new bh entity and only care to map
it to the right cache backing store with a pagecache hash lookup.

Andrea
