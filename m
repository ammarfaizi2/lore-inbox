Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTEJHzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbTEJHzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:55:43 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:36226
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263673AbTEJHzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:55:42 -0400
Date: Sat, 10 May 2003 03:59:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: CPU Freq ML <cpufreq@www.linux.org.uk>
Subject: [PATCH][2.5] Commented out printk causes change in program flow in
 cpufreq/p4-clockmod.c
Message-ID: <Pine.LNX.4.50.0305100338520.11047-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.69/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p4-clockmod.c
--- linux-2.5.69/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	6 May 2003 12:20:51 -0000	1.1.1.1
+++ linux-2.5.69/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	10 May 2003 07:30:20 -0000
@@ -104,18 +104,20 @@ static int cpufreq_p4_setdc(unsigned int
 	}
 
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
+#if 0
 	if (l & 0x01)
-//		printk(KERN_DEBUG PFX "CPU#%d currently thermal throttled\n", cpu);
-
+		printk(KERN_DEBUG PFX "CPU#%d currently thermal throttled\n", cpu);
+#endif
 	if (has_N44_O17_errata[cpu] && (newstate == DC_25PT || newstate == DC_DFLT))
 		newstate = DC_38PT;
 
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
 	if (newstate == DC_DISABLE) {
-//		printk(KERN_INFO PFX "CPU#%d disabling modulation\n", cpu);
+		/* printk(KERN_INFO PFX "CPU#%d disabling modulation\n", cpu); */
 		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 	} else {
-//		printk(KERN_INFO PFX "CPU#%d setting duty cycle to %d%%\n", cpu, ((125 * newstate) / 10));
+		/* printk(KERN_INFO PFX "CPU#%d setting duty cycle to %d%%\n",
+			cpu, ((125 * newstate) / 10)); */
 		/* bits 63 - 5	: reserved 
 		 * bit  4	: enable/disable
 		 * bits 3-1	: duty cycle

-- 
function.linuxpower.ca
