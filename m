Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVHXLQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVHXLQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVHXLQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:16:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30481 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750858AbVHXLQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:16:14 -0400
Date: Wed, 24 Aug 2005 13:16:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chris@zankel.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-xtensa/: "extern inline" -> "static inline"
Message-ID: <20050824111612.GM5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-xtensa/atomic.h      |   12 ++++-----
 include/asm-xtensa/checksum.h    |    4 +--
 include/asm-xtensa/delay.h       |    2 -
 include/asm-xtensa/io.h          |   14 +++++-----
 include/asm-xtensa/mmu_context.h |   18 ++++++-------
 include/asm-xtensa/page.h        |    2 -
 include/asm-xtensa/pci.h         |    4 +--
 include/asm-xtensa/pgtable.h     |    6 ++--
 include/asm-xtensa/semaphore.h   |   10 +++----
 include/asm-xtensa/string.h      |    8 +++---
 include/asm-xtensa/system.h      |   10 +++----
 include/asm-xtensa/tlbflush.h    |   40 +++++++++++++++----------------
 include/asm-xtensa/uaccess.h     |   10 +++----
 13 files changed, 70 insertions(+), 70 deletions(-)

--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/atomic.h.old	2005-08-23 01:45:21.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/atomic.h	2005-08-23 01:45:28.000000000 +0200
@@ -66,7 +66,7 @@
  *
  * Atomically adds @i to @v.
  */
-extern __inline__ void atomic_add(int i, atomic_t * v)
+static inline void atomic_add(int i, atomic_t * v)
 {
     unsigned int vval;
 
@@ -90,7 +90,7 @@
  *
  * Atomically subtracts @i from @v.
  */
-extern __inline__ void atomic_sub(int i, atomic_t *v)
+static inline void atomic_sub(int i, atomic_t *v)
 {
     unsigned int vval;
 
@@ -111,7 +111,7 @@
  * We use atomic_{add|sub}_return to define other functions.
  */
 
-extern __inline__ int atomic_add_return(int i, atomic_t * v)
+static inline int atomic_add_return(int i, atomic_t * v)
 {
      unsigned int vval;
 
@@ -130,7 +130,7 @@
     return vval;
 }
 
-extern __inline__ int atomic_sub_return(int i, atomic_t * v)
+static inline int atomic_sub_return(int i, atomic_t * v)
 {
     unsigned int vval;
 
@@ -224,7 +224,7 @@
 #define atomic_add_negative(i,v) (atomic_add_return((i),(v)) < 0)
 
 
-extern __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
+static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
     unsigned int all_f = -1;
     unsigned int vval;
@@ -243,7 +243,7 @@
 	);
 }
 
-extern __inline__ void atomic_set_mask(unsigned int mask, atomic_t *v)
+static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
     unsigned int vval;
 
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/checksum.h.old	2005-08-23 01:45:38.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/checksum.h	2005-08-23 01:45:43.000000000 +0200
@@ -47,14 +47,14 @@
  *	If you use these functions directly please don't forget the
  *	verify_area().
  */
-extern __inline__
+static inline
 unsigned int csum_partial_copy_nocheck ( const char *src, char *dst,
 					int len, int sum)
 {
 	return csum_partial_copy_generic ( src, dst, len, sum, NULL, NULL);
 }
 
-extern __inline__
+static inline
 unsigned int csum_partial_copy_from_user ( const char *src, char *dst,
 						int len, int sum, int *err_ptr)
 {
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/delay.h.old	2005-08-23 01:45:51.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/delay.h	2005-08-23 01:45:56.000000000 +0200
@@ -18,7 +18,7 @@
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void __delay(unsigned long loops)
+static inline void __delay(unsigned long loops)
 {
   /* 2 cycles per loop. */
   __asm__ __volatile__ ("1: addi %0, %0, -2; bgeui %0, 2, 1b"
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/io.h.old	2005-08-23 01:46:06.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/io.h	2005-08-23 01:46:10.000000000 +0200
@@ -41,12 +41,12 @@
  * These are trivial on the 1:1 Linux/Xtensa mapping
  */
 
-extern inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 	return PHYSADDR((unsigned long)address);
 }
 
-extern inline void * phys_to_virt(unsigned long address)
+static inline void * phys_to_virt(unsigned long address)
 {
 	return (void*) CACHED_ADDR(address);
 }
@@ -55,12 +55,12 @@
  * IO bus memory addresses are also 1:1 with the physical address
  */
 
-extern inline unsigned long virt_to_bus(volatile void * address)
+static inline unsigned long virt_to_bus(volatile void * address)
 {
 	return PHYSADDR((unsigned long)address);
 }
 
-extern inline void * bus_to_virt (unsigned long address)
+static inline void * bus_to_virt (unsigned long address)
 {
 	return (void *) CACHED_ADDR(address);
 }
@@ -69,17 +69,17 @@
  * Change "struct page" to physical address.
  */
 
-extern inline void *ioremap(unsigned long offset, unsigned long size)
+static inline void *ioremap(unsigned long offset, unsigned long size)
 {
         return (void *) CACHED_ADDR_IO(offset);
 }
 
-extern inline void *ioremap_nocache(unsigned long offset, unsigned long size)
+static inline void *ioremap_nocache(unsigned long offset, unsigned long size)
 {
         return (void *) BYPASS_ADDR_IO(offset);
 }
 
-extern inline void iounmap(void *addr)
+static inline void iounmap(void *addr)
 {
 }
 
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/mmu_context.h.old	2005-08-23 01:46:21.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/mmu_context.h	2005-08-23 01:46:25.000000000 +0200
@@ -199,13 +199,13 @@
 #define ASID_FIRST_VERSION						\
 	((unsigned long)(~ASID_VERSION_MASK) + 1 + ASID_FIRST_NONRESERVED)
 
-extern inline void set_rasid_register (unsigned long val)
+static inline void set_rasid_register (unsigned long val)
 {
 	__asm__ __volatile__ (" wsr %0, "__stringify(RASID)"\n\t"
 			      " isync\n" : : "a" (val));
 }
 
-extern inline unsigned long get_rasid_register (void)
+static inline unsigned long get_rasid_register (void)
 {
 	unsigned long tmp;
 	__asm__ __volatile__ (" rsr %0, "__stringify(RASID)"\n\t" : "=a" (tmp));
@@ -215,7 +215,7 @@
 
 #if ((XCHAL_MMU_ASID_INVALID == 0) && (XCHAL_MMU_ASID_KERNEL == 1))
 
-extern inline void
+static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long asid)
 {
 	extern void flush_tlb_all(void);
@@ -234,7 +234,7 @@
 /* XCHAL_MMU_ASID_INVALID == 0 and XCHAL_MMU_ASID_KERNEL ==1 are
    really the best, but if you insist... */
 
-extern inline int validate_asid (unsigned long asid)
+static inline int validate_asid (unsigned long asid)
 {
 	switch (asid) {
 	case XCHAL_MMU_ASID_INVALID:
@@ -247,7 +247,7 @@
 	return 1; /* valid */
 }
 
-extern inline void
+static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long asid)
 {
 	extern void flush_tlb_all(void);
@@ -274,14 +274,14 @@
  * instance.
  */
 
-extern inline int
+static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	mm->context = NO_CONTEXT;
 	return 0;
 }
 
-extern inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
                              struct task_struct *tsk)
 {
 	unsigned long asid = asid_cache;
@@ -301,7 +301,7 @@
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
-extern inline void destroy_context(struct mm_struct *mm)
+static inline void destroy_context(struct mm_struct *mm)
 {
 	/* Nothing to do. */
 }
@@ -310,7 +310,7 @@
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
-extern inline void
+static inline void
 activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	/* Unconditionally get a new ASID.  */
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/page.h.old	2005-08-23 01:49:21.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/page.h	2005-08-23 01:49:27.000000000 +0200
@@ -55,7 +55,7 @@
  * Pure 2^n version of get_order
  */
 
-extern __inline__ int get_order(unsigned long size)
+static inline int get_order(unsigned long size)
 {
 	int order;
 #ifndef XCHAL_HAVE_NSU
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/pci.h.old	2005-08-23 01:49:36.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/pci.h	2005-08-23 01:49:40.000000000 +0200
@@ -22,12 +22,12 @@
 
 extern struct pci_controller* pcibios_alloc_controller(void);
 
-extern inline void pcibios_set_master(struct pci_dev *dev)
+static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
 }
 
-extern inline void pcibios_penalize_isa_irq(int irq)
+static inline void pcibios_penalize_isa_irq(int irq)
 {
 	/* We don't do dynamic PCI IRQ allocation */
 }
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/pgtable.h.old	2005-08-23 01:49:48.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/pgtable.h	2005-08-23 01:49:51.000000000 +0200
@@ -260,7 +260,7 @@
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
-extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 }
@@ -278,14 +278,14 @@
 #endif
 }
 
-extern inline void
+static inline void
 set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pteval)
 {
 	update_pte(ptep, pteval);
 }
 
 
-extern inline void
+static inline void
 set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
 	*pmdp = pmdval;
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/semaphore.h.old	2005-08-23 01:50:04.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/semaphore.h	2005-08-23 01:50:11.000000000 +0200
@@ -47,7 +47,7 @@
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+static inline void sema_init (struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -79,7 +79,7 @@
 
 extern spinlock_t semaphore_wake_lock;
 
-extern __inline__ void down(struct semaphore * sem)
+static inline void down(struct semaphore * sem)
 {
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
@@ -89,7 +89,7 @@
 		__down(sem);
 }
 
-extern __inline__ int down_interruptible(struct semaphore * sem)
+static inline int down_interruptible(struct semaphore * sem)
 {
 	int ret = 0;
 #if WAITQUEUE_DEBUG
@@ -101,7 +101,7 @@
 	return ret;
 }
 
-extern __inline__ int down_trylock(struct semaphore * sem)
+static inline int down_trylock(struct semaphore * sem)
 {
 	int ret = 0;
 #if WAITQUEUE_DEBUG
@@ -117,7 +117,7 @@
  * Note! This is subtle. We jump to wake people up only if
  * the semaphore was negative (== somebody was waiting on it).
  */
-extern __inline__ void up(struct semaphore * sem)
+static inline void up(struct semaphore * sem)
 {
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/string.h.old	2005-08-23 01:50:28.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/string.h	2005-08-23 01:50:32.000000000 +0200
@@ -16,7 +16,7 @@
 #define _XTENSA_STRING_H
 
 #define __HAVE_ARCH_STRCPY
-extern __inline__ char *strcpy(char *__dest, const char *__src)
+static inline char *strcpy(char *__dest, const char *__src)
 {
 	register char *__xdest = __dest;
 	unsigned long __dummy;
@@ -35,7 +35,7 @@
 }
 
 #define __HAVE_ARCH_STRNCPY
-extern __inline__ char *strncpy(char *__dest, const char *__src, size_t __n)
+static inline char *strncpy(char *__dest, const char *__src, size_t __n)
 {
 	register char *__xdest = __dest;
 	unsigned long __dummy;
@@ -60,7 +60,7 @@
 }
 
 #define __HAVE_ARCH_STRCMP
-extern __inline__ int strcmp(const char *__cs, const char *__ct)
+static inline int strcmp(const char *__cs, const char *__ct)
 {
 	register int __res;
 	unsigned long __dummy;
@@ -82,7 +82,7 @@
 }
 
 #define __HAVE_ARCH_STRNCMP
-extern __inline__ int strncmp(const char *__cs, const char *__ct, size_t __n)
+static inline int strncmp(const char *__cs, const char *__ct, size_t __n)
 {
 	register int __res;
 	unsigned long __dummy;
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/system.h.old	2005-08-23 01:50:43.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/system.h	2005-08-23 01:50:46.000000000 +0200
@@ -56,7 +56,7 @@
 
 #define clear_cpenable() __clear_cpenable()
 
-extern __inline__ void __clear_cpenable(void)
+static inline void __clear_cpenable(void)
 {
 #if XCHAL_HAVE_CP
 	unsigned long i = 0;
@@ -64,7 +64,7 @@
 #endif
 }
 
-extern __inline__ void enable_coprocessor(int i)
+static inline void enable_coprocessor(int i)
 {
 #if XCHAL_HAVE_CP
 	int cp;
@@ -74,7 +74,7 @@
 #endif
 }
 
-extern __inline__ void disable_coprocessor(int i)
+static inline void disable_coprocessor(int i)
 {
 #if XCHAL_HAVE_CP
 	int cp;
@@ -123,7 +123,7 @@
  * cmpxchg
  */
 
-extern __inline__ unsigned long
+static inline unsigned long
 __cmpxchg_u32(volatile int *p, int old, int new)
 {
   __asm__ __volatile__("rsil    a15, "__stringify(LOCKLEVEL)"\n\t"
@@ -173,7 +173,7 @@
  * where no register reference will cause an overflow.
  */
 
-extern __inline__ unsigned long xchg_u32(volatile int * m, unsigned long val)
+static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 {
   unsigned long tmp;
   __asm__ __volatile__("rsil    a15, "__stringify(LOCKLEVEL)"\n\t"
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/tlbflush.h.old	2005-08-23 01:50:59.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/tlbflush.h	2005-08-23 01:51:03.000000000 +0200
@@ -39,7 +39,7 @@
  * page-table pages.
  */
 
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
                                       unsigned long start, unsigned long end)
 {
 }
@@ -51,26 +51,26 @@
 #define ITLB_PROBE_SUCCESS  (1 << ITLB_WAYS_LOG2)
 #define DTLB_PROBE_SUCCESS  (1 << DTLB_WAYS_LOG2)
 
-extern inline unsigned long itlb_probe(unsigned long addr)
+static inline unsigned long itlb_probe(unsigned long addr)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("pitlb  %0, %1\n\t" : "=a" (tmp) : "a" (addr));
 	return tmp;
 }
 
-extern inline unsigned long dtlb_probe(unsigned long addr)
+static inline unsigned long dtlb_probe(unsigned long addr)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("pdtlb  %0, %1\n\t" : "=a" (tmp) : "a" (addr));
 	return tmp;
 }
 
-extern inline void invalidate_itlb_entry (unsigned long probe)
+static inline void invalidate_itlb_entry (unsigned long probe)
 {
 	__asm__ __volatile__("iitlb  %0; isync\n\t" : : "a" (probe));
 }
 
-extern inline void invalidate_dtlb_entry (unsigned long probe)
+static inline void invalidate_dtlb_entry (unsigned long probe)
 {
 	__asm__ __volatile__("idtlb  %0; dsync\n\t" : : "a" (probe));
 }
@@ -80,68 +80,68 @@
  * caller must follow up with an 'isync', which can be relatively
  * expensive on some Xtensa implementations.
  */
-extern inline void invalidate_itlb_entry_no_isync (unsigned entry)
+static inline void invalidate_itlb_entry_no_isync (unsigned entry)
 {
 	/* Caller must follow up with 'isync'. */
 	__asm__ __volatile__ ("iitlb  %0\n" : : "a" (entry) );
 }
 
-extern inline void invalidate_dtlb_entry_no_isync (unsigned entry)
+static inline void invalidate_dtlb_entry_no_isync (unsigned entry)
 {
 	/* Caller must follow up with 'isync'. */
 	__asm__ __volatile__ ("idtlb  %0\n" : : "a" (entry) );
 }
 
-extern inline void set_itlbcfg_register (unsigned long val)
+static inline void set_itlbcfg_register (unsigned long val)
 {
 	__asm__ __volatile__("wsr  %0, "__stringify(ITLBCFG)"\n\t" "isync\n\t"
 			     : : "a" (val));
 }
 
-extern inline void set_dtlbcfg_register (unsigned long val)
+static inline void set_dtlbcfg_register (unsigned long val)
 {
 	__asm__ __volatile__("wsr  %0, "__stringify(DTLBCFG)"; dsync\n\t"
 	    		     : : "a" (val));
 }
 
-extern inline void set_ptevaddr_register (unsigned long val)
+static inline void set_ptevaddr_register (unsigned long val)
 {
 	__asm__ __volatile__(" wsr  %0, "__stringify(PTEVADDR)"; isync\n"
 			     : : "a" (val));
 }
 
-extern inline unsigned long read_ptevaddr_register (void)
+static inline unsigned long read_ptevaddr_register (void)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("rsr  %0, "__stringify(PTEVADDR)"\n\t" : "=a" (tmp));
 	return tmp;
 }
 
-extern inline void write_dtlb_entry (pte_t entry, int way)
+static inline void write_dtlb_entry (pte_t entry, int way)
 {
 	__asm__ __volatile__("wdtlb  %1, %0; dsync\n\t"
 			     : : "r" (way), "r" (entry) );
 }
 
-extern inline void write_itlb_entry (pte_t entry, int way)
+static inline void write_itlb_entry (pte_t entry, int way)
 {
 	__asm__ __volatile__("witlb  %1, %0; isync\n\t"
 	                     : : "r" (way), "r" (entry) );
 }
 
-extern inline void invalidate_page_directory (void)
+static inline void invalidate_page_directory (void)
 {
 	invalidate_dtlb_entry (DTLB_WAY_PGTABLE);
 }
 
-extern inline void invalidate_itlb_mapping (unsigned address)
+static inline void invalidate_itlb_mapping (unsigned address)
 {
 	unsigned long tlb_entry;
 	while ((tlb_entry = itlb_probe (address)) & ITLB_PROBE_SUCCESS)
 		invalidate_itlb_entry (tlb_entry);
 }
 
-extern inline void invalidate_dtlb_mapping (unsigned address)
+static inline void invalidate_dtlb_mapping (unsigned address)
 {
 	unsigned long tlb_entry;
 	while ((tlb_entry = dtlb_probe (address)) & DTLB_PROBE_SUCCESS)
@@ -165,28 +165,28 @@
  *      as[07..00] contain the asid
  */
 
-extern inline unsigned long read_dtlb_virtual (int way)
+static inline unsigned long read_dtlb_virtual (int way)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("rdtlb0  %0, %1\n\t" : "=a" (tmp), "+a" (way));
 	return tmp;
 }
 
-extern inline unsigned long read_dtlb_translation (int way)
+static inline unsigned long read_dtlb_translation (int way)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("rdtlb1  %0, %1\n\t" : "=a" (tmp), "+a" (way));
 	return tmp;
 }
 
-extern inline unsigned long read_itlb_virtual (int way)
+static inline unsigned long read_itlb_virtual (int way)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("ritlb0  %0, %1\n\t" : "=a" (tmp), "+a" (way));
 	return tmp;
 }
 
-extern inline unsigned long read_itlb_translation (int way)
+static inline unsigned long read_itlb_translation (int way)
 {
 	unsigned long tmp;
 	__asm__ __volatile__("ritlb1  %0, %1\n\t" : "=a" (tmp), "+a" (way));
--- linux-2.6.13-rc6-mm1-full/include/asm-xtensa/uaccess.h.old	2005-08-23 01:51:15.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-xtensa/uaccess.h	2005-08-23 01:51:19.000000000 +0200
@@ -211,7 +211,7 @@
 #define __access_ok(addr,size) (__kernel_ok || __user_ok((addr),(size)))
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
-extern inline int verify_area(int type, const void * addr, unsigned long size)
+static inline int verify_area(int type, const void * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
@@ -464,7 +464,7 @@
  * success.
  */
 
-extern inline unsigned long
+static inline unsigned long
 __xtensa_clear_user(void *addr, unsigned long size)
 {
 	if ( ! memset(addr, 0, size) )
@@ -472,7 +472,7 @@
 	return 0;
 }
 
-extern inline unsigned long
+static inline unsigned long
 clear_user(void *addr, unsigned long size)
 {
 	if (access_ok(VERIFY_WRITE, addr, size))
@@ -486,7 +486,7 @@
 extern long __strncpy_user(char *, const char *, long);
 #define __strncpy_from_user __strncpy_user
 
-extern inline long
+static inline long
 strncpy_from_user(char *dst, const char *src, long count)
 {
 	if (access_ok(VERIFY_READ, src, 1))
@@ -502,7 +502,7 @@
  */
 extern long __strnlen_user(const char *, long);
 
-extern inline long strnlen_user(const char *str, long len)
+static inline long strnlen_user(const char *str, long len)
 {
 	unsigned long top = __kernel_ok ? ~0UL : TASK_SIZE - 1;
 

