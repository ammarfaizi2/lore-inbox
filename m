Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTAATNi>; Wed, 1 Jan 2003 14:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbTAATNh>; Wed, 1 Jan 2003 14:13:37 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:15802 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261312AbTAATNh>; Wed, 1 Jan 2003 14:13:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 1 Jan 2003 11:21:58 -0800
Message-Id: <200301011921.LAA02354@baldur.yggdrasil.com>
To: akpm@digeo.com, James.Bottomley@steeleye.com
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> void *
> dma_alloc_coherent(struct device *dev, size_t size,
>-                            dma_addr_t *dma_handle)
>+                            dma_addr_t *dma_handle, int flag)

	I thought Andrew Morton's request for a gfp flag was for
allocating memory from a pool (for example, a "read ahead" will want
to abort if memory is unavailable rather than wait).

	The big DMA allocations, however, will always occur during
initialization, and I think will always have the intermediate policy
of "I can block, but I should fail rather than block for more than a
few seconds and potentially deadlock from loading too many drivers on
a system with very little memory."

	Can someone show me or invent an example of two different uses
of dma_alloc_coherent that really should use different policies on
whether to block or not?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
