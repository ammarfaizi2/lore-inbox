Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267845AbTAMML6>; Mon, 13 Jan 2003 07:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbTAMML6>; Mon, 13 Jan 2003 07:11:58 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61124 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267845AbTAMML5>;
	Mon, 13 Jan 2003 07:11:57 -0500
Date: Mon, 13 Jan 2003 18:03:23 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, paulus@au1.ibm.com
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 2/4 -- ppc arch
Message-ID: <20030113123323.GD2714@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113122835.GC2714@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one's for ppc.


diff -ruN -X dontdiff linux-2.5.55/arch/ppc/kernel/smp.c prof_counter-2.5.55/arch/ppc/kernel/smp.c
--- linux-2.5.55/arch/ppc/kernel/smp.c	Thu Jan  9 09:34:25 2003
+++ prof_counter-2.5.55/arch/ppc/kernel/smp.c	Mon Jan 13 14:20:04 2003
@@ -45,7 +45,7 @@
 atomic_t ipi_recv;
 atomic_t ipi_sent;
 unsigned int prof_multiplier[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
-unsigned int prof_counter[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
+DEFINE_PER_CPU(unsigned int, prof_counter) = 1;
 unsigned long cache_decay_ticks = HZ/100;
 unsigned long cpu_online_map = 1UL;
 unsigned long cpu_possible_map = 1UL;
@@ -90,9 +90,9 @@
 {
 	int cpu = smp_processor_id();
 
-	if (!--prof_counter[cpu]) {
+	if (!--per_cpu(prof_counter, cpu)) {
 		update_process_times(user_mode(regs));
-		prof_counter[cpu]=prof_multiplier[cpu];
+		per_cpu(prof_counter, cpu)=prof_multiplier[cpu];
 	}
 }
 
