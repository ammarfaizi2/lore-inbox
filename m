Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVGFNbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVGFNbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 09:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVGFNbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 09:31:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7441 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262140AbVGFJwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:52:37 -0400
Date: Wed, 6 Jul 2005 10:52:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [7/48] Suspend2 2.1.9.8 for 2.6.12: 352-disable-pdflush-during-suspend.patch
Message-ID: <20050706105227.A10793@flint.arm.linux.org.uk>
Mail-Followup-To: Nigel Cunningham <nigel@suspend2.net>,
	linux-kernel@vger.kernel.org
References: <11206164393426@foobar.com> <11206164401583@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11206164401583@foobar.com>; from nigel@suspend2.net on Wed, Jul 06, 2005 at 12:20:40PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 12:20:40PM +1000, Nigel Cunningham wrote:
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

On ARM SMP, if you want the "local" version, the flush functions are
prefixed by "local_", though I guess we can also define a __flush_tlb()
for compatibility if someone wants to use swsusp with ARM SMP.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
