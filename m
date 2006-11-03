Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWKCUXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWKCUXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWKCUXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:23:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:15825 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932068AbWKCUXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:23:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=URbI7u77LDoK+33sNLaMHKOW4YvOkGyvfS9w3YdN6XTD+bDu8Dc16jmBr3mjVvh9ty6ZGHJ4SM9Cd3PbjOwYsWiDIwVLjjwmAyW+lNq4Q42rCEUPGR1NoZrBWnN1ZIvJw6A0isXUzGbx/WnoiRQoX9TQqBwSXNsATJ/bHERKaxE=
Date: Fri, 3 Nov 2006 21:23:37 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sched.c: small cleanup
Message-Id: <20061103212337.fc518059.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

small cleanup for kernel/sched.c

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..9527758 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -464,7 +464,8 @@ static int show_schedstat(struct seq_fil
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
 					itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu",
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu"
+				    " %lu",
 				    sd->lb_cnt[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -474,11 +475,13 @@ static int show_schedstat(struct seq_fil
 				    sd->lb_nobusyq[itype],
 				    sd->lb_nobusyg[itype]);
 			}
-			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
+			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu"
+			    " %lu %lu %lu\n",
 			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
 			    sd->sbe_cnt, sd->sbe_balanced, sd->sbe_pushed,
 			    sd->sbf_cnt, sd->sbf_balanced, sd->sbf_pushed,
-			    sd->ttwu_wake_remote, sd->ttwu_move_affine, sd->ttwu_move_balance);
+			    sd->ttwu_wake_remote, sd->ttwu_move_affine,
+			    sd->ttwu_move_balance);
 		}
 		preempt_enable();
 #endif
@@ -1439,7 +1442,8 @@ static int try_to_wake_up(struct task_st
 
 		if (this_sd->flags & SD_WAKE_AFFINE) {
 			unsigned long tl = this_load;
-			unsigned long tl_per_task = cpu_avg_load_per_task(this_cpu);
+			unsigned long tl_per_task =
+				cpu_avg_load_per_task(this_cpu);
 
 			/*
 			 * If sync wakeup then subtract the (maximum possible)
@@ -2447,18 +2451,21 @@ small_imbalance:
 		pwr_now /= SCHED_LOAD_SCALE;
 
 		/* Amount of load we'd subtract */
-		tmp = busiest_load_per_task*SCHED_LOAD_SCALE/busiest->cpu_power;
+		tmp = busiest_load_per_task * SCHED_LOAD_SCALE /
+			busiest->cpu_power;
 		if (max_load > tmp)
 			pwr_move += busiest->cpu_power *
 				min(busiest_load_per_task, max_load - tmp);
 
 		/* Amount of load we'd add */
-		if (max_load*busiest->cpu_power <
-				busiest_load_per_task*SCHED_LOAD_SCALE)
-			tmp = max_load*busiest->cpu_power/this->cpu_power;
+		if (max_load * busiest->cpu_power <
+				busiest_load_per_task * SCHED_LOAD_SCALE)
+			tmp = max_load * busiest->cpu_power / this->cpu_power;
 		else
-			tmp = busiest_load_per_task*SCHED_LOAD_SCALE/this->cpu_power;
-		pwr_move += this->cpu_power*min(this_load_per_task, this_load + tmp);
+			tmp = busiest_load_per_task * SCHED_LOAD_SCALE / 
+				this->cpu_power;
+		pwr_move += this->cpu_power *
+			min(this_load_per_task, this_load + tmp);
 		pwr_move /= SCHED_LOAD_SCALE;
 
 		/* Move if we gain throughput */
@@ -3280,7 +3287,8 @@ void fastcall add_preempt_count(int val)
 	/*
 	 * Spinlock count overflowing soon?
 	 */
-	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
+	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
+		PREEMPT_MASK - 10);
 }
 EXPORT_SYMBOL(add_preempt_count);
 
@@ -5342,16 +5350,19 @@ static void sched_domain_debug(struct sc
 		if (!(sd->flags & SD_LOAD_BALANCE)) {
 			printk("does not load-balance\n");
 			if (sd->parent)
-				printk(KERN_ERR "ERROR: !SD_LOAD_BALANCE domain has parent");
+				printk(KERN_ERR "ERROR: "
+					"!SD_LOAD_BALANCE domain has parent");
 			break;
 		}
 
 		printk("span %s\n", str);
 
 		if (!cpu_isset(cpu, sd->span))
-			printk(KERN_ERR "ERROR: domain->span does not contain CPU%d\n", cpu);
+			printk(KERN_ERR "ERROR: "
+				"domain->span does not contain CPU%d\n", cpu);
 		if (!cpu_isset(cpu, group->cpumask))
-			printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
+			printk(KERN_ERR "ERROR: "
+				"domain->groups does not contain CPU%d\n", cpu);
 
 		printk(KERN_DEBUG);
 		for (i = 0; i < level + 2; i++)
@@ -5366,7 +5377,8 @@ static void sched_domain_debug(struct sc
 
 			if (!group->cpu_power) {
 				printk("\n");
-				printk(KERN_ERR "ERROR: domain->cpu_power not set\n");
+				printk(KERN_ERR "ERROR: "
+					"domain->cpu_power not set\n");
 			}
 
 			if (!cpus_weight(group->cpumask)) {
@@ -5389,14 +5401,17 @@ static void sched_domain_debug(struct sc
 		printk("\n");
 
 		if (!cpus_equal(sd->span, groupmask))
-			printk(KERN_ERR "ERROR: groups don't span domain->span\n");
+			printk(KERN_ERR "ERROR: "
+				"groups don't span domain->span\n");
 
 		level++;
 		sd = sd->parent;
 
 		if (sd) {
 			if (!cpus_subset(groupmask, sd->span))
-				printk(KERN_ERR "ERROR: parent span is not a superset of domain->span\n");
+				printk(KERN_ERR "ERROR: "
+					"parent span is not a superset of "
+					"domain->span\n");
 		}
 
 	} while (sd);
@@ -5716,12 +5731,12 @@ __setup("max_cache_size=", setup_max_cac
  */
 static void touch_cache(void *__cache, unsigned long __size)
 {
-	unsigned long size = __size/sizeof(long), chunk1 = size/3,
-			chunk2 = 2*size/3;
+	unsigned long size = __size / sizeof(long), chunk1 = size / 3,
+			chunk2 = 2 * size / 3;
 	unsigned long *cache = __cache;
 	int i;
 
-	for (i = 0; i < size/6; i += 8) {
+	for (i = 0; i < size / 6; i += 8) {
 		switch (i % 6) {
 			case 0: cache[i]++;
 			case 1: cache[size-1-i]++;
@@ -5826,11 +5841,11 @@ measure_cost(int cpu1, int cpu2, void *c
 	 */
 	measure_one(cache, size, cpu1, cpu2);
 	for (i = 0; i < ITERATIONS; i++)
-		cost1 += measure_one(cache, size - i*1024, cpu1, cpu2);
+		cost1 += measure_one(cache, size - i * 1024, cpu1, cpu2);
 
 	measure_one(cache, size, cpu2, cpu1);
 	for (i = 0; i < ITERATIONS; i++)
-		cost1 += measure_one(cache, size - i*1024, cpu2, cpu1);
+		cost1 += measure_one(cache, size - i * 1024, cpu2, cpu1);
 
 	/*
 	 * (We measure the non-migrating [cached] cost on both
@@ -5840,17 +5855,17 @@ measure_cost(int cpu1, int cpu2, void *c
 
 	measure_one(cache, size, cpu1, cpu1);
 	for (i = 0; i < ITERATIONS; i++)
-		cost2 += measure_one(cache, size - i*1024, cpu1, cpu1);
+		cost2 += measure_one(cache, size - i * 1024, cpu1, cpu1);
 
 	measure_one(cache, size, cpu2, cpu2);
 	for (i = 0; i < ITERATIONS; i++)
-		cost2 += measure_one(cache, size - i*1024, cpu2, cpu2);
+		cost2 += measure_one(cache, size - i * 1024, cpu2, cpu2);
 
 	/*
 	 * Get the per-iteration migration cost:
 	 */
-	do_div(cost1, 2*ITERATIONS);
-	do_div(cost2, 2*ITERATIONS);
+	do_div(cost1, 2 * ITERATIONS);
+	do_div(cost2, 2 * ITERATIONS);
 
 	return cost1 - cost2;
 }
@@ -5888,7 +5903,7 @@ static unsigned long long measure_migrat
 	 */
 	cache = vmalloc(max_size);
 	if (!cache) {
-		printk("could not vmalloc %d bytes for cache!\n", 2*max_size);
+		printk("could not vmalloc %d bytes for cache!\n", 2 * max_size);
 		return 1000000; /* return 1 msec on very small boxen */
 	}
 
@@ -5913,7 +5928,8 @@ static unsigned long long measure_migrat
 		avg_fluct = (avg_fluct + fluct)/2;
 
 		if (migration_debug)
-			printk("-> [%d][%d][%7d] %3ld.%ld [%3ld.%ld] (%ld): (%8Ld %8Ld)\n",
+			printk("-> [%d][%d][%7d] %3ld.%ld [%3ld.%ld] (%ld): "
+				"(%8Ld %8Ld)\n",
 				cpu1, cpu2, size,
 				(long)cost / 1000000,
 				((long)cost / 100000) % 10,
@@ -6011,17 +6027,19 @@ static void calibrate_migration_costs(co
 	if (system_state == SYSTEM_BOOTING) {
 		if (num_online_cpus() > 1) {
 			printk("migration_cost=");
-			for (distance = 0; distance <= max_distance; distance++) {
+			for (distance = 0; distance <= max_distance;
+				distance++) {
 				if (distance)
 					printk(",");
-				printk("%ld", (long)migration_cost[distance] / 1000);
+				printk("%ld",
+					(long)migration_cost[distance] / 1000);
 			}
 			printk("\n");
 		}
 	}
 	j1 = jiffies;
 	if (migration_debug)
-		printk("migration: %ld seconds\n", (j1-j0)/HZ);
+		printk("migration: %ld seconds\n", (j1-j0) / HZ);
 
 	/*
 	 * Move back to the original CPU. NUMA-Q gets confused
@@ -6348,11 +6366,10 @@ static int build_sched_domains(const cpu
 		if (cpus_weight(*cpu_map)
 				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
 			if (!sched_group_allnodes) {
-				sched_group_allnodes
-					= kmalloc_node(sizeof(struct sched_group)
-						  	* MAX_NUMNODES,
-						  GFP_KERNEL,
-						  cpu_to_node(i));
+				sched_group_allnodes = kmalloc_node(
+					sizeof(struct sched_group)*MAX_NUMNODES,
+					GFP_KERNEL,
+					cpu_to_node(i));
 				if (!sched_group_allnodes) {
 					printk(KERN_WARNING
 					"Can not alloc allnodes sched group\n");
