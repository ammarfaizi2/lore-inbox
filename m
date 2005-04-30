Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVD3S4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVD3S4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVD3S4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:56:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20494 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261339AbVD3S4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:56:10 -0400
Date: Sat, 30 Apr 2005 20:56:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Coywolf Qi Hunt <coywolf@lovecn.org>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.12-rc3-mm1
Message-ID: <20050430185604.GH3571@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org> <20050430142035.GB3571@stusta.de> <Pine.LNX.4.61.0504300940560.12903@montezuma.fsmlabs.com> <2cd57c9005043010051c6455fb@mail.gmail.com> <20050430180823.GA14922@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430180823.GA14922@lovecn.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 02:08:23AM +0800, Coywolf Qi Hunt wrote:
> On Sun, May 01, 2005 at 01:05:52AM +0800, Coywolf Qi Hunt wrote:
> ... 
> > I was trying to fix this too. You are quicker and better than me. In
> > addition, this redundant  include should be removed.
> 
> s/redundant/duplicate/
> 
> OK, since Zwane thinks my patch is "good in that its minimal impact", here it is.
> I've compile tested for SMP and UP.
> 
> This removes the compile warning: implicit declaration of function `set_irq_info' and a duplicate include line.
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
> ---
> 
> diff -pruN 2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c 2.6.12-rc3-mm1-cy2/arch/i386/kernel/io_apic.c
> --- 2.6.12-rc3-mm1/arch/i386/kernel/io_apic.c	2005-04-30 19:15:46.000000000 +0800
> +++ 2.6.12-rc3-mm1-cy2/arch/i386/kernel/io_apic.c	2005-05-01 00:49:27.000000000 +0800
> @@ -32,7 +32,6 @@
>  #include <linux/compiler.h>
>  #include <linux/acpi.h>
>  #include <linux/sysdev.h>
> -#include <linux/irq.h>
>  #include <asm/io.h>
>  #include <asm/smp.h>
>  #include <asm/desc.h>
> diff -pruN 2.6.12-rc3-mm1/include/linux/irq.h 2.6.12-rc3-mm1-cy2/include/linux/irq.h
> --- 2.6.12-rc3-mm1/include/linux/irq.h	2005-04-30 19:16:26.000000000 +0800
> +++ 2.6.12-rc3-mm1-cy2/include/linux/irq.h	2005-05-01 00:51:31.000000000 +0800
> @@ -161,6 +161,7 @@ static inline void set_irq_info(int irq,
>  #else
>  #define move_irq(x)
>  #define move_native_irq(x)
> +extern void set_irq_info(unsigned int irq, cpumask_t mask);
>  #endif // CONFIG_GENERIC_PENDING_IRQ
>  
>  extern int no_irq_affinity;


Is it planned that the empty set_irq_info() function in 
kernel/irq/manage.c will ever contain real code?

If not, an empty static inline as in the CONFIG_PCI_MSI=y && 
CONFIG_GENERIC_PENDING_IRQ=y case would generate better code.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

