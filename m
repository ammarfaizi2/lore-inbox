Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGFFUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGFFUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGFFUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:20:34 -0400
Received: from fsmlabs.com ([168.103.115.128]:60062 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261576AbVGFDan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:30:43 -0400
Date: Tue, 5 Jul 2005 21:34:53 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nigel Cunningham <nigel@suspend2.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [7/48] Suspend2 2.1.9.8 for 2.6.12:
 352-disable-pdflush-during-suspend.patch
In-Reply-To: <11206164401583@foobar.com>
Message-ID: <Pine.LNX.4.61.0507052134290.2149@montezuma.fsmlabs.com>
References: <11206164401583@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Nigel Cunningham wrote:

> diff -ruNp 353-disable-highmem-tlb-flush-for-copyback.patch-old/mm/highmem.c 353-disable-highmem-tlb-flush-for-copyback.patch-new/mm/highmem.c
> --- 353-disable-highmem-tlb-flush-for-copyback.patch-old/mm/highmem.c	2005-06-20 11:47:32.000000000 +1000
> +++ 353-disable-highmem-tlb-flush-for-copyback.patch-new/mm/highmem.c	2005-07-04 23:14:20.000000000 +1000
> @@ -26,6 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/hash.h>
>  #include <linux/highmem.h>
> +#include <linux/suspend.h>
>  #include <asm/tlbflush.h>
>  
>  static mempool_t *page_pool, *isa_page_pool;
> @@ -95,7 +96,10 @@ static void flush_all_zero_pkmaps(void)
>  
>  		set_page_address(page, NULL);
>  	}
> -	flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
> +	if (test_suspend_state(SUSPEND_FREEZE_SMP))
> +		__flush_tlb();
> +	else
> +		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
>  }
>  
>  static inline unsigned long map_new_virtual(struct page *page)

What state are the other processors in when you hit this path?

