Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVBCSof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVBCSof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbVBCSod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:44:33 -0500
Received: from linux.us.dell.com ([143.166.224.162]:26518 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263638AbVBCRyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:54:25 -0500
Date: Thu, 3 Feb 2005 11:53:52 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2.6.11-rc3] cpufreq-core: reduce warning messages
Message-ID: <20050203175352.GA27123@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq core is printing out messages at KERN_WARNING level that the
core recovers from without intervention, and that the system
administrator can do nothing about.  Patch below reduces the severity
of these messages to debug.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== cpufreq.c 1.94 vs edited =====
--- 1.94/drivers/cpufreq/cpufreq.c	2005-01-20 23:02:15 -06:00
+++ edited/cpufreq.c	2005-02-03 11:16:16 -06:00
@@ -258,7 +258,7 @@ void cpufreq_notify_transition(struct cp
 			    (likely(cpufreq_cpu_data[freqs->cpu]->cur)) &&
 			    (unlikely(freqs->old != cpufreq_cpu_data[freqs->cpu]->cur)))
 			{
-				printk(KERN_WARNING "Warning: CPU frequency is %u, "
+				dprintk("CPU frequency is %u, "
 				       "cpufreq assumed %u kHz.\n", freqs->old, cpufreq_cpu_data[freqs->cpu]->cur);
 				freqs->old = cpufreq_cpu_data[freqs->cpu]->cur;
 			}
@@ -814,7 +814,7 @@ static void cpufreq_out_of_sync(unsigned
 {
 	struct cpufreq_freqs freqs;
 
-	printk(KERN_WARNING "Warning: CPU frequency out of sync: cpufreq and timing "
+	dprintk("CPU frequency out of sync: cpufreq and timing "
 	       "core thinks of %u, is %u kHz.\n", old_freq, new_freq);
 
 	freqs.cpu = cpu;
@@ -919,7 +919,7 @@ static int cpufreq_resume(struct sys_dev
 		if (unlikely(cur_freq != cpu_policy->cur)) {
 			struct cpufreq_freqs freqs;
 
-			printk(KERN_WARNING "Warning: CPU frequency is %u, "
+			dprintk("CPU frequency is %u, "
 			       "cpufreq assumed %u kHz.\n", cur_freq, cpu_policy->cur);
 
 			freqs.cpu = cpu;
