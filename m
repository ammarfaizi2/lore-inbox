Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVILUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVILUXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVILUXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:23:35 -0400
Received: from palrel10.hp.com ([156.153.255.245]:46991 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932214AbVILUXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:23:33 -0400
Date: Mon, 12 Sep 2005 13:23:33 -0700
From: Grant Grundler <iod00d@hp.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
       Asit.K.Mallick@intel.com
Subject: Re: [patch 2.6.13] swiotlb: BUG() for DMA_NONE in sync_single
Message-ID: <20050912202333.GF21820@esmail.cup.hp.com>
References: <09122005104851.31056@bilbo.tuxdriver.com> <09122005104851.31120@bilbo.tuxdriver.com> <20050912185120.GD21820@esmail.cup.hp.com> <20050912195110.GC19644@tuxdriver.com> <20050912195356.GD19644@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912195356.GD19644@tuxdriver.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 03:53:56PM -0400, John W. Linville wrote:
> Call BUG() if DMA_NONE is passed-in as direction for sync_single.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Acked-by: Grant Grundler <iod00d@hp.com>

John,
Sorry - I didn't realize the tests for DMA_NONE I pointed
out were now redundant.  Can you respin this patch removing
the redundant checks for DMA_NONE as well?

thanks,
grant

> ---
> 
>  lib/swiotlb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -315,13 +315,13 @@ sync_single(struct device *hwdev, char *
>  	case SYNC_FOR_CPU:
>  		if (likely(dir == DMA_FROM_DEVICE || dma == DMA_BIDIRECTIONAL))
>  			memcpy(buffer, dma_addr, size);
> -		else if (dir != DMA_TO_DEVICE && dir != DMA_NONE)
> +		else if (dir != DMA_TO_DEVICE)
>  			BUG();
>  		break;
>  	case SYNC_FOR_DEVICE:
>  		if (likely(dir == DMA_TO_DEVICE || dma == DMA_BIDIRECTIONAL))
>  			memcpy(dma_addr, buffer, size);
> -		else if (dir != DMA_FROM_DEVICE && dir != DMA_NONE)
> +		else if (dir != DMA_FROM_DEVICE)
>  			BUG();
>  		break;
>  	default:
> -- 
> John W. Linville
> linville@tuxdriver.com
