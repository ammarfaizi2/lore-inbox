Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266406AbUBFDnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUBFDnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:43:33 -0500
Received: from h80ad253b.async.vt.edu ([128.173.37.59]:55424 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266406AbUBFDnS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:43:18 -0500
Message-Id: <200402060343.i163hILO009962@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.2-mm1 - #if versus #ifdef cleanup
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_264704001P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Feb 2004 22:43:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_264704001P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <9951.1076038997.1@turing-police.cc.vt.edu>

Much shorter this time, 15 changes of #if to #ifdef and
2 places CONFIG_FOO should be defined(CONFIG_FOO).  This gets
rid of spurious warnings if you build with "-Wundef" so you get
a warning if you have a preprocessor command like:

#if CONFIG_ETRAX_DS1302_RSTBIT == 27

and you'll be told if it's substituting a zero rather than silent
weirdness and unexpected code generation.

--- linux-2.6.2-mm1/arch/i386/mm/init.c.dist	2004-02-05 11:56:40.127062961 -0500
+++ linux-2.6.2-mm1/arch/i386/mm/init.c	2004-02-05 11:57:11.331301272 -0500
@@ -259,7 +259,7 @@
 	 * All user-space mappings are explicitly cleared after
 	 * SMP startup.
 	 */
-#if CONFIG_SMP && CONFIG_X86_PAE
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_PAE)
 	setup_identity_mappings(pgd_base, 0, 16*1024*1024);
 #endif
 	remap_numa_kva();
@@ -271,7 +271,7 @@
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, 0, pgd_base);
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 	{
 		pgd_t *pgd;
 		pmd_t *pmd;
--- linux-2.6.2-mm1/arch/um/kernel/mem.c.dist	2004-02-05 22:04:09.530768207 -0500
+++ linux-2.6.2-mm1/arch/um/kernel/mem.c	2004-02-05 22:04:28.503223549 -0500
@@ -136,7 +136,7 @@
 	}
 }
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
--- linux-2.6.2-mm1/arch/ia64/sn/kernel/irq.c.dist	2004-02-05 22:05:38.206896448 -0500
+++ linux-2.6.2-mm1/arch/ia64/sn/kernel/irq.c	2004-02-05 22:05:49.747173416 -0500
@@ -121,7 +121,7 @@
 static void
 sn_set_affinity_irq(unsigned int irq, unsigned long cpu)
 {
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	int redir = 0;
 	struct sn_intr_list_t *p = sn_intr_list[irq];
 	pcibr_intr_t intr;
--- linux-2.6.2-mm1/drivers/net/tulip/de4x5.c.dist	2004-02-05 21:57:25.648074959 -0500
+++ linux-2.6.2-mm1/drivers/net/tulip/de4x5.c	2004-02-05 21:57:49.455646345 -0500
@@ -5745,7 +5745,7 @@
 {
 	int err = 0;
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	err = pci_module_init (&de4x5_pci_driver);
 #endif
 #ifdef CONFIG_EISA
@@ -5757,7 +5757,7 @@
 
 static void __exit de4x5_module_exit (void)
 {
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	pci_unregister_driver (&de4x5_pci_driver);
 #endif
 #ifdef CONFIG_EISA
--- linux-2.6.2-mm1/drivers/net/depca.c.dist	2004-02-05 21:57:59.788894344 -0500
+++ linux-2.6.2-mm1/drivers/net/depca.c	2004-02-05 21:58:23.920473506 -0500
@@ -2086,7 +2086,7 @@
 {
         int err = 0;
 
-#if CONFIG_MCA
+#ifdef CONFIG_MCA
         err = mca_register_driver (&depca_mca_driver);
 #endif
 #ifdef CONFIG_EISA
@@ -2101,7 +2101,7 @@
 static void __exit depca_module_exit (void)
 {
 	int i;
-#if CONFIG_MCA
+#ifdef CONFIG_MCA
         mca_unregister_driver (&depca_mca_driver);
 #endif
 #ifdef CONFIG_EISA
--- linux-2.6.2-mm1/drivers/mtd/maps/solutionengine.c.dist	2004-02-05 21:59:09.209560451 -0500
+++ linux-2.6.2-mm1/drivers/mtd/maps/solutionengine.c	2004-02-05 21:59:34.746173334 -0500
@@ -97,7 +97,7 @@
 
 	nr_parts = parse_mtd_partitions(flash_mtd, probes, &parsed_parts, 0);
 
-#if CONFIG_MTD_SUPERH_RESERVE
+#ifdef CONFIG_MTD_SUPERH_RESERVE
 	if (nr_parts <= 0) {
 		printk(KERN_NOTICE "Using configured partition at 0x%08x.\n",
 		       CONFIG_MTD_SUPERH_RESERVE);
--- linux-2.6.2-mm1/include/asm-i386/module.h.dist	2004-02-05 11:53:50.442781424 -0500
+++ linux-2.6.2-mm1/include/asm-i386/module.h	2004-02-05 11:54:03.534132140 -0500
@@ -48,7 +48,7 @@
 #define MODULE_PROC_FAMILY "WINCHIP3D "
 #elif defined CONFIG_MCYRIXIII
 #define MODULE_PROC_FAMILY "CYRIXIII "
-#elif CONFIG_MVIAC3_2
+#elif defined CONFIG_MVIAC3_2
 #define MODULE_PROC_FAMILY "VIAC3-2 "
 #else
 #define MODULE_PROC_FAMILY "this needs to be fixed"
--- linux-2.6.2-mm1/include/asm-mips/hardirq.h.dist	2004-02-05 22:12:46.807788809 -0500
+++ linux-2.6.2-mm1/include/asm-mips/hardirq.h	2004-02-05 22:13:09.550334634 -0500
@@ -79,7 +79,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.6.2-mm1/include/asm-mips/pgtable-32.h.dist	2004-02-05 22:14:06.217694659 -0500
+++ linux-2.6.2-mm1/include/asm-mips/pgtable-32.h	2004-02-05 22:14:16.108932050 -0500
@@ -80,7 +80,7 @@
 
 #define VMALLOC_START     KSEG2
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
 #else
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
--- linux-2.6.2-mm1/include/asm-mips/topology.h.dist	2004-02-05 22:14:43.740595215 -0500
+++ linux-2.6.2-mm1/include/asm-mips/topology.h	2004-02-05 22:14:53.409827278 -0500
@@ -1,7 +1,7 @@
 #ifndef __ASM_TOPOLOGY_H
 #define __ASM_TOPOLOGY_H
 
-#if CONFIG_SGI_IP27
+#ifdef CONFIG_SGI_IP27
 
 #include <asm/mmzone.h>
 
--- linux-2.6.2-mm1/include/asm-sh/hardirq.h.dist	2004-02-05 22:15:30.049706641 -0500
+++ linux-2.6.2-mm1/include/asm-sh/hardirq.h	2004-02-05 22:15:39.181925815 -0500
@@ -74,7 +74,7 @@
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.6.2-mm1/include/asm-sh/kmap_types.h.dist	2004-02-05 22:16:06.239575203 -0500
+++ linux-2.6.2-mm1/include/asm-sh/kmap_types.h	2004-02-05 22:16:16.184813890 -0500
@@ -5,7 +5,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
--- linux-2.6.2-mm1/lib/crc32.c.dist	2004-02-05 12:14:58.643267051 -0500
+++ linux-2.6.2-mm1/lib/crc32.c	2004-02-05 12:15:13.535570912 -0500
@@ -397,7 +397,7 @@
  * the same way on decoding, it doesn't make a difference.
  */
 
-#if UNITTEST
+#ifdef UNITTEST
 
 #include <stdlib.h>
 #include <stdio.h>
--- linux-2.6.2-mm1/net/ipv6/af_inet6.c.dist	2004-02-05 12:13:50.659307786 -0500
+++ linux-2.6.2-mm1/net/ipv6/af_inet6.c	2004-02-05 12:14:00.029658308 -0500
@@ -56,7 +56,7 @@
 #include <net/transp_v6.h>
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
-#if CONFIG_IPV6_TUNNEL
+#ifdef CONFIG_IPV6_TUNNEL
 #include <net/ip6_tunnel.h>
 #endif
 



--==_Exmh_264704001P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIw1VcC3lWbTT17ARAtjdAKDfJxZKW6HgwyVbvDakl9CwIFZ/UgCfUPYC
Oi0k/FBkKVkb6GXwzcHa23k=
=0LiY
-----END PGP SIGNATURE-----

--==_Exmh_264704001P--
