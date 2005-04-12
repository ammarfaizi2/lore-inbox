Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbVDLVCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVDLVCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVDLUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:43:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:51376 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262109AbVDLTun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:50:43 -0400
Date: Tue, 12 Apr 2005 12:50:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 2/9] mempool gfp flag
Message-Id: <20050412125025.6890b2d7.akpm@osdl.org>
In-Reply-To: <425BC3B0.7020707@yahoo.com.au>
References: <425BC262.1070500@yahoo.com.au>
	<425BC3B0.7020707@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  The first is that mempool_alloc can possibly get stuck in __alloc_pages
>  when they should opt to fail, and take an element from their reserved pool.
> 
>  The second is that it will happily eat emergency PF_MEMALLOC reserves
>  instead of going to their reserved pools.
> 
>  Fix the first by passing __GFP_NORETRY in the allocation calls in
>  mempool_alloc. Fix the second by introducing a __GFP_MEMPOOL flag
>  which directs the page allocator not to allocate from the reserve
>  pool.
> 
> 
>  Index: linux-2.6/include/linux/gfp.h
>  ===================================================================
>  --- linux-2.6.orig/include/linux/gfp.h	2005-04-12 22:26:10.000000000 +1000
>  +++ linux-2.6/include/linux/gfp.h	2005-04-12 22:26:11.000000000 +1000
>  @@ -38,14 +38,16 @@ struct vm_area_struct;
>   #define __GFP_NO_GROW	0x2000u	/* Slab internal usage */
>   #define __GFP_COMP	0x4000u	/* Add compound page metadata */
>   #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
>  +#define __GFP_MEMPOOL	0x10000u/* Mempool allocation */

I think I'll rename this to "__GFP_NOMEMALLOC".  Things other then mempool
might want to use this.

