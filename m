Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWCBK0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWCBK0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWCBK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:26:16 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:45189 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751107AbWCBK0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:26:15 -0500
Message-ID: <4406C845.8000603@drzeus.cx>
Date: Thu, 02 Mar 2006 11:26:13 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx> <20060301232913.GC4024@flint.arm.linux.org.uk> <44069E3A.4000907@drzeus.cx> <20060302094153.GA14017@flint.arm.linux.org.uk> <4406C044.4080201@drzeus.cx> <20060302100409.GB14017@flint.arm.linux.org.uk>
In-Reply-To: <20060302100409.GB14017@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Mar 02, 2006 at 10:52:04AM +0100, Pierre Ossman wrote:
>   
>> Russell King wrote:
>>     
>>> I think you're asking Jens that question - I know of no way to tell
>>> the block layer that clustering is fine for normal but not highmem.
>>>       
>> That wasn't what I meant. What I was referring to was disabling highmem
>> altogether, the way that is done now through looking at the dma mask.
>>     
>
> You need to set your struct device's dma_mask appropriately:
>
>         u64 limit = BLK_BOUNCE_HIGH;
>
>         if (host->dev->dma_mask && *host->dev->dma_mask)
>                 limit = *host->dev->dma_mask;
>
>         blk_queue_bounce_limit(mq->queue, limit);
>
> Hence, if dma_mask is a NULL pointer or zero, highmem will be bounced.
>   

This I know. My beef is the readability of:

if (do_dma)
    *dev->dma_mask = DEVICE_DMA_MASK;
else
    *dev->dma_mask = 0;

I.e. we use dma_mask even though we don't do DMA.

> Neither PNP nor your platform device sets dma_mask, so highmem will
> always be bounced in the case of wbsd - which from what you write above
> is what you require anyway.
>
>   

wbsd isn't the issue, sdhci is. PCI sets a 32-bit mask by default so I
end up with highmem pages even when I'm not doing DMA.

Rgds
Pierre

