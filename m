Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUJQQbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUJQQbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJQQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:28:48 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:15375 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269205AbUJQQ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:27:22 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Daniele Pizzoni <auouo@tin.it>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
Subject: Re: [PATCH 4/8] replacing/fixing printk with pr_debug/pr_info in arch/i386 - mpparse.c
Date: Sun, 17 Oct 2004 19:26:55 +0300
User-Agent: KMail/1.5.4
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
References: <1098032569.3023.124.camel@pdp11.tsho.org>
In-Reply-To: <1098032569.3023.124.camel@pdp11.tsho.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410171926.55840.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 October 2004 20:10, Daniele Pizzoni wrote:
> Replace custom macro Dprintk (defined in apic.h included via smp.h)
>  with pr_debug from kernel.h.
> Use  pr_info when appropriate.
> Fix consistency of printks.
> 
> Signed-off-by: Daniele Pizzoni <auouo@tin.it>
> 
> Index: linux-2.6.9-rc4/arch/i386/kernel/mpparse.c
> ===================================================================
> --- linux-2.6.9-rc4.orig/arch/i386/kernel/mpparse.c	2004-08-14 07:36:44.000000000 +0200
> +++ linux-2.6.9-rc4/arch/i386/kernel/mpparse.c	2004-10-17 17:01:19.482218648 +0200
> @@ -13,6 +13,7 @@
>   *		Paul Diefenbaugh:	Added full ACPI support
>   */
>  
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/irq.h>
>  #include <linux/init.h>
> @@ -130,55 +131,55 @@ void __init MP_processor_info (struct mp
>  	apicid = mpc_apic_id(m, translation_table[mpc_record]);
>  
>  	if (m->mpc_featureflag&(1<<0))
> -		Dprintk("    Floating point unit present.\n");
> +		pr_debug("    Floating point unit present.\n");
>  	if (m->mpc_featureflag&(1<<7))
> -		Dprintk("    Machine Exception supported.\n");
> +		pr_debug("    Machine Exception supported.\n");
>  	if (m->mpc_featureflag&(1<<8))
> -		Dprintk("    64 bit compare & exchange supported.\n");
> +		pr_debug("    64 bit compare & exchange supported.\n");
>  	if (m->mpc_featureflag&(1<<9))
> -		Dprintk("    Internal APIC present.\n");
> +		pr_debug("    Internal APIC present.\n");
>  	if (m->mpc_featureflag&(1<<11))
> -		Dprintk("    SEP present.\n");
> +		pr_debug("    SEP present.\n");
>  	if (m->mpc_featureflag&(1<<12))
> -		Dprintk("    MTRR  present.\n");
> +		pr_debug("    MTRR  present.\n");
>  	if (m->mpc_featureflag&(1<<13))
> -		Dprintk("    PGE  present.\n");
> +		pr_debug("    PGE  present.\n");
>  	if (m->mpc_featureflag&(1<<14))
> -		Dprintk("    MCA  present.\n");
> +		pr_debug("    MCA  present.\n");
>  	if (m->mpc_featureflag&(1<<15))
> -		Dprintk("    CMOV  present.\n");
> +		pr_debug("    CMOV  present.\n");
>  	if (m->mpc_featureflag&(1<<16))
> -		Dprintk("    PAT  present.\n");
> +		pr_debug("    PAT  present.\n");
>  	if (m->mpc_featureflag&(1<<17))
> -		Dprintk("    PSE  present.\n");
> +		pr_debug("    PSE  present.\n");
>  	if (m->mpc_featureflag&(1<<18))
> -		Dprintk("    PSN  present.\n");
> +		pr_debug("    PSN  present.\n");
>  	if (m->mpc_featureflag&(1<<19))
> -		Dprintk("    Cache Line Flush Instruction present.\n");
> +		pr_debug("    Cache Line Flush Instruction present.\n");
>  	/* 20 Reserved */
>  	if (m->mpc_featureflag&(1<<21))
> -		Dprintk("    Debug Trace and EMON Store present.\n");
> +		pr_debug("    Debug Trace and EMON Store present.\n");
>  	if (m->mpc_featureflag&(1<<22))
> -		Dprintk("    ACPI Thermal Throttle Registers  present.\n");
> +		pr_debug("    ACPI Thermal Throttle Registers  present.\n");
                                                            ^^^^
While at it, you may fix stray double spaces...

>  	if (m->mpc_featureflag&(1<<23))
> -		Dprintk("    MMX  present.\n");
> +		pr_debug("    MMX  present.\n");
                                ^^^^

>  	if (m->mpc_featureflag&(1<<24))
> -		Dprintk("    FXSR  present.\n");
> +		pr_debug("    FXSR  present.\n");
>  	if (m->mpc_featureflag&(1<<25))
> -		Dprintk("    XMM  present.\n");
> +		pr_debug("    XMM  present.\n");
>  	if (m->mpc_featureflag&(1<<26))
> -		Dprintk("    Willamette New Instructions  present.\n");
> +		pr_debug("    Willamette New Instructions  present.\n");
>  	if (m->mpc_featureflag&(1<<27))
> -		Dprintk("    Self Snoop  present.\n");
> +		pr_debug("    Self Snoop  present.\n");
>  	if (m->mpc_featureflag&(1<<28))
> -		Dprintk("    HT  present.\n");
> +		pr_debug("    HT  present.\n");
>  	if (m->mpc_featureflag&(1<<29))
> -		Dprintk("    Thermal Monitor present.\n");
> +		pr_debug("    Thermal Monitor present.\n");
>  	/* 30, 31 Reserved */
>  
>  
>  	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
> -		Dprintk("    Bootup CPU\n");
> +		pr_debug("    Bootup CPU\n");

...and inconsistent usage of trailing period
(my personal preference is to remove trailing periods).

>  		boot_cpu_physical_apicid = m->mpc_apicid;
>  		boot_cpu_logical_apicid = apicid;
>  	}
> @@ -250,10 +251,10 @@ static void __init MP_ioapic_info (struc
>  	if (!(m->mpc_flags & MPC_APIC_USABLE))
>  		return;
>  
> -	printk(KERN_INFO "I/O APIC #%d Version %d at 0x%lX.\n",
> +	pr_info("I/O APIC #%d Version %d at 0x%lX.\n",
>  		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
>  	if (nr_ioapics >= MAX_IO_APICS) {
> -		printk(KERN_CRIT "Max # of I/O APICs (%d) exceeded (found %d).\n",
> +		printk(KERN_EMERG "Max # of I/O APICs (%d) exceeded (found %d).\n",
>  			MAX_IO_APICS, nr_ioapics);
>  		panic("Recompile kernel with bigger MAX_IO_APICS!.\n");
                                                               ^^^^
:)

[Rest snipped]
--
vda

