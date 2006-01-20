Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWATNWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWATNWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWATNWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:22:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:36301 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750949AbWATNWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:22:52 -0500
Date: Fri, 20 Jan 2006 08:22:36 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Subject: Re: [PATCH 2/5] stack overflow safe kdump (2.6.15-i386) - use_safe_smp_processor_id
Message-ID: <20060120132236.GH4695@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1137417833.2256.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137417833.2256.86.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 10:23:53PM +0900, Fernando Luis Vazquez Cao wrote:
> Substitute "smp_processor_id" with the stack overflow-safe
> "safe_smp_processor_id" in the reboot path to the second kernel.
> 

Acked-by: Vivek Goyal <vgoyal@in.ibm.com>

> ---
> diff -urNp linux-2.6.15/arch/i386/kernel/crash.c
> linux-2.6.15-sov/arch/i386/kernel/crash.c
> --- linux-2.6.15/arch/i386/kernel/crash.c	2006-01-03 12:21:10.000000000
> +0900
> +++ linux-2.6.15-sov/arch/i386/kernel/crash.c	2006-01-16
> 20:28:31.000000000 +0900
> @@ -120,7 +120,7 @@ static void crash_save_self(struct pt_re
>  	struct pt_regs regs;
>  	int cpu;
>  
> -	cpu = smp_processor_id();
> +	cpu = safe_smp_processor_id();
>  	if (saved_regs)
>  		crash_setup_regs(&regs, saved_regs);
>  	else
> @@ -211,7 +211,7 @@ void machine_crash_shutdown(struct pt_re
>  	local_irq_disable();
>  
>  	/* Make a note of crashing cpu. Will be used in NMI callback.*/
> -	crashing_cpu = smp_processor_id();
> +	crashing_cpu = safe_smp_processor_id();
>  	nmi_shootdown_cpus();
>  	lapic_shutdown();
>  #if defined(CONFIG_X86_IO_APIC)
> 
> 
