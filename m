Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSKTHn5>; Wed, 20 Nov 2002 02:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbSKTHn5>; Wed, 20 Nov 2002 02:43:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50873 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265890AbSKTHn4>;
	Wed, 20 Nov 2002 02:43:56 -0500
Date: Wed, 20 Nov 2002 08:50:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: mc@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 74 potential buffer overruns in 2.5.33
Message-ID: <20021120075048.GG11884@suse.de>
References: <20021119234531.GA2723@Xenon.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119234531.GA2723@Xenon.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19 2002, Andy Chou wrote:
> Here are 74 out-of-bounds array accesses in Linux 2.5.33 found by the

Ewwww, why so old??

> [BUG] Seems bad.
> /home/acc/linux/2.5.33/drivers/block/ll_rw_blk.c:556:blk_dump_rq_flags: 
> ERROR:BUFFER:556:556:Array bounds error: rq_flags[12] indexed with [12]
> 
> 	printk("%s: dev %02x:%02x: ", msg, major(rq->rq_dev), 
> minor(rq->rq_dev));
> 	bit = 0;
> 	do {
> 		if (rq->flags & (1 << bit))
> 
> Error --->
> 			printk("%s ", rq_flags[bit]);
> 		bit++;
> 	} while (bit < __REQ_NR_BITS);

This was due to someone adding and removing __REQ_* flags and not
changing blk_dump_rq_flags(). 2.5.48 has no such bug anymore, I fixed
this up long ago.

-- 
Jens Axboe

