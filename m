Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUK2ToZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUK2ToZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUK2Tnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:43:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30345 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261772AbUK2TjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:39:25 -0500
Date: Mon, 29 Nov 2004 20:36:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] noop-iosched.c: make some functions static
Message-ID: <20041129193615.GE11102@suse.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org> <20041129123135.GM9722@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129123135.GM9722@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29 2004, Adrian Bunk wrote:
> The patch below makes some needlessly global functions static.
> 
> 
> diffstat output:
>  drivers/block/noop-iosched.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Jens Axboe <axboe@suse.de>

> --- linux-2.6.10-rc1-mm3-full/drivers/block/noop-iosched.c.old	2004-11-06 20:10:24.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/block/noop-iosched.c	2004-11-06 20:11:23.000000000 +0100
> @@ -17,7 +17,7 @@
>  /*
>   * See if we can find a request that this buffer can be coalesced with.
>   */
> -int elevator_noop_merge(request_queue_t *q, struct request **req,
> +static int elevator_noop_merge(request_queue_t *q, struct request **req,
>  			struct bio *bio)
>  {
>  	struct list_head *entry = &q->queue_head;
> @@ -50,13 +50,13 @@
>  	return ELEVATOR_NO_MERGE;
>  }
>  
> -void elevator_noop_merge_requests(request_queue_t *q, struct request *req,
> +static void elevator_noop_merge_requests(request_queue_t *q, struct request *req,
>  				  struct request *next)
>  {
>  	list_del_init(&next->queuelist);
>  }
>  
> -void elevator_noop_add_request(request_queue_t *q, struct request *rq,
> +static void elevator_noop_add_request(request_queue_t *q, struct request *rq,
>  			       int where)
>  {
>  	struct list_head *insert = q->queue_head.prev;
> @@ -75,7 +75,7 @@
>  		q->last_merge = rq;
>  }
>  
> -struct request *elevator_noop_next_request(request_queue_t *q)
> +static struct request *elevator_noop_next_request(request_queue_t *q)
>  {
>  	if (!list_empty(&q->queue_head))
>  		return list_entry_rq(q->queue_head.next);
> @@ -94,12 +94,12 @@
>  	.elevator_owner = THIS_MODULE,
>  };
>  
> -int noop_init(void)
> +static int noop_init(void)
>  {
>  	return elv_register(&elevator_noop);
>  }
>  
> -void noop_exit(void)
> +static void noop_exit(void)
>  {
>  	elv_unregister(&elevator_noop);
>  }
> 
> 

-- 
Jens Axboe

