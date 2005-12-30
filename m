Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVL3Srn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVL3Srn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVL3Srn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:47:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61767 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751280AbVL3Srm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:47:42 -0500
Date: Fri, 30 Dec 2005 12:45:48 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI DMA burst delay
In-reply-to: <397463649@web.de>
To: =?ISO-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43B5805C.3060307@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <397463649@web.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> By the way, there is another question coming up to my mind. The pci card is to be designed for a large size copying machine (i.e. it is something like a framegrabber device which has to write out data to a printer simultaneously) which leads to really high bandwidth. For now I allocate the dma buffer in ram (a ringbuffer) using pci_alloc_consistent(), which unfortunately delimits the size to about 4 MB. However, it would be convenient to be able to allocate a larger dma buffer, because then we would be able to perform some image processing algorithms directly inside this buffer via mmapping it to user space. Is there any way to achieve this quite simple without being forced to use scatter/gather dma (our hardware is not able to do this - at least until now)?

Unfortunately if you need a memory buffer that is physically contiguous 
to do DMA on, your choices are basically either pci_alloc_consistent, or 
possibly boot-time allocation of memory by telling the kernel to use 
less memory than is in the machine. Trying to allocate a big chunk of 
contiguous memory after the system has come up will not be very reliable 
since memory tends to become fragmented.

When dealing with this amount of data it really would be best to use 
some form of scatter-gather DMA. Even if the hardware is not capable of 
taking multiple addresses and doing the DMA on its own, you could sort 
of fake it and tell it to do multiple transfers, one for each block of 
memory - that might have some overhead though.
