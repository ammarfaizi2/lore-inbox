Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVIBUbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVIBUbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVIBUbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:31:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57354 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750730AbVIBUbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:31:34 -0400
Date: Fri, 2 Sep 2005 22:31:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Message-ID: <20050902203123.GT3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-x86_64/desc.h      |    2 +-
 include/asm-x86_64/fixmap.h    |    2 +-
 include/asm-x86_64/io.h        |   14 +++++++-------
 include/asm-x86_64/msr.h       |   10 +++++-----
 include/asm-x86_64/pgalloc.h   |    8 ++++----
 include/asm-x86_64/pgtable.h   |    6 +++---
 include/asm-x86_64/processor.h |    4 ++--
 include/asm-x86_64/signal.h    |   10 +++++-----
 include/asm-x86_64/smp.h       |    2 +-
 include/asm-x86_64/system.h    |    2 +-
 10 files changed, 30 insertions(+), 30 deletions(-)

--- linux-2.6.13-mm1-full/include/asm-x86_64/desc.h.old	2005-09-02 22:26:18.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/desc.h	2005-09-02 22:26:24.000000000 +0200
@@ -191,7 +191,7 @@
 /*
  * load one particular LDT into the current CPU
  */
-extern inline void load_LDT_nolock (mm_context_t *pc, int cpu)
+static inline void load_LDT_nolock (mm_context_t *pc, int cpu)
 {
 	int count = pc->size;
 
--- linux-2.6.13-mm1-full/include/asm-x86_64/fixmap.h.old	2005-09-02 22:26:32.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/fixmap.h	2005-09-02 22:26:36.000000000 +0200
@@ -76,7 +76,7 @@
  * directly without translation, we catch the bug with a NULL-deference
  * kernel oops. Illegal ranges of incoming indices are caught too.
  */
-extern inline unsigned long fix_to_virt(const unsigned int idx)
+static inline unsigned long fix_to_virt(const unsigned int idx)
 {
 	/*
 	 * this branch gets completely eliminated after inlining,
--- linux-2.6.13-mm1-full/include/asm-x86_64/io.h.old	2005-09-02 22:26:45.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/io.h	2005-09-02 22:26:49.000000000 +0200
@@ -48,7 +48,7 @@
  * Talk about misusing macros..
  */
 #define __OUT1(s,x) \
-extern inline void out##s(unsigned x value, unsigned short port) {
+static inline void out##s(unsigned x value, unsigned short port) {
 
 #define __OUT2(s,s1,s2) \
 __asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
@@ -58,7 +58,7 @@
 __OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
 
 #define __IN1(s) \
-extern inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
+static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
 
 #define __IN2(s,s1,s2) \
 __asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
@@ -68,12 +68,12 @@
 __IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
 
 #define __INS(s) \
-extern inline void ins##s(unsigned short port, void * addr, unsigned long count) \
+static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
 { __asm__ __volatile__ ("rep ; ins" #s \
 : "=D" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
 
 #define __OUTS(s) \
-extern inline void outs##s(unsigned short port, const void * addr, unsigned long count) \
+static inline void outs##s(unsigned short port, const void * addr, unsigned long count) \
 { __asm__ __volatile__ ("rep ; outs" #s \
 : "=S" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
 
@@ -110,12 +110,12 @@
  * Change virtual addresses to physical addresses and vv.
  * These are pretty trivial
  */
-extern inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 	return __pa(address);
 }
 
-extern inline void * phys_to_virt(unsigned long address)
+static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
 }
@@ -130,7 +130,7 @@
 
 extern void __iomem *__ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
-extern inline void __iomem * ioremap (unsigned long offset, unsigned long size)
+static inline void __iomem * ioremap (unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
--- linux-2.6.13-mm1-full/include/asm-x86_64/msr.h.old	2005-09-02 22:26:58.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/msr.h	2005-09-02 22:27:03.000000000 +0200
@@ -64,7 +64,7 @@
 			  : "=a" (low), "=d" (high) \
 			  : "c" (counter))
 
-extern inline void cpuid(int op, unsigned int *eax, unsigned int *ebx,
+static inline void cpuid(int op, unsigned int *eax, unsigned int *ebx,
 			 unsigned int *ecx, unsigned int *edx)
 {
 	__asm__("cpuid"
@@ -90,7 +90,7 @@
 /*
  * CPUID functions returning a single datum
  */
-extern inline unsigned int cpuid_eax(unsigned int op)
+static inline unsigned int cpuid_eax(unsigned int op)
 {
 	unsigned int eax;
 
@@ -100,7 +100,7 @@
 		: "bx", "cx", "dx");
 	return eax;
 }
-extern inline unsigned int cpuid_ebx(unsigned int op)
+static inline unsigned int cpuid_ebx(unsigned int op)
 {
 	unsigned int eax, ebx;
 
@@ -110,7 +110,7 @@
 		: "cx", "dx" );
 	return ebx;
 }
-extern inline unsigned int cpuid_ecx(unsigned int op)
+static inline unsigned int cpuid_ecx(unsigned int op)
 {
 	unsigned int eax, ecx;
 
@@ -120,7 +120,7 @@
 		: "bx", "dx" );
 	return ecx;
 }
-extern inline unsigned int cpuid_edx(unsigned int op)
+static inline unsigned int cpuid_edx(unsigned int op)
 {
 	unsigned int eax, edx;
 
--- linux-2.6.13-mm1-full/include/asm-x86_64/pgalloc.h.old	2005-09-02 22:27:12.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/pgalloc.h	2005-09-02 22:27:35.000000000 +0200
@@ -18,12 +18,12 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)));
 }
 
-extern __inline__ pmd_t *get_pmd(void)
+static inline pmd_t *get_pmd(void)
 {
 	return (pmd_t *)get_zeroed_page(GFP_KERNEL);
 }
 
-extern __inline__ void pmd_free(pmd_t *pmd)
+static inline void pmd_free(pmd_t *pmd)
 {
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
 	free_page((unsigned long)pmd);
@@ -86,13 +86,13 @@
 /* Should really implement gc for free page table pages. This could be
    done with a reference count in struct page. */
 
-extern __inline__ void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(pte_t *pte)
 {
 	BUG_ON((unsigned long)pte & (PAGE_SIZE-1));
 	free_page((unsigned long)pte); 
 }
 
-extern inline void pte_free(struct page *pte)
+static inline void pte_free(struct page *pte)
 {
 	__free_page(pte);
 } 
--- linux-2.6.13-mm1-full/include/asm-x86_64/pgtable.h.old	2005-09-02 22:27:51.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/pgtable.h	2005-09-02 22:27:55.000000000 +0200
@@ -85,7 +85,7 @@
 	pud_val(*dst) = pud_val(val);
 }
 
-extern inline void pud_clear (pud_t *pud)
+static inline void pud_clear (pud_t *pud)
 {
 	set_pud(pud, __pud(0));
 }
@@ -95,7 +95,7 @@
 	pgd_val(*dst) = pgd_val(val); 
 } 
 
-extern inline void pgd_clear (pgd_t * pgd)
+static inline void pgd_clear (pgd_t * pgd)
 {
 	set_pgd(pgd, __pgd(0));
 }
@@ -375,7 +375,7 @@
 }
  
 /* Change flags of a PTE */
-extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { 
 	pte_val(pte) &= _PAGE_CHG_MASK;
 	pte_val(pte) |= pgprot_val(newprot);
--- linux-2.6.13-mm1-full/include/asm-x86_64/processor.h.old	2005-09-02 22:28:04.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/processor.h	2005-09-02 22:28:08.000000000 +0200
@@ -377,13 +377,13 @@
 #define ASM_NOP_MAX 8
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-extern inline void rep_nop(void)
+static inline void rep_nop(void)
 {
 	__asm__ __volatile__("rep;nop": : :"memory");
 }
 
 /* Stop speculative execution */
-extern inline void sync_core(void)
+static inline void sync_core(void)
 { 
 	int tmp;
 	asm volatile("cpuid" : "=a" (tmp) : "0" (1) : "ebx","ecx","edx","memory");
--- linux-2.6.13-mm1-full/include/asm-x86_64/signal.h.old	2005-09-02 22:28:17.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/signal.h	2005-09-02 22:28:20.000000000 +0200
@@ -143,23 +143,23 @@
 #undef __HAVE_ARCH_SIG_BITOPS
 #if 0
 
-extern __inline__ void sigaddset(sigset_t *set, int _sig)
+static inline void sigaddset(sigset_t *set, int _sig)
 {
 	__asm__("btsq %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
 }
 
-extern __inline__ void sigdelset(sigset_t *set, int _sig)
+static inline void sigdelset(sigset_t *set, int _sig)
 {
 	__asm__("btrq %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
 }
 
-extern __inline__ int __const_sigismember(sigset_t *set, int _sig)
+static inline int __const_sigismember(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;
 	return 1 & (set->sig[sig / _NSIG_BPW] >> (sig & ~(_NSIG_BPW-1)));
 }
 
-extern __inline__ int __gen_sigismember(sigset_t *set, int _sig)
+static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
 	int ret;
 	__asm__("btq %2,%1\n\tsbbq %0,%0"
@@ -172,7 +172,7 @@
 	 __const_sigismember((set),(sig)) :	\
 	 __gen_sigismember((set),(sig)))
 
-extern __inline__ int sigfindinword(unsigned long word)
+static inline int sigfindinword(unsigned long word)
 {
 	__asm__("bsfq %1,%0" : "=r"(word) : "rm"(word) : "cc");
 	return word;
--- linux-2.6.13-mm1-full/include/asm-x86_64/smp.h.old	2005-09-02 22:28:31.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/smp.h	2005-09-02 22:28:41.000000000 +0200
@@ -72,7 +72,7 @@
 
 #define raw_smp_processor_id() read_pda(cpunumber)
 
-extern __inline int hard_smp_processor_id(void)
+static inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_ID(*(unsigned int *)(APIC_BASE+APIC_ID));
--- linux-2.6.13-mm1-full/include/asm-x86_64/system.h.old	2005-09-02 22:28:50.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-x86_64/system.h	2005-09-02 22:28:56.000000000 +0200
@@ -199,7 +199,7 @@
 
 #define __xg(x) ((volatile long *)(x))
 
-extern inline void set_64bit(volatile unsigned long *ptr, unsigned long val)
+static inline void set_64bit(volatile unsigned long *ptr, unsigned long val)
 {
 	*ptr = val;
 }

