Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVHXQBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVHXQBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVHXQBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:01:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35589 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751092AbVHXQBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:01:15 -0400
Date: Wed, 24 Aug 2005 18:01:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: schwidefsky@de.ibm.com
Cc: linux390@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] s390: "extern inline" -> "static inline"
Message-ID: <20050824160113.GG4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/s390/Debugging390.txt |    2 
 arch/s390/kernel/debug.c            |   12 ++--
 arch/s390/mm/fault.c                |    2 
 drivers/s390/char/keyboard.h        |    4 -
 drivers/s390/cio/ioasm.h            |   26 +++++-----
 drivers/s390/cio/qdio.h             |    8 +--
 drivers/s390/net/fsm.h              |    6 +-
 drivers/s390/s390mach.h             |    2 
 include/asm-s390/debug.h            |   16 +++---
 include/asm-s390/ebcdic.h           |    2 
 include/asm-s390/io.h               |    8 +--
 include/asm-s390/lowcore.h          |    2 
 include/asm-s390/mmu_context.h      |    2 
 include/asm-s390/pgtable.h          |   70 ++++++++++++++--------------
 include/asm-s390/sigp.h             |    6 +-
 include/asm-s390/smp.h              |    2 
 include/asm-s390/uaccess.h          |    2 
 17 files changed, 86 insertions(+), 86 deletions(-)

--- linux-2.6.13-rc6-mm2-full/Documentation/s390/Debugging390.txt.old	2005-08-24 16:45:00.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/Documentation/s390/Debugging390.txt	2005-08-24 16:45:11.000000000 +0200
@@ -871,7 +871,7 @@
 
 
 
-extern inline void spin_lock(spinlock_t *lp)
+static inline void spin_lock(spinlock_t *lp)
 {
       a0:       18 34           lr      %r3,%r4
       a2:       a7 3a 03 bc     ahi     %r3,956
--- linux-2.6.13-rc6-mm2-full/arch/s390/kernel/debug.c.old	2005-08-24 16:45:22.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/arch/s390/kernel/debug.c	2005-08-24 16:45:28.000000000 +0200
@@ -470,7 +470,7 @@
  * - goto next entry in p_info
  */
 
-extern inline int
+static inline int
 debug_next_entry(file_private_info_t *p_info)
 {
 	debug_info_t *id;
@@ -788,7 +788,7 @@
  * - set active entry to next in the ring buffer
  */
 
-extern inline void
+static inline void
 proceed_active_entry(debug_info_t * id)
 {
 	if ((id->active_entries[id->active_area] += id->entry_size)
@@ -805,7 +805,7 @@
  * - set active area to next in the ring buffer
  */
 
-extern inline void
+static inline void
 proceed_active_area(debug_info_t * id)
 {
 	id->active_area++;
@@ -816,7 +816,7 @@
  * get_active_entry:
  */
 
-extern inline debug_entry_t*
+static inline debug_entry_t*
 get_active_entry(debug_info_t * id)
 {
 	return (debug_entry_t *) (((char *) id->areas[id->active_area]
@@ -829,7 +829,7 @@
  * - set timestamp, caller address, cpu number etc.
  */
 
-extern inline void
+static inline void
 debug_finish_entry(debug_info_t * id, debug_entry_t* active, int level,
 			int exception)
 {
@@ -959,7 +959,7 @@
  * counts arguments in format string for sprintf view
  */
 
-extern inline int
+static inline int
 debug_count_numargs(char *string)
 {
 	int numargs=0;
--- linux-2.6.13-rc6-mm2-full/arch/s390/mm/fault.c.old	2005-08-24 16:45:36.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/arch/s390/mm/fault.c	2005-08-24 16:45:40.000000000 +0200
@@ -160,7 +160,7 @@
  *   11       Page translation     ->  Not present       (nullification)
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
-extern inline void
+static inline void
 do_exception(struct pt_regs *regs, unsigned long error_code, int is_protection)
 {
         struct task_struct *tsk;
--- linux-2.6.13-rc6-mm2-full/drivers/s390/char/keyboard.h.old	2005-08-24 16:45:49.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/s390/char/keyboard.h	2005-08-24 16:45:53.000000000 +0200
@@ -41,14 +41,14 @@
 /*
  * Helper Functions.
  */
-extern inline void
+static inline void
 kbd_put_queue(struct tty_struct *tty, int ch)
 {
 	tty_insert_flip_char(tty, ch, 0);
 	tty_schedule_flip(tty);
 }
 
-extern inline void
+static inline void
 kbd_puts_queue(struct tty_struct *tty, char *cp)
 {
 	while (*cp)
--- linux-2.6.13-rc6-mm2-full/drivers/s390/cio/ioasm.h.old	2005-08-24 16:46:01.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/s390/cio/ioasm.h	2005-08-24 16:46:08.000000000 +0200
@@ -21,7 +21,7 @@
  * Some S390 specific IO instructions as inline
  */
 
-extern __inline__ int stsch(int irq, volatile struct schib *addr)
+static inline int stsch(int irq, volatile struct schib *addr)
 {
 	int ccode;
 
@@ -36,7 +36,7 @@
 	return ccode;
 }
 
-extern __inline__ int msch(int irq, volatile struct schib *addr)
+static inline int msch(int irq, volatile struct schib *addr)
 {
 	int ccode;
 
@@ -51,7 +51,7 @@
 	return ccode;
 }
 
-extern __inline__ int msch_err(int irq, volatile struct schib *addr)
+static inline int msch_err(int irq, volatile struct schib *addr)
 {
 	int ccode;
 
@@ -79,7 +79,7 @@
 	return ccode;
 }
 
-extern __inline__ int tsch(int irq, volatile struct irb *addr)
+static inline int tsch(int irq, volatile struct irb *addr)
 {
 	int ccode;
 
@@ -94,7 +94,7 @@
 	return ccode;
 }
 
-extern __inline__ int tpi( volatile struct tpi_info *addr)
+static inline int tpi( volatile struct tpi_info *addr)
 {
 	int ccode;
 
@@ -108,7 +108,7 @@
 	return ccode;
 }
 
-extern __inline__ int ssch(int irq, volatile struct orb *addr)
+static inline int ssch(int irq, volatile struct orb *addr)
 {
 	int ccode;
 
@@ -123,7 +123,7 @@
 	return ccode;
 }
 
-extern __inline__ int rsch(int irq)
+static inline int rsch(int irq)
 {
 	int ccode;
 
@@ -138,7 +138,7 @@
 	return ccode;
 }
 
-extern __inline__ int csch(int irq)
+static inline int csch(int irq)
 {
 	int ccode;
 
@@ -153,7 +153,7 @@
 	return ccode;
 }
 
-extern __inline__ int hsch(int irq)
+static inline int hsch(int irq)
 {
 	int ccode;
 
@@ -168,7 +168,7 @@
 	return ccode;
 }
 
-extern __inline__ int xsch(int irq)
+static inline int xsch(int irq)
 {
 	int ccode;
 
@@ -183,7 +183,7 @@
 	return ccode;
 }
 
-extern __inline__ int chsc(void *chsc_area)
+static inline int chsc(void *chsc_area)
 {
 	int cc;
 
@@ -198,7 +198,7 @@
 	return cc;
 }
 
-extern __inline__ int iac( void)
+static inline int iac( void)
 {
 	int ccode;
 
@@ -210,7 +210,7 @@
 	return ccode;
 }
 
-extern __inline__ int rchp(int chpid)
+static inline int rchp(int chpid)
 {
 	int ccode;
 
--- linux-2.6.13-rc6-mm2-full/drivers/s390/cio/qdio.h.old	2005-08-24 16:47:04.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/s390/cio/qdio.h	2005-08-24 16:47:09.000000000 +0200
@@ -265,7 +265,7 @@
 /*
  * Some instructions as assembly
  */
-extern __inline__ int 
+static inline int 
 do_siga_sync(unsigned int irq, unsigned int mask1, unsigned int mask2)
 {
 	int cc;
@@ -300,7 +300,7 @@
 	return cc;
 }
 
-extern __inline__ int
+static inline int
 do_siga_input(unsigned int irq, unsigned int mask)
 {
 	int cc;
@@ -334,7 +334,7 @@
 	return cc;
 }
 
-extern __inline__ int
+static inline int
 do_siga_output(unsigned long irq, unsigned long mask, __u32 *bb)
 {
 	int cc;
@@ -401,7 +401,7 @@
 	return cc;
 }
 
-extern __inline__ unsigned long
+static inline unsigned long
 do_clear_global_summary(void)
 {
 
--- linux-2.6.13-rc6-mm2-full/drivers/s390/net/fsm.h.old	2005-08-24 16:47:19.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/s390/net/fsm.h	2005-08-24 16:47:23.000000000 +0200
@@ -140,7 +140,7 @@
  *              1  if current state or event is out of range
  *              !0 if state and event in range, but no action defined.
  */
-extern __inline__ int
+static inline int
 fsm_event(fsm_instance *fi, int event, void *arg)
 {
 	fsm_function_t r;
@@ -188,7 +188,7 @@
  * @param fi    Pointer to FSM
  * @param state The new state for this FSM.
  */
-extern __inline__ void
+static inline void
 fsm_newstate(fsm_instance *fi, int newstate)
 {
 	atomic_set(&fi->state,newstate);
@@ -208,7 +208,7 @@
  *
  * @return The current state of the FSM.
  */
-extern __inline__ int
+static inline int
 fsm_getstate(fsm_instance *fi)
 {
 	return atomic_read(&fi->state);
--- linux-2.6.13-rc6-mm2-full/drivers/s390/s390mach.h.old	2005-08-24 16:47:31.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/s390/s390mach.h	2005-08-24 16:47:36.000000000 +0200
@@ -88,7 +88,7 @@
 #define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
 #define CRW_ERC_PMOD     0x08 /* installed parameters modified */
 
-extern __inline__ int stcrw(struct crw *pcrw )
+static inline int stcrw(struct crw *pcrw )
 {
         int ccode;
 
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/debug.h.old	2005-08-24 16:47:44.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/debug.h	2005-08-24 16:47:49.000000000 +0200
@@ -131,7 +131,7 @@
 
 void debug_stop_all(void);
 
-extern inline debug_entry_t* 
+static inline debug_entry_t* 
 debug_event(debug_info_t* id, int level, void* data, int length)
 {
 	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
@@ -139,7 +139,7 @@
         return debug_event_common(id,level,data,length);
 }
 
-extern inline debug_entry_t* 
+static inline debug_entry_t* 
 debug_int_event(debug_info_t* id, int level, unsigned int tag)
 {
         unsigned int t=tag;
@@ -148,7 +148,7 @@
         return debug_event_common(id,level,&t,sizeof(unsigned int));
 }
 
-extern inline debug_entry_t *
+static inline debug_entry_t *
 debug_long_event (debug_info_t* id, int level, unsigned long tag)
 {
         unsigned long t=tag;
@@ -157,7 +157,7 @@
         return debug_event_common(id,level,&t,sizeof(unsigned long));
 }
 
-extern inline debug_entry_t* 
+static inline debug_entry_t* 
 debug_text_event(debug_info_t* id, int level, const char* txt)
 {
 	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
@@ -170,7 +170,7 @@
 	__attribute__ ((format(printf, 3, 4)));
 
 
-extern inline debug_entry_t* 
+static inline debug_entry_t* 
 debug_exception(debug_info_t* id, int level, void* data, int length)
 {
 	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
@@ -178,7 +178,7 @@
         return debug_exception_common(id,level,data,length);
 }
 
-extern inline debug_entry_t* 
+static inline debug_entry_t* 
 debug_int_exception(debug_info_t* id, int level, unsigned int tag)
 {
         unsigned int t=tag;
@@ -187,7 +187,7 @@
         return debug_exception_common(id,level,&t,sizeof(unsigned int));
 }
 
-extern inline debug_entry_t * 
+static inline debug_entry_t * 
 debug_long_exception (debug_info_t* id, int level, unsigned long tag)
 {
         unsigned long t=tag;
@@ -196,7 +196,7 @@
         return debug_exception_common(id,level,&t,sizeof(unsigned long));
 }
 
-extern inline debug_entry_t* 
+static inline debug_entry_t* 
 debug_text_exception(debug_info_t* id, int level, const char* txt)
 {
 	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/ebcdic.h.old	2005-08-24 16:51:01.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/ebcdic.h	2005-08-24 16:51:07.000000000 +0200
@@ -21,7 +21,7 @@
 extern __u8 _ebc_tolower[]; /* EBCDIC -> lowercase */
 extern __u8 _ebc_toupper[]; /* EBCDIC -> uppercase */
 
-extern __inline__ void
+static inline void
 codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
 {
 	if (nr-- <= 0)
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/io.h.old	2005-08-24 16:48:37.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/io.h	2005-08-24 16:48:42.000000000 +0200
@@ -24,7 +24,7 @@
  * Change virtual addresses to physical addresses and vv.
  * These are pretty trivial
  */
-extern inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile void * address)
 {
 	unsigned long real_address;
 	__asm__ (
@@ -42,7 +42,7 @@
         return real_address;
 }
 
-extern inline void * phys_to_virt(unsigned long address)
+static inline void * phys_to_virt(unsigned long address)
 {
         return __io_virt(address);
 }
@@ -54,7 +54,7 @@
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
-extern inline void * ioremap (unsigned long offset, unsigned long size)
+static inline void * ioremap (unsigned long offset, unsigned long size)
 {
         return __ioremap(offset, size, 0);
 }
@@ -64,7 +64,7 @@
  * it's useful if some control registers are in such an area and write combining
  * or read caching is not desirable:
  */
-extern inline void * ioremap_nocache (unsigned long offset, unsigned long size)
+static inline void * ioremap_nocache (unsigned long offset, unsigned long size)
 {
         return __ioremap(offset, size, 0);
 }
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/lowcore.h.old	2005-08-24 16:48:52.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/lowcore.h	2005-08-24 16:48:56.000000000 +0200
@@ -342,7 +342,7 @@
 #define S390_lowcore (*((struct _lowcore *) 0))
 extern struct _lowcore *lowcore_ptr[];
 
-extern __inline__ void set_prefix(__u32 address)
+static inline void set_prefix(__u32 address)
 {
         __asm__ __volatile__ ("spx %0" : : "m" (address) : "memory" );
 }
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/mmu_context.h.old	2005-08-24 16:49:10.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/mmu_context.h	2005-08-24 16:49:15.000000000 +0200
@@ -44,7 +44,7 @@
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
-extern inline void activate_mm(struct mm_struct *prev,
+static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
         switch_mm(prev, next, current);
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/pgtable.h.old	2005-08-24 16:49:28.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/pgtable.h	2005-08-24 16:49:38.000000000 +0200
@@ -318,7 +318,7 @@
  * within a page table are directly modified.  Thus, the following
  * hook is made available.
  */
-extern inline void set_pte(pte_t *pteptr, pte_t pteval)
+static inline void set_pte(pte_t *pteptr, pte_t pteval)
 {
 	*pteptr = pteval;
 }
@@ -329,63 +329,63 @@
  */
 #ifndef __s390x__
 
-extern inline int pgd_present(pgd_t pgd) { return 1; }
-extern inline int pgd_none(pgd_t pgd)    { return 0; }
-extern inline int pgd_bad(pgd_t pgd)     { return 0; }
-
-extern inline int pmd_present(pmd_t pmd) { return pmd_val(pmd) & _SEG_PRESENT; }
-extern inline int pmd_none(pmd_t pmd)    { return pmd_val(pmd) & _PAGE_TABLE_INV; }
-extern inline int pmd_bad(pmd_t pmd)
+static inline int pgd_present(pgd_t pgd) { return 1; }
+static inline int pgd_none(pgd_t pgd)    { return 0; }
+static inline int pgd_bad(pgd_t pgd)     { return 0; }
+
+static inline int pmd_present(pmd_t pmd) { return pmd_val(pmd) & _SEG_PRESENT; }
+static inline int pmd_none(pmd_t pmd)    { return pmd_val(pmd) & _PAGE_TABLE_INV; }
+static inline int pmd_bad(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (~PAGE_MASK & ~_PAGE_TABLE_INV)) != _PAGE_TABLE;
 }
 
 #else /* __s390x__ */
 
-extern inline int pgd_present(pgd_t pgd)
+static inline int pgd_present(pgd_t pgd)
 {
 	return (pgd_val(pgd) & ~PAGE_MASK) == _PGD_ENTRY;
 }
 
-extern inline int pgd_none(pgd_t pgd)
+static inline int pgd_none(pgd_t pgd)
 {
 	return pgd_val(pgd) & _PGD_ENTRY_INV;
 }
 
-extern inline int pgd_bad(pgd_t pgd)
+static inline int pgd_bad(pgd_t pgd)
 {
 	return (pgd_val(pgd) & (~PAGE_MASK & ~_PGD_ENTRY_INV)) != _PGD_ENTRY;
 }
 
-extern inline int pmd_present(pmd_t pmd)
+static inline int pmd_present(pmd_t pmd)
 {
 	return (pmd_val(pmd) & ~PAGE_MASK) == _PMD_ENTRY;
 }
 
-extern inline int pmd_none(pmd_t pmd)
+static inline int pmd_none(pmd_t pmd)
 {
 	return pmd_val(pmd) & _PMD_ENTRY_INV;
 }
 
-extern inline int pmd_bad(pmd_t pmd)
+static inline int pmd_bad(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (~PAGE_MASK & ~_PMD_ENTRY_INV)) != _PMD_ENTRY;
 }
 
 #endif /* __s390x__ */
 
-extern inline int pte_none(pte_t pte)
+static inline int pte_none(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_EMPTY;
 }
 
-extern inline int pte_present(pte_t pte)
+static inline int pte_present(pte_t pte)
 {
 	return !(pte_val(pte) & _PAGE_INVALID) ||
 		(pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_NONE;
 }
 
-extern inline int pte_file(pte_t pte)
+static inline int pte_file(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_FILE;
 }
@@ -396,12 +396,12 @@
  * query functions pte_write/pte_dirty/pte_young only work if
  * pte_present() is true. Undefined behaviour if not..
  */
-extern inline int pte_write(pte_t pte)
+static inline int pte_write(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_RO) == 0;
 }
 
-extern inline int pte_dirty(pte_t pte)
+static inline int pte_dirty(pte_t pte)
 {
 	/* A pte is neither clean nor dirty on s/390. The dirty bit
 	 * is in the storage key. See page_test_and_clear_dirty for
@@ -410,7 +410,7 @@
 	return 0;
 }
 
-extern inline int pte_young(pte_t pte)
+static inline int pte_young(pte_t pte)
 {
 	/* A pte is neither young nor old on s/390. The young bit
 	 * is in the storage key. See page_test_and_clear_young for
@@ -419,7 +419,7 @@
 	return 0;
 }
 
-extern inline int pte_read(pte_t pte)
+static inline int pte_read(pte_t pte)
 {
 	/* All pages are readable since we don't use the fetch
 	 * protection bit in the storage key.
@@ -433,9 +433,9 @@
 
 #ifndef __s390x__
 
-extern inline void pgd_clear(pgd_t * pgdp)      { }
+static inline void pgd_clear(pgd_t * pgdp)      { }
 
-extern inline void pmd_clear(pmd_t * pmdp)
+static inline void pmd_clear(pmd_t * pmdp)
 {
 	pmd_val(pmdp[0]) = _PAGE_TABLE_INV;
 	pmd_val(pmdp[1]) = _PAGE_TABLE_INV;
@@ -445,12 +445,12 @@
 
 #else /* __s390x__ */
 
-extern inline void pgd_clear(pgd_t * pgdp)
+static inline void pgd_clear(pgd_t * pgdp)
 {
 	pgd_val(*pgdp) = _PGD_ENTRY_INV | _PGD_ENTRY;
 }
 
-extern inline void pmd_clear(pmd_t * pmdp)
+static inline void pmd_clear(pmd_t * pmdp)
 {
 	pmd_val(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
 	pmd_val1(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
@@ -458,7 +458,7 @@
 
 #endif /* __s390x__ */
 
-extern inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_val(*ptep) = _PAGE_INVALID_EMPTY;
 }
@@ -467,14 +467,14 @@
  * The following pte modification functions only work if
  * pte_present() is true. Undefined behaviour if not..
  */
-extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) &= PAGE_MASK;
 	pte_val(pte) |= pgprot_val(newprot);
 	return pte;
 }
 
-extern inline pte_t pte_wrprotect(pte_t pte)
+static inline pte_t pte_wrprotect(pte_t pte)
 {
 	/* Do not clobber _PAGE_INVALID_NONE pages!  */
 	if (!(pte_val(pte) & _PAGE_INVALID))
@@ -482,13 +482,13 @@
 	return pte;
 }
 
-extern inline pte_t pte_mkwrite(pte_t pte) 
+static inline pte_t pte_mkwrite(pte_t pte) 
 {
 	pte_val(pte) &= ~_PAGE_RO;
 	return pte;
 }
 
-extern inline pte_t pte_mkclean(pte_t pte)
+static inline pte_t pte_mkclean(pte_t pte)
 {
 	/* The only user of pte_mkclean is the fork() code.
 	   We must *not* clear the *physical* page dirty bit
@@ -497,7 +497,7 @@
 	return pte;
 }
 
-extern inline pte_t pte_mkdirty(pte_t pte)
+static inline pte_t pte_mkdirty(pte_t pte)
 {
 	/* We do not explicitly set the dirty bit because the
 	 * sske instruction is slow. It is faster to let the
@@ -506,7 +506,7 @@
 	return pte;
 }
 
-extern inline pte_t pte_mkold(pte_t pte)
+static inline pte_t pte_mkold(pte_t pte)
 {
 	/* S/390 doesn't keep its dirty/referenced bit in the pte.
 	 * There is no point in clearing the real referenced bit.
@@ -514,7 +514,7 @@
 	return pte;
 }
 
-extern inline pte_t pte_mkyoung(pte_t pte)
+static inline pte_t pte_mkyoung(pte_t pte)
 {
 	/* S/390 doesn't keep its dirty/referenced bit in the pte.
 	 * There is no point in setting the real referenced bit.
@@ -694,7 +694,7 @@
 #ifndef __s390x__
 
 /* Find an entry in the second-level page table.. */
-extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
+static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
         return (pmd_t *) dir;
 }
@@ -757,7 +757,7 @@
 #else
 #define __SWP_OFFSET_MASK (~0UL >> 11)
 #endif
-extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
+static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
 	offset &= __SWP_OFFSET_MASK;
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/sigp.h.old	2005-08-24 16:49:46.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/sigp.h	2005-08-24 16:49:51.000000000 +0200
@@ -67,7 +67,7 @@
 /*
  * Signal processor
  */
-extern __inline__ sigp_ccode
+static inline sigp_ccode
 signal_processor(__u16 cpu_addr, sigp_order_code order_code)
 {
 	sigp_ccode ccode;
@@ -86,7 +86,7 @@
 /*
  * Signal processor with parameter
  */
-extern __inline__ sigp_ccode
+static inline sigp_ccode
 signal_processor_p(__u32 parameter, __u16 cpu_addr,
 		   sigp_order_code order_code)
 {
@@ -107,7 +107,7 @@
 /*
  * Signal processor with parameter and return status
  */
-extern __inline__ sigp_ccode
+static inline sigp_ccode
 signal_processor_ps(__u32 *statusptr, __u32 parameter,
 		    __u16 cpu_addr, sigp_order_code order_code)
 {
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/smp.h.old	2005-08-24 16:50:00.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/smp.h	2005-08-24 16:50:04.000000000 +0200
@@ -52,7 +52,7 @@
 extern int smp_get_cpu(cpumask_t cpu_map);
 extern void smp_put_cpu(int cpu);
 
-extern __inline__ __u16 hard_smp_processor_id(void)
+static inline __u16 hard_smp_processor_id(void)
 {
         __u16 cpu_address;
  
--- linux-2.6.13-rc6-mm2-full/include/asm-s390/uaccess.h.old	2005-08-24 16:50:14.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/asm-s390/uaccess.h	2005-08-24 16:50:19.000000000 +0200
@@ -66,7 +66,7 @@
 #define access_ok(type,addr,size) __access_ok(addr,size)
 
 /* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user *addr,
+static inline int __deprecated verify_area(int type, const void __user *addr,
 						unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;

