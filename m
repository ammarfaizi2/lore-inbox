Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVELGiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVELGiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVELGiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:38:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261179AbVELGiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:38:02 -0400
Date: Thu, 12 May 2005 08:37:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reducing max segments expected to work?
Message-ID: <20050512063757.GK23463@suse.de>
References: <20050511214749.GA14072@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511214749.GA14072@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2005, Benjamin LaHaise wrote:
> Hello Jens et al,
> 
> Is reducing the max number of segments in the block layer supposed to 
> work (as done in the patch below), or should i be sticking to mucking 
> with MAX_PHYS_SEGMENTS?  I seem to get a kernel thatt cannot boot with 
> the below patch applied, and was wondering if you're aware of any 
> problems in this area.  I'll probably post something more detailed 
> tomorrow after trying a few things.
> 
> 		-ben
> -- 
> "Time is what keeps everything from happening all at once." -- John Wheeler
> 
> 
> diff -purN v2.6.12-rc4/include/linux/blkdev.h test-rc4/include/linux/blkdev.h
> --- v2.6.12-rc4/include/linux/blkdev.h	2005-04-28 11:02:01.000000000 -0400
> +++ test-rc4/include/linux/blkdev.h	2005-05-11 17:06:10.000000000 -0400
> @@ -667,8 +667,8 @@ extern long blk_congestion_wait(int rw, 
>  extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
>  extern int blkdev_issue_flush(struct block_device *, sector_t *);
>  
> -#define MAX_PHYS_SEGMENTS 128
> -#define MAX_HW_SEGMENTS 128
> +#define MAX_PHYS_SEGMENTS 32
> +#define MAX_HW_SEGMENTS 32
>  #define MAX_SECTORS 255

This doesn't really do what you would think it does - the defines should
be called DEFAULT_PHYS_SEGMENTS etc, since they are just default values
and do not denote any max-allowed-by-driver value.

But it is strange why your system wont boot after applying the above.
What happens (and what kind of storage)?

-- 
Jens Axboe

