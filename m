Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTABB46>; Wed, 1 Jan 2003 20:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTABB46>; Wed, 1 Jan 2003 20:56:58 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:24494 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265339AbTABB45>; Wed, 1 Jan 2003 20:56:57 -0500
Date: Wed, 01 Jan 2003 18:11:43 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Message-id: <3E139FDF.4010106@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200301011948.h01JmBo02789@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> adam@yggdrasil.com said:
> 
>>	Can someone show me or invent an example of two different uses of
>>dma_alloc_coherent that really should use different policies on
>>whether to block or not? 
> 
> 
> The obvious one is allocations from interrupt routines, which must be 
> GFP_ATOMIC (ignoring the issue of whether a driver should be doing a memory 
> allocation in an interrupt).  Allocating large pools at driver initialisation 
> should probably be GFP_KERNEL as you say.

More:  not just "from interrupt routines", also "when a spinlock is held".
Though one expects that if a dma_pool were in use, it'd probably have one
of that kind of chunk already available (ideally, even initialized).

Many task-initiated allocations would use GFP_KERNEL; not just major driver
activation points like open().

- Dave

