Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288882AbSANHZ2>; Mon, 14 Jan 2002 02:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288890AbSANHZP>; Mon, 14 Jan 2002 02:25:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64521 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288882AbSANHYj>;
	Mon, 14 Jan 2002 02:24:39 -0500
Date: Mon, 14 Jan 2002 08:24:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: blk_queue_bounce_limit
Message-ID: <20020114082435.G13929@suse.de>
In-Reply-To: <3C415FE2.24CB084B@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C415FE2.24CB084B@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13 2002, Manfred Spraul wrote:
> I think the selection of the ISA pool in blk_queue_bounce_limit is
> wrong:
> it switches to the ISA pool if the requested DMA address is equal to
> 16 MB. I think it must switch if the requested bounce limit is smaller
> than max_low_pfn.
> 
> <<<<<<<
> -	if (dma_addr == BLK_BOUNCE_ISA) {
> +	if (bounce_pfn < blk_max_low_pfn) {
> +		BUG_ON(dma_addr < BLK_BOUNCE_ISA);
>                 init_emergency_isa_pool();
>                 q->bounce_gfp = GFP_NOIO | GFP_DMA;
>         } else
>                 q->bounce_gfp = GFP_NOHIGHIO;
> <<<
> 
> Usually both lines are identical, except:
> - If only 16 MB are installed, then bouncing to ISA is never needed.
> - There could be broken devices that only support DMA to < 512 MB.
> For such a device no bounce it needed if less than 512 MB is installed,
> and if more is installed we must bounce to ISA. (since we don't have
> a 512MB zone).
> - Bouncing to less that 16 MB is not supported.

Yes it's a grey area, I'll add your patch.

-- 
Jens Axboe

