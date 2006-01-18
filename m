Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWARTaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWARTaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWARTaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:30:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964923AbWARTaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:30:18 -0500
Date: Wed, 18 Jan 2006 14:38:11 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Nick Piggin <npiggin@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/2] x86_64: pageattr use single list
In-Reply-To: <20060117150316.7411.98772.sendpatchset@linux.site>
Message-ID: <Pine.LNX.4.61.0601181437030.6584@dhcp83-105.boston.redhat.com>
References: <20060117150307.7411.94174.sendpatchset@linux.site>
 <20060117150316.7411.98772.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2006, Nick Piggin wrote:

> Use page->lru.next to implement the singly linked list of pages rather
> than the struct deferred_page which needs to be allocated and freed for
> each page.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> Acked-by: Andi Kleen <ak@suse.de>
> 
> Index: linux-2.6/arch/x86_64/mm/pageattr.c
> ===================================================================

...

> +
> +	flush_map((dpage && !dpage->lru.next) ? (unsigned long)page_address(dpage) : 0);
> +	while (dpage) {
> +		__free_page(dpage);
> +		dpage = (struct page *)dpage->lru.next;
>  	} 
>  } 
>  

do you want to be touching a struct page that was just freed?

-Jason
