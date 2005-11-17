Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVKQJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVKQJCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVKQJC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:02:29 -0500
Received: from [85.8.13.51] ([85.8.13.51]:3229 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750705AbVKQJC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:02:29 -0500
Message-ID: <437C4728.9060205@drzeus.cx>
Date: Thu, 17 Nov 2005 10:02:32 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de>
In-Reply-To: <20051117085432.GY7787@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Nov 17 2005, Pierre Ossman wrote:
>   
>> I'm writing a PCI driver for the first time and I'm trying to wrap my
>> head around the DMA mappings in that world. I've done a ISA driver which
>> uses DMA, but this is a bit more complex and the documentation doesn't
>> explain everything.
>>
>> What I'm particularly confused about is how the IOMMU should be handled
>> with regard to scatterlist limits. My hardware cannot handle
>> scatterlists, only a single DMA address. But from what I understand the
>>     
>
> What kind of hardware can't handle scatter gather?
>
>   

I'd figure most hardware? DMA is handled by writing the start address
into one register and a size into another. Being able to set several
addr/len pairs seems highly advanced to me. :)

>> IOMMU can be very similar to a normal "CPU" MMU. So it should be able to
>> aggregate pages that are non-continuous in physical memory into one
>> single block in bus memory. Now the question is what do I set
>> nr_phys_segments and nr_hw_segments to? Of course the code also needs to
>> handle systems without an IOMMU.
>>     
>
> nr_hw_segments is how many segments your driver will see once dma
> mapping is complete (and the IOMMU has done its tricks), so you want to
> set that to 1 if the hardware can't handle an sg list.
>
>   

And nr_phys_segments? I haven't really grasped the relation between the
two. Is this the number of segments handed to the IOMMU? If so, then I
would need to know how many it can handle (and set it to one if there is
no IOMMU).

> That'll work irregardless of whether there's an IOMMU there or not. Note
> that the mere existence of an IOMMU will _not_ save your performance on
> this hardware, you need one with good virtual merging support to get
> larger transfers.
>
>   

I thought the IOMMU could do the merging through its mapping tables? The
way I understood it, sg support in the device was just to avoid wasting
resources on the IOMMU by using fewer mappings (which would assume the
IOMMU is segment based, not page based).

Rgds
Pierre
