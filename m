Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWBFVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBFVYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWBFVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:24:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48335
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932132AbWBFVYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:24:43 -0500
Date: Mon, 06 Feb 2006 13:24:34 -0800 (PST)
Message-Id: <20060206.132434.130599234.davem@davemloft.net>
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unify pfn_to_page [25/25] sparc64
 pfn_to_page/page_to_pfn
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43E731B5.9050407@jp.fujitsu.com>
References: <43E731B5.9050407@jp.fujitsu.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:23:33 +0900

> --- cleanup_pfn_page.orig/arch/sparc64/mm/init.c
> +++ cleanup_pfn_page/arch/sparc64/mm/init.c
> @@ -320,16 +320,6 @@ void __kprobes flush_icache_range(unsign
>   	}
>   }
> 
> -unsigned long page_to_pfn(struct page *page)
> -{
> -	return (unsigned long) ((page - mem_map) + pfn_base);
> -}
> -
> -struct page *pfn_to_page(unsigned long pfn)
> -{
> -	return (mem_map + (pfn - pfn_base));
> -}
> -
>   void show_mem(void)
>   {
>   	printk("Mem-info:\n");

We did not want these inlined on sparc64 for a good reason.
The pointer arithmatic gets expanded to many additions,
subtractions, and shifts, and I felt it too much to inline.

If you want to consolidate all of the implementations, that's
fine, but please keep the option of not inlining these two
routines.

Thank you.
