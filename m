Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDEONj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDEONj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDEONj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 10:13:39 -0400
Received: from 64-44-36-66.user.uswo.net ([64.44.36.66]:2153 "EHLO
	mail.int.automatika.com") by vger.kernel.org with ESMTP
	id S1750760AbWDEONi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 10:13:38 -0400
Message-ID: <4433D058.80208@automatika.com>
Date: Wed, 05 Apr 2006 10:12:40 -0400
From: Kartik Babu <kbabu@automatika.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dma_alloc_coherent
References: <5XY8B-82x-1@gated-at.bofh.it> <44330535.2070803@shaw.ca>
In-Reply-To: <44330535.2070803@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a char device driver Im using to control the SPI port on the PXA255 
processor. I transfer fixed sized packets over this bus, and hence DMA 
is a good option instead of interrupt driven IO.

it seems that the dma_pool_create function explicitly handles both cases 
dev = NULL and dev != NULL.

However, the dma_alloc_coherent function only checks if dev is not NULL, 
and apparently uses the valu in one case without checking it.

My understanding is that the dev pointer is needed only to check the 
mask for accesible DMA locations correct?

Kartik

Robert Hancock wrote:
> Kartik Babu wrote:
>>  I'm trying to replace consistent_alloc in a driver that was written 
>> for the 2.4 kernel with dma_alloc_coherent. My question is that I do 
>> not use a struct device * pointer at all. Browsing through the source 
>> for the 2.6.12
>> on ARM XScale PXA255, I see that this argument may be NULL.
>>
>> Still, I'd like to know if passing NULL has any side effects. If so, 
>> what are they?
>>
>> I do however have a cdev structure taht I use for device 
>> registration, but I do not see how that would help.
>
> What kind of a device is it? If it's a PCI device, the struct device 
> can be accessed with the dev pointer inside the struct pci_dev.
>

