Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSKDJdz>; Mon, 4 Nov 2002 04:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSKDJdz>; Mon, 4 Nov 2002 04:33:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261934AbSKDJdy>;
	Mon, 4 Nov 2002 04:33:54 -0500
Date: Mon, 4 Nov 2002 10:39:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021104093947.GE13587@suse.de>
References: <20021103220904.GE28704@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Linus Torvalds wrote:
> 	struct request *rq;
> 
> 	rq = blk_get_request(q, WRITE, __GFP_WAIT);
> 	rq->flags = REQ_BLOCK_PC;
> 	rq->data = NULL;
> 	rq->data_len = 0;
> 	rq->timeout = 5*HZ; /* Or whatever */
> 	memset(rq->cmd, 0, sizeof(rq->cmd));
> 	rq->cmd[0] = SYNCHRONIZE_CACHE;
> 	.. fill in whatever bytes the SYNCHRONIZE_CACHE cmd needs ..
> 	rq->cmd_len = 10;
> 	err = blk_do_rq(q, bdev, rq);
> 	blk_put_request(rq);

Warning, redundant blk_put_request().

I agree with Linus' example though. The queue is nice that way, for
completely synchronizing access to the device.

> and you're done. The above should work pretty much on all block drivers
> out there, btw: the ones that don't understand SCSI commands should just
> ignore requests that aren't the regular REQ_CMD commands.

Except ide drives?

-- 
Jens Axboe

