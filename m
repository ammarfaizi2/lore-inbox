Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRE3MJG>; Wed, 30 May 2001 08:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbRE3MI4>; Wed, 30 May 2001 08:08:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8209 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262747AbRE3MIv>;
	Wed, 30 May 2001 08:08:51 -0400
Date: Wed, 30 May 2001 14:08:49 +0200
From: Jens Axboe <axboe@kernel.org>
To: Mark Hemment <markhe@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ll_rw_blk.c and high memory
Message-ID: <20010530140849.A17136@suse.de>
In-Reply-To: <Pine.LNX.4.21.0105301233390.7153-100000@alloc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301233390.7153-100000@alloc>; from markhe@veritas.com on Wed, May 30, 2001 at 12:47:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Mark Hemment wrote:
> Hi Jens, all,
> 
>   In drivers/block/ll_rw_blk.c:blk_dev_init(), the high and low queued
> sectors are calculated from the total number of free pages in all memory
> zones.  Shouldn't this calculation be passed upon the number of pages upon
> which I/O can be done directly (ie. without bounce pages)?

Yes it should

>   On a box with gigabytes of memory, high_queued_sectors becomes larger
> than the amount of memory upon which block I/O can be directly done - the
> test in ll_rw_block() against high_queued_sectors is then never true.  The
> throttling of submitting I/O happens much earlier in the stack - at
> the allocation of a bounce page.  This doesn't seem right.

It's not, I've known this for some time. With some queues doing highmem
I/O though, it becomes less easy to do it. But I'll just change it to
look at the number of low mem pages available. I doubt it would matter
much, the throttling is mainly meant for machines short on memory. For
machines with lots of RAM, the throttling will probably never be
activated anyway.

-- 
Jens Axboe

