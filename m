Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTB0T10>; Thu, 27 Feb 2003 14:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTB0T1Z>; Thu, 27 Feb 2003 14:27:25 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:27523 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266379AbTB0T1L>; Thu, 27 Feb 2003 14:27:11 -0500
Message-Id: <200302271937.h1RJbPJT010145@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 - more if/ifdef janitor work - arch/i386/*
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1348950028P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 14:37:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1348950028P
Content-Type: text/plain; charset=us-ascii

Cleaning up arch/i386 a bit:

--- arch/i386/kernel/irq.c.dist	2003-02-24 14:05:06.000000000 -0500
+++ arch/i386/kernel/irq.c	2003-02-27 01:51:37.646097560 -0500
@@ -90,7 +90,7 @@
  * each architecture has to answer this themselves, it doesnt deserve
  * a generic callback i think.
  */
-#if CONFIG_X86
+#ifdef CONFIG_X86
 	printk("unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -167,7 +167,7 @@
 		if (cpu_online(j))
 			p += seq_printf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
@@ -183,7 +183,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
@@ -832,7 +832,7 @@
 	return 0;
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
@@ -911,7 +911,7 @@
 	/* create /proc/irq/1234 */
 	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	{
 		struct proc_dir_entry *entry;
 
--- arch/i386/kernel/traps.c.dist	2003-02-24 14:05:11.000000000 -0500
+++ arch/i386/kernel/traps.c	2003-02-27 01:52:05.023410608 -0500
@@ -96,7 +96,7 @@
 		stack = (unsigned long*)&stack;
 
 	printk("Call Trace:");
-#if CONFIG_KALLSYMS
+#ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
 	i = 1;
@@ -423,7 +423,7 @@
 	unsigned char reason = inb(0x61);
  
 	if (!(reason & 0xc0)) {
-#if CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
--- arch/i386/kernel/acpi/sleep.c.dist	2003-02-24 14:05:31.000000000 -0500
+++ arch/i386/kernel/acpi/sleep.c	2003-02-27 01:52:28.273527560 -0500
@@ -34,7 +34,7 @@
  */
 int acpi_save_state_mem (void)
 {
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	panic("S3 and PAE do not like each other for now.");
 	return 1;
 #endif
--- arch/i386/kernel/reboot.c.dist	2003-02-24 14:05:14.000000000 -0500
+++ arch/i386/kernel/reboot.c	2003-02-27 01:52:47.224436660 -0500
@@ -223,7 +223,7 @@
 
 void machine_restart(char * __unused)
 {
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	int cpuid;
 	
 	cpuid = GET_APIC_ID(apic_read(APIC_ID));
--- arch/i386/kernel/setup.c.dist	2003-02-24 14:05:31.000000000 -0500
+++ arch/i386/kernel/setup.c	2003-02-27 01:53:00.968096324 -0500
@@ -640,7 +640,7 @@
 	} else {
 		if (highmem_pages == -1)
 			highmem_pages = 0;
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 		if (highmem_pages >= max_pfn) {
 			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
 			highmem_pages = 0;
--- arch/i386/mm/highmem.c.dist	2003-02-24 14:05:33.000000000 -0500
+++ arch/i386/mm/highmem.c	2003-02-27 01:53:41.980064804 -0500
@@ -37,7 +37,7 @@
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	if (!pte_none(*(kmap_pte-idx)))
 		BUG();
 #endif
@@ -49,7 +49,7 @@
 
 void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
--- arch/i386/mm/init.c.dist	2003-02-24 14:05:39.000000000 -0500
+++ arch/i386/mm/init.c	2003-02-27 01:54:40.659881300 -0500
@@ -53,7 +53,7 @@
 {
 	pmd_t *pmd_table;
 		
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	if (pmd_table != pmd_offset(pgd, 0)) 
@@ -186,7 +186,7 @@
 	return 0;
 }
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
@@ -263,7 +263,7 @@
 	unsigned long vaddr;
 	pgd_t *pgd_base = swapper_pg_dir;
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	int i;
 	/* Init entries of the first-level page table to the zero page */
 	for (i = 0; i < PTRS_PER_PGD; i++)
@@ -293,7 +293,7 @@
 
 	permanent_kmaps_init(pgd_base);
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	/*
 	 * Add low memory identity-mappings - SMP needs it when
 	 * starting up on an AP from real-mode. In the non-PAE
@@ -315,7 +315,7 @@
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
 	for (i = 0; i < USER_PTRS_PER_PGD; i++)
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
@@ -361,7 +361,7 @@
 
 	load_cr3(swapper_pg_dir);
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	/*
 	 * We will bail out later - printk doesn't work right now so
 	 * the user would just see a hanging kernel.
@@ -490,7 +490,7 @@
 		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10))
 	       );
 
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 	if (!cpu_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
 #endif
--- arch/i386/mm/pgtable.c.dist	2003-02-24 14:06:03.000000000 -0500
+++ arch/i386/mm/pgtable.c	2003-02-27 01:55:26.286071252 -0500
@@ -151,7 +151,7 @@
 	struct page *pte;
    
    	do {
-#if CONFIG_HIGHPTE
+#ifdef CONFIG_HIGHPTE
 		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
 #else
 		pte = alloc_pages(GFP_KERNEL, 0);



--==_Exmh_1348950028P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Xmj0cC3lWbTT17ARAt9dAKD4R6qZ0yszpwrmecj9KPTBsak8SQCeKoFA
mKojmGh0COZzbOjNQ6bTx0Y=
=N92N
-----END PGP SIGNATURE-----

--==_Exmh_1348950028P--
