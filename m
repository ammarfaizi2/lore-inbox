Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVATHNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVATHNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVATHNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:13:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:31370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262067AbVATHMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:12:55 -0500
Date: Wed, 19 Jan 2005 23:12:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2: CONFIG_SMP=n compile error
Message-Id: <20050119231210.51a24cbc.akpm@osdl.org>
In-Reply-To: <20050120065318.GA3170@stusta.de>
References: <20050119213818.55b14bb0.akpm@osdl.org>
	<20050120065318.GA3170@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> arch/i386/kernel/nmi.c:130: error: `cpu_callin_map' undeclared (first use in this function)

--- 25/arch/i386/kernel/nmi.c~i386-x86-64-fix-smp-nmi-watchdog-race-fix	2005-01-19 23:03:08.946815320 -0800
+++ 25-akpm/arch/i386/kernel/nmi.c	2005-01-19 23:05:07.968721240 -0800
@@ -117,8 +117,10 @@ int __init check_nmi_watchdog (void)
 	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
            as they come up. */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+#ifdef CONFIG_SMP
 		if (!cpu_isset(cpu, cpu_callin_map))
 			continue;
+#endif
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			nmi_active = 0;
diff -puN include/asm-i386/smp.h~i386-x86-64-fix-smp-nmi-watchdog-race-fix include/asm-i386/smp.h
_

