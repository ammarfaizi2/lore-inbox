Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284940AbRLUQvT>; Fri, 21 Dec 2001 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284942AbRLUQvK>; Fri, 21 Dec 2001 11:51:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64521 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284937AbRLUQvE>;
	Fri, 21 Dec 2001 11:51:04 -0500
Date: Fri, 21 Dec 2001 17:50:07 +0100
From: Jens Axboe <axboe@kernel.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance during disk writes
Message-ID: <20011221175007.A2929@suse.de>
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>, <20011220132729Z286241-18285+3296@vger.kernel.org>; <20011220094025.B2632@holomorphy.com> <3C222BB5.B2CCC11B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C222BB5.B2CCC11B@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2001, Andrew Morton wrote:
> --- linux-2.4.17-pre6/drivers/block/ll_rw_blk.c	Mon Nov  5 21:01:11 2001
> +++ linux-akpm/drivers/block/ll_rw_blk.c	Sat Dec  8 11:10:36 2001
> @@ -690,7 +690,8 @@ again:
>  	} else if (q->head_active && !q->plugged)
>  		head = head->next;
>  
> -	el_ret = elevator->elevator_merge_fn(q, &req, head, bh, rw,max_sectors);
> +	el_ret = elevator->elevator_merge_fn(q, &req, head, bh,
> +				rw, max_sectors, elevator->max_bomb_segments);

merge function can just grab max_bomb_segments ala

	int mbs = q->elevator.max_bomb_segments

so no need to modify the merge functions.

-- 
Jens Axboe

