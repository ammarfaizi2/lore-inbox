Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935607AbWK1FVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935607AbWK1FVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 00:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935609AbWK1FVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 00:21:04 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:48703 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S935607AbWK1FVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 00:21:02 -0500
Date: Mon, 27 Nov 2006 23:19:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Reserving a fixed physical address page of RAM.
In-reply-to: <456BAEB0.5030800@vertical.com>
To: Jon Ringle <jringle@vertical.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <456BC6D4.9080109@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no>
 <456B8517.7040502@shaw.ca> <456BAEB0.5030800@vertical.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Ringle wrote:
> Robert Hancock wrote:
>> Jon Ringle wrote:
>>> Hi,
>>>
>>> I need to reserve a page of memory at a specific area of RAM that will
>>> be used as a "shared memory" with another processor over PCI. How can I
>>> ensure that the this area of RAM gets reseved so that the Linux's memory
>>> management (kmalloc() and friends) don't use it?
>>>
>>> Some things that I've considered are iotable_init() and ioremap().
>>> However, I've seen these used for memory mapped IO devices which are
>>> outside of the RAM memory. Can I use them for reseving RAM too?
>>>
>>> I appreciate any advice in this regard.
>>
>> Sounds to me like dma_alloc_coherent is what you want..
>>
> It looks promising, however, I need to reserve a physical address area 
> that is well known (so that the code running on the other processor 
> knows where in PCI memory to write to). It appears that 
> dma_alloc_coherent returns the address that it allocated. Instead I need 
> something where I can tell it what physical address and range I want to 
> use.

I don't think this is possible in the general case, as there's no 
mechanism for moving things out of the way if they might be in use. Your 
best solution is likely to use dma_alloc_coherent and pass the bus 
address returned into the other processor to tell it where to write..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


