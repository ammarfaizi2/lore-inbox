Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVGFKFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVGFKFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGFKFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:05:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32984 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262184AbVGFIIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:08:55 -0400
Date: Wed, 6 Jul 2005 10:08:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [7/48] Suspend2 2.1.9.8 for 2.6.12: 352-disable-pdflush-during-suspend.patch
Message-ID: <20050706080825.GB1412@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164401583@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164401583@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

Take a look at cpu hotplug system, it is cleaner way of doing this...

										Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
