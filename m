Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVKPPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVKPPxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVKPPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:53:17 -0500
Received: from cantor2.suse.de ([195.135.220.15]:9610 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030377AbVKPPxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:53:16 -0500
From: Andi Kleen <ak@suse.de>
To: Mika =?iso-8859-15?q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Subject: Re: DMA32 zone unusable
Date: Wed, 16 Nov 2005 16:53:06 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <437B4EB0.3080908@kolumbus.fi>
In-Reply-To: <437B4EB0.3080908@kolumbus.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511161653.07291.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 16:22, Mika Penttilä wrote:
> The new DMA32 zone (which at least x86-64 has) is quite "interesting" :
> 
> #define __GFP_DMA32    ((__force gfp_t)0x04) <-----!!!!!  
> 
> #define GFP_ZONEMASK    0x03   <------!!!!!
> 
> #define gfp_zone(mask) ((__force int)((mask) & (__force gfp_t)GFP_ZONEMASK))

Yes that was a last minute change that was wrong. I will submit
an update. Thanks for reviewing.

-Andi

> static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>                         unsigned int order)
> {
>     if (unlikely(order >= MAX_ORDER))
>         return NULL;
> 
>     return __alloc_pages(gfp_mask, order,
>         NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
> }
> 
> 
> So with GFP_DMA32 you never get those pages (but DMA instead).
> 
> --Mika
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
