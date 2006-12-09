Return-Path: <linux-kernel-owner+w=401wt.eu-S1761625AbWLIOC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761625AbWLIOC4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761626AbWLIOC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:02:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6476 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761625AbWLIOCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:02:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=INQ9STJHUjsUrM5A6aUiJWajb2onJu4mnYPhG3M4UGnb+Yvy2WByPQcGoQGO40YUW4H3Oj4xFyaxCHRUy6TbdGWkNEFoC+7FZE03c558B+Mpby4bMRGJ0vo5m9yCqRL+vx/bbxJrS7BjU9dtUom7BCIEfMqmPRZtL/J6I1LBpAo=
Message-ID: <84144f020612090602w5c7f3f9ay8e771763ea8843cf@mail.gmail.com>
Date: Sat, 9 Dec 2006 16:02:53 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [RFC] Cleanup slab headers / API to allow easy addition of new slab allocators
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       "Christoph Hellwig" <hch@infradead.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, akpm@osdl.org, mpm@selenic.com,
       "Manfred Spraul" <manfred@colorfullife.com>
In-Reply-To: <Pine.LNX.4.64.0612081106320.16873@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612081106320.16873@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: 497308aa227eeee0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 12/8/06, Christoph Lameter <clameter@sgi.com> wrote:
> +#define        SLAB_POISON             0x00000800UL    /* DEBUG: Poison objects */
> +#define        SLAB_HWCACHE_ALIGN      0x00002000UL    /* Align objs on cache lines */
> +#define SLAB_CACHE_DMA         0x00004000UL    /* Use GFP_DMA memory */
> +#define SLAB_MUST_HWCACHE_ALIGN        0x00008000UL    /* Force alignment even if debuggin is active */

Please fix formatting while you're at it.

> +#ifdef CONFIG_SLAB
> +#include <linux/slab_def.h>
> +#else
> +
> +/*
> + * Fallback definitions for an allocator not wanting to provide
> + * its own optimized kmalloc definitions (like SLOB).
> + */
> +
> +#if defined(CONFIG_NUMA) || defined(CONFIG_DEBUG_SLAB)
> +#error "SLAB fallback definitions not usable for NUMA or Slab debug"

Do we need this? Shouldn't we just make sure no one can enable
CONFIG_NUMA and CONFIG_DEBUG_SLAB for non-compatible allocators?

> -static inline void *kmalloc(size_t size, gfp_t flags)
> +void *kmalloc(size_t size, gfp_t flags)

static inline?

> +void *kzalloc(size_t size, gfp_t flags)
> +{
> +       return __kzalloc(size, flags);
> +}

same here.
