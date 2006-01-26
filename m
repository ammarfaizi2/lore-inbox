Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWAZUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWAZUdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWAZUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:33:43 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14492 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932242AbWAZUdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:33:42 -0500
Subject: arch/i386/kernel/nmi.c: fix compiler warning
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 15:33:44 -0500
Message-Id: <1138307625.30814.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/nmi.c: In function 'check_nmi_watchdog':
arch/i386/kernel/nmi.c:139: warning: statement with no effect

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.16-rc1/arch/i386/kernel/nmi.c~	2006-01-17 02:44:47.000000000 -0500
+++ linux-2.6.16-rc1/arch/i386/kernel/nmi.c	2006-01-26 15:30:59.000000000 -0500
@@ -135,8 +135,10 @@
 
 	printk(KERN_INFO "Testing NMI watchdog ... ");
 
+#ifdef CONFIG_SMP
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
+#endif
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;


