Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288871AbSANHGD>; Mon, 14 Jan 2002 02:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288850AbSANHFy>; Mon, 14 Jan 2002 02:05:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49161 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287984AbSANHFk>;
	Mon, 14 Jan 2002 02:05:40 -0500
Date: Mon, 14 Jan 2002 08:05:29 +0100
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.2-pre11/drivers/loop.c bio question
Message-ID: <20020114080529.D13929@suse.de>
In-Reply-To: <200201121631.IAA06475@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201121631.IAA06475@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12 2002, Adam J. Richter wrote:
> 	Has anyone out there tried to use linux-2.5.2-pre11/drivers/loop.c?
> In my hacked version of loop.c, do_bio_blockbacked is often
> called with a bio that has bio->bi_idx set to 1 rather than 0
> (and with bi->bi_vcnt == 1), so it thinks it has no transfers to do.
> When I add the kludge of doing "bio->bi_idx = 0;" at the beginning
> of the routine, then it works fine.

Must be some of your changes, end_that_request_last is the one that
increments the index and that is not called for loop requests.

> 	It is possible that my problem is self-inflicted because I
> am using a version that I have adopted the "initial value" patch to,
> and I also added a temporary hack to force the requests to be processed
> one sector at a time, like so:
> 
>         blk_queue_max_segment_size(BLK_DEFAULT_QUEUE(MAJOR_NR), 512);

Well that change has absolutely zero impact on loop, so you cannot
possibly see any changes from that. Besides, _if_ it would have an
effect you did not limit the segment size to 512 bytes -- there is no
splitting going on, so you would still receive up to 4k of data at the
time per segment.

-- 
Jens Axboe

