Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWHAUMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWHAUMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWHAUMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:12:30 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:40113 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161017AbWHAUM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:12:29 -0400
Date: Tue, 1 Aug 2006 22:12:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ifdef blktrace debugging fields
Message-ID: <20060801201256.GE20108@suse.de>
References: <200608010657.k716vBWF004420@shell0.pdx.osdl.net> <20060801071658.GG31908@suse.de> <20060801002904.53407219.akpm@osdl.org> <20060801074436.GJ31908@suse.de> <20060801134703.GG7006@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801134703.GG7006@martell.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01 2006, Alexey Dobriyan wrote:
> On Tue, Aug 01, 2006 at 09:44:36AM +0200, Jens Axboe wrote:
> > Certainly. If Alexey adds the blkdev.h bit as well, we can go ahead with
> > it.
> 
> Done. Originally I looked at slab size of task_struct and still
> recovering.

;-)

> [PATCH] ifdef blktrace debugging fields
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  block/ll_rw_blk.c      |    4 ++--
>  include/linux/blkdev.h |    4 ++--
>  include/linux/sched.h  |    3 ++-
>  kernel/fork.c          |    2 ++
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> --- a/block/ll_rw_blk.c
> +++ b/block/ll_rw_blk.c
> @@ -1779,10 +1779,10 @@ static void blk_release_queue(struct kob
>  
>  	if (q->queue_tags)
>  		__blk_queue_free_tags(q);
> -
> +#ifdef CONFIG_BLK_DEV_IO_TRACE
>  	if (q->blk_trace)
>  		blk_trace_shutdown(q);
> -
> +#endif
>  	kmem_cache_free(requestq_cachep, q);
>  }

That can be made ifdef less, if you unconditionally call
blk_trace_shutdown() and just make that one do:

        if (q->blk_trace) {
                ...
        }

since that'll then do the right always. Please make that change, then
I'm fine with the patch.

-- 
Jens Axboe

