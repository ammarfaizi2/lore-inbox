Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUJQQMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUJQQMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269189AbUJQQK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:10:59 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:60637 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S269182AbUJQQJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:09:11 -0400
Subject: [PATCH 4/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - mpparse.c
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032569.3023.124.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:10:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro Dprintk (defined in apic.h included via smp.h)
 with pr_debug from kernel.h.
Use  pr_info when appropriate.
Fix consistency of printks.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/mpparse.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/mpparse.c	2004-08-14 07:36:44.000000000 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/mpparse.c	2004-10-17 17:01:19.482218648 +0200
@@ -13,6 +13,7 @@
  *		Paul Diefenbaugh:	Added full ACPI support
  */
 
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
 #include <linux/init.h>
@@ -130,55 +131,55 @@ void __init MP_processor_info (struct mp
 	apicid = mpc_apic_id(m, translation_table[mpc_record]);
 
 	if (m->mpc_featureflag&(1<<0))
-		Dprintk("    Floating point unit present.\n");
+		pr_debug("    Floating point unit present.\n");
 	if (m->mpc_featureflag&(1<<7))
-		Dprintk("    Machine Exception supported.\n");
+		pr_debug("    Machine Exception supported.\n");
 	if (m->mpc_featureflag&(1<<8))
-		Dprintk("    64 bit compare & exchange supported.\n");
+		pr_debug("    64 bit compare & exchange supported.\n");
 	if (m->mpc_featureflag&(1<<9))
-		Dprintk("    Internal APIC present.\n");
+		pr_debug("    Internal APIC present.\n");
 	if (m->mpc_featureflag&(1<<11))
-		Dprintk("    SEP present.\n");
+		pr_debug("    SEP present.\n");
 	if (m->mpc_featureflag&(1<<12))
-		Dprintk("    MTRR  present.\n");
+		pr_debug("    MTRR  present.\n");
 	if (m->mpc_featureflag&(1<<13))
-		Dprintk("    PGE  present.\n");
+		pr_debug("    PGE  present.\n");
 	if (m->mpc_featureflag&(1<<14))
-		Dprintk("    MCA  present.\n");
+		pr_debug("    MCA  present.\n");
 	if (m->mpc_featureflag&(1<<15))
-		Dprintk("    CMOV  present.\n");
+		pr_debug("    CMOV  present.\n");
 	if (m->mpc_featureflag&(1<<16))
-		Dprintk("    PAT  present.\n");
+		pr_debug("    PAT  present.\n");
 	if (m->mpc_featureflag&(1<<17))
-		Dprintk("    PSE  present.\n");
+		pr_debug("    PSE  present.\n");
 	if (m->mpc_featureflag&(1<<18))
-		Dprintk("    PSN  present.\n");
+		pr_debug("    PSN  present.\n");
 	if (m->mpc_featureflag&(1<<19))
-		Dprintk("    Cache Line Flush Instruction present.\n");
+		pr_debug("    Cache Line Flush Instruction present.\n");
 	/* 20 Reserved */
 	if (m->mpc_featureflag&(1<<21))
-		Dprintk("    Debug Trace and EMON Store present.\n");
+		pr_debug("    Debug Trace and EMON Store present.\n");
 	if (m->mpc_featureflag&(1<<22))
-		Dprintk("    ACPI Thermal Throttle Registers  present.\n");
+		pr_debug("    ACPI Thermal Throttle Registers  present.\n");
 	if (m->mpc_featureflag&(1<<23))
-		Dprintk("    MMX  present.\n");
+		pr_debug("    MMX  present.\n");
 	if (m->mpc_featureflag&(1<<24))
-		Dprintk("    FXSR  present.\n");
+		pr_debug("    FXSR  present.\n");
 	if (m->mpc_featureflag&(1<<25))
-		Dprintk("    XMM  present.\n");
+		pr_debug("    XMM  present.\n");
 	if (m->mpc_featureflag&(1<<26))
-		Dprintk("    Willamette New Instructions  present.\n");
+		pr_debug("    Willamette New Instructions  present.\n");
 	if (m->mpc_featureflag&(1<<27))
-		Dprintk("    Self Snoop  present.\n");
+		pr_debug("    Self Snoop  present.\n");
 	if (m->mpc_featureflag&(1<<28))
-		Dprintk("    HT  present.\n");
+		pr_debug("    HT  present.\n");
 	if (m->mpc_featureflag&(1<<29))
-		Dprintk("    Thermal Monitor present.\n");
+		pr_debug("    Thermal Monitor present.\n");
 	/* 30, 31 Reserved */
 
 
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
-		Dprintk("    Bootup CPU\n");
+		pr_debug("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
 		boot_cpu_logical_apicid = apicid;
 	}
@@ -250,10 +251,10 @@ static void __init MP_ioapic_info (struc
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;
 
-	printk(KERN_INFO "I/O APIC #%d Version %d at 0x%lX.\n",
+	pr_info("I/O APIC #%d Version %d at 0x%lX.\n",
 		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
 	if (nr_ioapics >= MAX_IO_APICS) {
-		printk(KERN_CRIT "Max # of I/O APICs (%d) exceeded (found %d).\n",
+		printk(KERN_EMERG "Max # of I/O APICs (%d) exceeded (found %d).\n",
 			MAX_IO_APICS, nr_ioapics);
 		panic("Recompile kernel with bigger MAX_IO_APICS!.\n");
 	}
@@ -269,7 +270,7 @@ static void __init MP_ioapic_info (struc
 static void __init MP_intsrc_info (struct mpc_config_intsrc *m)
 {
 	mp_irqs [mp_irq_entries] = *m;
-	Dprintk("Int: type %d, pol %d, trig %d, bus %d,"
+	pr_debug("Int: type %d, pol %d, trig %d, bus %d,"
 		" IRQ %02x, APIC ID %x, APIC INT %02x\n",
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
@@ -280,7 +281,7 @@ static void __init MP_intsrc_info (struc
 
 static void __init MP_lintsrc_info (struct mpc_config_lintsrc *m)
 {
-	Dprintk("Lint: type %d, pol %d, trig %d, bus %d,"
+	pr_debug("Lint: type %d, pol %d, trig %d, bus %d,"
 		" IRQ %02x, APIC ID %x, APIC LINT %02x\n",
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) &3, m->mpc_srcbusid,
@@ -303,7 +304,7 @@ static void __init MP_lintsrc_info (stru
 #ifdef CONFIG_X86_NUMAQ
 static void __init MP_translation_info (struct mpc_config_translation *m)
 {
-	printk(KERN_INFO "Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
+	pr_info("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
 
 	if (mpc_record >= MAX_MPC_ENTRY) 
 		printk(KERN_ERR "MAX_MPC_ENTRY exceeded!\n");
@@ -324,7 +325,7 @@ static void __init smp_read_mpc_oem(stru
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
 	
 	mpc_record = 0;
-	printk(KERN_INFO "Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
+	pr_info("Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
 		printk(KERN_WARNING "SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
@@ -364,7 +365,7 @@ static inline void mps_oem_check(struct 
 		char *productid)
 {
 	if (strncmp(oem, "IBM NUMA", 8))
-		printk("Warning!  May not be a NUMA-Q system!\n");
+		printk(KERN_WARN "Warning! May not be a NUMA-Q system!\n");
 	if (mpc->mpc_oemptr)
 		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr,
 				mpc->mpc_oemsize);
@@ -402,15 +403,15 @@ static int __init smp_read_mpc(struct mp
 	}
 	memcpy(oem,mpc->mpc_oem,8);
 	oem[8]=0;
-	printk(KERN_INFO "OEM ID: %s ",oem);
+	pr_info("OEM ID: %s ",oem);
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
-	printk("Product ID: %s ",str);
+	pr_info("Product ID: %s ",str);
 
 	mps_oem_check(mpc, oem, str);
 
-	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
+	pr_info("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
 	/* 
 	 * Save the local APIC address (it might be non-default) -- but only
@@ -517,12 +518,12 @@ static void __init construct_default_ioi
 	 *  If it does, we assume it's valid.
 	 */
 	if (mpc_default_type == 5) {
-		printk(KERN_INFO "ISA/PCI bus type with no IRQ information... falling back to ELCR\n");
+		pr_info("ISA/PCI bus type with no IRQ information... falling back to ELCR\n");
 
 		if (ELCR_trigger(0) || ELCR_trigger(1) || ELCR_trigger(2) || ELCR_trigger(13))
 			printk(KERN_WARNING "ELCR contains invalid data... not using ELCR\n");
 		else {
-			printk(KERN_INFO "Using ELCR to identify PCI interrupts\n");
+			pr_info("Using ELCR to identify PCI interrupts\n");
 			ELCR_fallback = 1;
 		}
 	}
@@ -597,7 +598,6 @@ static inline void __init construct_defa
 	bus.mpc_busid = 0;
 	switch (mpc_default_type) {
 		default:
-			printk("???\n");
 			printk(KERN_ERR "Unknown standard configuration %d\n",
 				mpc_default_type);
 			/* fall through */
@@ -661,18 +661,18 @@ void __init get_smp_config (void)
 	 * processors, where MPS only supports physical.
 	 */
 	if (acpi_lapic && acpi_ioapic) {
-		printk(KERN_INFO "Using ACPI (MADT) for SMP configuration information\n");
+		pr_info("Using ACPI (MADT) for SMP configuration information\n");
 		return;
 	}
 	else if (acpi_lapic)
-		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration information\n");
+		pr_info("Using ACPI for processor (LAPIC) configuration information\n");
 
-	printk(KERN_INFO "Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
+	pr_info("Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
 	if (mpf->mpf_feature2 & (1<<7)) {
-		printk(KERN_INFO "    IMCR and PIC compatibility mode.\n");
+		pr_info("    IMCR and PIC compatibility mode.\n");
 		pic_mode = 1;
 	} else {
-		printk(KERN_INFO "    Virtual Wire compatibility mode.\n");
+		pr_info("    Virtual Wire compatibility mode.\n");
 		pic_mode = 0;
 	}
 
@@ -681,7 +681,7 @@ void __init get_smp_config (void)
 	 */
 	if (mpf->mpf_feature1 != 0) {
 
-		printk(KERN_INFO "Default MP configuration #%d\n", mpf->mpf_feature1);
+		pr_info("Default MP configuration #%d\n", mpf->mpf_feature1);
 		construct_default_ISA_mptable(mpf->mpf_feature1);
 
 	} else if (mpf->mpf_physptr) {
@@ -717,7 +717,7 @@ void __init get_smp_config (void)
 	} else
 		BUG();
 
-	printk(KERN_INFO "Processors: %d\n", num_processors);
+	pr_info("Processors: %d\n", num_processors);
 	/*
 	 * Only use the first configuration found.
 	 */
@@ -728,9 +728,9 @@ static int __init smp_scan_config (unsig
 	unsigned long *bp = phys_to_virt(base);
 	struct intel_mp_floating *mpf;
 
-	Dprintk("Scan SMP from %p for %ld bytes.\n", bp,length);
+	pr_debug("Scan SMP from %p for %ld bytes.\n", bp,length);
 	if (sizeof(*mpf) != 16)
-		printk("Error: MPF size\n");
+		printk(KERN_ERR "Error: MPF size\n");
 
 	while (length > 0) {
 		mpf = (struct intel_mp_floating *)bp;
@@ -741,7 +741,7 @@ static int __init smp_scan_config (unsig
 				|| (mpf->mpf_specification == 4)) ) {
 
 			smp_found_config = 1;
-			printk(KERN_INFO "found SMP MP-table at %08lx\n",
+			pr_info("found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
 			if (mpf->mpf_physptr) {
@@ -825,7 +825,7 @@ void __init mp_register_lapic_address (
 	if (boot_cpu_physical_apicid == -1U)
 		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 
-	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
+	pr_debug("Boot CPU = %d\n", boot_cpu_physical_apicid);
 }
 
 
@@ -898,7 +898,7 @@ void __init mp_register_ioapic (
 	int			idx = 0;
 
 	if (nr_ioapics >= MAX_IO_APICS) {
-		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
+		printk(KERN_EMERG "ERROR: Max # of I/O APICs (%d) exceeded "
 			"(found %d)\n", MAX_IO_APICS, nr_ioapics);
 		panic("Recompile kernel with bigger MAX_IO_APICS!\n");
 	}
@@ -927,7 +927,7 @@ void __init mp_register_ioapic (
 	mp_ioapic_routing[idx].gsi_end = gsi_base + 
 		io_apic_get_redir_entries(idx);
 
-	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
+	pr_info("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
 		"GSI %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
 		mp_ioapic_routing[idx].gsi_base,
@@ -971,7 +971,7 @@ void __init mp_override_legacy_irq (
 	intsrc.mpc_dstapic = mp_ioapics[ioapic].mpc_apicid;	   /* APIC ID */
 	intsrc.mpc_dstirq = pin;				    /* INTIN# */
 
-	Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, %d-%d\n",
+	pr_debug("Int: type %d, pol %d, trig %d, bus %d, irq %d, %d-%d\n",
 		intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
 		(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
 		intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, intsrc.mpc_dstirq);
@@ -994,7 +994,7 @@ void __init mp_config_acpi_legacy_irqs (
 	 * Fabricate the legacy ISA bus (bus #31).
 	 */
 	mp_bus_id_to_type[MP_ISA_BUS] = MP_BUS_ISA;
-	Dprintk("Bus #%d is ISA\n", MP_ISA_BUS);
+	pr_debug("Bus #%d is ISA\n", MP_ISA_BUS);
 
 	/* 
 	 * Locate the IOAPIC that manages the ISA IRQs (0-15). 
@@ -1029,7 +1029,7 @@ void __init mp_config_acpi_legacy_irqs (
 		}
 
 		if (idx != mp_irq_entries) {
-			printk(KERN_DEBUG "ACPI: IRQ%d used by override.\n", i);
+			pr_info("ACPI: IRQ%d used by override.\n", i);
 			continue;			/* IRQ already used */
 		}
 
@@ -1037,7 +1037,7 @@ void __init mp_config_acpi_legacy_irqs (
 		intsrc.mpc_srcbusirq = i;		   /* Identity mapped */
 		intsrc.mpc_dstirq = i;
 
-		Dprintk("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
+		pr_debug("Int: type %d, pol %d, trig %d, bus %d, irq %d, "
 			"%d-%d\n", intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3, 
 			(intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus, 
 			intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, 
@@ -1088,7 +1088,7 @@ void mp_register_gsi (u32 gsi, int edge_
 		return;
 	}
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
-		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
+		pr_debug("Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
 		return;
 	}


