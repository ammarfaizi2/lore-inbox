Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUJRTQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUJRTQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUJRTJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:09:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5263 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267548AbUJRTDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:03:01 -0400
Date: Mon, 18 Oct 2004 21:04:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniele Pizzoni <auouo@tin.it>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace custom Dprintk macro with pr_debug - nmi.c
Message-ID: <20041018190417.GA5845@elte.hu>
References: <1098129428.3024.61.camel@pdp11.tsho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098129428.3024.61.camel@pdp11.tsho.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


looks good.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

* Daniele Pizzoni <auouo@tin.it> wrote:

> Substituted custom Dprintk macro with pr_debug
> 
> Signed-off-by: Daniele Pizzoni
> 
> 
> Index: linux-2.6.9-rc4/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux-2.6.9-rc4.orig/arch/i386/kernel/nmi.c	2004-10-18 19:41:13.798118432 +0200
> +++ linux-2.6.9-rc4/arch/i386/kernel/nmi.c	2004-10-18 21:50:57.884757392 +0200
> @@ -13,6 +13,8 @@
>   *  Mikael Pettersson	: PM converted to driver model. Disable/enable API.
>   */
>  
> +//#define DEBUG // pr_debug
> +#include <linux/kernel.h>
>  #include <linux/config.h>
>  #include <linux/mm.h>
>  #include <linux/irq.h>
> @@ -332,7 +334,7 @@ static void setup_k7_watchdog(void)
>  		| K7_NMI_EVENT;
>  
>  	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
> -	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
> +	pr_debug("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
>  	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
>  	apic_write(APIC_LVTPC, APIC_DM_NMI);
>  	evntsel |= K7_EVNTSEL_ENABLE;
> @@ -354,7 +356,7 @@ static void setup_p6_watchdog(void)
>  		| P6_NMI_EVENT;
>  
>  	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
> -	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
> +	pr_debug("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
>  	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
>  	apic_write(APIC_LVTPC, APIC_DM_NMI);
>  	evntsel |= P6_EVNTSEL0_ENABLE;
> @@ -395,7 +397,7 @@ static int setup_p4_watchdog(void)
>  
>  	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
>  	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
> -	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
> +	pr_debug("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
>  	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
>  	apic_write(APIC_LVTPC, APIC_DM_NMI);
>  	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
> 
