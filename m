Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUFGUYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUFGUYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUFGUYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:24:36 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:643 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S265036AbUFGUXh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:23:37 -0400
Message-Id: <200406072023.i57KNVoW000441@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>, mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.7-rc2-mm2 perfctr #if/#ifdef cleanup
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1854717721P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Jun 2004 16:23:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1854717721P
Content-Type: text/plain; charset=us-ascii

Cleaning up some #if/#ifdef confusion in the perfctr patch...

--- linux-2.6.7-rc2-mm2/drivers/perfctr/cpumask.h.ifdef	2004-06-03 21:49:39.000000000 -0400
+++ linux-2.6.7-rc2-mm2/drivers/perfctr/cpumask.h	2004-06-03 23:28:00.836549456 -0400
@@ -15,7 +15,7 @@
 
 /* `perfctr_cpus_forbidden_mask' used to be defined in <asm/perfctr.h>,
    but cpumask_t compatibility issues forced it to be moved here. */
-#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 extern cpumask_t perfctr_cpus_forbidden_mask;
 #define perfctr_cpu_is_forbidden(cpu)	cpu_isset((cpu), perfctr_cpus_forbidden_mask)
 #else
--- linux-2.6.7-rc2-mm2/drivers/perfctr/ppc.c.ifdef	2004-06-03 21:49:39.000000000 -0400
+++ linux-2.6.7-rc2-mm2/drivers/perfctr/ppc.c	2004-06-03 23:34:07.144098221 -0400
@@ -57,7 +57,7 @@ static unsigned int new_id(void)
 	return id;
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void perfctr_default_ihandler(unsigned long pc)
 {
 }
@@ -80,7 +80,7 @@ void perfctr_cpu_set_ihandler(perfctr_ih
 #define perfctr_cstatus_has_ictrs(cstatus)	0
 #endif
 
-#if defined(CONFIG_SMP) && PERFCTR_INTERRUPT_SUPPORT
+#if defined(CONFIG_SMP) && defined(PERFCTR_INTERRUPT_SUPPORT)
 
 static inline void
 set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
@@ -348,7 +348,7 @@ static int ppc_check_control(struct perf
 	return 0;
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void ppc_isuspend(struct perfctr_cpu_state *state)
 {
 	// XXX
@@ -442,7 +442,7 @@ static void perfctr_cpu_read_counters(/*
 	return ppc_read_counters(state, ctrs);
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
 {
 	return ppc_isuspend(state);
--- linux-2.6.7-rc2-mm2/drivers/perfctr/virtual.c.ifdef	2004-06-03 21:49:39.000000000 -0400
+++ linux-2.6.7-rc2-mm2/drivers/perfctr/virtual.c	2004-06-03 23:33:04.761690098 -0400
@@ -36,16 +36,16 @@ struct vperfctr {
 	/* sampling_timer and bad_cpus_allowed are frequently
 	   accessed, so they get to share a cache line */
 	unsigned int sampling_timer ____cacheline_aligned;
-#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 	atomic_t bad_cpus_allowed;
 #endif
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 	unsigned int iresume_cstatus;
 #endif
 };
 #define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 
 static void vperfctr_ihandler(unsigned long pc);
 
@@ -64,7 +64,7 @@ static inline void vperfctr_set_ihandler
 static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr) { }
 #endif
 
-#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 
 static inline void vperfctr_init_bad_cpus_allowed(struct vperfctr *perfctr)
 {
@@ -226,7 +226,7 @@ static void vperfctr_sample(struct vperf
 	}
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 /* vperfctr interrupt handler (XXX: add buffering support) */
 /* PREEMPT note: called in IRQ context with preemption disabled. */
 static void vperfctr_ihandler(unsigned long pc)
@@ -328,7 +328,7 @@ void __vperfctr_suspend(struct vperfctr 
 void __vperfctr_resume(struct vperfctr *perfctr)
 {
 	if (IS_RUNNING(perfctr)) {
-#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 		if (unlikely(atomic_read(&perfctr->bad_cpus_allowed)) &&
 		    perfctr_cstatus_nrctrs(perfctr->cpu_state.cstatus)) {
 			perfctr->cpu_state.cstatus = 0;
@@ -355,7 +355,7 @@ void __vperfctr_sample(struct vperfctr *
 		vperfctr_sample(perfctr);
 }
 
-#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 /* Called from set_cpus_allowed().
  * PRE: current holds task_lock(owner)
  * PRE: owner->thread.perfctr == perfctr
@@ -455,7 +455,7 @@ static int do_vperfctr_control(struct vp
 
 static int do_vperfctr_iresume(struct vperfctr *perfctr, const struct task_struct *tsk)
 {
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 	unsigned int iresume_cstatus;
 
 	if (!tsk)
--- linux-2.6.7-rc2-mm2/drivers/perfctr/x86.c.ifdef	2004-06-03 21:49:39.000000000 -0400
+++ linux-2.6.7-rc2-mm2/drivers/perfctr/x86.c	2004-06-03 23:35:36.452797807 -0400
@@ -140,7 +140,7 @@ static unsigned int new_id(void)
 	return id;
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void perfctr_default_ihandler(unsigned long pc)
 {
 }
@@ -171,7 +171,7 @@ void perfctr_cpu_set_ihandler(perfctr_ih
 #define apic_write(reg,vector)			do{}while(0)
 #endif
 
-#if defined(CONFIG_SMP) && PERFCTR_INTERRUPT_SUPPORT
+#if defined(CONFIG_SMP) && defined(PERFCTR_INTERRUPT_SUPPORT)
 
 static inline void
 set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
@@ -441,7 +441,7 @@ static int p6_check_control(struct perfc
 	return p6_like_check_control(state, 0);
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 /* PRE: perfctr_cstatus_has_ictrs(state->cstatus) != 0 */
 /* shared with K7 and P4 */
 static void p6_like_isuspend(struct perfctr_cpu_state *state,
@@ -576,7 +576,7 @@ static int k7_check_control(struct perfc
 	return p6_like_check_control(state, 1);
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void k7_isuspend(struct perfctr_cpu_state *state)
 {
 	p6_like_isuspend(state, MSR_K7_EVNTSEL0);
@@ -809,7 +809,7 @@ static int p4_check_control(struct perfc
 	return 0;
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void p4_isuspend(struct perfctr_cpu_state *state)
 {
 	return p6_like_isuspend(state, MSR_P4_CCCR0);
@@ -938,7 +938,7 @@ static noinline void perfctr_cpu_read_co
 	return read_counters(state, ctrs);
 }
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 static void (*cpu_isuspend)(struct perfctr_cpu_state*);
 static noinline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
 {
@@ -1257,7 +1257,7 @@ static int __init intel_init(void)
 		write_control = p6_write_control;
 		check_control = p6_check_control;
 		clear_counters = p6_clear_counters;
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 		if (cpu_has_apic) {
 			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
 			cpu_isuspend = p6_isuspend;
@@ -1284,7 +1284,7 @@ static int __init intel_init(void)
 		write_control = p4_write_control;
 		check_control = p4_check_control;
 		clear_counters = p4_clear_counters;
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 		if (cpu_has_apic) {
 			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
 			cpu_isuspend = p4_isuspend;
@@ -1316,7 +1316,7 @@ static int __init amd_init(void)
 	write_control = k7_write_control;
 	check_control = k7_check_control;
 	clear_counters = k7_clear_counters;
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 	if (cpu_has_apic) {
 		perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
 		cpu_isuspend = k7_isuspend;
--- linux-2.6.7-rc2-mm2/include/asm-ppc/perfctr.h.ifdef	2004-06-03 21:49:43.000000000 -0400
+++ linux-2.6.7-rc2-mm2/include/asm-ppc/perfctr.h	2004-06-03 23:38:48.137397246 -0400
@@ -155,7 +155,7 @@ typedef void (*perfctr_ihandler_t)(unsig
    does not yet enable this due to an erratum in 750/7400/7410. */
 //#define PERFCTR_INTERRUPT_SUPPORT 1
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
 extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
 extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
--- linux-2.6.7-rc2-mm2/include/linux/perfctr.h.ifdef	2004-06-03 21:49:44.000000000 -0400
+++ linux-2.6.7-rc2-mm2/include/linux/perfctr.h	2004-06-03 23:27:24.820509915 -0400
@@ -131,7 +131,7 @@ static inline void perfctr_sample_thread
 
 static inline void perfctr_set_cpus_allowed(struct task_struct *p, cpumask_t new_mask)
 {
-#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 	struct vperfctr *perfctr;
 
 	task_lock(p);


--==_Exmh_1854717721P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAxM7DcC3lWbTT17ARAjVDAJ4qvqC8R0YpVtArjBBoiDD3SYUuPwCeKFRX
nisaUYMPERH0SDDQU6W4mSk=
=sQ1e
-----END PGP SIGNATURE-----

--==_Exmh_1854717721P--
