Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVG0UKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVG0UKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVG0UJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:09:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262488AbVG0UI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:08:27 -0400
Date: Wed, 27 Jul 2005 13:03:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <christoph@lameter.com>
Subject: Re: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-Id: <20050727130355.08a534b7.akpm@osdl.org>
In-Reply-To: <20050727195107.GC29092@stusta.de>
References: <20050727195107.GC29092@stusta.de>
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
> - 2 Jul 2005
> - 21 Jun 2005
> - 30 May 2005
> - 15 May 2005

Yeah, I've been ducking that one.

> --- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-06 15:40:38.000000000 +0100
> +++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-06 15:41:06.000000000 +0100
> @@ -2431,7 +2440,6 @@
>  					__builtin_return_address(0));
>  	return objp;
>  }
> -EXPORT_SYMBOL(kmem_cache_alloc_node);
>  
>  #endif

Even though we don't currently have in-module users, we probably will do so
soon and it's a part of the slab API and the slab API is exported to
modules.  I don't see much point in partially-exporting the API and
applying a patch which we'll soon revert.

Christoph?
