Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVJAX76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVJAX76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVJAX76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:59:58 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750911AbVJAX75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:59:57 -0400
Date: Sun, 2 Oct 2005 01:59:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gerg@uclinux.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-m68knommu/: "extern inline" -> "static inline"
Message-ID: <20051001235955.GI4212@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-m68knommu/atomic.h      |    4 ++--
 include/asm-m68knommu/cacheflush.h  |    2 +-
 include/asm-m68knommu/delay.h       |    4 ++--
 include/asm-m68knommu/io.h          |    8 ++++----
 include/asm-m68knommu/mcfwdebug.h   |    2 +-
 include/asm-m68knommu/mmu_context.h |    4 ++--
 include/asm-m68knommu/processor.h   |    4 ++--
 include/asm-m68knommu/semaphore.h   |   10 +++++-----
 include/asm-m68knommu/tlbflush.h    |    4 ++--
 9 files changed, 21 insertions(+), 21 deletions(-)

--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/atomic.h.old	2005-10-02 01:56:14.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/atomic.h	2005-10-02 01:56:25.000000000 +0200
@@ -100,7 +100,7 @@
 #define smp_mb__before_atomic_inc()    barrier()
 #define smp_mb__after_atomic_inc() barrier()
 
-extern __inline__ int atomic_add_return(int i, atomic_t * v)
+static inline int atomic_add_return(int i, atomic_t * v)
 {
 	unsigned long temp, flags;
 
@@ -115,7 +115,7 @@
 
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 
-extern __inline__ int atomic_sub_return(int i, atomic_t * v)
+static inline int atomic_sub_return(int i, atomic_t * v)
 {
 	unsigned long temp, flags;
 
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/cacheflush.h.old	2005-10-02 01:56:42.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/cacheflush.h	2005-10-02 01:56:49.000000000 +0200
@@ -25,7 +25,7 @@
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	memcpy(dst, src, len)
 
-extern inline void __flush_cache_all(void)
+static inline void __flush_cache_all(void)
 {
 #ifdef CONFIG_M5407
 	/*
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/delay.h.old	2005-10-02 01:56:56.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/delay.h	2005-10-02 01:57:01.000000000 +0200
@@ -8,7 +8,7 @@
 
 #include <asm/param.h>
 
-extern __inline__ void __delay(unsigned long loops)
+static inline void __delay(unsigned long loops)
 {
 #if defined(CONFIG_COLDFIRE)
 	/* The coldfire runs this loop at significantly different speeds
@@ -48,7 +48,7 @@
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void _udelay(unsigned long usecs)
+static inline void _udelay(unsigned long usecs)
 {
 #if defined(CONFIG_M68328) || defined(CONFIG_M68EZ328) || \
     defined(CONFIG_M68VZ328) || defined(CONFIG_M68360) || \
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/io.h.old	2005-10-02 01:57:10.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/io.h	2005-10-02 01:57:13.000000000 +0200
@@ -147,19 +147,19 @@
 extern void *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag);
 extern void __iounmap(void *addr, unsigned long size);
 
-extern inline void *ioremap(unsigned long physaddr, unsigned long size)
+static inline void *ioremap(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
-extern inline void *ioremap_nocache(unsigned long physaddr, unsigned long size)
+static inline void *ioremap_nocache(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
-extern inline void *ioremap_writethrough(unsigned long physaddr, unsigned long size)
+static inline void *ioremap_writethrough(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
-extern inline void *ioremap_fullcache(unsigned long physaddr, unsigned long size)
+static inline void *ioremap_fullcache(unsigned long physaddr, unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/mcfwdebug.h.old	2005-10-02 01:57:22.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/mcfwdebug.h	2005-10-02 01:57:26.000000000 +0200
@@ -90,7 +90,7 @@
  * that the debug module instructions (2 longs) must be long word aligned and
  * some pointer fiddling is performed to ensure this.
  */
-extern inline void wdebug(int reg, unsigned long data) {
+static inline void wdebug(int reg, unsigned long data) {
 	unsigned short dbg_spc[6];
 	unsigned short *dbg;
 
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/mmu_context.h.old	2005-10-02 01:57:34.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/mmu_context.h	2005-10-02 01:57:38.000000000 +0200
@@ -10,7 +10,7 @@
 {
 }
 
-extern inline int
+static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	// mm->context = virt_to_phys(mm->pgd);
@@ -25,7 +25,7 @@
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
-extern inline void activate_mm(struct mm_struct *prev_mm,
+static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
 }
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/processor.h.old	2005-10-02 01:57:46.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/processor.h	2005-10-02 01:57:51.000000000 +0200
@@ -21,7 +21,7 @@
 #include <asm/ptrace.h>
 #include <asm/current.h>
 
-extern inline unsigned long rdusp(void)
+static inline unsigned long rdusp(void)
 {
 #ifdef CONFIG_COLDFIRE
 	extern unsigned int sw_usp;
@@ -33,7 +33,7 @@
 #endif
 }
 
-extern inline void wrusp(unsigned long usp)
+static inline void wrusp(unsigned long usp)
 {
 #ifdef CONFIG_COLDFIRE
 	extern unsigned int sw_usp;
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/semaphore.h.old	2005-10-02 01:57:58.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/semaphore.h	2005-10-02 01:58:02.000000000 +0200
@@ -44,7 +44,7 @@
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+static inline void sema_init (struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER(*sem, val);
 }
@@ -76,7 +76,7 @@
  * "down_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/m68k/lib/semaphore.S
  */
-extern inline void down(struct semaphore * sem)
+static inline void down(struct semaphore * sem)
 {
 	might_sleep();
 	__asm__ __volatile__(
@@ -91,7 +91,7 @@
 		: "cc", "%a0", "%a1", "memory");
 }
 
-extern inline int down_interruptible(struct semaphore * sem)
+static inline int down_interruptible(struct semaphore * sem)
 {
 	int ret;
 
@@ -110,7 +110,7 @@
 	return(ret);
 }
 
-extern inline int down_trylock(struct semaphore * sem)
+static inline int down_trylock(struct semaphore * sem)
 {
 	register struct semaphore *sem1 __asm__ ("%a1") = sem;
 	register int result __asm__ ("%d0");
@@ -138,7 +138,7 @@
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-extern inline void up(struct semaphore * sem)
+static inline void up(struct semaphore * sem)
 {
 	__asm__ __volatile__(
 		"| atomic up operation\n\t"
--- linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/tlbflush.h.old	2005-10-02 01:58:09.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-m68knommu/tlbflush.h	2005-10-02 01:58:17.000000000 +0200
@@ -47,12 +47,12 @@
 	BUG();
 }
 
-extern inline void flush_tlb_kernel_page(unsigned long addr)
+static inline void flush_tlb_kernel_page(unsigned long addr)
 {
 	BUG();
 }
 
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
 	BUG();

