Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTDVTWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTDVTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:22:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59264 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263399AbTDVTVS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:21:18 -0400
Message-Id: <200304221933.h3MJXMLq004830@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 - #if cleanup arch/* (1/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:33:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up files in arch/*

--- linux-2.5.68-bk3/arch/alpha/kernel/core_marvel.c.dist	2003-04-07 13:30:40.000000000 -0400
+++ linux-2.5.68-bk3/arch/alpha/kernel/core_marvel.c	2003-04-22 15:02:18.391673759 -0400
@@ -781,7 +781,7 @@
 		rtc_access.function = 0x49;		/* GET_TOY */
 		if (write) rtc_access.function = 0x48;	/* PUT_TOY */
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 		if (smp_processor_id() != boot_cpuid)
 			smp_call_function_on_cpu(__marvel_access_rtc,
 						 &rtc_access,
--- linux-2.5.68-bk3/arch/alpha/kernel/irq.c.dist	2003-04-22 13:57:33.000000000 -0400
+++ linux-2.5.68-bk3/arch/alpha/kernel/irq.c	2003-04-22 15:02:25.833711303 -0400
@@ -556,7 +556,7 @@
 unlock:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	seq_puts(p, "IPI: ");
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_online(i))
--- linux-2.5.68-bk3/arch/arm/common/sa1111.c.dist	2003-04-22 13:56:43.000000000 -0400
+++ linux-2.5.68-bk3/arch/arm/common/sa1111.c	2003-04-22 15:03:15.545348488 -0400
@@ -419,7 +419,7 @@
 
 	spin_lock_irqsave(&sachip->lock, flags);
 
-#if CONFIG_ARCH_SA1100
+#ifdef CONFIG_ARCH_SA1100
 	/*
 	 * First, set up the 3.6864MHz clock on GPIO 27 for the SA-1111:
 	 * (SA-1110 Developer's Manual, section 9.1.2.1)
@@ -427,7 +427,7 @@
 	GAFR |= GPIO_32_768kHz;
 	GPDR |= GPIO_32_768kHz;
 	TUCR = TUCR_3_6864MHz;
-#elif CONFIG_ARCH_PXA
+#elif defined(CONFIG_ARCH_PXA)
 	pxa_gpio_mode(GPIO11_3_6MHz_MD);
 #else
 #error missing clock setup
--- linux-2.5.68-bk3/arch/cris/drivers/eeprom.c.dist	2003-04-07 13:31:04.000000000 -0400
+++ linux-2.5.68-bk3/arch/cris/drivers/eeprom.c	2003-04-22 15:02:37.126262292 -0400
@@ -163,7 +163,7 @@
   init_waitqueue_head(&eeprom.wait_q);
   eeprom.busy = 0;
 
-#if CONFIG_ETRAX_I2C_EEPROM_PROBE
+#ifdef CONFIG_ETRAX_I2C_EEPROM_PROBE
 #define EETEXT "Found"
 #else
 #define EETEXT "Assuming"
@@ -191,7 +191,7 @@
   eeprom.usec_delay_step = 128;
   eeprom.adapt_state = 0;
   
-#if CONFIG_ETRAX_I2C_EEPROM_PROBE
+#ifdef CONFIG_ETRAX_I2C_EEPROM_PROBE
   i2c_start();
   i2c_outbyte(0x80);
   if(!i2c_getack())
--- linux-2.5.68-bk3/arch/i386/kernel/acpi/sleep.c.dist	2003-04-07 13:31:18.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/kernel/acpi/sleep.c	2003-04-22 14:59:42.834276601 -0400
@@ -75,7 +75,7 @@
 		printk(KERN_ERR "ACPI: Wakeup code way too big, S3 disabled.\n");
 		return;
 	}
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	printk(KERN_ERR "ACPI: S3 and PAE do not like each other for now, S3 disabled.\n");
 	return;
 #endif
--- linux-2.5.68-bk3/arch/i386/kernel/irq.c.dist	2003-04-22 13:57:34.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/kernel/irq.c	2003-04-22 14:59:17.614096093 -0400
@@ -91,7 +91,7 @@
  * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
-#if CONFIG_X86
+#ifdef CONFIG_X86
 	printk("unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -172,7 +172,7 @@
 		if (cpu_online(j))
 			seq_printf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
@@ -188,7 +188,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
@@ -852,7 +852,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
@@ -931,7 +931,7 @@
 	/* create /proc/irq/1234 */
 	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	{
 		struct proc_dir_entry *entry;
 
--- linux-2.5.68-bk3/arch/i386/kernel/reboot.c.dist	2003-04-07 13:30:59.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/kernel/reboot.c	2003-04-22 14:59:50.579138204 -0400
@@ -215,7 +215,7 @@
 
 void machine_restart(char * __unused)
 {
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	int cpuid;
 	
 	cpuid = GET_APIC_ID(apic_read(APIC_ID));
--- linux-2.5.68-bk3/arch/i386/kernel/setup.c.dist	2003-04-22 13:57:34.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/kernel/setup.c	2003-04-22 15:00:13.293038159 -0400
@@ -596,7 +596,7 @@
 	} else {
 		if (highmem_pages == -1)
 			highmem_pages = 0;
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 		if (highmem_pages >= max_pfn) {
 			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
 			highmem_pages = 0;
@@ -818,7 +818,7 @@
 			static const char *nops[] = {
 				0,
 				"\x90",
-#if CONFIG_MK7 || CONFIG_MK8
+#if defined(CONFIG_MK7) || defined(CONFIG_MK8)
 				"\x66\x90",
 				"\x66\x66\x90",
 				"\x66\x66\x66\x90",
--- linux-2.5.68-bk3/arch/i386/kernel/traps.c.dist	2003-04-22 13:56:47.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/kernel/traps.c	2003-04-22 14:59:29.658314358 -0400
@@ -101,7 +101,7 @@
 		stack = (unsigned long*)&stack;
 
 	printk("Call Trace:");
-#if CONFIG_KALLSYMS
+#ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
 	i = 1;
@@ -438,7 +438,7 @@
 	unsigned char reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
--- linux-2.5.68-bk3/arch/i386/mm/highmem.c.dist	2003-04-07 13:31:41.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/mm/highmem.c	2003-04-22 15:00:24.951578553 -0400
@@ -36,7 +36,7 @@
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	if (!pte_none(*(kmap_pte-idx)))
 		BUG();
 #endif
@@ -48,7 +48,7 @@
 
 void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
--- linux-2.5.68-bk3/arch/i386/mm/init.c.dist	2003-04-07 13:32:18.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/mm/init.c	2003-04-22 15:00:40.730262871 -0400
@@ -55,7 +55,7 @@
 {
 	pmd_t *pmd_table;
 		
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	if (pmd_table != pmd_offset(pgd, 0)) 
@@ -188,7 +188,7 @@
 	return 0;
 }
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
@@ -265,7 +265,7 @@
 	unsigned long vaddr;
 	pgd_t *pgd_base = swapper_pg_dir;
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	int i;
 	/* Init entries of the first-level page table to the zero page */
 	for (i = 0; i < PTRS_PER_PGD; i++)
@@ -295,7 +295,7 @@
 
 	permanent_kmaps_init(pgd_base);
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	/*
 	 * Add low memory identity-mappings - SMP needs it when
 	 * starting up on an AP from real-mode. In the non-PAE
@@ -317,7 +317,7 @@
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
 	for (i = 0; i < USER_PTRS_PER_PGD; i++)
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
@@ -363,7 +363,7 @@
 
 	load_cr3(swapper_pg_dir);
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	/*
 	 * We will bail out later - printk doesn't work right now so
 	 * the user would just see a hanging kernel.
@@ -487,7 +487,7 @@
 		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10))
 	       );
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	if (!cpu_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
 #endif
--- linux-2.5.68-bk3/arch/i386/mm/pgtable.c.dist	2003-04-22 13:57:34.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/mm/pgtable.c	2003-04-22 15:00:52.426575649 -0400
@@ -141,7 +141,7 @@
 {
 	struct page *pte;
 
-#if CONFIG_HIGHPTE
+#ifdef CONFIG_HIGHPTE
 	pte = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT, 0);
 #else
 	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
--- linux-2.5.68-bk3/arch/ia64/kernel/irq.c.dist	2003-04-07 13:32:28.000000000 -0400
+++ linux-2.5.68-bk3/arch/ia64/kernel/irq.c	2003-04-22 15:03:42.512793094 -0400
@@ -107,7 +107,7 @@
  * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
-#if CONFIG_X86
+#ifdef CONFIG_X86
 	printk(KERN_ERR "unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -121,7 +121,7 @@
 	ack_APIC_irq();
 #endif
 #endif
-#if CONFIG_IA64
+#ifdef CONFIG_IA64
 	printk(KERN_ERR "Unexpected irq vector 0x%x on CPU %u!\n", irq, smp_processor_id());
 #endif
 }
@@ -204,7 +204,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
 	while (irq_desc(irq)->status & IRQ_INPROGRESS)
@@ -844,7 +844,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
@@ -947,7 +947,7 @@
 	/* create /proc/irq/1234 */
 	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	{
 		struct proc_dir_entry *entry;
 		/* create /proc/irq/1234/smp_affinity */
--- linux-2.5.68-bk3/arch/m68k/sun3/prom/init.c.dist	2003-04-07 13:32:32.000000000 -0400
+++ linux-2.5.68-bk3/arch/m68k/sun3/prom/init.c	2003-04-22 15:02:10.878682912 -0400
@@ -32,7 +32,7 @@
 
 void __init prom_init(struct linux_romvec *rp)
 {
-#if CONFIG_AP1000
+#ifdef CONFIG_AP1000
 	extern struct linux_romvec *ap_prom_init(void);
 	rp = ap_prom_init();
 #endif
--- linux-2.5.68-bk3/arch/m68k/sun3/prom/printf.c.dist	2003-04-07 13:30:38.000000000 -0400
+++ linux-2.5.68-bk3/arch/m68k/sun3/prom/printf.c	2003-04-22 15:02:00.224179881 -0400
@@ -38,7 +38,7 @@
 
 	bptr = ppbuf;
 
-#if CONFIG_AP1000
+#ifdef CONFIG_AP1000
         ap_write(1,bptr,strlen(bptr));
 #else
 
--- linux-2.5.68-bk3/arch/mips/arc/misc.c.dist	2003-04-07 13:30:44.000000000 -0400
+++ linux-2.5.68-bk3/arch/mips/arc/misc.c	2003-04-22 15:02:51.070987629 -0400
@@ -19,7 +19,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	romvec->halt();
@@ -29,7 +29,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	romvec->pdown();
@@ -40,7 +40,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	romvec->restart();
@@ -50,7 +50,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	romvec->reboot();
@@ -60,7 +60,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	romvec->imode();
--- linux-2.5.68-bk3/arch/mips64/arc/misc.c.dist	2003-04-07 13:31:57.000000000 -0400
+++ linux-2.5.68-bk3/arch/mips64/arc/misc.c	2003-04-22 15:03:28.786554889 -0400
@@ -29,7 +29,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	ARC_CALL0(halt);
@@ -41,7 +41,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	ARC_CALL0(pdown);
@@ -54,7 +54,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	ARC_CALL0(restart);
@@ -66,7 +66,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	ARC_CALL0(reboot);
@@ -78,7 +78,7 @@
 {
 	bc_disable();
 	cli();
-#if CONFIG_SCSI_SGIWD93
+#ifdef CONFIG_SCSI_SGIWD93
 	reset_wd33c93(sgiwd93_host);
 #endif
 	ARC_CALL0(imode);
--- linux-2.5.68-bk3/arch/ppc/kernel/process.c.dist	2003-04-07 13:31:18.000000000 -0400
+++ linux-2.5.68-bk3/arch/ppc/kernel/process.c	2003-04-22 15:01:20.995841886 -0400
@@ -524,7 +524,7 @@
 	while (count < 16 && sp > prev_sp && sp < stack_top && (sp & 3) == 0) {
 		if (count == 0) {
 			printk("Call trace:");
-#if CONFIG_KALLSYMS
+#ifdef CONFIG_KALLSYMS
 			printk("\n");
 #endif
 		} else {
@@ -534,7 +534,7 @@
 			} else
 				ret = *(unsigned long *)(sp + 4);
 			printk(" [%08lx] ", ret);
-#if CONFIG_KALLSYMS
+#ifdef CONFIG_KALLSYMS
 			print_symbol("%s", ret);
 			printk("\n");
 #endif
--- linux-2.5.68-bk3/arch/s390/kernel/s390_ksyms.c.dist	2003-04-22 13:56:53.000000000 -0400
+++ linux-2.5.68-bk3/arch/s390/kernel/s390_ksyms.c	2003-04-22 15:04:17.252446716 -0400
@@ -13,7 +13,7 @@
 #include <asm/delay.h>
 #include <asm/pgalloc.h>
 #include <asm/setup.h>
-#if CONFIG_IP_MULTICAST
+#ifdef CONFIG_IP_MULTICAST
 #include <net/arp.h>
 #endif
 
--- linux-2.5.68-bk3/arch/s390/kernel/traps.c.dist	2003-04-22 13:56:53.000000000 -0400
+++ linux-2.5.68-bk3/arch/s390/kernel/traps.c	2003-04-22 15:04:11.293300921 -0400
@@ -304,7 +304,7 @@
 	}
 	else
 	{
-#if CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_REMOTE_DEBUG
 		if(gdb_stub_initialised)
 		{
 			gdb_stub_handle_exception(regs, signal);
--- linux-2.5.68-bk3/arch/s390/math-emu/math.c.dist	2003-04-22 13:56:53.000000000 -0400
+++ linux-2.5.68-bk3/arch/s390/math-emu/math.c	2003-04-22 15:04:22.667691879 -0400
@@ -102,7 +102,7 @@
         struct pt_regs *regs;
         __u16 *location;
         
-#if CONFIG_SYSCTL
+#ifdef CONFIG_SYSCTL
         if(sysctl_ieee_emulation_warnings)
 #endif
         {
--- linux-2.5.68-bk3/arch/sparc/kernel/sparc_ksyms.c.dist	2003-04-22 13:56:59.000000000 -0400
+++ linux-2.5.68-bk3/arch/sparc/kernel/sparc_ksyms.c	2003-04-22 15:01:05.790763035 -0400
@@ -157,7 +157,7 @@
 EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL(mostek_lock);
 EXPORT_SYMBOL(mstk48t02_regs);
-#if CONFIG_SUN_AUXIO
+#ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(auxio_register);
 #endif
 EXPORT_SYMBOL(request_fast_irq);
@@ -182,7 +182,7 @@
 EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(mmu_release_scsi_sgl));
 EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(mmu_release_scsi_one));
 
-#if CONFIG_SBUS
+#ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_root);
 EXPORT_SYMBOL(dma_chain);
 EXPORT_SYMBOL(sbus_set_sbus64);
@@ -197,7 +197,7 @@
 EXPORT_SYMBOL(sbus_iounmap);
 EXPORT_SYMBOL(sbus_ioremap);
 #endif
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 EXPORT_SYMBOL(ebus_chain);
 EXPORT_SYMBOL(insl);
 EXPORT_SYMBOL(outsl);
--- linux-2.5.68-bk3/arch/sparc/mm/srmmu.c.dist	2003-04-22 13:56:59.000000000 -0400
+++ linux-2.5.68-bk3/arch/sparc/mm/srmmu.c	2003-04-22 15:01:12.159940681 -0400
@@ -1340,7 +1340,7 @@
 	flush_tlb_all();
 	poke_srmmu();
 
-#if CONFIG_SUN_IO
+#ifdef CONFIG_SUN_IO
 	srmmu_allocate_ptable_skeleton(sparc_iomap.start, IOBASE_END);
 	srmmu_allocate_ptable_skeleton(DVMA_VADDR, DVMA_END);
 #endif
--- linux-2.5.68-bk3/arch/sparc64/kernel/sparc64_ksyms.c.dist	2003-04-07 13:32:26.000000000 -0400
+++ linux-2.5.68-bk3/arch/sparc64/kernel/sparc64_ksyms.c	2003-04-22 14:58:56.802810582 -0400
@@ -196,10 +196,10 @@
 EXPORT_SYMBOL(mostek_lock);
 EXPORT_SYMBOL(mstk48t02_regs);
 EXPORT_SYMBOL(request_fast_irq);
-#if CONFIG_SUN_AUXIO
+#ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(auxio_register);
 #endif
-#if CONFIG_SBUS
+#ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_root);
 EXPORT_SYMBOL(dma_chain);
 EXPORT_SYMBOL(sbus_set_sbus64);
--- linux-2.5.68-bk3/arch/um/kernel/irq.c.dist	2003-04-07 13:32:25.000000000 -0400
+++ linux-2.5.68-bk3/arch/um/kernel/irq.c	2003-04-22 15:01:41.838953249 -0400
@@ -48,7 +48,7 @@
  * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
-#if CONFIG_X86
+#ifdef CONFIG_X86
 	printk(KERN_ERR "unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -121,7 +121,7 @@
 	}
 	p += sprintf(p, "\n");
 #ifdef notdef
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	p += sprintf(p, "LOC: ");
 	for (j = 0; j < num_online_cpus(); j++)
 		p += sprintf(p, "%10u ",
@@ -198,7 +198,7 @@
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
 	/* is there anything to synchronize with? */
@@ -621,7 +621,7 @@
 
 	err = parse_hex_value(buffer, count, &new_value);
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
 	 * way to make the system unusable accidentally :-) At least
--- linux-2.5.68-bk3/arch/um/kernel/mem.c.dist	2003-04-22 13:57:35.000000000 -0400
+++ linux-2.5.68-bk3/arch/um/kernel/mem.c	2003-04-22 15:01:31.024653808 -0400
@@ -124,7 +124,7 @@
 	kmem_top = new;
 }
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 /* Changed during early boot */
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
@@ -329,7 +329,7 @@
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 	init_highmem();
 	setup_highmem(highmem);
 #endif
--- linux-2.5.68-bk3/arch/um/kernel/sys_call_table.c.dist	2003-04-07 13:32:26.000000000 -0400
+++ linux-2.5.68-bk3/arch/um/kernel/sys_call_table.c	2003-04-22 15:01:53.880109716 -0400
@@ -236,7 +236,7 @@
 extern syscall_handler_t sys_remap_file_pages;
 extern syscall_handler_t sys_set_tid_address;
 
-#if CONFIG_NFSD
+#ifdef CONFIG_NFSD
 #define NFSSERVCTL sys_nfsservctl
 #else
 #define NFSSERVCTL sys_ni_syscall
--- linux-2.5.68-bk3/arch/x86_64/kernel/irq.c.dist	2003-04-07 13:31:09.000000000 -0400
+++ linux-2.5.68-bk3/arch/x86_64/kernel/irq.c	2003-04-22 15:03:58.082286082 -0400
@@ -90,7 +90,7 @@
  * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
-#if CONFIG_X86
+#ifdef CONFIG_X86
 	printk("unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -171,7 +171,7 @@
 		if (cpu_online(j))
 		seq_printf(p, "%10u ", cpu_pda[j].__nmi_count);
 	seq_putc(p, '\n');
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
@@ -827,7 +827,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
@@ -906,7 +906,7 @@
 	/* create /proc/irq/1234 */
 	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	{
 		struct proc_dir_entry *entry;
 
--- linux-2.5.68-bk3/arch/x86_64/kernel/reboot.c.dist	2003-04-07 13:32:26.000000000 -0400
+++ linux-2.5.68-bk3/arch/x86_64/kernel/reboot.c	2003-04-22 15:04:04.707275045 -0400
@@ -68,7 +68,7 @@
 
 void machine_restart(char * __unused)
 {
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	int cpuid;
 	
 	cpuid = GET_APIC_ID(apic_read(APIC_ID));
--- linux-2.5.68-bk3/arch/x86_64/kernel/traps.c.dist	2003-04-07 13:30:34.000000000 -0400
+++ linux-2.5.68-bk3/arch/x86_64/kernel/traps.c	2003-04-22 15:03:48.421819575 -0400
@@ -529,7 +529,7 @@
 	unsigned char reason = inb(0x61);
 
 	if (!(reason & 0xc0)) {
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.



