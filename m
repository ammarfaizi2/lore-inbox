Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313196AbSC1RyY>; Thu, 28 Mar 2002 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313199AbSC1RyU>; Thu, 28 Mar 2002 12:54:20 -0500
Received: from are.twiddle.net ([64.81.246.98]:33426 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S313196AbSC1Rxz>;
	Thu, 28 Mar 2002 12:53:55 -0500
Date: Thu, 28 Mar 2002 09:53:46 -0800
From: Richard Henderson <rth@twiddle.net>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [1/10]
Message-ID: <20020328095346.A23600@twiddle.net>
Mail-Followup-To: Chris Meadors <clubneon@hereintown.net>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
In-Reply-To: <E16o6CB-0005Ny-00@lightning.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 12:17:47PM -0500, Chris Meadors wrote:
> This is probally the Wrong Thing to do, but making pgalloc.h include 
> highmem.h instead of the other way around, thus breaking at least the
> Alpha and Sparc64 platforms wasn't much less Wrong.

Actually, this breaks x86.  I've been back and forth with Linus
about this a couple of times.  My latest attempt follows.  It was
done after he left for vacation, so I havn't heard if he hates
it yet...


r~


	bk://are.twiddle.net:8080/flush-hdrs

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.538  
#	include/asm-alpha/pgalloc.h	1.7     -> 1.8    
#	arch/alpha/kernel/sys_rx164.c	1.1     -> 1.2    
#	        mm/vmalloc.c	1.10    -> 1.11   
#	arch/alpha/kernel/sys_sio.c	1.2     -> 1.3    
#	arch/alpha/kernel/sys_ruffian.c	1.3     -> 1.4    
#	include/asm-i386/pgalloc.h	1.13    -> 1.14   
#	arch/alpha/kernel/sys_jensen.c	1.3     -> 1.4    
#	           mm/mmap.c	1.22    -> 1.23   
#	arch/alpha/kernel/sys_sable.c	1.2     -> 1.3    
#	arch/alpha/kernel/sys_eiger.c	1.3     -> 1.4    
#	       kernel/fork.c	1.37    -> 1.38   
#	arch/i386/kernel/vm86.c	1.6     -> 1.7    
#	         mm/vmscan.c	1.58    -> 1.59   
#	arch/alpha/kernel/sys_takara.c	1.1     -> 1.2    
#	arch/alpha/kernel/core_irongate.c	1.4     -> 1.5    
#	     kernel/module.c	1.8     -> 1.9    
#	arch/alpha/kernel/sys_dp264.c	1.6     -> 1.7    
#	    fs/binfmt_aout.c	1.9     -> 1.10   
#	arch/alpha/kernel/sys_eb64p.c	1.1     -> 1.2    
#	include/linux/highmem.h	1.13    -> 1.14   
#	arch/alpha/kernel/sys_mikasa.c	1.1     -> 1.2    
#	arch/alpha/kernel/sys_noritake.c	1.1     -> 1.2    
#	 arch/i386/mm/init.c	1.11    -> 1.12   
#	arch/i386/mm/ioremap.c	1.5     -> 1.6    
#	arch/alpha/kernel/sys_cabriolet.c	1.4     -> 1.5    
#	arch/alpha/mm/fault.c	1.5     -> 1.6    
#	          mm/msync.c	1.2     -> 1.3    
#	arch/alpha/kernel/sys_nautilus.c	1.3     -> 1.4    
#	       mm/mprotect.c	1.8     -> 1.9    
#	arch/alpha/kernel/sys_wildfire.c	1.2     -> 1.3    
#	arch/alpha/kernel/sys_alcor.c	1.2     -> 1.3    
#	         mm/memory.c	1.54    -> 1.55   
#	arch/alpha/kernel/sys_sx164.c	1.2     -> 1.3    
#	arch/alpha/kernel/sys_miata.c	1.4     -> 1.5    
#	         mm/mremap.c	1.10    -> 1.11   
#	include/asm-i386/pgtable.h	1.9     -> 1.10   
#	arch/i386/kernel/acpi.c	1.1     -> 1.2    
#	arch/alpha/kernel/sys_rawhide.c	1.4     -> 1.5    
#	arch/alpha/kernel/sys_titan.c	1.4     -> 1.5    
#	               (new)	        -> 1.1     include/asm-i386/cacheflush.h
#	               (new)	        -> 1.1     include/asm-alpha/tlbflush.h
#	               (new)	        -> 1.1     include/asm-i386/tlbflush.h
#	               (new)	        -> 1.1     include/asm-alpha/cacheflush.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/25	rth@are.twiddle.net	1.538
# Break an include loop by moving cache flushing routines from
# asm/pgtable.h and/or asm/pgalloc.h to asm/cacheflush.h, and
# tlb flushing routines to asm/tlbflush.h.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
--- a/arch/alpha/kernel/core_irongate.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/core_irongate.c	Thu Mar 28 09:52:12 2002
@@ -19,6 +19,8 @@
 #include <asm/system.h>
 #include <asm/pci.h>
 #include <asm/hwrpb.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 #define __EXTERN_INLINE inline
 #include <asm/io.h>
diff -Nru a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
--- a/arch/alpha/kernel/sys_alcor.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_alcor.c	Thu Mar 28 09:52:12 2002
@@ -26,6 +26,7 @@
 #include <asm/irq.h>
 #include <asm/pgtable.h>
 #include <asm/core_cia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
--- a/arch/alpha/kernel/sys_cabriolet.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_cabriolet.c	Thu Mar 28 09:52:12 2002
@@ -28,6 +28,7 @@
 #include <asm/core_apecs.h>
 #include <asm/core_cia.h>
 #include <asm/core_lca.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
--- a/arch/alpha/kernel/sys_dp264.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_dp264.c	Thu Mar 28 09:52:12 2002
@@ -30,6 +30,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_tsunami.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
--- a/arch/alpha/kernel/sys_eb64p.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_eb64p.c	Thu Mar 28 09:52:12 2002
@@ -27,6 +27,7 @@
 #include <asm/core_apecs.h>
 #include <asm/core_lca.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
--- a/arch/alpha/kernel/sys_eiger.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_eiger.c	Thu Mar 28 09:52:12 2002
@@ -27,6 +27,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_tsunami.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
--- a/arch/alpha/kernel/sys_jensen.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_jensen.c	Thu Mar 28 09:52:12 2002
@@ -26,6 +26,7 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
--- a/arch/alpha/kernel/sys_miata.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_miata.c	Thu Mar 28 09:52:12 2002
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/core_cia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_mikasa.c b/arch/alpha/kernel/sys_mikasa.c
--- a/arch/alpha/kernel/sys_mikasa.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_mikasa.c	Thu Mar 28 09:52:12 2002
@@ -26,6 +26,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_apecs.h>
 #include <asm/core_cia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
--- a/arch/alpha/kernel/sys_nautilus.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_nautilus.c	Thu Mar 28 09:52:12 2002
@@ -43,6 +43,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_irongate.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
--- a/arch/alpha/kernel/sys_noritake.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_noritake.c	Thu Mar 28 09:52:12 2002
@@ -27,6 +27,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_apecs.h>
 #include <asm/core_cia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_rawhide.c b/arch/alpha/kernel/sys_rawhide.c
--- a/arch/alpha/kernel/sys_rawhide.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_rawhide.c	Thu Mar 28 09:52:12 2002
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/core_mcpcia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_ruffian.c b/arch/alpha/kernel/sys_ruffian.c
--- a/arch/alpha/kernel/sys_ruffian.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_ruffian.c	Thu Mar 28 09:52:12 2002
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/core_cia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
--- a/arch/alpha/kernel/sys_rx164.c	Thu Mar 28 09:52:11 2002
+++ b/arch/alpha/kernel/sys_rx164.c	Thu Mar 28 09:52:11 2002
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/core_polaris.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
--- a/arch/alpha/kernel/sys_sable.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_sable.c	Thu Mar 28 09:52:12 2002
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/core_t2.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
--- a/arch/alpha/kernel/sys_sio.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_sio.c	Thu Mar 28 09:52:12 2002
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_apecs.h>
 #include <asm/core_lca.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_sx164.c b/arch/alpha/kernel/sys_sx164.c
--- a/arch/alpha/kernel/sys_sx164.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_sx164.c	Thu Mar 28 09:52:12 2002
@@ -25,6 +25,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_cia.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_takara.c b/arch/alpha/kernel/sys_takara.c
--- a/arch/alpha/kernel/sys_takara.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_takara.c	Thu Mar 28 09:52:12 2002
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/core_cia.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
--- a/arch/alpha/kernel/sys_titan.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_titan.c	Thu Mar 28 09:52:12 2002
@@ -28,6 +28,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_titan.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
--- a/arch/alpha/kernel/sys_wildfire.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/kernel/sys_wildfire.c	Thu Mar 28 09:52:12 2002
@@ -23,6 +23,7 @@
 #include <asm/pgtable.h>
 #include <asm/core_wildfire.h>
 #include <asm/hwrpb.h>
+#include <asm/tlbflush.h>
 
 #include "proto.h"
 #include "irq_impl.h"
diff -Nru a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
--- a/arch/alpha/mm/fault.c	Thu Mar 28 09:52:12 2002
+++ b/arch/alpha/mm/fault.c	Thu Mar 28 09:52:12 2002
@@ -12,7 +12,7 @@
 
 #define __EXTERN_INLINE inline
 #include <asm/mmu_context.h>
-#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 #undef  __EXTERN_INLINE
 
 #include <linux/signal.h>
diff -Nru a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	Thu Mar 28 09:52:12 2002
+++ b/arch/i386/kernel/acpi.c	Thu Mar 28 09:52:12 2002
@@ -43,6 +43,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
+#include <asm/tlbflush.h>
 
 
 #define PREFIX			"ACPI: "
diff -Nru a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	Thu Mar 28 09:52:12 2002
+++ b/arch/i386/kernel/vm86.c	Thu Mar 28 09:52:12 2002
@@ -12,10 +12,12 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/io.h>
+#include <asm/tlbflush.h>
 
 /*
  * Known problems:
diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Thu Mar 28 09:52:12 2002
+++ b/arch/i386/mm/init.c	Thu Mar 28 09:52:12 2002
@@ -37,6 +37,7 @@
 #include <asm/e820.h>
 #include <asm/apic.h>
 #include <asm/tlb.h>
+#include <asm/tlbflush.h>
 
 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
@@ -573,7 +574,8 @@
 }
 
 #if defined(CONFIG_X86_PAE)
-struct kmem_cache_s *pae_pgd_cachep;
+static struct kmem_cache_s *pae_pgd_cachep;
+
 void __init pgtable_cache_init(void)
 {
 	/*
@@ -584,4 +586,96 @@
 	if (!pae_pgd_cachep)
 		panic("init_pae(): Cannot alloc pae_pgd SLAB cache");
 }
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	int i;
+	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
+
+	if (pgd) {
+		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
+			unsigned long pmd = __get_free_page(GFP_KERNEL);
+			if (!pmd)
+				goto out_oom;
+			clear_page(pmd);
+			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
+		}
+		memcpy(pgd + USER_PTRS_PER_PGD,
+			swapper_pg_dir + USER_PTRS_PER_PGD,
+			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+out_oom:
+	for (i--; i >= 0; i--)
+		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
+	kmem_cache_free(pae_pgd_cachep, pgd);
+	return NULL;
+}
+
+void pgd_free(pgd_t *pgd)
+{
+	int i;
+
+	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
+	kmem_cache_free(pae_pgd_cachep, pgd);
+}
+
+#else
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+
+	if (pgd) {
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+		memcpy(pgd + USER_PTRS_PER_PGD,
+			swapper_pg_dir + USER_PTRS_PER_PGD,
+			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+}
+
+void pgd_free(pgd_t *pgd)
+{
+	free_page((unsigned long)pgd);
+}
 #endif /* CONFIG_X86_PAE */
+
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	int count = 0;
+	pte_t *pte;
+   
+   	do {
+		pte = (pte_t *) __get_free_page(GFP_KERNEL);
+		if (pte)
+			clear_page(pte);
+		else {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ);
+		}
+	} while (!pte && (count++ < 10));
+	return pte;
+}
+
+struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	int count = 0;
+	struct page *pte;
+   
+   	do {
+#if CONFIG_HIGHPTE
+		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
+#else
+		pte = alloc_pages(GFP_KERNEL, 0);
+#endif
+		if (pte)
+			clear_highpage(pte);
+		else {
+			current->state = TASK_UNINTERRUPTIBLE;
+			schedule_timeout(HZ);
+		}
+	} while (!pte && (count++ < 10));
+	return pte;
+}
diff -Nru a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
--- a/arch/i386/mm/ioremap.c	Thu Mar 28 09:52:12 2002
+++ b/arch/i386/mm/ioremap.c	Thu Mar 28 09:52:12 2002
@@ -11,6 +11,9 @@
 #include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
 
 static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
 	unsigned long phys_addr, unsigned long flags)
diff -Nru a/fs/binfmt_aout.c b/fs/binfmt_aout.c
--- a/fs/binfmt_aout.c	Thu Mar 28 09:52:12 2002
+++ b/fs/binfmt_aout.c	Thu Mar 28 09:52:12 2002
@@ -28,6 +28,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
 
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout_library(struct file*);
diff -Nru a/include/asm-alpha/cacheflush.h b/include/asm-alpha/cacheflush.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-alpha/cacheflush.h	Thu Mar 28 09:52:12 2002
@@ -0,0 +1,64 @@
+#ifndef _ALPHA_CACHEFLUSH_H
+#define _ALPHA_CACHEFLUSH_H
+
+#include <linux/config.h>
+#include <linux/mm.h>
+
+/* Caches aren't brain-dead on the Alpha. */
+#define flush_cache_all()			do { } while (0)
+#define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_range(vma, start, end)	do { } while (0)
+#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_page_to_ram(page)			do { } while (0)
+#define flush_dcache_page(page)			do { } while (0)
+
+/* Note that the following two definitions are _highly_ dependent
+   on the contexts in which they are used in the kernel.  I personally
+   think it is criminal how loosely defined these macros are.  */
+
+/* We need to flush the kernel's icache after loading modules.  The
+   only other use of this macro is in load_aout_interp which is not
+   used on Alpha. 
+
+   Note that this definition should *not* be used for userspace
+   icache flushing.  While functional, it is _way_ overkill.  The
+   icache is tagged with ASNs and it suffices to allocate a new ASN
+   for the process.  */
+#ifndef CONFIG_SMP
+#define flush_icache_range(start, end)		imb()
+#else
+#define flush_icache_range(start, end)		smp_imb()
+extern void smp_imb(void);
+#endif
+
+/* We need to flush the userspace icache after setting breakpoints in
+   ptrace.
+
+   Instead of indiscriminately using imb, take advantage of the fact
+   that icache entries are tagged with the ASN and load a new mm context.  */
+/* ??? Ought to use this in arch/alpha/kernel/signal.c too.  */
+
+#ifndef CONFIG_SMP
+extern void __load_new_mm_context(struct mm_struct *);
+static inline void
+flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			unsigned long addr, int len)
+{
+	if (vma->vm_flags & VM_EXEC) {
+		struct mm_struct *mm = vma->vm_mm;
+		if (current->active_mm == mm)
+			__load_new_mm_context(mm);
+		else
+			mm->context[smp_processor_id()] = 0;
+	}
+}
+#else
+extern void flush_icache_user_range(struct vm_area_struct *vma,
+		struct page *page, unsigned long addr, int len);
+#endif
+
+/* This is used only in do_no_page and do_swap_page.  */
+#define flush_icache_page(vma, page) \
+  flush_icache_user_range((vma), (page), 0, 0)
+
+#endif /* _ALPHA_CACHEFLUSH_H */
diff -Nru a/include/asm-alpha/pgalloc.h b/include/asm-alpha/pgalloc.h
--- a/include/asm-alpha/pgalloc.h	Thu Mar 28 09:52:11 2002
+++ b/include/asm-alpha/pgalloc.h	Thu Mar 28 09:52:11 2002
@@ -3,228 +3,6 @@
 
 #include <linux/config.h>
 
-#ifndef __EXTERN_INLINE
-#define __EXTERN_INLINE extern inline
-#define __MMU_EXTERN_INLINE
-#endif
-
-extern void __load_new_mm_context(struct mm_struct *);
-
-
-/* Caches aren't brain-dead on the Alpha. */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
-#define flush_dcache_page(page)			do { } while (0)
-
-/* Note that the following two definitions are _highly_ dependent
-   on the contexts in which they are used in the kernel.  I personally
-   think it is criminal how loosely defined these macros are.  */
-
-/* We need to flush the kernel's icache after loading modules.  The
-   only other use of this macro is in load_aout_interp which is not
-   used on Alpha. 
-
-   Note that this definition should *not* be used for userspace
-   icache flushing.  While functional, it is _way_ overkill.  The
-   icache is tagged with ASNs and it suffices to allocate a new ASN
-   for the process.  */
-#ifndef CONFIG_SMP
-#define flush_icache_range(start, end)		imb()
-#else
-#define flush_icache_range(start, end)		smp_imb()
-extern void smp_imb(void);
-#endif
-
-
-/*
- * Use a few helper functions to hide the ugly broken ASN
- * numbers on early Alphas (ev4 and ev45)
- */
-
-__EXTERN_INLINE void
-ev4_flush_tlb_current(struct mm_struct *mm)
-{
-	__load_new_mm_context(mm);
-	tbiap();
-}
-
-__EXTERN_INLINE void
-ev5_flush_tlb_current(struct mm_struct *mm)
-{
-	__load_new_mm_context(mm);
-}
-
-static inline void
-flush_tlb_other(struct mm_struct *mm)
-{
-	long * mmc = &mm->context[smp_processor_id()];
-	/*
-	 * Check it's not zero first to avoid cacheline ping pong when
-	 * possible.
-	 */
-	if (*mmc)
-		*mmc = 0;
-}
-
-/* We need to flush the userspace icache after setting breakpoints in
-   ptrace.
-
-   Instead of indiscriminately using imb, take advantage of the fact
-   that icache entries are tagged with the ASN and load a new mm context.  */
-/* ??? Ought to use this in arch/alpha/kernel/signal.c too.  */
-
-#ifndef CONFIG_SMP
-static inline void
-flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
-			unsigned long addr, int len)
-{
-	if (vma->vm_flags & VM_EXEC) {
-		struct mm_struct *mm = vma->vm_mm;
-		if (current->active_mm == mm)
-			__load_new_mm_context(mm);
-		else
-			mm->context[smp_processor_id()] = 0;
-	}
-}
-#else
-extern void flush_icache_user_range(struct vm_area_struct *vma,
-		struct page *page, unsigned long addr, int len);
-#endif
-
-/* this is used only in do_no_page and do_swap_page */
-#define flush_icache_page(vma, page)	flush_icache_user_range((vma), (page), 0, 0)
-
-/*
- * Flush just one page in the current TLB set.
- * We need to be very careful about the icache here, there
- * is no way to invalidate a specific icache page..
- */
-
-__EXTERN_INLINE void
-ev4_flush_tlb_current_page(struct mm_struct * mm,
-			   struct vm_area_struct *vma,
-			   unsigned long addr)
-{
-	int tbi_flag = 2;
-	if (vma->vm_flags & VM_EXEC) {
-		__load_new_mm_context(mm);
-		tbi_flag = 3;
-	}
-	tbi(tbi_flag, addr);
-}
-
-__EXTERN_INLINE void
-ev5_flush_tlb_current_page(struct mm_struct * mm,
-			   struct vm_area_struct *vma,
-			   unsigned long addr)
-{
-	if (vma->vm_flags & VM_EXEC)
-		__load_new_mm_context(mm);
-	else
-		tbi(2, addr);
-}
-
-
-#ifdef CONFIG_ALPHA_GENERIC
-# define flush_tlb_current		alpha_mv.mv_flush_tlb_current
-# define flush_tlb_current_page		alpha_mv.mv_flush_tlb_current_page
-#else
-# ifdef CONFIG_ALPHA_EV4
-#  define flush_tlb_current		ev4_flush_tlb_current
-#  define flush_tlb_current_page	ev4_flush_tlb_current_page
-# else
-#  define flush_tlb_current		ev5_flush_tlb_current
-#  define flush_tlb_current_page	ev5_flush_tlb_current_page
-# endif
-#endif
-
-#ifdef __MMU_EXTERN_INLINE
-#undef __EXTERN_INLINE
-#undef __MMU_EXTERN_INLINE
-#endif
-
-/*
- * Flush current user mapping.
- */
-static inline void flush_tlb(void)
-{
-	flush_tlb_current(current->active_mm);
-}
-
-/*
- * Flush a specified range of user mapping page tables
- * from TLB.
- * Although Alpha uses VPTE caches, this can be a nop, as Alpha does
- * not have finegrained tlb flushing, so it will flush VPTE stuff
- * during next flush_tlb_range.
- */
-static inline void flush_tlb_pgtables(struct mm_struct *mm,
-	unsigned long start, unsigned long end)
-{
-}
-
-#ifndef CONFIG_SMP
-/*
- * Flush everything (kernel mapping may also have
- * changed due to vmalloc/vfree)
- */
-static inline void flush_tlb_all(void)
-{
-	tbia();
-}
-
-/*
- * Flush a specified user mapping
- */
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	if (mm == current->active_mm)
-		flush_tlb_current(mm);
-	else
-		flush_tlb_other(mm);
-}
-
-/*
- * Page-granular tlb flush.
- *
- * do a tbisd (type = 2) normally, and a tbis (type = 3)
- * if it is an executable mapping.  We want to avoid the
- * itlb flush, because that potentially also does a
- * icache flush.
- */
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-	unsigned long addr)
-{
-	struct mm_struct * mm = vma->vm_mm;
-
-	if (mm == current->active_mm)
-		flush_tlb_current_page(mm, vma, addr);
-	else
-		flush_tlb_other(mm);
-}
-
-/*
- * Flush a specified range of user mapping:  on the
- * Alpha we flush the whole user tlb.
- */
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-	unsigned long start, unsigned long end)
-{
-	flush_tlb_mm(vma->vm_mm);
-}
-
-#else /* CONFIG_SMP */
-
-extern void flush_tlb_all(void);
-extern void flush_tlb_mm(struct mm_struct *);
-extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
-extern void flush_tlb_range(struct vm_area_struct *, unsigned long, unsigned long);
-
-#endif /* CONFIG_SMP */
-
 /*      
  * Allocate and free page tables. The xxx_kernel() versions are
  * used to allocate a kernel page table - this turns on ASN bits
@@ -291,5 +69,7 @@
 {
 	__free_page(page);
 }
+
+#define check_pgt_cache()	do { } while (0)
 
 #endif /* _ALPHA_PGALLOC_H */
diff -Nru a/include/asm-alpha/tlbflush.h b/include/asm-alpha/tlbflush.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-alpha/tlbflush.h	Thu Mar 28 09:52:12 2002
@@ -0,0 +1,155 @@
+#ifndef _ALPHA_TLBFLUSH_H
+#define _ALPHA_TLBFLUSH_H
+
+#include <linux/config.h>
+#include <linux/mm.h>
+
+#ifndef __EXTERN_INLINE
+#define __EXTERN_INLINE extern inline
+#define __MMU_EXTERN_INLINE
+#endif
+
+extern void __load_new_mm_context(struct mm_struct *);
+
+
+/* Use a few helper functions to hide the ugly broken ASN
+   numbers on early Alphas (ev4 and ev45).  */
+
+__EXTERN_INLINE void
+ev4_flush_tlb_current(struct mm_struct *mm)
+{
+	__load_new_mm_context(mm);
+	tbiap();
+}
+
+__EXTERN_INLINE void
+ev5_flush_tlb_current(struct mm_struct *mm)
+{
+	__load_new_mm_context(mm);
+}
+
+/* Flush just one page in the current TLB set.  We need to be very
+   careful about the icache here, there is no way to invalidate a
+   specific icache page.  */
+
+__EXTERN_INLINE void
+ev4_flush_tlb_current_page(struct mm_struct * mm,
+			   struct vm_area_struct *vma,
+			   unsigned long addr)
+{
+	int tbi_flag = 2;
+	if (vma->vm_flags & VM_EXEC) {
+		__load_new_mm_context(mm);
+		tbi_flag = 3;
+	}
+	tbi(tbi_flag, addr);
+}
+
+__EXTERN_INLINE void
+ev5_flush_tlb_current_page(struct mm_struct * mm,
+			   struct vm_area_struct *vma,
+			   unsigned long addr)
+{
+	if (vma->vm_flags & VM_EXEC)
+		__load_new_mm_context(mm);
+	else
+		tbi(2, addr);
+}
+
+
+#ifdef CONFIG_ALPHA_GENERIC
+# define flush_tlb_current		alpha_mv.mv_flush_tlb_current
+# define flush_tlb_current_page		alpha_mv.mv_flush_tlb_current_page
+#else
+# ifdef CONFIG_ALPHA_EV4
+#  define flush_tlb_current		ev4_flush_tlb_current
+#  define flush_tlb_current_page	ev4_flush_tlb_current_page
+# else
+#  define flush_tlb_current		ev5_flush_tlb_current
+#  define flush_tlb_current_page	ev5_flush_tlb_current_page
+# endif
+#endif
+
+#ifdef __MMU_EXTERN_INLINE
+#undef __EXTERN_INLINE
+#undef __MMU_EXTERN_INLINE
+#endif
+
+/* Flush current user mapping.  */
+static inline void
+flush_tlb(void)
+{
+	flush_tlb_current(current->active_mm);
+}
+
+/* Flush someone else's user mapping.  */
+static inline void
+flush_tlb_other(struct mm_struct *mm)
+{
+	long *mmc = &mm->context[smp_processor_id()];
+	/* Check it's not zero first to avoid cacheline ping pong
+	   when possible.  */
+	if (*mmc) *mmc = 0;
+}
+
+/* Flush a specified range of user mapping page tables from TLB.
+   Although Alpha uses VPTE caches, this can be a nop, as Alpha does
+   not have finegrained tlb flushing, so it will flush VPTE stuff
+   during next flush_tlb_range.  */
+
+static inline void
+flush_tlb_pgtables(struct mm_struct *mm, unsigned long start,
+		   unsigned long end)
+{
+}
+
+#ifndef CONFIG_SMP
+/* Flush everything (kernel mapping may also have changed
+   due to vmalloc/vfree).  */
+static inline void flush_tlb_all(void)
+{
+	tbia();
+}
+
+/* Flush a specified user mapping.  */
+static inline void
+flush_tlb_mm(struct mm_struct *mm)
+{
+	if (mm == current->active_mm)
+		flush_tlb_current(mm);
+	else
+		flush_tlb_other(mm);
+}
+
+/* Page-granular tlb flush.  */
+static inline void
+flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm == current->active_mm)
+		flush_tlb_current_page(mm, vma, addr);
+	else
+		flush_tlb_other(mm);
+}
+
+/* Flush a specified range of user mapping.  On the Alpha we flush
+   the whole user tlb.  */
+static inline void
+flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end)
+{
+	flush_tlb_mm(vma->vm_mm);
+}
+
+#else /* CONFIG_SMP */
+
+extern void flush_tlb_all(void);
+extern void flush_tlb_mm(struct mm_struct *);
+extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+extern void flush_tlb_range(struct vm_area_struct *, unsigned long,
+			    unsigned long);
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ALPHA_TLBFLUSH_H */
diff -Nru a/include/asm-i386/cacheflush.h b/include/asm-i386/cacheflush.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/cacheflush.h	Thu Mar 28 09:52:12 2002
@@ -0,0 +1,18 @@
+#ifndef _I386_CACHEFLUSH_H
+#define _I386_CACHEFLUSH_H
+
+/* Keep includes the same across arches.  */
+#include <linux/mm.h>
+
+/* Caches aren't brain-dead on the intel. */
+#define flush_cache_all()			do { } while (0)
+#define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_range(vma, start, end)	do { } while (0)
+#define flush_cache_page(vma, vmaddr)		do { } while (0)
+#define flush_page_to_ram(page)			do { } while (0)
+#define flush_dcache_page(page)			do { } while (0)
+#define flush_icache_range(start, end)		do { } while (0)
+#define flush_icache_page(vma,pg)		do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
+
+#endif /* _I386_CACHEFLUSH_H */
diff -Nru a/include/asm-i386/pgalloc.h b/include/asm-i386/pgalloc.h
--- a/include/asm-i386/pgalloc.h	Thu Mar 28 09:52:12 2002
+++ b/include/asm-i386/pgalloc.h	Thu Mar 28 09:52:12 2002
@@ -5,7 +5,6 @@
 #include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
-#include <linux/highmem.h>
 
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
@@ -20,109 +19,11 @@
  * Allocate and free page tables.
  */
 
-#if defined (CONFIG_X86_PAE)
-/*
- * We can't include <linux/slab.h> here, thus these uglinesses.
- */
-struct kmem_cache_s;
-
-extern struct kmem_cache_s *pae_pgd_cachep;
-extern void *kmem_cache_alloc(struct kmem_cache_s *, int);
-extern void kmem_cache_free(struct kmem_cache_s *, void *);
-
-
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	int i;
-	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
-
-	if (pgd) {
-		for (i = 0; i < USER_PTRS_PER_PGD; i++) {
-			unsigned long pmd = __get_free_page(GFP_KERNEL);
-			if (!pmd)
-				goto out_oom;
-			clear_page(pmd);
-			set_pgd(pgd + i, __pgd(1 + __pa(pmd)));
-		}
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-	return pgd;
-out_oom:
-	for (i--; i >= 0; i--)
-		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, pgd);
-	return NULL;
-}
-
-#else
+extern pgd_t *pgd_alloc(struct mm_struct *);
+extern void pgd_free(pgd_t *pgd);
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-	return pgd;
-}
-
-#endif /* CONFIG_X86_PAE */
-
-static inline void pgd_free(pgd_t *pgd)
-{
-#if defined(CONFIG_X86_PAE)
-	int i;
-
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
-		free_page((unsigned long)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, pgd);
-#else
-	free_page((unsigned long)pgd);
-#endif
-}
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	int count = 0;
-	pte_t *pte;
-   
-   	do {
-		pte = (pte_t *) __get_free_page(GFP_KERNEL);
-		if (pte)
-			clear_page(pte);
-		else {
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
-	} while (!pte && (count++ < 10));
-	return pte;
-}
-
-static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	int count = 0;
-	struct page *pte;
-   
-   	do {
-#if CONFIG_HIGHPTE
-		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
-#else
-		pte = alloc_pages(GFP_KERNEL, 0);
-#endif
-		if (pte)
-			clear_highpage(pte);
-		else {
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
-	} while (!pte && (count++ < 10));
-	return pte;
-}
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
+extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
 
 static inline void pte_free_kernel(pte_t *pte)
 {
@@ -143,85 +44,6 @@
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
-
-/*
- * TLB flushing:
- *
- *  - flush_tlb() flushes the current mm struct TLBs
- *  - flush_tlb_all() flushes all processes TLBs
- *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
- *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
- *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
- *
- * ..but the i386 has somewhat limited tlb flushing capabilities,
- * and page-granular flushes are available only on i486 and up.
- */
-
-#ifndef CONFIG_SMP
-
-#define flush_tlb() __flush_tlb()
-#define flush_tlb_all() __flush_tlb_all()
-#define local_flush_tlb() __flush_tlb()
-
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	if (mm == current->active_mm)
-		__flush_tlb();
-}
-
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-	unsigned long addr)
-{
-	if (vma->vm_mm == current->active_mm)
-		__flush_tlb_one(addr);
-}
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-	unsigned long start, unsigned long end)
-{
-	if (vma->vm_mm == current->active_mm)
-		__flush_tlb();
-}
-
-#else
-
-#include <asm/smp.h>
-
-#define local_flush_tlb() \
-	__flush_tlb()
-
-extern void flush_tlb_all(void);
-extern void flush_tlb_current_task(void);
-extern void flush_tlb_mm(struct mm_struct *);
-extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
-
-#define flush_tlb()	flush_tlb_current_task()
-
-static inline void flush_tlb_range(struct vm_area_struct * vma, unsigned long start, unsigned long end)
-{
-	flush_tlb_mm(vma->vm_mm);
-}
-
-#define TLBSTATE_OK	1
-#define TLBSTATE_LAZY	2
-
-struct tlb_state
-{
-	struct mm_struct *active_mm;
-	int state;
-	char __cacheline_padding[24];
-};
-extern struct tlb_state cpu_tlbstate[NR_CPUS];
-
-
-#endif
-
-static inline void flush_tlb_pgtables(struct mm_struct *mm,
-				      unsigned long start, unsigned long end)
-{
-	/* i386 does not keep any page table caches in TLB */
-}
 
 #define check_pgt_cache()	do { } while (0)
 
diff -Nru a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Thu Mar 28 09:52:12 2002
+++ b/include/asm-i386/pgtable.h	Thu Mar 28 09:52:12 2002
@@ -24,71 +24,6 @@
 extern pgd_t swapper_pg_dir[1024];
 extern void paging_init(void);
 
-/* Caches aren't brain-dead on the intel. */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_icache_range(start, end)		do { } while (0)
-#define flush_icache_page(vma,pg)		do { } while (0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-
-#define __flush_tlb()							\
-	do {								\
-		unsigned int tmpreg;					\
-									\
-		__asm__ __volatile__(					\
-			"movl %%cr3, %0;  # flush TLB \n"		\
-			"movl %0, %%cr3;              \n"		\
-			: "=r" (tmpreg)					\
-			:: "memory");					\
-	} while (0)
-
-/*
- * Global pages have to be flushed a bit differently. Not a real
- * performance problem because this does not happen often.
- */
-#define __flush_tlb_global()						\
-	do {								\
-		unsigned int tmpreg;					\
-									\
-		__asm__ __volatile__(					\
-			"movl %1, %%cr4;  # turn off PGE     \n"	\
-			"movl %%cr3, %0;  # flush TLB        \n"	\
-			"movl %0, %%cr3;                     \n"	\
-			"movl %2, %%cr4;  # turn PGE back on \n"	\
-			: "=&r" (tmpreg)				\
-			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
-			  "r" (mmu_cr4_features)			\
-			: "memory");					\
-	} while (0)
-
-extern unsigned long pgkern_mask;
-
-/*
- * Do not check the PGE bit unnecesserily if this is a PPro+ kernel.
- */
-#ifdef CONFIG_X86_PGE
-# define __flush_tlb_all() __flush_tlb_global()
-#else
-# define __flush_tlb_all()						\
-	do {								\
-		if (cpu_has_pge)					\
-			__flush_tlb_global();				\
-		else							\
-			__flush_tlb();					\
-	} while (0)
-#endif
-
-#ifndef CONFIG_X86_INVLPG
-#define __flush_tlb_one(addr) __flush_tlb()
-#else
-#define __flush_tlb_one(addr) \
-__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
-#endif
-
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff -Nru a/include/asm-i386/tlbflush.h b/include/asm-i386/tlbflush.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/tlbflush.h	Thu Mar 28 09:52:12 2002
@@ -0,0 +1,141 @@
+#ifndef _I386_TLBFLUSH_H
+#define _I386_TLBFLUSH_H
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <asm/processor.h>
+
+#define __flush_tlb()							\
+	do {								\
+		unsigned int tmpreg;					\
+									\
+		__asm__ __volatile__(					\
+			"movl %%cr3, %0;  # flush TLB \n"		\
+			"movl %0, %%cr3;              \n"		\
+			: "=r" (tmpreg)					\
+			:: "memory");					\
+	} while (0)
+
+/*
+ * Global pages have to be flushed a bit differently. Not a real
+ * performance problem because this does not happen often.
+ */
+#define __flush_tlb_global()						\
+	do {								\
+		unsigned int tmpreg;					\
+									\
+		__asm__ __volatile__(					\
+			"movl %1, %%cr4;  # turn off PGE     \n"	\
+			"movl %%cr3, %0;  # flush TLB        \n"	\
+			"movl %0, %%cr3;                     \n"	\
+			"movl %2, %%cr4;  # turn PGE back on \n"	\
+			: "=&r" (tmpreg)				\
+			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
+			  "r" (mmu_cr4_features)			\
+			: "memory");					\
+	} while (0)
+
+extern unsigned long pgkern_mask;
+
+/*
+ * Do not check the PGE bit unnecesserily if this is a PPro+ kernel.
+ */
+#ifdef CONFIG_X86_PGE
+# define __flush_tlb_all() __flush_tlb_global()
+#else
+# define __flush_tlb_all()						\
+	do {								\
+		if (cpu_has_pge)					\
+			__flush_tlb_global();				\
+		else							\
+			__flush_tlb();					\
+	} while (0)
+#endif
+
+#ifndef CONFIG_X86_INVLPG
+#define __flush_tlb_one(addr) __flush_tlb()
+#else
+#define __flush_tlb_one(addr) \
+__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+#endif
+
+/*
+ * TLB flushing:
+ *
+ *  - flush_tlb() flushes the current mm struct TLBs
+ *  - flush_tlb_all() flushes all processes TLBs
+ *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
+ *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
+ *
+ * ..but the i386 has somewhat limited tlb flushing capabilities,
+ * and page-granular flushes are available only on i486 and up.
+ */
+
+#ifndef CONFIG_SMP
+
+#define flush_tlb() __flush_tlb()
+#define flush_tlb_all() __flush_tlb_all()
+#define local_flush_tlb() __flush_tlb()
+
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	if (mm == current->active_mm)
+		__flush_tlb();
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+	unsigned long addr)
+{
+	if (vma->vm_mm == current->active_mm)
+		__flush_tlb_one(addr);
+}
+
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+	unsigned long start, unsigned long end)
+{
+	if (vma->vm_mm == current->active_mm)
+		__flush_tlb();
+}
+
+#else
+
+#include <asm/smp.h>
+
+#define local_flush_tlb() \
+	__flush_tlb()
+
+extern void flush_tlb_all(void);
+extern void flush_tlb_current_task(void);
+extern void flush_tlb_mm(struct mm_struct *);
+extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+
+#define flush_tlb()	flush_tlb_current_task()
+
+static inline void flush_tlb_range(struct vm_area_struct * vma, unsigned long start, unsigned long end)
+{
+	flush_tlb_mm(vma->vm_mm);
+}
+
+#define TLBSTATE_OK	1
+#define TLBSTATE_LAZY	2
+
+struct tlb_state
+{
+	struct mm_struct *active_mm;
+	int state;
+	char __cacheline_padding[24];
+};
+extern struct tlb_state cpu_tlbstate[NR_CPUS];
+
+
+#endif
+
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
+				      unsigned long start, unsigned long end)
+{
+	/* i386 does not keep any page table caches in TLB */
+}
+
+#endif /* _I386_TLBFLUSH_H */
diff -Nru a/include/linux/highmem.h b/include/linux/highmem.h
--- a/include/linux/highmem.h	Thu Mar 28 09:52:12 2002
+++ b/include/linux/highmem.h	Thu Mar 28 09:52:12 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
+#include <asm/cacheflush.h>
 
 #ifdef CONFIG_HIGHMEM
 
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Mar 28 09:52:12 2002
+++ b/kernel/fork.c	Thu Mar 28 09:52:12 2002
@@ -29,6 +29,8 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 static kmem_cache_t *task_struct_cachep;
 
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Thu Mar 28 09:52:12 2002
+++ b/kernel/module.c	Thu Mar 28 09:52:12 2002
@@ -11,6 +11,7 @@
 #include <linux/kmod.h>
 #include <linux/seq_file.h>
 #include <linux/fs.h>
+#include <asm/cacheflush.h>
 
 /*
  * Originally by Anonymous (as far as I know...)
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Thu Mar 28 09:52:12 2002
+++ b/mm/memory.c	Thu Mar 28 09:52:12 2002
@@ -48,6 +48,7 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
+#include <asm/tlbflush.h>
 
 unsigned long max_mapnr;
 unsigned long num_physpages;
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Thu Mar 28 09:52:12 2002
+++ b/mm/mmap.c	Thu Mar 28 09:52:12 2002
@@ -17,6 +17,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 
 /*
  * WARNING: the debugging will use recursive algorithms so never enable this
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	Thu Mar 28 09:52:12 2002
+++ b/mm/mprotect.c	Thu Mar 28 09:52:12 2002
@@ -9,11 +9,13 @@
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/fs.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <linux/highmem.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 static inline void change_pte_range(pmd_t * pmd, unsigned long address,
 	unsigned long size, pgprot_t newprot)
diff -Nru a/mm/mremap.c b/mm/mremap.c
--- a/mm/mremap.c	Thu Mar 28 09:52:12 2002
+++ b/mm/mremap.c	Thu Mar 28 09:52:12 2002
@@ -11,9 +11,12 @@
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/fs.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 extern int vm_enough_memory(long pages);
 
diff -Nru a/mm/msync.c b/mm/msync.c
--- a/mm/msync.c	Thu Mar 28 09:52:12 2002
+++ b/mm/msync.c	Thu Mar 28 09:52:12 2002
@@ -14,6 +14,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 
 /*
  * Called with mm->page_table_lock held to protect against other
diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c	Thu Mar 28 09:52:12 2002
+++ b/mm/vmalloc.c	Thu Mar 28 09:52:12 2002
@@ -15,6 +15,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
 struct vm_struct * vmlist;
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Mar 28 09:52:12 2002
+++ b/mm/vmscan.c	Thu Mar 28 09:52:12 2002
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 
 /*
  * The "priority" of VM scanning is how much of the queues we
