Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbRE3Sf0>; Wed, 30 May 2001 14:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbRE3SfG>; Wed, 30 May 2001 14:35:06 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:2821 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261800AbRE3Se5>; Wed, 30 May 2001 14:34:57 -0400
Date: Wed, 30 May 2001 20:34:45 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Carlos E Gorges <carlos@techlinux.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 245-ac4
In-Reply-To: <01053015181600.08588@shark.techlinux>
Message-ID: <Pine.LNX.3.96.1010530203203.27595A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all,
> 
> This patch remove some NULL parameters tests in kfree-like functions and
> add this directly in function. 
> 
> - dev_kfree_skb_irq == dev_kfree_skb == kfree_skb 
> - kfree already handle null parameters :
> void kfree (const void *objp)
> {
>         kmem_cache_t *c;
>         unsigned long flags;
>  
> >>       if (!objp)
> >>               return;
>  
>        local_irq_save(flags);
>         CHECK_PAGE(virt_to_page(objp));
>         c = GET_PAGE_CACHE(virt_to_page(objp));
>         __kmem_cache_free(c, (void*)objp);
>         local_irq_restore(flags);
> }

This is bad. It will only slow thing down.

It will also hide allocation errors in the rest of the kernel. A bug that
causes crash is much better than the one that doesn't.

Mikulas


