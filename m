Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKTA2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKTA2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 19:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKTA2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 19:28:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750773AbVKTA2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 19:28:20 -0500
Date: Sat, 19 Nov 2005 16:28:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, jesper.juhl@gmail.com
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Message-Id: <20051119162805.47796de9.akpm@osdl.org>
In-Reply-To: <200511200010.33658.jesper.juhl@gmail.com>
References: <200511200010.33658.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> In arch/i386/kernel/nmi.c::nmi_watchdog_tick(), the variable `sum' is 
> of type "int" but it's used to store the result of 
> per_cpu(irq_stat, cpu).apic_timer_irqs which is an "unsigned int", it's
> also later compared to last_irq_sums[cpu] which is also an 
> "unsigned int", so `sum' really ought to be unsigned itself.
> This small patch makes that change.
> 
> ...
> 
> --- linux-2.6.15-rc1-git7-orig/arch/i386/kernel/nmi.c	2005-11-12 18:07:14.000000000 +0100
> +++ linux-2.6.15-rc1-git7/arch/i386/kernel/nmi.c	2005-11-19 23:58:17.000000000 +0100
> @@ -528,9 +528,10 @@ void nmi_watchdog_tick (struct pt_regs *
>  	 * Since current_thread_info()-> is always on the stack, and we
>  	 * always switch the stack NMI-atomically, it's safe to use
>  	 * smp_processor_id().
>  	 */
> -	int sum, cpu = smp_processor_id();
> +	unsigned int sum;
> +	int cpu = smp_processor_id();
>  
>  	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
>  
>  	if (last_irq_sums[cpu] == sum) {
> 

-ETOOTRIVIAL.  The code as-is works OK, and we have these sorts of things
all over the tee.

