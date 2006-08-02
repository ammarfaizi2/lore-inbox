Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWHBSzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWHBSzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWHBSzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:55:31 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:41854 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932148AbWHBSza
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:55:30 -0400
Date: Wed, 2 Aug 2006 21:55:27 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org
Subject: Re: [PATCH] Move valid_dma_direction() from x86_64 to generic code
Message-ID: <20060802185527.GB4982@rhun.ibm.com>
References: <200607280928.54306.eike-kernel@sf-tec.de> <20060728174449.GA11046@rhun.ibm.com> <200608021720.40815.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608021720.40815.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 05:20:40PM +0200, Rolf Eike Beer wrote:

> As suggested by Muli Ben-Yehuda this function is moved to generic code as
> may be useful for all archs.

I like it, but ...

> diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
> index b6da83d..10174b1 100644
> --- a/include/asm-x86_64/dma-mapping.h
> +++ b/include/asm-x86_64/dma-mapping.h
> @@ -55,13 +55,6 @@ extern dma_addr_t bad_dma_address;
>  extern struct dma_mapping_ops* dma_ops;
>  extern int iommu_merge;
>  
> -static inline int valid_dma_direction(int dma_direction)
> -{
> -	return ((dma_direction == DMA_BIDIRECTIONAL) ||
> -		(dma_direction == DMA_TO_DEVICE) ||
> -		(dma_direction == DMA_FROM_DEVICE));
> -}
> -

Several files include asm/dma-mapping.h directly, which will now cause
them to fail to compile on x86-64 due to the missing definition for
valid_dma_direction, unless by chance another header already brought
it in indirectly. I guess the right thing to do is convert them all to
using linux/dma-mapping.h instead.

./arch/x86_64/kernel/pci-swiotlb.c:6:#include <asm/dma-mapping.h>
./drivers/net/fec_8xx/fec_main.c:40:#include <asm/dma-mapping.h>
./drivers/net/fs_enet/fs_enet.h:11:#include <asm/dma-mapping.h>
./include/asm-x86_64/swiotlb.h:5:#include <asm/dma-mapping.h>
./include/linux/dma-mapping.h:27:#include <asm/dma-mapping.h>

Cheers,
Muli
