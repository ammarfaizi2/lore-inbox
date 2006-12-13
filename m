Return-Path: <linux-kernel-owner+w=401wt.eu-S1750822AbWLMUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWLMUpH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWLMUpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:45:06 -0500
Received: from [198.186.3.68] ([198.186.3.68]:41561 "EHLO mx.pathscale.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbWLMUpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:45:05 -0500
Subject: Re: sg_dma_address and sg_dma_len
From: Ralph Campbell <ralph.campbell@qlogic.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200612131737.kBDHb47D013437@agluck-lia64.sc.intel.com>
References: <200612131737.kBDHb47D013437@agluck-lia64.sc.intel.com>
Content-Type: text/plain
Organization: QLogic
Date: Wed, 13 Dec 2006 12:45:00 -0800
Message-Id: <1166042700.14800.392.camel@brick.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 09:37 -0800, Luck, Tony wrote:
> Ralph,
> 
> I'm seeing dozens of build warnings and errors on ia64 from
> infiniband.  According to git you touched it last, so even
> if you aren't to blame, you are by definition an expert :-)
> 
> E.g.
> 
> In file included from include/rdma/ib_addr.h:37,
>                  from drivers/infiniband/core/addr.c:39:
> include/rdma/ib_verbs.h: In function `ib_sg_dma_address':
> include/rdma/ib_verbs.h:1572: warning: implicit declaration of function `sg_dma_address'
> include/rdma/ib_verbs.h: In function `ib_sg_dma_len':
> include/rdma/ib_verbs.h:1584: warning: implicit declaration of function `sg_dma_len'
> 
> Adding a #include <linux/pci.h> would shut them up (as the defines for
> sg_dma_address and sg_dma_len are in asm/pci.h) ... but I've no idea
> whether this is the right fix.
> 
> -Tony

For some reason ia64 defines sg_dma_address() in include/asm-ia64/pci.h
instead of include/asm-ia64/scatterlist.h like most other architectures.

Since pci.h includes <asm/scatterlist.h> it seems like the fix would be
to move the two lines:
	#define sg_dma_len(sg)          ((sg)->dma_length)
	#define sg_dma_address(sg)      ((sg)->dma_address)
to include/asm-ia64/scatterlist.h

Now that I look, I see asm-sh64/pci.h and asm-frv/dma-mapping.h
would also need to be changed.

