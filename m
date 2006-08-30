Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWH3WRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWH3WRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWH3WRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:17:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:48325 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932170AbWH3WQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:13 -0400
Subject: [RFC][PATCH 9/9] convert the "easy" architectures to generic PAGE_SIZE
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:11 -0700
References: <20060830221604.E7320C0F@localhost.localdomain>
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
Message-Id: <20060830221611.98D26E38@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---

 threadalloc-dave/include/asm-xtensa/page.h    |   11 +----------
 threadalloc-dave/include/asm-x86_64/page.h    |   12 +-----------
 threadalloc-dave/include/asm-v850/page.h      |   12 +-----------
 threadalloc-dave/include/asm-um/page.h        |    9 +--------
 threadalloc-dave/include/asm-sparc/page.h     |   16 +---------------
 threadalloc-dave/include/asm-sh64/page.h      |   12 +-----------
 threadalloc-dave/include/asm-sh/page.h        |    8 +-------
 threadalloc-dave/include/asm-s390/page.h      |    8 +-------
 threadalloc-dave/include/asm-m68knommu/page.h |   10 +---------
 threadalloc-dave/include/asm-m68k/page.h      |   20 +-------------------
 threadalloc-dave/include/asm-m32r/page.h      |    3 ---
 threadalloc-dave/include/asm-i386/page.h      |    8 +-------
 threadalloc-dave/include/asm-h8300/page.h     |   11 +----------
 threadalloc-dave/include/asm-generic/page.h   |    6 ++----
 threadalloc-dave/include/asm-frv/page.h       |    4 +---
 threadalloc-dave/include/asm-frv/mem-layout.h |   15 ++-------------
 threadalloc-dave/include/asm-cris/page.h      |   13 +------------
 threadalloc-dave/include/asm-arm26/page.h     |    7 +------
 threadalloc-dave/include/asm-arm/page.h       |    9 +--------
 threadalloc-dave/include/asm-arm/page-nommu.h |    3 ---
 threadalloc-dave/include/asm-alpha/page.h     |    9 +--------
 threadalloc-dave/arch/ia64/Kconfig            |    3 ---
 threadalloc-dave/arch/mips/Kconfig            |    3 ---
 threadalloc-dave/arch/parisc/Kconfig          |    3 ---
 threadalloc-dave/arch/powerpc/Kconfig         |    3 ---
 threadalloc-dave/arch/sparc64/Kconfig         |    3 ---
 threadalloc-dave/mm/Kconfig                   |   11 ++++++-----
 27 files changed, 27 insertions(+), 205 deletions(-)

diff -puN include/asm-xtensa/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-xtensa/page.h
--- threadalloc/include/asm-xtensa/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-xtensa/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -14,16 +14,7 @@
 #ifdef __KERNEL__
 
 #include <asm/processor.h>
-
-/*
- * PAGE_SHIFT determines the page size
- * PAGE_ALIGN(x) aligns the pointer to the (next) page boundary
- */
-
-#define PAGE_SHIFT		XCHAL_MMU_MIN_PTE_PAGE_SIZE
-#define PAGE_SIZE		(1 << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE - 1) & PAGE_MASK)
+#include <asm-generic/page.h>
 
 #define DCACHE_WAY_SIZE		(XCHAL_DCACHE_SIZE / XCHAL_DCACHE_WAYS)
 #define PAGE_OFFSET		XCHAL_KSEG_CACHED_VADDR
diff -puN include/asm-x86_64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-x86_64/page.h
--- threadalloc/include/asm-x86_64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-x86_64/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,15 +1,8 @@
 #ifndef _X86_64_PAGE_H
 #define _X86_64_PAGE_H
 
+#include <asm-generic/page.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	(0x1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PHYSICAL_PAGE_MASK	(~(PAGE_SIZE-1) & __PHYSICAL_MASK)
 
 #define THREAD_ORDER 1 
@@ -88,9 +81,6 @@ typedef struct { unsigned long pgprot; }
 #define __PAGE_OFFSET           0xffff810000000000
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /* See Documentation/x86_64/mm.txt for a description of the memory map. */
 #define __PHYSICAL_MASK_SHIFT	46
 #define __PHYSICAL_MASK		((1UL << __PHYSICAL_MASK_SHIFT) - 1)
diff -puN include/asm-v850/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-v850/page.h
--- threadalloc/include/asm-v850/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-v850/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -15,12 +15,7 @@
 #define __V850_PAGE_H__
 
 #include <asm/machdep.h>
-
-
-#define PAGE_SHIFT	12
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#define PAGE_MASK       (~(PAGE_SIZE-1))
-
+#include <asm-generic/page.h>
 
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. For archs with
@@ -93,11 +88,6 @@ typedef unsigned long pgprot_t;
 
 #endif /* !__ASSEMBLY__ */
 
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
-
 /* No current v850 processor has virtual memory.  */
 #define __virt_to_phys(addr)	(addr)
 #define __phys_to_virt(addr)	(addr)
diff -puN include/asm-um/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-um/page.h
--- threadalloc/include/asm-um/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-um/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -10,11 +10,7 @@
 struct page;
 
 #include <asm/vm-flags.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page.h>
 
 /*
  * These are used to make use of C type-checking..
@@ -85,9 +81,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long uml_physmem;
 
 #define PAGE_OFFSET (uml_physmem)
diff -puN include/asm-sparc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sparc/page.h
--- threadalloc/include/asm-sparc/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-sparc/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -8,18 +8,7 @@
 #ifndef _SPARC_PAGE_H
 #define _SPARC_PAGE_H
 
-#ifdef CONFIG_SUN4
-#define PAGE_SHIFT   13
-#else
-#define PAGE_SHIFT   12
-#endif
-#ifndef __ASSEMBLY__
-/* I have my suspicions... -DaveM */
-#define PAGE_SIZE    (1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE    (1 << PAGE_SHIFT)
-#endif
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 
@@ -137,9 +126,6 @@ BTFIXUPDEF_SETHI(sparc_unmapped_base)
 
 #endif /* !(__ASSEMBLY__) */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)  (((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #define PAGE_OFFSET	0xf0000000
 #ifndef __ASSEMBLY__
 extern unsigned long phys_base;
diff -puN include/asm-sh64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sh64/page.h
--- threadalloc/include/asm-sh64/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-sh64/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -17,15 +17,8 @@
  *
  */
 
+#include <asm-generic/page.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	4096
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
@@ -85,9 +78,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * Kconfig defined.
  */
diff -puN include/asm-sh/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-sh/page.h
--- threadalloc/include/asm-sh/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-sh/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -13,11 +13,8 @@
    [ P4 control   ]		0xE0000000
  */
 
+#include <asm-generic/page.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
@@ -79,9 +76,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * IF YOU CHANGE THIS, PLEASE ALSO CHANGE
  *
diff -puN include/asm-s390/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-s390/page.h
--- threadalloc/include/asm-s390/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-s390/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -10,11 +10,8 @@
 #define _S390_PAGE_H
 
 #include <asm/types.h>
+#include <asm-generic/page.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT      12
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#define PAGE_MASK       (~(PAGE_SIZE-1))
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
@@ -174,9 +171,6 @@ page_get_storage_key(unsigned long addr)
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)        (((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #define __PAGE_OFFSET           0x0UL
 #define PAGE_OFFSET             0x0UL
 #define __pa(x)                 (unsigned long)(x)
diff -puN include/asm-m68knommu/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-m68knommu/page.h
--- threadalloc/include/asm-m68knommu/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-m68knommu/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,12 +1,7 @@
 #ifndef _M68KNOMMU_PAGE_H
 #define _M68KNOMMU_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT	(12)
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 
@@ -44,9 +39,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
diff -puN include/asm-m68k/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-m68k/page.h
--- threadalloc/include/asm-m68k/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-m68k/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,22 +1,7 @@
 #ifndef _M68K_PAGE_H
 #define _M68K_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-#ifndef CONFIG_SUN3
-#define PAGE_SHIFT	(12)
-#else
-#define PAGE_SHIFT	(13)
-#endif
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	(1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
-#ifdef __KERNEL__
-
+#include <asm-generic/page.h>
 #include <asm/setup.h>
 
 #if PAGE_SHIFT < 13
@@ -103,9 +88,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/page_offset.h>
diff -puN include/asm-m32r/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-m32r/page.h
--- threadalloc/include/asm-m32r/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-m32r/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -41,9 +41,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 /*
  * This handles the memory map.. We could make this a config
  * option, but too many people screw it up, and too few need
diff -puN include/asm-i386/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-i386/page.h
--- threadalloc/include/asm-i386/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-i386/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,10 +1,7 @@
 #ifndef _I386_PAGE_H
 #define _I386_PAGE_H
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page.h>
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
 #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
@@ -78,9 +75,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 /*
  * This handles the memory map.. We could make this a config
  * option, but too many people screw it up, and too few need
diff -puN include/asm-h8300/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-h8300/page.h
--- threadalloc/include/asm-h8300/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-h8300/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,16 +1,10 @@
 #ifndef _H8300_PAGE_H
 #define _H8300_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT	(12)
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #ifdef __KERNEL__
 
 #include <asm/setup.h>
+#include <asm-generic/page.h>
 
 #ifndef __ASSEMBLY__
  
@@ -44,9 +38,6 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
diff -puN include/asm-generic/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-generic/page.h
--- threadalloc/include/asm-generic/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:01.000000000 -0700
+++ threadalloc-dave/include/asm-generic/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -13,8 +13,6 @@
 #define ASM_CONST(x) __ASM_CONST(x)
 #endif
 
-#ifdef CONFIG_ARCH_GENERIC_PAGE_SIZE
-
 #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
 #define PAGE_SIZE       (ASM_CONST(1) << PAGE_SHIFT)
 
@@ -28,8 +26,7 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)        ALIGN(addr, PAGE_SIZE)
 
-#endif /* CONFIG_ARCH_GENERIC_PAGE_SIZE */
-
+#ifndef __ASSEMBLY__
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_ARCH_HAVE_GET_ORDER
 /* Pure 2^n version of get_order */
@@ -45,6 +42,7 @@ static __inline__ __attribute_const__ in
 	} while (size);
 	return order;
 }
+#endif /* __ASSEMBLY__ */
 
 #endif	/* CONFIG_ARCH_HAVE_GET_ORDER */
 #endif  /* __ASSEMBLY__ */
diff -puN include/asm-frv/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-frv/page.h
--- threadalloc/include/asm-frv/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-frv/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -3,6 +3,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm-generic/page.h>
 #include <asm/virtconvert.h>
 #include <asm/mem-layout.h>
 #include <asm/sections.h>
@@ -41,9 +42,6 @@ typedef struct { unsigned long	pgprot;	}
 #define __pgprot(x)	((pgprot_t) { (x) } )
 #define PTE_MASK	PAGE_MASK
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 #define devmem_is_allowed(pfn)	1
 
 #define __pa(vaddr)		virt_to_phys((void *) (unsigned long) (vaddr))
diff -puN include/asm-frv/mem-layout.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-frv/mem-layout.h
--- threadalloc/include/asm-frv/mem-layout.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-frv/mem-layout.h	2006-08-30 15:15:06.000000000 -0700
@@ -12,25 +12,14 @@
 #ifndef _ASM_MEM_LAYOUT_H
 #define _ASM_MEM_LAYOUT_H
 
+#include <asm-generic/page.h>
+
 #ifndef __ASSEMBLY__
 #define __UL(X)	((unsigned long) (X))
 #else
 #define __UL(X)	(X)
 #endif
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT			14
-
-#ifndef __ASSEMBLY__
-#define PAGE_SIZE			(1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE			(1 << PAGE_SHIFT)
-#endif
-
-#define PAGE_MASK			(~(PAGE_SIZE-1))
-
 /*****************************************************************************/
 /*
  * virtual memory layout from kernel's point of view
diff -puN include/asm-cris/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-cris/page.h
--- threadalloc/include/asm-cris/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-cris/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,17 +1,9 @@
 #ifndef _CRIS_PAGE_H
 #define _CRIS_PAGE_H
 
+#include <asm-generic/page.h>
 #include <asm/arch/page.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	13
-#ifndef __ASSEMBLY__
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1 << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #ifdef __KERNEL__
 
 #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
@@ -63,9 +55,6 @@ typedef struct { unsigned long pgprot; }
 
 #define page_to_phys(page)     __pa((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #ifndef __ASSEMBLY__
 
 #endif /* __ASSEMBLY__ */
diff -puN include/asm-arm26/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-arm26/page.h
--- threadalloc/include/asm-arm26/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-arm26/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -1,6 +1,7 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
 
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -79,12 +80,6 @@ typedef unsigned long pgprot_t;
 
 #define EXEC_PAGESIZE   32768
 
-#define PAGE_SIZE		(1UL << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
diff -puN include/asm-arm/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-arm/page.h
--- threadalloc/include/asm-arm/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-arm/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -10,17 +10,10 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		12
-#define PAGE_SIZE		(1UL << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #ifndef __ASSEMBLY__
 
 #ifndef CONFIG_MMU
diff -puN include/asm-arm/page-nommu.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-arm/page-nommu.h
--- threadalloc/include/asm-arm/page-nommu.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-arm/page-nommu.h	2006-08-30 15:15:06.000000000 -0700
@@ -42,9 +42,6 @@ typedef unsigned long pgprot_t;
 #define __pmd(x)        (x)
 #define __pgprot(x)     (x)
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
diff -puN include/asm-alpha/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT include/asm-alpha/page.h
--- threadalloc/include/asm-alpha/page.h~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:14:55.000000000 -0700
+++ threadalloc-dave/include/asm-alpha/page.h	2006-08-30 15:15:06.000000000 -0700
@@ -2,11 +2,7 @@
 #define _ALPHA_PAGE_H
 
 #include <asm/pal.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	13
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 
@@ -78,9 +74,6 @@ typedef unsigned long pgprot_t;
 
 #endif /* !__ASSEMBLY__ */
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
-
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 #ifndef CONFIG_DISCONTIGMEM
diff -puN arch/ia64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/ia64/Kconfig
--- threadalloc/arch/ia64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:02.000000000 -0700
+++ threadalloc-dave/arch/ia64/Kconfig	2006-08-30 15:15:06.000000000 -0700
@@ -149,9 +149,6 @@ config MCKINLEY
 
 endchoice
 
-config ARCH_GENERIC_PAGE_SIZE
-	def_bool y
-
 choice
 	prompt "Page Table Levels"
 	default PGTABLE_3
diff -puN arch/mips/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/mips/Kconfig
--- threadalloc/arch/mips/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:03.000000000 -0700
+++ threadalloc-dave/arch/mips/Kconfig	2006-08-30 15:15:06.000000000 -0700
@@ -1444,9 +1444,6 @@ config MIPS_PAGE_SIZE_64KB
 	def_bool y
 	depends on EXPERIMENTAL && !CPU_R3000 && !CPU_TX39XX
 
-config ARCH_GENERIC_PAGE_SIZE
-	def_bool y
-
 config BOARD_SCACHE
 	bool
 
diff -puN arch/parisc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/parisc/Kconfig
--- threadalloc/arch/parisc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:04.000000000 -0700
+++ threadalloc-dave/arch/parisc/Kconfig	2006-08-30 15:15:06.000000000 -0700
@@ -146,9 +146,6 @@ config PARISC_LARGER_PAGE_SIZES
 	def_bool y
 	depends on PA8X00 && EXPERIMENTAL
 
-config ARCH_GENERIC_PAGE_SIZE
-	def_bool y
-
 endchoice
 
 config SMP
diff -puN arch/powerpc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/powerpc/Kconfig
--- threadalloc/arch/powerpc/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:05.000000000 -0700
+++ threadalloc-dave/arch/powerpc/Kconfig	2006-08-30 15:15:06.000000000 -0700
@@ -725,9 +725,6 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
-config ARCH_GENERIC_PAGE_SIZE
-	def_bool y
-
 config PPC_64K_PAGES
 	bool "enable 64k page size"
 	depends on PPC64
diff -puN arch/sparc64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT arch/sparc64/Kconfig
--- threadalloc/arch/sparc64/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:03.000000000 -0700
+++ threadalloc-dave/arch/sparc64/Kconfig	2006-08-30 15:15:06.000000000 -0700
@@ -34,9 +34,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
-config ARCH_GENERIC_PAGE_SIZE
-	def_bool y
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff -puN mm/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT mm/Kconfig
--- threadalloc/mm/Kconfig~arch-generic-PAGE_SIZE-give-every-arch-PAGE_SHIFT	2006-08-30 15:15:05.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-08-30 15:15:06.000000000 -0700
@@ -4,7 +4,6 @@ config ARCH_HAVE_GET_ORDER
 
 choice
 	prompt "Kernel Page Size"
-	depends on ARCH_GENERIC_PAGE_SIZE
 	default PAGE_SIZE_4KB if MIPS || PARISC
 	default PAGE_SIZE_8KB if SPARC64
 	default PAGE_SIZE_16KB if IA64
@@ -45,15 +44,17 @@ config PAGE_SIZE_4MB
 	depends on SPARC64
 endchoice
 
+# Note that sparc and m68k vary their page sizes based
+# on the SUN3/4 options, so they are not explicitly listed
 config PAGE_SHIFT
 	int
-	depends on ARCH_GENERIC_PAGE_SIZE
-	default "13" if PAGE_SIZE_8KB
-	default "14" if PAGE_SIZE_16KB
+	default "13" if PAGE_SIZE_8KB || ALPHA || CRIS || SUN3 || SUN4
+	default "14" if PAGE_SIZE_16KB || FRV
 	default "16" if PAGE_SIZE_64KB || PPC_64K_PAGES
 	default "19" if PAGE_SIZE_512KB
 	default "22" if PAGE_SIZE_4MB
-	default "12"
+	default "12" # arm(26) || h8300 || i386 || m68knommu || m32r || ppc(32)
+		     # s390 || sh/64 || um || v850 || xtensa || x86_64
 
 config SELECT_MEMORY_MODEL
 	def_bool y
_
