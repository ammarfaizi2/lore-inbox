Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVCOEgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVCOEgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVCOEgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:36:15 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:44424 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262240AbVCOEez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:34:55 -0500
Date: Tue, 15 Mar 2005 15:34:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] PPC64 iSeries: cleanup iSeries_setup
Message-Id: <20050315153446.4404919f.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__15_Mar_2005_15_34_46_+1100_NZcmbHcioKWXWHhF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__15_Mar_2005_15_34_46_+1100_NZcmbHcioKWXWHhF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch does some trivial cleanups on iSeries_setup.[ch]:
	- eliminiate warning about iommu_init_early_iSeries not being
	  declared
	- remove trailing whitespace
	- change some functions to static
	- remove defunct function declarations

Built and booted on iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-cleanup.1/arch/ppc64/kernel/iSeries_setup.c linus-cleanup.2/arch/ppc64/kernel/iSeries_setup.c
--- linus-cleanup.1/arch/ppc64/kernel/iSeries_setup.c	2005-03-06 07:08:24.000000000 +1100
+++ linus-cleanup.2/arch/ppc64/kernel/iSeries_setup.c	2005-03-15 15:23:35.000000000 +1100
@@ -15,7 +15,7 @@
  *      as published by the Free Software Foundation; either version
  *      2 of the License, or (at your option) any later version.
  */
- 
+
 #undef DEBUG
 
 #include <linux/config.h>
@@ -39,6 +39,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
+#include <asm/iommu.h>
 
 #include <asm/time.h>
 #include "iSeries_setup.h"
@@ -57,6 +58,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/iSeries/mf.h>
 #include <asm/iSeries/HvLpEvent.h>
+#include <asm/iSeries/iSeries_irq.h>
 
 extern void hvlog(char *fmt, ...);
 
@@ -72,7 +74,6 @@ extern void ppcdbg_initialize(void);
 static void build_iSeries_Memory_Map(void);
 static void setup_iSeries_cache_sizes(void);
 static void iSeries_bolt_kernel(unsigned long saddr, unsigned long eaddr);
-extern void iSeries_setup_arch(void);
 extern void iSeries_pci_final_fixup(void);
 
 /* Global Variables */
@@ -108,8 +109,8 @@ struct MemoryBlock {
  * and return the number of physical blocks and fill in the array of
  * block data.
  */
-unsigned long iSeries_process_Condor_mainstore_vpd(struct MemoryBlock *mb_array,
-		unsigned long max_entries)
+static unsigned long iSeries_process_Condor_mainstore_vpd(
+		struct MemoryBlock *mb_array, unsigned long max_entries)
 {
 	unsigned long holeFirstChunk, holeSizeChunks;
 	unsigned long numMemoryBlocks = 1;
@@ -154,7 +155,7 @@ unsigned long iSeries_process_Condor_mai
 #define MaxSegmentAdrRangeBlocks	128
 #define MaxAreaRangeBlocks		4
 
-unsigned long iSeries_process_Regatta_mainstore_vpd(
+static unsigned long iSeries_process_Regatta_mainstore_vpd(
 		struct MemoryBlock *mb_array, unsigned long max_entries)
 {
 	struct IoHriMainStoreSegment5 *msVpdP =
@@ -246,7 +247,7 @@ unsigned long iSeries_process_Regatta_ma
 		printk("          Bitmap range: %016lx - %016lx\n"
 				"        Absolute range: %016lx - %016lx\n",
 				mb_array[i].logicalStart,
-				mb_array[i].logicalEnd, 
+				mb_array[i].logicalEnd,
 				mb_array[i].absStart, mb_array[i].absEnd);
 		mb_array[i].absStart = addr_to_chunk(mb_array[i].absStart &
 				0x000fffffffffffff);
@@ -261,7 +262,7 @@ unsigned long iSeries_process_Regatta_ma
 	return numSegmentBlocks;
 }
 
-unsigned long iSeries_process_mainstore_vpd(struct MemoryBlock *mb_array,
+static unsigned long iSeries_process_mainstore_vpd(struct MemoryBlock *mb_array,
 		unsigned long max_entries)
 {
 	unsigned long i;
@@ -302,7 +303,7 @@ static void __init iSeries_parse_cmdline
 	*p = 0;
 }
 
-/*static*/ void __init iSeries_init_early(void)
+static void __init iSeries_init_early(void)
 {
 	DBG(" -> iSeries_init_early()\n");
 
@@ -355,7 +356,7 @@ static void __init iSeries_parse_cmdline
 #ifdef CONFIG_SMP
 	smp_init_iSeries();
 #endif
-	if (itLpNaca.xPirEnvironMode == 0) 
+	if (itLpNaca.xPirEnvironMode == 0)
 		piranha_simulator = 1;
 
 	/* Associate Lp Event Queue 0 with processor 0 */
@@ -385,21 +386,21 @@ static void __init iSeries_parse_cmdline
 /*
  * The iSeries may have very large memories ( > 128 GB ) and a partition
  * may get memory in "chunks" that may be anywhere in the 2**52 real
- * address space.  The chunks are 256K in size.  To map this to the 
- * memory model Linux expects, the AS/400 specific code builds a 
+ * address space.  The chunks are 256K in size.  To map this to the
+ * memory model Linux expects, the AS/400 specific code builds a
  * translation table to translate what Linux thinks are "physical"
- * addresses to the actual real addresses.  This allows us to make 
+ * addresses to the actual real addresses.  This allows us to make
  * it appear to Linux that we have contiguous memory starting at
  * physical address zero while in fact this could be far from the truth.
- * To avoid confusion, I'll let the words physical and/or real address 
- * apply to the Linux addresses while I'll use "absolute address" to 
+ * To avoid confusion, I'll let the words physical and/or real address
+ * apply to the Linux addresses while I'll use "absolute address" to
  * refer to the actual hardware real address.
  *
- * build_iSeries_Memory_Map gets information from the Hypervisor and 
+ * build_iSeries_Memory_Map gets information from the Hypervisor and
  * looks at the Main Store VPD to determine the absolute addresses
  * of the memory that has been assigned to our partition and builds
  * a table used to translate Linux's physical addresses to these
- * absolute addresses.  Absolute addresses are needed when 
+ * absolute addresses.  Absolute addresses are needed when
  * communicating with the hypervisor (e.g. to build HPT entries)
  */
 
@@ -428,13 +429,13 @@ static void __init build_iSeries_Memory_
 	 * otherwise, it might not be returned by PLIC as the first
 	 * chunks
 	 */
-	
+
 	loadAreaFirstChunk = (u32)addr_to_chunk(itLpNaca.xLoadAreaAddr);
 	loadAreaSize =  itLpNaca.xLoadAreaChunks;
 
 	/*
-	 * Only add the pages already mapped here.  
-	 * Otherwise we might add the hpt pages 
+	 * Only add the pages already mapped here.
+	 * Otherwise we might add the hpt pages
 	 * The rest of the pages of the load area
 	 * aren't in the HPT yet and can still
 	 * be assigned an arbitrary physical address
@@ -446,7 +447,7 @@ static void __init build_iSeries_Memory_
 
 	/*
 	 * TODO Do we need to do something if the HPT is in the 64MB load area?
-	 * This would be required if the itLpNaca.xLoadAreaChunks includes 
+	 * This would be required if the itLpNaca.xLoadAreaChunks includes
 	 * the HPT size
 	 */
 
@@ -454,11 +455,11 @@ static void __init build_iSeries_Memory_
 		"                    absolute addr = %016lx\n",
 		chunk_to_addr(loadAreaFirstChunk));
 	printk("Load area size %dK\n", loadAreaSize * 256);
-	
+
 	for (nextPhysChunk = 0; nextPhysChunk < loadAreaSize; ++nextPhysChunk)
 		msChunks.abs[nextPhysChunk] =
 			loadAreaFirstChunk + nextPhysChunk;
-	
+
 	/*
 	 * Get absolute address of our HPT and remember it so
 	 * we won't map it to any physical address
@@ -475,7 +476,7 @@ static void __init build_iSeries_Memory_
 	num_ptegs = hptSizePages *
 		(PAGE_SIZE / (sizeof(HPTE) * HPTES_PER_GROUP));
 	htab_hash_mask = num_ptegs - 1;
-	
+
 	/*
 	 * The actual hashed page table is in the hypervisor,
 	 * we have no direct access
@@ -533,9 +534,9 @@ static void __init build_iSeries_Memory_
 	}
 
 	/*
-	 * main store size (in chunks) is 
+	 * main store size (in chunks) is
 	 *   totalChunks - hptSizeChunks
-	 * which should be equal to 
+	 * which should be equal to
 	 *   nextPhysChunk
 	 */
 	systemcfg->physicalMemorySize = chunk_to_addr(nextPhysChunk);
@@ -650,7 +651,7 @@ extern unsigned long ppc_tb_freq;
 /*
  * Document me.
  */
-void __init iSeries_setup_arch(void)
+static void __init iSeries_setup_arch(void)
 {
 	void *eventStack;
 	unsigned procIx = get_paca()->lppaca.dyn_hv_phys_proc_index;
@@ -669,14 +670,14 @@ void __init iSeries_setup_arch(void)
 	 */
 	eventStack = alloc_bootmem_pages(LpEventStackSize);
 	memset(eventStack, 0, LpEventStackSize);
-	
+
 	/* Invoke the hypervisor to initialize the event stack */
 	HvCallEvent_setLpEventStack(0, eventStack, LpEventStackSize);
 
 	/* Initialize fields in our Lp Event Queue */
 	xItLpQueue.xSlicEventStackPtr = (char *)eventStack;
 	xItLpQueue.xSlicCurEventPtr = (char *)eventStack;
-	xItLpQueue.xSlicLastValidEventPtr = (char *)eventStack + 
+	xItLpQueue.xSlicLastValidEventPtr = (char *)eventStack +
 					(LpEventStackSize - LpEventMaxSize);
 	xItLpQueue.xIndex = 0;
 
@@ -694,7 +695,7 @@ void __init iSeries_setup_arch(void)
 	tbFreqMhzHundreths = (tbFreqHz / 10000) - (tbFreqMhz * 100);
 	ppc_tb_freq = tbFreqHz;
 
-	printk("Max  logical processors = %d\n", 
+	printk("Max  logical processors = %d\n",
 			itVpdAreas.xSlicMaxLogicalProcs);
 	printk("Max physical processors = %d\n",
 			itVpdAreas.xSlicMaxPhysicalProcs);
@@ -706,7 +707,7 @@ void __init iSeries_setup_arch(void)
 	printk("Processor version = %x\n", systemcfg->processor);
 }
 
-void iSeries_get_cpuinfo(struct seq_file *m)
+static void iSeries_get_cpuinfo(struct seq_file *m)
 {
 	seq_printf(m, "machine\t\t: 64-bit iSeries Logical Partition\n");
 }
@@ -715,7 +716,7 @@ void iSeries_get_cpuinfo(struct seq_file
  * Document me.
  * and Implement me.
  */
-int iSeries_get_irq(struct pt_regs *regs)
+static int iSeries_get_irq(struct pt_regs *regs)
 {
 	/* -2 means ignore this interrupt */
 	return -2;
@@ -724,7 +725,7 @@ int iSeries_get_irq(struct pt_regs *regs
 /*
  * Document me.
  */
-void iSeries_restart(char *cmd)
+static void iSeries_restart(char *cmd)
 {
 	mf_reboot();
 }
@@ -732,7 +733,7 @@ void iSeries_restart(char *cmd)
 /*
  * Document me.
  */
-void iSeries_power_off(void)
+static void iSeries_power_off(void)
 {
 	mf_power_off();
 }
@@ -740,14 +741,11 @@ void iSeries_power_off(void)
 /*
  * Document me.
  */
-void iSeries_halt(void)
+static void iSeries_halt(void)
 {
 	mf_power_off();
 }
 
-/* JDH Hack */
-unsigned long jdh_time = 0;
-
 extern void setup_default_decr(void);
 
 /*
@@ -758,17 +756,17 @@ extern void setup_default_decr(void);
  *   and sets up the kernel timer decrementer based on that value.
  *
  */
-void __init iSeries_calibrate_decr(void)
+static void __init iSeries_calibrate_decr(void)
 {
 	unsigned long	cyclesPerUsec;
 	struct div_result divres;
-	
+
 	/* Compute decrementer (and TB) frequency in cycles/sec */
 	cyclesPerUsec = ppc_tb_freq / 1000000;
 
 	/*
 	 * Set the amount to refresh the decrementer by.  This
-	 * is the number of decrementer ticks it takes for 
+	 * is the number of decrementer ticks it takes for
 	 * 1/HZ seconds.
 	 */
 	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
@@ -793,7 +791,7 @@ void __init iSeries_calibrate_decr(void)
 	setup_default_decr();
 }
 
-void __init iSeries_progress(char * st, unsigned short code)
+static void __init iSeries_progress(char * st, unsigned short code)
 {
 	printk("Progress: [%04x] - %s\n", (unsigned)code, st);
 	if (!piranha_simulator && mf_initialized) {
@@ -825,7 +823,7 @@ static void __init iSeries_fixup_klimit(
 	}
 }
 
-int __init iSeries_src_init(void)
+static int __init iSeries_src_init(void)
 {
         /* clear the progress line */
         ppc_md.progress(" ", 0xffff);
diff -ruNp linus-cleanup.1/arch/ppc64/kernel/iSeries_setup.h linus-cleanup.2/arch/ppc64/kernel/iSeries_setup.h
--- linus-cleanup.1/arch/ppc64/kernel/iSeries_setup.h	2004-09-24 15:23:06.000000000 +1000
+++ linus-cleanup.2/arch/ppc64/kernel/iSeries_setup.h	2005-03-15 15:22:05.000000000 +1100
@@ -19,19 +19,8 @@
 #ifndef	__ISERIES_SETUP_H__
 #define	__ISERIES_SETUP_H__
 
-extern void iSeries_setup_arch(void);
-extern void iSeries_setup_residual(struct seq_file *m, int cpu_id);
-extern void iSeries_get_cpuinfo(struct seq_file *m);
-extern void iSeries_init_IRQ(void);
-extern int iSeries_get_irq(struct pt_regs *regs);
-extern void iSeries_restart(char *cmd);
-extern void iSeries_power_off(void);
-extern void iSeries_halt(void);
-extern void iSeries_time_init(void);
 extern void iSeries_get_boot_time(struct rtc_time *tm);
 extern int iSeries_set_rtc_time(struct rtc_time *tm);
 extern void iSeries_get_rtc_time(struct rtc_time *tm);
-extern void iSeries_calibrate_decr(void);
-extern void iSeries_progress( char *, unsigned short );
 
 #endif /* __ISERIES_SETUP_H__ */

--Signature=_Tue__15_Mar_2005_15_34_46_+1100_NZcmbHcioKWXWHhF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCNmXm4CJfqux9a+8RArtOAJ4zYbBJss+Wcm/RrFytOORUxSuwhwCfTgu7
yrUBJY9fpR9sKxKQn6m7dlg=
=WITi
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Mar_2005_15_34_46_+1100_NZcmbHcioKWXWHhF--
