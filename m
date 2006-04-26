Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWDZNhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWDZNhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDZNhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:37:31 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:22322
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932328AbWDZNhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:37:31 -0400
Message-Id: <444F93E5.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:38:13 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <cpufreq@lists.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq {d,}printk adjustments
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert some dprintk-s to printk-s as their use of KERN_* indicates they
were meant to be used that way. Alternatively, the KERN_* prefixes could
be removed and the dprintk-s then retained.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/drivers/cpufreq/cpufreq.c
2.6.17-rc2-cpufreq-dprintk/drivers/cpufreq/cpufreq.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/drivers/cpufreq/cpufreq.c	2006-04-26 11:50:31.667747992 +0200
+++ 2.6.17-rc2-cpufreq-dprintk/drivers/cpufreq/cpufreq.c	2006-04-24 12:28:37.000000000 +0200
@@ -257,9 +257,9 @@ void cpufreq_notify_transition(struct cp
 		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
 			if ((policy) && (policy->cpu == freqs->cpu) &&
 			    (policy->cur) && (policy->cur != freqs->old)) {
-				dprintk(KERN_WARNING "Warning: CPU frequency is"
-					" %u, cpufreq assumed %u kHz.\n",
-					freqs->old, policy->cur);
+				printk(KERN_WARNING "Warning: CPU frequency is"
+				       " %u, cpufreq assumed %u kHz.\n",
+				       freqs->old, policy->cur);
 				freqs->old = policy->cur;
 			}
 		}
@@ -874,7 +874,7 @@ static void cpufreq_out_of_sync(unsigned
 {
 	struct cpufreq_freqs freqs;
 
-	dprintk(KERN_WARNING "Warning: CPU frequency out of sync: cpufreq and timing "
+	printk(KERN_WARNING "Warning: CPU frequency out of sync: cpufreq and timing "
 	       "core thinks of %u, is %u kHz.\n", old_freq, new_freq);
 
 	freqs.cpu = cpu;
@@ -1006,7 +1006,7 @@ static int cpufreq_suspend(struct sys_de
 		struct cpufreq_freqs freqs;
 
 		if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
-			dprintk(KERN_DEBUG "Warning: CPU frequency is %u, "
+			printk(KERN_WARNING "Warning: CPU frequency is %u, "
 			       "cpufreq assumed %u kHz.\n",
 			       cur_freq, cpu_policy->cur);
 
@@ -1087,7 +1087,7 @@ static int cpufreq_resume(struct sys_dev
 			struct cpufreq_freqs freqs;
 
 			if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
-				dprintk(KERN_WARNING "Warning: CPU frequency"
+				printk(KERN_WARNING "Warning: CPU frequency"
 				       "is %u, cpufreq assumed %u kHz.\n",
 				       cur_freq, cpu_policy->cur);
 


