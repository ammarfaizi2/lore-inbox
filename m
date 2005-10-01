Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVJAG45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVJAG45 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 02:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVJAG45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 02:56:57 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:32765 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750752AbVJAG44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 02:56:56 -0400
Date: Fri, 30 Sep 2005 23:56:54 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] [CPUFREQ] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001065654.GE25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -595,12 +595,11 @@ static int cpufreq_add_dev (struct sys_d
 		goto module_out;
 	}
 
-	policy = kmalloc(sizeof(struct cpufreq_policy), GFP_KERNEL);
+	policy = kzalloc(sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!policy) {
 		ret = -ENOMEM;
 		goto nomem_out;
 	}
-	memset(policy, 0, sizeof(struct cpufreq_policy));
 
 	policy->cpu = cpu;
 	policy->cpus = cpumask_of_cpu(cpu);
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -192,9 +192,8 @@ cpufreq_stats_create_table (struct cpufr
 	unsigned int cpu = policy->cpu;
 	if (cpufreq_stats_table[cpu])
 		return -EBUSY;
-	if ((stat = kmalloc(sizeof(struct cpufreq_stats), GFP_KERNEL)) == NULL)
+	if ((stat = kzalloc(sizeof(struct cpufreq_stats), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(stat, 0, sizeof (struct cpufreq_stats));
 
 	data = cpufreq_cpu_get(cpu);
 	if ((ret = sysfs_create_group(&data->kobj, &stats_attr_group)))
@@ -216,12 +215,11 @@ cpufreq_stats_create_table (struct cpufr
 	alloc_size += count * count * sizeof(int);
 #endif
 	stat->max_state = count;
-	stat->time_in_state = kmalloc(alloc_size, GFP_KERNEL);
+	stat->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
 	if (!stat->time_in_state) {
 		ret = -ENOMEM;
 		goto error_out;
 	}
-	memset(stat->time_in_state, 0, alloc_size);
 	stat->freq_table = (unsigned int *)(stat->time_in_state + count);
 
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
