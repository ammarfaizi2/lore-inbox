Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273132AbRIJBpN>; Sun, 9 Sep 2001 21:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273149AbRIJBpD>; Sun, 9 Sep 2001 21:45:03 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:32197
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S273132AbRIJBoy>; Sun, 9 Sep 2001 21:44:54 -0400
Date: Sun, 09 Sep 2001 21:45:01 -0400
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1299510000.1000086297@tiny>
In-Reply-To: <20010910030405.A11329@athlon.random>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
 <Pine.LNX.4.33.0109091724120.22033-100000@penguin.transmeta.com>
 <20010910030405.A11329@athlon.random>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 10, 2001 03:04:05 AM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

> On Sun, Sep 09, 2001 at 05:38:14PM -0700, Linus Torvalds wrote:
>> It would definitely make all the issues with Andrea's pagecache code just
>> go away completely.
> 
> I also recommend to write it on top of the blkdev in pagecache patch
> since there I just implemented the "physical address space" abstraction,
> I had to write it to make the mknod hda and mknod hda.new to share the
> same cache transparently.
> 

Hi guys,

I some code on top of the writepage for all io patch (2.4.2 timeframe),
that implemented getblk_mapping, get_hash_table_mapping and bread_mapping,
which gave the same features as the original but took an address space as
one of the args.  

The idea is more or less what has been discussed, but it did assume one
blocksize per mapping.  Of course, set_blocksize and invalidate_buffers
were on the todo list ;-)  The only other gotcha was calling
filemap_fdatasync and truncate_inode_pages in put_super, to make sure
things got flushed right.

Anyway, the whole thing can be cut down to a smallish patch, either alone
or on top of andrea's stuff.  Daniel, if you want to work together on it,
I'm game.

-chris

