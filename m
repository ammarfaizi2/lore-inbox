Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVDUH0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVDUH0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDUH0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:26:31 -0400
Received: from colino.net ([213.41.131.56]:13563 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261414AbVDUH0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:26:18 -0400
Date: Thu, 21 Apr 2005 09:26:11 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       debian-powerpc@lists.debian.org
Subject: 2.6.12-rc3 cpufreq compile error on ppc32
Message-ID: <20050421092611.37df940b@colin.toulouse>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

One of Ben's patches ("ppc32: Fix cpufreq problems") went in 2.6.12-
rc3, but it depended on another patch that's still in -mm only: 
add-suspend-method-to-cpufreq-core.patch

In addition to this, there's a third patch in -mm that fixes warnings
and line length to the previous patch, but it doesn't apply cleanly
anymore. It's named add-suspend-method-to-cpufreq-core-warning-fix.patch

Here's an updated version. HTH,

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/cpufreq/cpufreq.c	2005-04-21 09:14:28.000000000 +0200
+++ b/drivers/cpufreq/cpufreq.c	2005-04-21 09:18:11.000000000 +0200
@@ -955,7 +955,6 @@
 {
 	int cpu = sysdev->id;
 	unsigned int ret = 0;
-	unsigned int cur_freq = 0;
 	struct cpufreq_policy *cpu_policy;
 
 	dprintk("resuming cpu %u\n", cpu);
@@ -995,21 +994,24 @@
 			cur_freq = cpufreq_driver->get(cpu_policy->cpu);
 
 		if (!cur_freq || !cpu_policy->cur) {
-			printk(KERN_ERR "cpufreq: resume failed to assert current frequency is what timing core thinks it is.\n");
+			printk(KERN_ERR "cpufreq: resume failed to assert "
+					"current frequency is what timing core "
+					"thinks it is.\n");
 			goto out;
 		}
 
 		if (unlikely(cur_freq != cpu_policy->cur)) {
 			struct cpufreq_freqs freqs;
 
-			printk(KERN_WARNING "Warning: CPU frequency is %u, "
-			       "cpufreq assumed %u kHz.\n", cur_freq, cpu_policy->cur);
+			printk(KERN_WARNING "Warning: CPU frequency is %u, cpufreq assumed "
+					    "%u kHz.\n", cur_freq, cpu_policy->cur);
 
 			freqs.cpu = cpu;
 			freqs.old = cpu_policy->cur;
 			freqs.new = cur_freq;
 
-			notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_RESUMECHANGE, &freqs);
+			notifier_call_chain(&cpufreq_transition_notifier_list,
+						CPUFREQ_RESUMECHANGE, &freqs);
 			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
 
 			cpu_policy->cur = cur_freq;

