Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSLaVxt>; Tue, 31 Dec 2002 16:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSLaVxt>; Tue, 31 Dec 2002 16:53:49 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:20425 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264748AbSLaVxt>; Tue, 31 Dec 2002 16:53:49 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 31 Dec 2002 14:02:03 -0800
Message-Id: <200212312202.OAA10841@adam.yggdrasil.com>
To: david-b@pacbell.net, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>struct dma_pool *dma_pool_create(char *, struct device *, size_t)
>void dma_pool_destroy (struct dma_pool *pool)
>void *dma_pool_alloc(struct dma_pool *, int mem_flags, dma_addr_t *)
>void dma_pool_free(struct dma_pool *, void *, dma_addr_t)

	I would like to be able to have failure-free, deadlock-free
blocking memory allocation, such as we have with the non-DMA mempool
library so that we can guarantee that drivers that have been
successfully initialized will continue to work regardless of memory
pressure, and reduce error branches that drivers have to deal with.

	Such a facility could be layered on top of your interface
perhaps by extending the mempool code to pass an extra parameter
around.  If so, then you should think about arranging your interface
so that it could be driven with as little glue as possible by mempool.

	I think that the term "pool" is more descriptively used by
mempool and more misleadningly used by the pci_pool code, as there is
no guaranteed pool being reserved in the pci_pool code.  Alas, I don't
have a good alternative term to suggest at the moment.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
