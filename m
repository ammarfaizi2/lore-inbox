Return-Path: <linux-kernel-owner+w=401wt.eu-S1761343AbWLJQAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761343AbWLJQAm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761625AbWLJQAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:00:42 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:5066 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761343AbWLJQAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:00:41 -0500
Message-Id: <20061210160004.373995000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 10 Dec 2006 08:00:04 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] kernel/latency_trace.c cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, just broke up some long lines.

Although I didn't touch the long lines made up of strings.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/latency_trace.c |   62 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 41 insertions(+), 21 deletions(-)

Index: linux-2.6.19/kernel/latency_trace.c
===================================================================
--- linux-2.6.19.orig/kernel/latency_trace.c
+++ linux-2.6.19/kernel/latency_trace.c
@@ -594,7 +594,8 @@ ____trace(int cpu, enum trace_type type,
 #ifdef CONFIG_DEBUG_PREEMPT
 //	WARN_ON(!atomic_read(&tr->disabled));
 #endif
-	if (!tr->critical_start && !trace_user_triggered && !trace_all_cpus && !trace_print_at_crash && !print_functions)
+	if (!tr->critical_start && !trace_user_triggered && !trace_all_cpus &&
+	    !trace_print_at_crash && !print_functions)
 		goto out;
 	/*
 	 * Allocate the next index. Make sure an NMI (or interrupt)
@@ -713,7 +714,8 @@ ___trace(enum trace_type type, unsigned 
 	 * is waiting to become runnable:
 	 */
 #ifdef CONFIG_WAKEUP_TIMING
-	if (wakeup_timing && !trace_all_cpus && !trace_print_at_crash && !print_functions) {
+	if (wakeup_timing && !trace_all_cpus && !trace_print_at_crash &&
+	    !print_functions) {
 		if (!sch.tr || cpu != sch.cpu)
 			goto out;
 		tr = sch.tr;
@@ -759,7 +761,8 @@ EXPORT_SYMBOL(trace_special_pid);
 void notrace trace_special_u64(unsigned long long v1, unsigned long v2)
 {
 	___trace(TRACE_SPECIAL_U64, CALLER_ADDR0, 0,
-		 (unsigned long) (v1 >> 32), (unsigned long) (v1 & 0xFFFFFFFF), v2);
+		 (unsigned long) (v1 >> 32), (unsigned long) (v1 & 0xFFFFFFFF),
+		 v2);
 }
 
 EXPORT_SYMBOL(trace_special_u64);
@@ -828,7 +831,8 @@ sys_call(unsigned long nr, unsigned long
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86)
 
 void notrace
-sys_ia32_call(unsigned long nr, unsigned long p1, unsigned long p2, unsigned long p3)
+sys_ia32_call(unsigned long nr, unsigned long p1, unsigned long p2,
+	      unsigned long p3)
 {
 	if (syscall_tracing)
 		___trace(TRACE_SYSCALL, nr | 0x80000000, 0, p1, p2, p3);
@@ -991,7 +995,8 @@ static int min_idx(struct block_idx *bid
 		if (idx >= min(max_tr.traces[cpu].trace_idx, MAX_TRACE))
 			continue;
 		if (idx >= MAX_TRACE*NR_CPUS) {
-			printk("huh: idx (%d) > %ld*%d!\n", idx, MAX_TRACE, NR_CPUS);
+			printk("huh: idx (%d) > %ld*%d!\n", idx, MAX_TRACE,
+				NR_CPUS);
 			WARN_ON(1);
 			break;
 		}
@@ -1085,7 +1090,8 @@ static void update_out_trace(void)
 		for_each_online_cpu(cpu) {
 			tmp_max = max_tr.traces + cpu;
 			entries = min(tmp_max->trace_idx, MAX_TRACE);
-			printk("CPU%d: %016Lx (%016Lx) ... #%d (%016Lx) %016Lx\n", cpu,
+			printk("CPU%d: %016Lx (%016Lx) ... #%d (%016Lx) %016Lx\n",
+				cpu,
 				tmp_max->trace[0].timestamp,
 				tmp_max->trace[1].timestamp,
 				entries,
@@ -1136,7 +1142,8 @@ static void update_out_trace(void)
 		out_entry++;
 		sum++;
 		if (sum >= MAX_TRACE*NR_CPUS) {
-			printk("huh: sum (%d) > %ld*%d!\n", sum, MAX_TRACE, NR_CPUS);
+			printk("huh: sum (%d) > %ld*%d!\n", sum, MAX_TRACE,
+				NR_CPUS);
 			WARN_ON(1);
 			break;
 		}
@@ -1194,11 +1201,14 @@ static void * notrace l_start(struct seq
 	entries = min(tr->trace_idx, MAX_TRACE);
 
 	if (!n) {
-		seq_printf(m, "preemption latency trace v1.1.5 on %s\n", UTS_RELEASE);
+		seq_printf(m, "preemption latency trace v1.1.5 on %s\n",
+			   UTS_RELEASE);
 		seq_puts(m, "--------------------------------------------------------------------\n");
 		seq_printf(m, " latency: %lu us, #%lu/%lu, CPU#%d | (M:%s VP:%d, KP:%d, SP:%d HP:%d",
 			cycles_to_usecs(tr->saved_latency),
-			entries, entries + atomic_read(&tr->underrun) + atomic_read(&tr->overrun),
+			entries,
+			(entries + atomic_read(&tr->underrun) +
+			 atomic_read(&tr->overrun)),
 			out_tr.cpu,
 #if defined(CONFIG_PREEMPT_NONE)
 			"server",
@@ -1394,7 +1404,8 @@ static int notrace l_show_special(struct
 			seq_printf(m, "%lx)\n", entry->u.special.v3);
 	} else {
 		seq_printf(m, " (%lx%8lx %lx)\n",
-			   entry->u.special.v1, entry->u.special.v2, entry->u.special.v3);
+			   entry->u.special.v1, entry->u.special.v2,
+			   entry->u.special.v3);
 	}
 	return 0;
 }
@@ -1578,7 +1589,8 @@ static int notrace l_show(struct seq_fil
 			l_show_special(m, trace_idx, entry, entry0, next_entry, 1);
 			break;
 		case TRACE_SPECIAL_SYM:
-			l_show_special_sym(m, trace_idx, entry, entry0, next_entry, 1);
+			l_show_special_sym(m, trace_idx, entry, entry0,
+					   next_entry, 1);
 			break;
 		case TRACE_CMDLINE:
 			l_show_cmdline(m, trace_idx, entry, entry0, next_entry);
@@ -1619,8 +1631,8 @@ static void update_max_tr(struct cpu_tra
 	max_tr.cpu = tr->cpu;
 	save = max_tr.traces + tr->cpu;
 
-	if ((wakeup_timing || trace_user_triggered || trace_print_at_crash || print_functions) &&
-				trace_all_cpus) {
+	if ((wakeup_timing || trace_user_triggered || trace_print_at_crash ||
+	     print_functions) && trace_all_cpus) {
 		all_cpus = 1;
 		for_each_online_cpu(cpu)
 			atomic_inc(&cpu_traces[cpu].disabled);
@@ -1952,7 +1964,8 @@ void notrace trace_hardirqs_off(void)
 	local_save_flags(flags);
 
 	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
-		__start_critical_timing(CALLER_ADDR0, 0 /* CALLER_ADDR1 */, INTERRUPT_LATENCY);
+		__start_critical_timing(CALLER_ADDR0, 0 /* CALLER_ADDR1 */,
+					INTERRUPT_LATENCY);
 }
 
 EXPORT_SYMBOL(trace_hardirqs_off);
@@ -2014,7 +2027,8 @@ void notrace add_preempt_count(unsigned 
 		if (!irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == val)
-				__start_critical_timing(eip, parent_eip, PREEMPT_LATENCY);
+				__start_critical_timing(eip, parent_eip,
+							PREEMPT_LATENCY);
 	}
 #endif
 	(void)eip, (void)parent_eip;
@@ -2032,7 +2046,8 @@ void notrace sub_preempt_count(unsigned 
 	/*
 	 * Is the spinlock portion underflowing?
 	 */
-	if (DEBUG_WARN_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK)))
+	if (DEBUG_WARN_ON((val < PREEMPT_MASK) &&
+			  !(preempt_count() & PREEMPT_MASK)))
 		return;
 #endif
 
@@ -2046,7 +2061,8 @@ void notrace sub_preempt_count(unsigned 
 		if (!irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == val)
-				__stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+				__stop_critical_timing(CALLER_ADDR0,
+						       CALLER_ADDR1);
 	}
 #endif
 	preempt_count() -= val;
@@ -2071,7 +2087,8 @@ void notrace mask_preempt_count(unsigned
 		if (!irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == mask)
-				__start_critical_timing(eip, parent_eip, PREEMPT_LATENCY);
+				__start_critical_timing(eip, parent_eip,
+							PREEMPT_LATENCY);
 	}
 #endif
 	(void) eip, (void) parent_eip;
@@ -2090,7 +2107,8 @@ void notrace unmask_preempt_count(unsign
 		if (!irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == mask)
-				__stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+				__stop_critical_timing(CALLER_ADDR0,
+						       CALLER_ADDR1);
 	}
 #endif
 	preempt_count() &= ~mask;
@@ -2136,7 +2154,8 @@ check_wakeup_timing(struct cpu_trace *tr
 	if (!report_latency(delta))
 		goto out;
 
-	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, *flags);
+	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip,
+		  0, 0, 0, *flags);
 
 	latency = cycles_to_usecs(delta);
 	latency_hist(tr->latency_type, cpu, latency);
@@ -2262,7 +2281,8 @@ void trace_stop_sched_switched(struct ta
 		check_wakeup_timing(tr, CALLER_ADDR0, &flags);
 	} else {
 		if (sch.task)
-			trace_special_pid(sch.task->pid, sch.task->prio, p->prio);
+			trace_special_pid(sch.task->pid, sch.task->prio,
+					  p->prio);
 		if (sch.task && (sch.task->prio >= p->prio))
 			sch.task = NULL;
 		__raw_spin_unlock(&sch.trace_lock);
--
