Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVKOHvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVKOHvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVKOHvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:51:24 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:37393 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S932324AbVKOHvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:51:24 -0500
Message-ID: <437993A8.8050702@snapgear.com>
Date: Tue, 15 Nov 2005 17:52:08 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68knommu: enable_irq/disable_irq
References: <20051113074136.GA816@lst.de>
In-Reply-To: <20051113074136.GA816@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Christoph Hellwig wrote:
> mach_enable_irq/mach_disable_irq are never actually set, so let's remove
> them.
> 
> Btw, is it really intentionally that enable_irq/disable_irq are no-ops on
> m68knommu?

No, I think they should be implemented. It would clean up some driver
irq ugliness in some of the m68knommu arch specific drivers.

Regards
Greg



> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/arch/m68knommu/kernel/m68k_ksyms.c
> ===================================================================
> --- linux-2.6.orig/arch/m68knommu/kernel/m68k_ksyms.c	2005-10-31 12:23:08.000000000 +0100
> +++ linux-2.6/arch/m68knommu/kernel/m68k_ksyms.c	2005-11-12 09:22:34.000000000 +0100
> @@ -38,8 +38,6 @@
>  
>  EXPORT_SYMBOL(ip_fast_csum);
>  
> -EXPORT_SYMBOL(mach_enable_irq);
> -EXPORT_SYMBOL(mach_disable_irq);
>  EXPORT_SYMBOL(kernel_thread);
>  
>  /* Networking helper routines. */
> Index: linux-2.6/arch/m68knommu/kernel/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/m68knommu/kernel/setup.c	2005-11-07 21:30:08.000000000 +0100
> +++ linux-2.6/arch/m68knommu/kernel/setup.c	2005-11-12 09:22:26.000000000 +0100
> @@ -65,8 +65,6 @@
>  /* machine dependent irq functions */
>  void (*mach_init_IRQ) (void) = NULL;
>  irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
> -void (*mach_enable_irq) (unsigned int) = NULL;
> -void (*mach_disable_irq) (unsigned int) = NULL;
>  int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
>  void (*mach_process_int) (int irq, struct pt_regs *fp) = NULL;
>  void (*mach_trap_init) (void);
> Index: linux-2.6/include/asm-m68knommu/irq.h
> ===================================================================
> --- linux-2.6.orig/include/asm-m68knommu/irq.h	2005-11-07 21:30:09.000000000 +0100
> +++ linux-2.6/include/asm-m68knommu/irq.h	2005-11-12 09:22:05.000000000 +0100
> @@ -84,8 +84,8 @@
>  /*
>   * Some drivers want these entry points
>   */
> -#define enable_irq(x)	(mach_enable_irq  ? (*mach_enable_irq)(x)  : 0)
> -#define disable_irq(x)	(mach_disable_irq ? (*mach_disable_irq)(x) : 0)
> +#define enable_irq(x)	0
> +#define disable_irq(x)	do { } while (0)
>  
>  #define enable_irq_nosync(x)	enable_irq(x)
>  #define disable_irq_nosync(x)	disable_irq(x)
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
