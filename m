Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSLaX3p>; Tue, 31 Dec 2002 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSLaX3p>; Tue, 31 Dec 2002 18:29:45 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:50653 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264920AbSLaX3n>; Tue, 31 Dec 2002 18:29:43 -0500
Date: Tue, 31 Dec 2002 15:44:21 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: Andrew Morton <akpm@digeo.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Message-id: <3E122BD5.6020400@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212312202.OAA10841@adam.yggdrasil.com>
 <3E121D28.47282D77@digeo.com> <3E1226FF.9010407@pacbell.net>
 <3E1227F4.E4B98632@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that was exactly what I was demonstrating ... those are
the callbacks that'd be supplied to mempool_create(), showing
that it doesn't need to change for that kind of usage.  (Which
isn't allocating DMA buffers, note!)

But we still need lower level allocators that are reasonable
for use with 1/Nth page allocations ... which isn't a problem
that mempool even attempts to solve.  Hence dma_pool, in any of
its implementations, would go underneath mempool to achieve what
Adam was describing (for drivers that need it).

- Dave


Andrew Morton wrote:
> David Brownell wrote:
> 
>>        void *mempool_alloc_td (int mem_flags, void *pool)
>>        {
>>                struct td *td;
>>                dma_addr_t dma;
>>
>>                td = dma_pool_alloc (pool, mem_flags, &dma);
>>                if (!td)
>>                        return td;
>>                td->td_dma = dma;       /* feed to the hardware */
>>                ... plus other init
>>                return td;
>>        }
> 
> 
> The existing mempool code can be used to implement this, I believe.  The
> pool->alloc callback is passed an opaque void *, and it returns
> a void * which can point at any old composite caller-defined blob.
> 



