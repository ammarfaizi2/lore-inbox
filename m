Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVATRp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVATRp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVATRp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:45:28 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:38333 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262232AbVATRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:45:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc1-mm2: CONFIG_SMP=n compile error
Date: Thu, 20 Jan 2005 18:44:59 +0100
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, ak@suse.de, linux-kernel@vger.kernel.org
References: <20050119213818.55b14bb0.akpm@osdl.org> <20050120065318.GA3170@stusta.de> <20050119231210.51a24cbc.akpm@osdl.org>
In-Reply-To: <20050119231210.51a24cbc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501201845.00653.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 of January 2005 08:12, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > arch/i386/kernel/nmi.c:130: error: `cpu_callin_map' undeclared (first use in this function)
> 
> --- 25/arch/i386/kernel/nmi.c~i386-x86-64-fix-smp-nmi-watchdog-race-fix	2005-01-19 23:03:08.946815320 -0800
> +++ 25-akpm/arch/i386/kernel/nmi.c	2005-01-19 23:05:07.968721240 -0800
> @@ -117,8 +117,10 @@ int __init check_nmi_watchdog (void)
>  	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
>             as they come up. */
>  	for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +#ifdef CONFIG_SMP
>  		if (!cpu_isset(cpu, cpu_callin_map))
>  			continue;
> +#endif
>  		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
>  			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
>  			nmi_active = 0;
> diff -puN include/asm-i386/smp.h~i386-x86-64-fix-smp-nmi-watchdog-race-fix include/asm-i386/smp.h

Similar fix is necessary for x86-64, it appears.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
