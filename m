Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSKETh1>; Tue, 5 Nov 2002 14:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbSKETh1>; Tue, 5 Nov 2002 14:37:27 -0500
Received: from [202.88.171.30] ([202.88.171.30]:6819 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S265098AbSKEThZ>;
	Tue, 5 Nov 2002 14:37:25 -0500
Date: Wed, 6 Nov 2002 01:11:00 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] kernel_stat cleanup
Message-ID: <20021106011100.A28528@dikhow>
Reply-To: dipankar@gamebox.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial cleanup removing two old unused macros from
kernel_stat.h that made no sense with the new per-CPU kstat.
Also included a few finicky coding style changes. Please apply.

Thanks
Dipankar


diff -urN linux-2.5.46-base/include/linux/kernel_stat.h linux-2.5.46-misc/include/linux/kernel_stat.h
--- linux-2.5.46-base/include/linux/kernel_stat.h	Tue Nov  5 21:58:28 2002
+++ linux-2.5.46-misc/include/linux/kernel_stat.h	Tue Nov  5 23:22:05 2002
@@ -35,23 +35,16 @@
 
 extern unsigned long nr_context_switches(void);
 
-/*
- * Maybe we need to smp-ify kernel_stat some day. It would be nice to do
- * that without having to modify all the code that increments the stats.
- */
-#define KERNEL_STAT_INC(x) kstat.x++
-#define KERNEL_STAT_ADD(x, y) kstat.x += y
-
 #if !defined(CONFIG_ARCH_S390)
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
-static inline int kstat_irqs (int irq)
+static inline int kstat_irqs(int irq)
 {
 	int i, sum=0;
 
-	for (i = 0 ; i < NR_CPUS ; i++) 
-		if (cpu_possible(i)) 
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
 			sum += kstat_cpu(i).irqs[irq];
 
 	return sum;
