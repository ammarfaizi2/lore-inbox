Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264210AbSKDJoL>; Mon, 4 Nov 2002 04:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265988AbSKDJoL>; Mon, 4 Nov 2002 04:44:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27036 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264210AbSKDJoK>;
	Mon, 4 Nov 2002 04:44:10 -0500
Date: Mon, 4 Nov 2002 10:50:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021104095030.GA26266@suse.de>
References: <20021103220904.GE28704@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com> <20021104093947.GE13587@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104093947.GE13587@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04 2002, Jens Axboe wrote:
> On Sun, Nov 03 2002, Linus Torvalds wrote:
> > 	struct request *rq;
> > 
> > 	rq = blk_get_request(q, WRITE, __GFP_WAIT);
> > 	rq->flags = REQ_BLOCK_PC;
> > 	rq->data = NULL;
> > 	rq->data_len = 0;
> > 	rq->timeout = 5*HZ; /* Or whatever */
> > 	memset(rq->cmd, 0, sizeof(rq->cmd));
> > 	rq->cmd[0] = SYNCHRONIZE_CACHE;
> > 	.. fill in whatever bytes the SYNCHRONIZE_CACHE cmd needs ..
> > 	rq->cmd_len = 10;
> > 	err = blk_do_rq(q, bdev, rq);
> > 	blk_put_request(rq);
> 
> Warning, redundant blk_put_request().

Sorry no, I fixed that so the example is fine!

-- 
Jens Axboe

