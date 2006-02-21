Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWBUBGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWBUBGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWBUBGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:06:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161251AbWBUBGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:06:54 -0500
Date: Mon, 20 Feb 2006 17:02:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-Id: <20060220170206.317d7fcf.akpm@osdl.org>
In-Reply-To: <20060220223613.GL4661@stusta.de>
References: <20060220223613.GL4661@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> I didn't find any modular usage of kmem_cache_alloc_node.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 27 Jul 2005
> - 2 Jul 2005
> - 21 Jun 2005
> - 30 May 2005
> - 15 May 2005
> 
> --- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-06 15:40:38.000000000 +0100
> +++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-06 15:41:06.000000000 +0100
> @@ -2431,7 +2440,6 @@
>  					__builtin_return_address(0));
>  	return objp;
>  }
> -EXPORT_SYMBOL(kmem_cache_alloc_node);
>  
>  #endif
>  

kmem_cache_alloc_node() is part of the slab API and it is reasonable that
it be exported in this manner along with the rest of that API.  If someone
wanted to use kmem_cache_alloc_node() and found it wasn't exported like the
rest of the slab functions, that would look weird.

So I don't think we need bother going through the drawn-out pain of
retracting an export which has been in-tree for a year or so.

