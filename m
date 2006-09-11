Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWIKXvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWIKXvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWIKXvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:51:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965165AbWIKXvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:51:15 -0400
Message-ID: <4505F670.9020605@garzik.org>
Date: Mon, 11 Sep 2006 19:51:12 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 12/19] dmaengine: dma_async_memcpy_err for DMA engines
 that do not support memcpy
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231838.4737.6812.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231838.4737.6812.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Default virtual function that returns an error if the user attempts a
> memcpy operation.  An XOR engine is an example of a DMA engine that does
> not support memcpy.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/dma/dmaengine.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index fe62237..33ad690 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -593,6 +593,18 @@ void dma_async_device_unregister(struct 
>  }
>  
>  /**
> + * dma_async_do_memcpy_err - default function for dma devices that
> + *	do not support memcpy
> + */
> +dma_cookie_t dma_async_do_memcpy_err(struct dma_chan *chan,
> +		union dmaengine_addr dest, unsigned int dest_off,
> +		union dmaengine_addr src, unsigned int src_off,
> +                size_t len, unsigned long flags)
> +{
> +	return -ENXIO;
> +}

Further illustration of how this API growth is going wrong.  You should 
create an API such that it is impossible for an XOR transform to ever 
call non-XOR-transform hooks.

	Jeff



