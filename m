Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVADFDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVADFDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVADFCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:02:11 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:34504 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262051AbVADEpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:45:52 -0500
Date: Tue, 4 Jan 2005 15:43:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] PPC64: remove StudlyCaps from lppaca structure
Message-Id: <20050104154319.505b1197.sfr@canb.auug.org.au>
In-Reply-To: <20050104154025.63a1b9fb.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
	<20050104153102.67284491.sfr@canb.auug.org.au>
	<20050104153445.3777e689.sfr@canb.auug.org.au>
	<20050104153740.56622b4f.sfr@canb.auug.org.au>
	<20050104154025.63a1b9fb.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_43_19_+1100_zN1gYzXJHDwUdGo2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_43_19_+1100_zN1gYzXJHDwUdGo2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch just renames all the fields (and the structure name) of the
lppaca structure to rid us of some more StudyCaps.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.10/arch/ppc64/kernel/asm-offsets.c linus-bk-naca.11/arch/ppc64/kernel/asm-offsets.c
--- linus-bk-naca.10/arch/ppc64/kernel/asm-offsets.c	2004-12-13 15:02:03.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/asm-offsets.c	2004-12-31 15:51:16.000000000 +1100
@@ -102,10 +102,10 @@
         DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
 	DEFINE(PACALPPACA, offsetof(struct paca_struct, lppaca));
 	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
-        DEFINE(LPPACASRR0, offsetof(struct ItLpPaca, xSavedSrr0));
-        DEFINE(LPPACASRR1, offsetof(struct ItLpPaca, xSavedSrr1));
-	DEFINE(LPPACAANYINT, offsetof(struct ItLpPaca, xIntDword.xAnyInt));
-	DEFINE(LPPACADECRINT, offsetof(struct ItLpPaca, xIntDword.xFields.xDecrInt));
+	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
+	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
+	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
+	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
 
 	/* RTAS */
 	DEFINE(RTASBASE, offsetof(struct rtas_t, base));
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/iSeries_setup.c linus-bk-naca.11/arch/ppc64/kernel/iSeries_setup.c
--- linus-bk-naca.10/arch/ppc64/kernel/iSeries_setup.c	2004-12-11 02:51:17.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/iSeries_setup.c	2004-12-13 15:31:14.000000000 +1100
@@ -559,7 +559,7 @@
 static void __init setup_iSeries_cache_sizes(void)
 {
 	unsigned int i, n;
-	unsigned int procIx = get_paca()->lppaca.xDynHvPhysicalProcIndex;
+	unsigned int procIx = get_paca()->lppaca.dyn_hv_phys_proc_index;
 
 	systemcfg->icache_size =
 	ppc64_caches.isize = xIoHriProcessorVpd[procIx].xInstCacheSize * 1024;
@@ -656,7 +656,7 @@
 void __init iSeries_setup_arch(void)
 {
 	void *eventStack;
-	unsigned procIx = get_paca()->lppaca.xDynHvPhysicalProcIndex;
+	unsigned procIx = get_paca()->lppaca.dyn_hv_phys_proc_index;
 
 	/* Add an eye catcher and the systemcfg layout version number */
 	strcpy(systemcfg->eye_catcher, "SYSTEMCFG:PPC64");
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/iSeries_smp.c linus-bk-naca.11/arch/ppc64/kernel/iSeries_smp.c
--- linus-bk-naca.10/arch/ppc64/kernel/iSeries_smp.c	2004-12-10 16:26:54.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/iSeries_smp.c	2004-12-13 15:29:16.000000000 +1100
@@ -90,7 +90,7 @@
 
 	np = 0;
         for (i=0; i < NR_CPUS; ++i) {
-                if (paca[i].lppaca.xDynProcStatus < 2) {
+                if (paca[i].lppaca.dyn_proc_status < 2) {
 			cpu_set(i, cpu_possible_map);
 			cpu_set(i, cpu_present_map);
 			cpu_set(i, cpu_sibling_map[i]);
@@ -106,7 +106,7 @@
 	unsigned np = 0;
 
 	for (i=0; i < NR_CPUS; ++i) {
-		if (paca[i].lppaca.xDynProcStatus < 2) {
+		if (paca[i].lppaca.dyn_proc_status < 2) {
 			/*paca[i].active = 1;*/
 			++np;
 		}
@@ -120,7 +120,7 @@
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	/* Verify that our partition has a processor nr */
-	if (paca[nr].lppaca.xDynProcStatus >= 2)
+	if (paca[nr].lppaca.dyn_proc_status >= 2)
 		return;
 
 	/* The processor is currently spinning, waiting
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/idle.c linus-bk-naca.11/arch/ppc64/kernel/idle.c
--- linus-bk-naca.10/arch/ppc64/kernel/idle.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/idle.c	2004-12-13 16:06:18.000000000 +1100
@@ -67,7 +67,7 @@
 	 * The decrementer stops during the yield.  Force a fake decrementer
 	 * here and let the timer_interrupt code sort out the actual time.
 	 */
-	get_paca()->lppaca.xIntDword.xFields.xDecrInt = 1;
+	get_paca()->lppaca.int_dword.fields.decr_int = 1;
 	process_iSeries_events();
 }
 
@@ -86,7 +86,7 @@
 	lpaca = get_paca();
 
 	while (1) {
-		if (lpaca->lppaca.xSharedProc) {
+		if (lpaca->lppaca.shared_proc) {
 			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
 				process_iSeries_events();
 			if (!need_resched())
@@ -173,7 +173,7 @@
 		 * Indicate to the HV that we are idle. Now would be
 		 * a good time to find other work to dispatch.
 		 */
-		lpaca->lppaca.xIdle = 1;
+		lpaca->lppaca.idle = 1;
 
 		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
 		if (!oldval) {
@@ -194,7 +194,7 @@
 
 				HMT_medium();
 
-				if (!(ppaca->lppaca.xIdle)) {
+				if (!(ppaca->lppaca.idle)) {
 					local_irq_disable();
 
 					/*
@@ -233,7 +233,7 @@
 		}
 
 		HMT_medium();
-		lpaca->lppaca.xIdle = 0;
+		lpaca->lppaca.idle = 0;
 		schedule();
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
@@ -251,7 +251,7 @@
 		 * Indicate to the HV that we are idle. Now would be
 		 * a good time to find other work to dispatch.
 		 */
-		lpaca->lppaca.xIdle = 1;
+		lpaca->lppaca.idle = 1;
 
 		while (!need_resched() && !cpu_is_offline(cpu)) {
 			local_irq_disable();
@@ -273,7 +273,7 @@
 		}
 
 		HMT_medium();
-		lpaca->lppaca.xIdle = 0;
+		lpaca->lppaca.idle = 0;
 		schedule();
 		if (cpu_is_offline(smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
@@ -352,7 +352,7 @@
 #ifdef CONFIG_PPC_PSERIES
 	if (systemcfg->platform & PLATFORM_PSERIES) {
 		if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-			if (get_paca()->lppaca.xSharedProc) {
+			if (get_paca()->lppaca.shared_proc) {
 				printk(KERN_INFO "Using shared processor idle loop\n");
 				idle_loop = shared_idle;
 			} else {
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/irq.c linus-bk-naca.11/arch/ppc64/kernel/irq.c
--- linus-bk-naca.10/arch/ppc64/kernel/irq.c	2004-12-31 14:53:21.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/irq.c	2004-12-13 15:43:22.000000000 +1100
@@ -259,8 +259,8 @@
 
 	lpaca = get_paca();
 #ifdef CONFIG_SMP
-	if (lpaca->lppaca.xIntDword.xFields.xIpiCnt) {
-		lpaca->lppaca.xIntDword.xFields.xIpiCnt = 0;
+	if (lpaca->lppaca.int_dword.fields.ipi_cnt) {
+		lpaca->lppaca.int_dword.fields.ipi_cnt = 0;
 		iSeries_smp_message_recv(regs);
 	}
 #endif /* CONFIG_SMP */
@@ -270,8 +270,8 @@
 
 	irq_exit();
 
-	if (lpaca->lppaca.xIntDword.xFields.xDecrInt) {
-		lpaca->lppaca.xIntDword.xFields.xDecrInt = 0;
+	if (lpaca->lppaca.int_dword.fields.decr_int) {
+		lpaca->lppaca.int_dword.fields.decr_int = 0;
 		/* Signal a fake decrementer interrupt */
 		timer_interrupt(regs);
 	}
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/lparcfg.c linus-bk-naca.11/arch/ppc64/kernel/lparcfg.c
--- linus-bk-naca.10/arch/ppc64/kernel/lparcfg.c	2004-12-13 15:02:29.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/lparcfg.c	2004-12-13 16:00:00.000000000 +1100
@@ -72,7 +72,7 @@
 
 /*
  * For iSeries legacy systems, the PPA purr function is available from the
- * xEmulatedTimeBase field in the paca.
+ * emulated_time_base field in the paca.
  */
 static unsigned long get_purr(void)
 {
@@ -82,11 +82,11 @@
 
 	for_each_cpu(cpu) {
 		lpaca = paca + cpu;
-		sum_purr += lpaca->lppaca.xEmulatedTimeBase;
+		sum_purr += lpaca->lppaca.emulated_time_base;
 
 #ifdef PURR_DEBUG
 		printk(KERN_INFO "get_purr for cpu (%d) has value (%ld) \n",
-			cpu, lpaca->lppaca.xEmulatedTimeBase);
+			cpu, lpaca->lppaca.emulated_time_base);
 #endif
 	}
 	return sum_purr;
@@ -107,7 +107,7 @@
 
 	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
 
-	shared = (int)(lpaca->lppaca_ptr->xSharedProc);
+	shared = (int)(lpaca->lppaca_ptr->shared_proc);
 	seq_printf(m, "serial_number=%c%c%c%c%c%c%c\n",
 		   e2a(xItExtVpdPanel.mfgID[2]),
 		   e2a(xItExtVpdPanel.mfgID[3]),
@@ -395,7 +395,7 @@
 			   (h_resource >> 0 * 8) & 0xffff);
 
 		/* pool related entries are apropriate for shared configs */
-		if (paca[0].lppaca.xSharedProc) {
+		if (paca[0].lppaca.shared_proc) {
 
 			h_pic(&pool_idle_time, &pool_procs);
 
@@ -444,7 +444,7 @@
 	seq_printf(m, "partition_potential_processors=%d\n",
 		   partition_potential_processors);
 
-	seq_printf(m, "shared_processor_mode=%d\n", paca[0].lppaca.xSharedProc);
+	seq_printf(m, "shared_processor_mode=%d\n", paca[0].lppaca.shared_proc);
 
 	return 0;
 }
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/pacaData.c linus-bk-naca.11/arch/ppc64/kernel/pacaData.c
--- linus-bk-naca.10/arch/ppc64/kernel/pacaData.c	2004-12-13 15:02:07.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/pacaData.c	2004-12-13 16:05:34.000000000 +1100
@@ -28,7 +28,7 @@
 extern unsigned long __toc_start;
 
 /* The Paca is an array with one entry per processor.  Each contains an 
- * ItLpPaca, which contains the information shared between the 
+ * lppaca, which contains the information shared between the 
  * hypervisor and Linux.  Each also contains an ItLpRegSave area which
  * is used by the hypervisor to save registers.
  * On systems with hardware multi-threading, there are two threads
@@ -61,13 +61,13 @@
 	.cpu_start = (start),		/* Processor start */		    \
 	.hw_cpu_id = 0xffff,						    \
 	.lppaca = {							    \
-		.xDesc = 0xd397d781,	/* "LpPa" */			    \
-		.xSize = sizeof(struct ItLpPaca),			    \
-		.xFPRegsInUse = 1,					    \
-		.xDynProcStatus = 2,					    \
-		.xDecrVal = 0x00ff0000,					    \
-		.xEndOfQuantum = 0xfffffffffffffffful,			    \
-		.xSLBCount = 64,					    \
+		.desc = 0xd397d781,	/* "LpPa" */			    \
+		.size = sizeof(struct lppaca),				    \
+		.dyn_proc_status = 2,					    \
+		.decr_val = 0x00ff0000,					    \
+		.fpregs_in_use = 1,					    \
+		.end_of_quantum = 0xfffffffffffffffful,			    \
+		.slb_count = 64,					    \
 	},								    \
 	EXTRA_INITS((number), (lpq))					    \
 }
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/sysfs.c linus-bk-naca.11/arch/ppc64/kernel/sysfs.c
--- linus-bk-naca.10/arch/ppc64/kernel/sysfs.c	2004-12-13 15:01:19.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/sysfs.c	2004-12-13 15:58:30.000000000 +1100
@@ -157,7 +157,7 @@
 #ifdef CONFIG_PPC_PSERIES
 	/* instruct hypervisor to maintain PMCs */
 	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
-		get_paca()->lppaca.xPMCRegsInUse = 1;
+		get_paca()->lppaca.pmcregs_in_use = 1;
 
 	/*
 	 * On SMT machines we have to set the run latch in the ctrl register
diff -ruN linus-bk-naca.10/arch/ppc64/kernel/time.c linus-bk-naca.11/arch/ppc64/kernel/time.c
--- linus-bk-naca.10/arch/ppc64/kernel/time.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/kernel/time.c	2004-12-13 15:43:28.000000000 +1100
@@ -230,7 +230,7 @@
 /*
  * For iSeries shared processors, we have to let the hypervisor
  * set the hardware decrementer.  We set a virtual decrementer
- * in the ItLpPaca and call the hypervisor if the virtual
+ * in the lppaca and call the hypervisor if the virtual
  * decrementer is less than the current value in the hardware
  * decrementer. (almost always the new decrementer value will
  * be greater than the current hardware decementer so the hypervisor
@@ -256,7 +256,7 @@
 	profile_tick(CPU_PROFILING, regs);
 #endif
 
-	lpaca->lppaca.xIntDword.xFields.xDecrInt = 0;
+	lpaca->lppaca.int_dword.fields.decr_int = 0;
 
 	while (lpaca->next_jiffy_update_tb <= (cur_tb = get_tb())) {
 
diff -ruN linus-bk-naca.10/arch/ppc64/lib/locks.c linus-bk-naca.11/arch/ppc64/lib/locks.c
--- linus-bk-naca.10/arch/ppc64/lib/locks.c	2004-09-16 21:51:57.000000000 +1000
+++ linus-bk-naca.11/arch/ppc64/lib/locks.c	2004-12-13 16:08:05.000000000 +1100
@@ -34,7 +34,7 @@
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
 	holder_paca = &paca[holder_cpu];
-	yield_count = holder_paca->lppaca.xYieldCount;
+	yield_count = holder_paca->lppaca.yield_count;
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
@@ -66,7 +66,7 @@
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
 	holder_paca = &paca[holder_cpu];
-	yield_count = holder_paca->lppaca.xYieldCount;
+	yield_count = holder_paca->lppaca.yield_count;
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
diff -ruN linus-bk-naca.10/arch/ppc64/xmon/xmon.c linus-bk-naca.11/arch/ppc64/xmon/xmon.c
--- linus-bk-naca.10/arch/ppc64/xmon/xmon.c	2004-12-11 02:33:00.000000000 +1100
+++ linus-bk-naca.11/arch/ppc64/xmon/xmon.c	2004-12-13 15:50:52.000000000 +1100
@@ -1489,7 +1489,7 @@
 	unsigned long val;
 #ifdef CONFIG_PPC_ISERIES
 	struct paca_struct *ptrPaca = NULL;
-	struct ItLpPaca *ptrLpPaca = NULL;
+	struct lppaca *ptrLpPaca = NULL;
 	struct ItLpRegSave *ptrLpRegSave = NULL;
 #endif
 
@@ -1513,10 +1513,10 @@
 		printf("  Local Processor Control Area (LpPaca): \n");
 		ptrLpPaca = ptrPaca->lppaca_ptr;
 		printf("    Saved Srr0=%.16lx  Saved Srr1=%.16lx \n",
-		       ptrLpPaca->xSavedSrr0, ptrLpPaca->xSavedSrr1);
+		       ptrLpPaca->saved_srr0, ptrLpPaca->saved_srr1);
 		printf("    Saved Gpr3=%.16lx  Saved Gpr4=%.16lx \n",
-		       ptrLpPaca->xSavedGpr3, ptrLpPaca->xSavedGpr4);
-		printf("    Saved Gpr5=%.16lx \n", ptrLpPaca->xSavedGpr5);
+		       ptrLpPaca->saved_gpr3, ptrLpPaca->saved_gpr4);
+		printf("    Saved Gpr5=%.16lx \n", ptrLpPaca->saved_gpr5);
     
 		printf("  Local Processor Register Save Area (LpRegSave): \n");
 		ptrLpRegSave = ptrPaca->reg_save_ptr;
diff -ruN linus-bk-naca.10/include/asm-ppc64/lppaca.h linus-bk-naca.11/include/asm-ppc64/lppaca.h
--- linus-bk-naca.10/include/asm-ppc64/lppaca.h	2004-12-13 15:04:43.000000000 +1100
+++ linus-bk-naca.11/include/asm-ppc64/lppaca.h	2004-12-13 16:09:08.000000000 +1100
@@ -28,7 +28,7 @@
 //----------------------------------------------------------------------------
 #include <asm/types.h>
 
-struct ItLpPaca
+struct lppaca
 {
 //=============================================================================
 // CACHE_LINE_1 0x0000 - 0x007F Contains read-only data
@@ -36,24 +36,24 @@
 // PLIC when preparing to bring a processor online or when dispatching a 
 // virtual processor!
 //=============================================================================
-	u32	xDesc;			// Eye catcher 0xD397D781	x00-x03
-	u16	xSize;			// Size of this struct		x04-x05
-	u16	xRsvd1_0;		// Reserved			x06-x07
-	u16	xRsvd1_1:14;		// Reserved			x08-x09
-	u8	xSharedProc:1;		// Shared processor indicator	...
-	u8	xSecondaryThread:1;	// Secondary thread indicator	...
-	volatile u8 xDynProcStatus:8;	// Dynamic Status of this proc	x0A-x0A
-	u8	xSecondaryThreadCnt;	// Secondary thread count	x0B-x0B
-	volatile u16 xDynHvPhysicalProcIndex;// Dynamic HV Physical Proc Index0C-x0D
-	volatile u16 xDynHvLogicalProcIndex;// Dynamic HV Logical Proc Indexx0E-x0F
-	u32	xDecrVal;   		// Value for Decr programming 	x10-x13
-	u32	xPMCVal;       		// Value for PMC regs         	x14-x17
-	volatile u32 xDynHwNodeId;	// Dynamic Hardware Node id	x18-x1B
-	volatile u32 xDynHwProcId;	// Dynamic Hardware Proc Id	x1C-x1F
-	volatile u32 xDynPIR;		// Dynamic ProcIdReg value	x20-x23
-	u32	xDseiData;           	// DSEI data                  	x24-x27
-	u64	xSPRG3;               	// SPRG3 value                	x28-x2F
-	u8	xRsvd1_3[80];		// Reserved			x30-x7F
+	u32	desc;			// Eye catcher 0xD397D781	x00-x03
+	u16	size;			// Size of this struct		x04-x05
+	u16	reserved1;		// Reserved			x06-x07
+	u16	reserved2:14;		// Reserved			x08-x09
+	u8	shared_proc:1;		// Shared processor indicator	...
+	u8	secondary_thread:1;	// Secondary thread indicator	...
+	volatile u8 dyn_proc_status:8;	// Dynamic Status of this proc	x0A-x0A
+	u8	secondary_thread_count;	// Secondary thread count	x0B-x0B
+	volatile u16 dyn_hv_phys_proc_index;// Dynamic HV Physical Proc Index0C-x0D
+	volatile u16 dyn_hv_log_proc_index;// Dynamic HV Logical Proc Indexx0E-x0F
+	u32	decr_val;   		// Value for Decr programming 	x10-x13
+	u32	pmc_val;       		// Value for PMC regs         	x14-x17
+	volatile u32 dyn_hw_node_id;	// Dynamic Hardware Node id	x18-x1B
+	volatile u32 dyn_hw_proc_id;	// Dynamic Hardware Proc Id	x1C-x1F
+	volatile u32 dyn_pir;		// Dynamic ProcIdReg value	x20-x23
+	u32	dsei_data;           	// DSEI data                  	x24-x27
+	u64	sprg3;               	// SPRG3 value                	x28-x2F
+	u8	reserved3[80];		// Reserved			x30-x7F
    
 //=============================================================================
 // CACHE_LINE_2 0x0080 - 0x00FF Contains local read-write data
@@ -61,17 +61,17 @@
 	// This Dword contains a byte for each type of interrupt that can occur.  
 	// The IPI is a count while the others are just a binary 1 or 0.
 	union {
-		u64	xAnyInt;
+		u64	any_int;
 		struct {
-			u16	xRsvd;		// Reserved - cleared by #mpasmbl
-			u8	xXirrInt;	// Indicates xXirrValue is valid or Immed IO
-			u8	xIpiCnt;	// IPI Count
-			u8	xDecrInt;	// DECR interrupt occurred
-			u8	xPdcInt;	// PDC interrupt occurred
-			u8	xQuantumInt;	// Interrupt quantum reached
-			u8	xOldPlicDeferredExtInt;	// Old PLIC has a deferred XIRR pending
-		} xFields;
-	} xIntDword;
+			u16	reserved;	// Reserved - cleared by #mpasmbl
+			u8	xirr_int;	// Indicates xXirrValue is valid or Immed IO
+			u8	ipi_cnt;	// IPI Count
+			u8	decr_int;	// DECR interrupt occurred
+			u8	pdc_int;	// PDC interrupt occurred
+			u8	quantum_int;	// Interrupt quantum reached
+			u8	old_plic_deferred_ext_int;	// Old PLIC has a deferred XIRR pending
+		} fields;
+	} int_dword;
 
 	// Whenever any fields in this Dword are set then PLIC will defer the 
 	// processing of external interrupts.  Note that PLIC will store the 
@@ -81,54 +81,52 @@
 	// entire Dword is zero or not.  A non-zero value in the low order 
 	// 2-bytes will result in SLIC being granted the highest thread 
 	// priority upon return.  A 0 will return to SLIC as medium priority.
-	u64	xPlicDeferIntsArea;	// Entire Dword
+	u64	plic_defer_ints_area;	// Entire Dword
 
 	// Used to pass the real SRR0/1 from PLIC to SLIC as well as to 
 	// pass the target SRR0/1 from SLIC to PLIC on a SetAsrAndRfid.
-	u64     xSavedSrr0;             // Saved SRR0                   x10-x17
-	u64     xSavedSrr1;             // Saved SRR1                   x18-x1F
+	u64	saved_srr0;		// Saved SRR0                   x10-x17
+	u64	saved_srr1;		// Saved SRR1                   x18-x1F
 
 	// Used to pass parms from the OS to PLIC for SetAsrAndRfid
-	u64     xSavedGpr3;             // Saved GPR3                   x20-x27
-	u64     xSavedGpr4;             // Saved GPR4                   x28-x2F
-	u64     xSavedGpr5;             // Saved GPR5                   x30-x37
-
-	u8	xRsvd2_1;		// Reserved			x38-x38
-	u8      xCpuCtlsTaskAttributes; // Task attributes for cpuctls  x39-x39
-	u8      xFPRegsInUse;           // FP regs in use               x3A-x3A
-	u8      xPMCRegsInUse;          // PMC regs in use              x3B-x3B
-	volatile u32  xSavedDecr;	// Saved Decr Value             x3C-x3F
-	volatile u64  xEmulatedTimeBase;// Emulated TB for this thread  x40-x47
-	volatile u64  xCurPLICLatency;	// Unaccounted PLIC latency     x48-x4F
-	u64     xTotPLICLatency;        // Accumulated PLIC latency     x50-x57   
-	u64     xWaitStateCycles;       // Wait cycles for this proc    x58-x5F
-	u64     xEndOfQuantum;          // TB at end of quantum         x60-x67
-	u64     xPDCSavedSPRG1;         // Saved SPRG1 for PMC int      x68-x6F
-	u64     xPDCSavedSRR0;          // Saved SRR0 for PMC int       x70-x77
-	volatile u32 xVirtualDecr;	// Virtual DECR for shared procsx78-x7B
-	u16     xSLBCount;              // # of SLBs to maintain        x7C-x7D
-	u8      xIdle;                  // Indicate OS is idle          x7E
-	u8      xRsvd2_2;               // Reserved                     x7F
+	u64	saved_gpr3;		// Saved GPR3                   x20-x27
+	u64	saved_gpr4;		// Saved GPR4                   x28-x2F
+	u64	saved_gpr5;		// Saved GPR5                   x30-x37
+
+	u8	reserved4;		// Reserved			x38-x38
+	u8	cpuctls_task_attrs;	// Task attributes for cpuctls  x39-x39
+	u8	fpregs_in_use;		// FP regs in use               x3A-x3A
+	u8	pmcregs_in_use;		// PMC regs in use              x3B-x3B
+	volatile u32 saved_decr;	// Saved Decr Value             x3C-x3F
+	volatile u64 emulated_time_base;// Emulated TB for this thread  x40-x47
+	volatile u64 cur_plic_latency;	// Unaccounted PLIC latency     x48-x4F
+	u64	tot_plic_latency;	// Accumulated PLIC latency     x50-x57   
+	u64	wait_state_cycles;	// Wait cycles for this proc    x58-x5F
+	u64	end_of_quantum;		// TB at end of quantum         x60-x67
+	u64	pdc_saved_sprg1;	// Saved SPRG1 for PMC int      x68-x6F
+	u64	pdc_saved_srr0;		// Saved SRR0 for PMC int       x70-x77
+	volatile u32 virtual_decr;	// Virtual DECR for shared procsx78-x7B
+	u16	slb_count;		// # of SLBs to maintain        x7C-x7D
+	u8	idle;			// Indicate OS is idle          x7E
+	u8	reserved5;		// Reserved                     x7F
 
 
 //=============================================================================
 // CACHE_LINE_3 0x0100 - 0x007F: This line is shared with other processors
 //=============================================================================
-	// This is the xYieldCount.  An "odd" value (low bit on) means that 
+	// This is the yield_count.  An "odd" value (low bit on) means that 
 	// the processor is yielded (either because of an OS yield or a PLIC 
 	// preempt).  An even value implies that the processor is currently 
 	// executing.
 	// NOTE: This value will ALWAYS be zero for dedicated processors and 
 	// will NEVER be zero for shared processors (ie, initialized to a 1).
-	volatile u32 xYieldCount;	// PLIC increments each dispatchx00-x03
-	u8	xRsvd3_0[124];		// Reserved                     x04-x7F         
+	volatile u32 yield_count;	// PLIC increments each dispatchx00-x03
+	u8	reserved6[124];		// Reserved                     x04-x7F         
 
 //=============================================================================
 // CACHE_LINE_4-5 0x0100 - 0x01FF Contains PMC interrupt data
 //=============================================================================
-	u8      xPmcSaveArea[256];	// PMC interrupt Area           x00-xFF
-
-
+	u8	pmc_save_area[256];	// PMC interrupt Area           x00-xFF
 };
 
 #endif /* _ASM_LPPACA_H */
diff -ruN linus-bk-naca.10/include/asm-ppc64/paca.h linus-bk-naca.11/include/asm-ppc64/paca.h
--- linus-bk-naca.10/include/asm-ppc64/paca.h	2004-12-31 15:48:57.000000000 +1100
+++ linus-bk-naca.11/include/asm-ppc64/paca.h	2004-12-31 15:54:35.000000000 +1100
@@ -34,8 +34,8 @@
  *
  * This structure is not directly accessed by firmware or the service
  * processor except for the first two pointers that point to the
- * ItLpPaca area and the ItLpRegSave area for this CPU.  Both the
- * ItLpPaca and ItLpRegSave objects are currently contained within the
+ * lppaca area and the ItLpRegSave area for this CPU.  Both the
+ * lppaca and ItLpRegSave objects are currently contained within the
  * PACA but they do not need to be.
  */
 struct paca_struct {
@@ -50,7 +50,7 @@
 	 * MAGIC: These first two pointers can't be moved - they're
 	 * accessed by the firmware
 	 */
-	struct ItLpPaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
+	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
 	struct ItLpRegSave *reg_save_ptr; /* Pointer to LpRegSave for PLIC */
 
 	/*
@@ -109,7 +109,7 @@
 	 * alignment will suffice to ensure that it doesn't
 	 * cross a page boundary.
 	 */
-	struct ItLpPaca lppaca __attribute__((__aligned__(0x400)));
+	struct lppaca lppaca __attribute__((__aligned__(0x400)));
 #ifdef CONFIG_PPC_ISERIES
 	struct ItLpRegSave reg_save;
 #endif
diff -ruN linus-bk-naca.10/include/asm-ppc64/spinlock.h linus-bk-naca.11/include/asm-ppc64/spinlock.h
--- linus-bk-naca.10/include/asm-ppc64/spinlock.h	2004-09-09 09:59:50.000000000 +1000
+++ linus-bk-naca.11/include/asm-ppc64/spinlock.h	2004-12-13 15:25:23.000000000 +1100
@@ -57,7 +57,7 @@
 
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 /* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (get_paca()->lppaca.xSharedProc)
+#define SHARED_PROCESSOR (get_paca()->lppaca.shared_proc)
 extern void __spin_yield(spinlock_t *lock);
 extern void __rw_yield(rwlock_t *lock);
 #else /* SPLPAR || ISERIES */
diff -ruN linus-bk-naca.10/include/asm-ppc64/time.h linus-bk-naca.11/include/asm-ppc64/time.h
--- linus-bk-naca.10/include/asm-ppc64/time.h	2004-07-05 11:49:20.000000000 +1000
+++ linus-bk-naca.11/include/asm-ppc64/time.h	2004-12-13 16:05:02.000000000 +1100
@@ -78,8 +78,8 @@
 	struct paca_struct *lpaca = get_paca();
 	int cur_dec;
 
-	if (lpaca->lppaca.xSharedProc) {
-		lpaca->lppaca.xVirtualDecr = val;
+	if (lpaca->lppaca.shared_proc) {
+		lpaca->lppaca.virtual_decr = val;
 		cur_dec = get_dec();
 		if (cur_dec > val)
 			HvCall_setVirtualDecr();

--Signature=_Tue__4_Jan_2005_15_43_19_+1100_zN1gYzXJHDwUdGo2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2h7n4CJfqux9a+8RAt/tAKCXRAi90E4G4wW7qQKXd2ZwpKqjYQCfYwSD
GqB67thZqBPXg1ClE3caRDQ=
=mC17
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_43_19_+1100_zN1gYzXJHDwUdGo2--
