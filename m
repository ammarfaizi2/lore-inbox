Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSLVLCH>; Sun, 22 Dec 2002 06:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSLVLCH>; Sun, 22 Dec 2002 06:02:07 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:19643 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266120AbSLVLCF>; Sun, 22 Dec 2002 06:02:05 -0500
Date: Sun, 22 Dec 2002 12:10:14 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] cpufreq: compile fix for !CONFIG_CPU_FREQ
Message-ID: <20021222111013.GA11988@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on the x86-loops-per-jiffy notifier patch sent yesterday.

diff -ruN linux-original/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-original/arch/i386/kernel/cpu/common.c	2002-12-22 11:13:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/common.c	2002-12-22 12:06:29.000000000 +0100
@@ -387,9 +387,11 @@
 		for ( i = 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
+#ifdef CONFIG_CPU_FREQ
 	if (c == &boot_cpu_data) {
 			cpufreq_register_notifier(&loops_per_jiffy_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 	}
+#endif
 
 	printk(KERN_DEBUG "CPU:             Common caps: %08lx %08lx %08lx %08lx\n",
 	       boot_cpu_data.x86_capability[0],
