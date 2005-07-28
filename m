Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVG1TVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVG1TVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVG1TS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:18:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262139AbVG1TSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:18:04 -0400
Date: Thu, 28 Jul 2005 12:16:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050728121656.66845f70.akpm@osdl.org>
In-Reply-To: <200507282111.32970.rjw@sisk.pl>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<200507282111.32970.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> There are two problems with the compilation of arch/x86_64/kernel/nmi.c.

Thanks.

> --- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/nmi.c	2005-07-28 21:05:53.000000000 +0200
>  +++ patched/arch/x86_64/kernel/nmi.c	2005-07-28 18:58:02.000000000 +0200
>  @@ -152,8 +152,10 @@ int __init check_nmi_watchdog (void)
>   
>   	printk(KERN_INFO "testing NMI watchdog ... ");
>   
>  +#ifdef CONFIG_SMP
>   	if (nmi_watchdog == NMI_LOCAL_APIC)
>   		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
>  +#endif
>   
>   	for (cpu = 0; cpu < NR_CPUS; cpu++)
>   		counts[cpu] = cpu_pda[cpu].__nmi_count; 

This bit is no longer needed, since
alpha-fix-statement-with-no-effect-warnings.patch got dropped.
