Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSL1Bm0>; Fri, 27 Dec 2002 20:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSL1Bm0>; Fri, 27 Dec 2002 20:42:26 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:3055 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S265361AbSL1Bm0>; Fri, 27 Dec 2002 20:42:26 -0500
Date: Fri, 27 Dec 2002 17:56:43 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E0D04DB.1000500@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212272140.gBRLeMW03698@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>- There's no analogue to pci_pool, and there's nothing like
>>   "kmalloc" (likely built from N dma-coherent pools). 
> 
> 
> I didn't want to build another memory pool re-implementation.  The mempool API 
> seems to me to be flexible enough for this, is there some reason it won't work?

I didn't notice any way it would track, and return, DMA addresses.
It's much like a kmem_cache in that way.


> I did consider wrappering mempool to make it easier, but I couldn't really 
> find a simplifying wrapper that wouldn't lose flexibility.

In My Ideal World (tm) Linux would have some kind of memory allocator
that'd be configured to use __get_free_pages() or dma_alloc_coherent()
as appropriate.  Fast, efficient; caching pre-initted objects; etc.

I'm not sure how realistic that is.  So long as APIs keep getting written
so that drivers _must_ re-invent the "memory allocator" wheel, it's not.

But ... if the generic DMA API includes such stuff, it'd be easy to replace
a dumb implementation (have you seen pci_pool, or how usb_buffer_alloc
works? :) with something more intelligent than any driver could justify
writing for its own use.

- Dave

