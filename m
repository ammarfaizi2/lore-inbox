Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263619AbUJ3HX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbUJ3HX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 03:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUJ3HX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 03:23:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53253 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263619AbUJ3HXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 03:23:18 -0400
Date: Sat, 30 Oct 2004 09:22:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small cpufreq cleanup
Message-ID: <20041030072246.GG4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below does the following cleanups in the cpufreq code:
- remove the __deprecated cpufreq_set{,max} functions that didn't have
  any users left
- make cpufreq_gov_dbs static

cpufreq_driver_target and cpufreq_governor in drivers/cpufreq/cpufreq.c 
also both have currently exactly zero in-kernel users, but I left them.


diffstat output:
 drivers/cpufreq/cpufreq_ondemand.c  |    3 +--
 drivers/cpufreq/cpufreq_userspace.c |   21 ---------------------
 include/linux/cpufreq.h             |    3 ---
 3 files changed, 1 insertion(+), 26 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/include/linux/cpufreq.h.old	2004-10-30 08:02:34.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/include/linux/cpufreq.h	2004-10-30 08:03:07.000000000 +0200
@@ -261,9 +261,6 @@
  *********************************************************************/
 #ifdef CONFIG_CPU_FREQ_24_API
 
-int __deprecated cpufreq_setmax(unsigned int cpu);
-int __deprecated cpufreq_set(unsigned int kHz, unsigned int cpu);
-
 
 /* /proc/sys/cpu */
 enum {
--- linux-2.6.10-rc1-mm2-full/drivers/cpufreq/cpufreq_userspace.c.old	2004-10-30 08:05:10.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/cpufreq/cpufreq_userspace.c	2004-10-30 08:06:04.000000000 +0200
@@ -141,27 +141,6 @@
 
 static unsigned int warning_print = 0;
 
-int __deprecated cpufreq_set(unsigned int freq, unsigned int cpu)
-{
-	return _cpufreq_set(freq, cpu);
-}
-EXPORT_SYMBOL_GPL(cpufreq_set);
-
-
-/** 
- * cpufreq_setmax - set the CPU to the maximum frequency
- * @cpu - affected cpu;
- *
- * Sets the CPU frequency to the maximum frequency supported by
- * this CPU.
- */
-int __deprecated cpufreq_setmax(unsigned int cpu)
-{
-	if (!cpu_is_managed[cpu] || !cpu_online(cpu))
-		return -EINVAL;
-	return _cpufreq_set(cpu_max_freq[cpu], cpu);
-}
-EXPORT_SYMBOL_GPL(cpufreq_setmax);
 
 /*********************** cpufreq_sysctl interface ********************/
 static int
--- linux-2.6.10-rc1-mm2-full/drivers/cpufreq/cpufreq_ondemand.c.old	2004-10-30 07:58:22.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/cpufreq/cpufreq_ondemand.c	2004-10-30 07:59:05.000000000 +0200
@@ -410,12 +410,11 @@
 	return 0;
 }
 
-struct cpufreq_governor cpufreq_gov_dbs = {
+static struct cpufreq_governor cpufreq_gov_dbs = {
 	.name		= "ondemand",
 	.governor	= cpufreq_governor_dbs,
 	.owner		= THIS_MODULE,
 };
-EXPORT_SYMBOL(cpufreq_gov_dbs);
 
 static int __init cpufreq_gov_dbs_init(void)
 {

