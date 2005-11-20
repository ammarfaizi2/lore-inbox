Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVKTXZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKTXZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVKTXZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:25:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43792 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932120AbVKTXZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:25:13 -0500
Date: Mon, 21 Nov 2005 00:25:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: lethal@linux-sh.org, rc@rc0.org.uk
Cc: linuxsh-shmedia-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-sh64/: "extern inline" -> "static inline"
Message-ID: <20051120232512.GK16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-sh64/io.h          |    8 ++++----
 include/asm-sh64/mmu_context.h |    2 +-
 include/asm-sh64/pgalloc.h     |   14 +++++++-------
 include/asm-sh64/pgtable.h     |   26 +++++++++++++-------------
 include/asm-sh64/processor.h   |    4 ++--
 include/asm-sh64/system.h      |    4 ++--
 include/asm-sh64/tlbflush.h    |    2 +-
 include/asm-sh64/uaccess.h     |    2 +-
 8 files changed, 31 insertions(+), 31 deletions(-)

--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/io.h.old	2005-11-20 19:46:54.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/io.h	2005-11-20 19:47:05.000000000 +0100
@@ -143,12 +143,12 @@
  * Change virtual addresses to physical addresses and vv.
  * These are trivial on the 1:1 Linux/SuperH mapping
  */
-extern __inline__ unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 	return __pa(address);
 }
 
-extern __inline__ void * phys_to_virt(unsigned long address)
+static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
 }
@@ -156,12 +156,12 @@
 extern void * __ioremap(unsigned long phys_addr, unsigned long size,
 			unsigned long flags);
 
-extern __inline__ void * ioremap(unsigned long phys_addr, unsigned long size)
+static inline void * ioremap(unsigned long phys_addr, unsigned long size)
 {
 	return __ioremap(phys_addr, size, 1);
 }
 
-extern __inline__ void * ioremap_nocache (unsigned long phys_addr, unsigned long size)
+static inline void * ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {
 	return __ioremap(phys_addr, size, 0);
 }
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/mmu_context.h.old	2005-11-20 19:47:15.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/mmu_context.h	2005-11-20 19:47:18.000000000 +0100
@@ -50,7 +50,7 @@
  */
 #define MMU_VPN_MASK	0xfffff000
 
-extern __inline__ void
+static inline void
 get_new_mmu_context(struct mm_struct *mm)
 {
 	extern void flush_tlb_all(void);
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/pgalloc.h.old	2005-11-20 19:47:27.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/pgalloc.h	2005-11-20 19:47:33.000000000 +0100
@@ -38,14 +38,14 @@
  * if any.
  */
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static inline pgd_t *get_pgd_slow(void)
 {
 	unsigned int pgd_size = (USER_PTRS_PER_PGD * sizeof(pgd_t));
 	pgd_t *ret = (pgd_t *)kmalloc(pgd_size, GFP_KERNEL);
 	return ret;
 }
 
-extern __inline__ pgd_t *get_pgd_fast(void)
+static inline pgd_t *get_pgd_fast(void)
 {
 	unsigned long *ret;
 
@@ -62,14 +62,14 @@
 	return (pgd_t *)ret;
 }
 
-extern __inline__ void free_pgd_fast(pgd_t *pgd)
+static inline void free_pgd_fast(pgd_t *pgd)
 {
 	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
 	pgd_quicklist = (unsigned long *) pgd;
 	pgtable_cache_size++;
 }
 
-extern __inline__ void free_pgd_slow(pgd_t *pgd)
+static inline void free_pgd_slow(pgd_t *pgd)
 {
 	kfree((void *)pgd);
 }
@@ -77,7 +77,7 @@
 extern pte_t *get_pte_slow(pmd_t *pmd, unsigned long address_preadjusted);
 extern pte_t *get_pte_kernel_slow(pmd_t *pmd, unsigned long address_preadjusted);
 
-extern __inline__ pte_t *get_pte_fast(void)
+static inline pte_t *get_pte_fast(void)
 {
 	unsigned long *ret;
 
@@ -89,7 +89,7 @@
 	return (pte_t *)ret;
 }
 
-extern __inline__ void free_pte_fast(pte_t *pte)
+static inline void free_pte_fast(pte_t *pte)
 {
 	*(unsigned long *)pte = (unsigned long) pte_quicklist;
 	pte_quicklist = (unsigned long *) pte;
@@ -167,7 +167,7 @@
 
 extern int do_check_pgt_cache(int, int);
 
-extern inline void set_pgdir(unsigned long address, pgd_t entry)
+static inline void set_pgdir(unsigned long address, pgd_t entry)
 {
 	struct task_struct * p;
 	pgd_t *pgd;
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/pgtable.h.old	2005-11-20 19:47:43.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/pgtable.h	2005-11-20 19:47:48.000000000 +0100
@@ -421,18 +421,18 @@
 static inline int pte_file(pte_t pte) { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_write(pte_t pte){ return pte_val(pte) & _PAGE_WRITE; }
 
-extern inline pte_t pte_rdprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_READ)); return pte; }
-extern inline pte_t pte_wrprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_WRITE)); return pte; }
-extern inline pte_t pte_exprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_EXECUTE)); return pte; }
-extern inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }
-extern inline pte_t pte_mkold(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_ACCESSED)); return pte; }
-
-extern inline pte_t pte_mkread(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_READ)); return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_WRITE)); return pte; }
-extern inline pte_t pte_mkexec(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_EXECUTE)); return pte; }
-extern inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
-extern inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
-extern inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
+static inline pte_t pte_rdprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_READ)); return pte; }
+static inline pte_t pte_wrprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_WRITE)); return pte; }
+static inline pte_t pte_exprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_EXECUTE)); return pte; }
+static inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }
+static inline pte_t pte_mkold(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_ACCESSED)); return pte; }
+
+static inline pte_t pte_mkread(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_READ)); return pte; }
+static inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_WRITE)); return pte; }
+static inline pte_t pte_mkexec(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_EXECUTE)); return pte; }
+static inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
+static inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
+static inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
 
 
 /*
@@ -456,7 +456,7 @@
 #define mk_pte_phys(physpage, pgprot) \
 ({ pte_t __pte; set_pte(&__pte, __pte(physpage | pgprot_val(pgprot))); __pte; })
 
-extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { set_pte(&pte, __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot))); return pte; }
 
 typedef pte_t *pte_addr_t;
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/processor.h.old	2005-11-20 19:47:59.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/processor.h	2005-11-20 19:48:04.000000000 +0100
@@ -228,7 +228,7 @@
  * FPU lazy state save handling.
  */
 
-extern __inline__ void release_fpu(void)
+static inline void release_fpu(void)
 {
 	unsigned long long __dummy;
 
@@ -240,7 +240,7 @@
 			     : "r" (SR_FD));
 }
 
-extern __inline__ void grab_fpu(void)
+static inline void grab_fpu(void)
 {
 	unsigned long long __dummy;
 
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/system.h.old	2005-11-20 19:48:12.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/system.h	2005-11-20 19:48:16.000000000 +0100
@@ -132,7 +132,7 @@
 	(flags != 0);			\
 })
 
-extern __inline__ unsigned long xchg_u32(volatile int * m, unsigned long val)
+static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 {
 	unsigned long flags, retval;
 
@@ -143,7 +143,7 @@
 	return retval;
 }
 
-extern __inline__ unsigned long xchg_u8(volatile unsigned char * m, unsigned long val)
+static inline unsigned long xchg_u8(volatile unsigned char * m, unsigned long val)
 {
 	unsigned long flags, retval;
 
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/uaccess.h.old	2005-11-20 19:48:25.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/uaccess.h	2005-11-20 19:48:29.000000000 +0100
@@ -287,7 +287,7 @@
  */
 extern long __strnlen_user(const char *__s, long __n);
 
-extern __inline__ long strnlen_user(const char *s, long n)
+static inline long strnlen_user(const char *s, long n)
 {
 	if (!__addr_ok(s))
 		return 0;
--- linux-2.6.15-rc1-mm2-full/include/asm-sh64/tlbflush.h.old	2005-11-20 19:48:37.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-sh64/tlbflush.h	2005-11-20 19:48:43.000000000 +0100
@@ -20,7 +20,7 @@
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
 }

