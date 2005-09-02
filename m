Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVIBUY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVIBUY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVIBUY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:24:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50954 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750859AbVIBUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:24:55 -0400
Date: Fri, 2 Sep 2005 22:24:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: wli@holomorphy.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sparc: "extern inline" -> "static inline"
Message-ID: <20050902202444.GS3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/sparc/kernel/time.c      |    2 +-
 arch/sparc/mm/srmmu.c         |    2 +-
 include/asm-sparc/btfixup.h   |   12 ++++++------
 include/asm-sparc/cache.h     |   18 +++++++++---------
 include/asm-sparc/cypress.h   |    8 ++++----
 include/asm-sparc/delay.h     |    2 +-
 include/asm-sparc/dma.h       |    2 +-
 include/asm-sparc/iommu.h     |    4 ++--
 include/asm-sparc/kdebug.h    |    2 +-
 include/asm-sparc/mbus.h      |    4 ++--
 include/asm-sparc/msi.h       |    2 +-
 include/asm-sparc/mxcc.h      |    8 ++++----
 include/asm-sparc/obio.h      |   30 +++++++++++++++---------------
 include/asm-sparc/pci.h       |    6 +++---
 include/asm-sparc/pgtable.h   |   28 ++++++++++++++--------------
 include/asm-sparc/pgtsrmmu.h  |   30 +++++++++++++++---------------
 include/asm-sparc/processor.h |    2 +-
 include/asm-sparc/psr.h       |    6 +++---
 include/asm-sparc/sbi.h       |   10 +++++-----
 include/asm-sparc/sbus.h      |    6 +++---
 include/asm-sparc/smp.h       |   26 +++++++++++++-------------
 include/asm-sparc/smpprim.h   |    8 ++++----
 include/asm-sparc/spinlock.h  |   10 +++++-----
 include/asm-sparc/system.h    |    2 +-
 include/asm-sparc/traps.h     |    2 +-
 25 files changed, 116 insertions(+), 116 deletions(-)

--- linux-2.6.13-mm1-full/arch/sparc/kernel/time.c.old	2005-09-02 22:13:04.000000000 +0200
+++ linux-2.6.13-mm1-full/arch/sparc/kernel/time.c	2005-09-02 22:13:17.000000000 +0200
@@ -457,7 +457,7 @@
 	sbus_time_init();
 }
 
-extern __inline__ unsigned long do_gettimeoffset(void)
+static inline unsigned long do_gettimeoffset(void)
 {
 	return (*master_l10_counter >> 10) & 0x1fffff;
 }
--- linux-2.6.13-mm1-full/arch/sparc/mm/srmmu.c.old	2005-09-02 22:13:29.000000000 +0200
+++ linux-2.6.13-mm1-full/arch/sparc/mm/srmmu.c	2005-09-02 22:13:47.000000000 +0200
@@ -260,7 +260,7 @@
 { return __pte((pte_val(pte) & SRMMU_CHG_MASK) | pgprot_val(newprot)); }
 
 /* to find an entry in a top-level page table... */
-extern inline pgd_t *srmmu_pgd_offset(struct mm_struct * mm, unsigned long address)
+static inline pgd_t *srmmu_pgd_offset(struct mm_struct * mm, unsigned long address)
 { return mm->pgd + (address >> SRMMU_PGDIR_SHIFT); }
 
 /* Find an entry in the second-level page table.. */
--- linux-2.6.13-mm1-full/include/asm-sparc/btfixup.h.old	2005-09-02 22:13:56.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/btfixup.h	2005-09-02 22:14:03.000000000 +0200
@@ -51,7 +51,7 @@
 #define BTFIXUPDEF_SIMM13(__name)							\
 	extern unsigned int ___sf_##__name(void) __attribute_const__;		\
 	extern unsigned ___ss_##__name[2];						\
-	extern __inline__ unsigned int ___sf_##__name(void) {				\
+	static inline unsigned int ___sf_##__name(void) {				\
 		unsigned int ret;							\
 		__asm__ ("or %%g0, ___s_" #__name ", %0" : "=r"(ret));			\
 		return ret;								\
@@ -59,7 +59,7 @@
 #define BTFIXUPDEF_SIMM13_INIT(__name,__val)						\
 	extern unsigned int ___sf_##__name(void) __attribute_const__;		\
 	extern unsigned ___ss_##__name[2];						\
-	extern __inline__ unsigned int ___sf_##__name(void) {				\
+	static inline unsigned int ___sf_##__name(void) {				\
 		unsigned int ret;							\
 		__asm__ ("or %%g0, ___s_" #__name "__btset_" #__val ", %0" : "=r"(ret));\
 		return ret;								\
@@ -73,7 +73,7 @@
 #define BTFIXUPDEF_HALF(__name)								\
 	extern unsigned int ___af_##__name(void) __attribute_const__;		\
 	extern unsigned ___as_##__name[2];						\
-	extern __inline__ unsigned int ___af_##__name(void) {				\
+	static inline unsigned int ___af_##__name(void) {				\
 		unsigned int ret;							\
 		__asm__ ("or %%g0, ___a_" #__name ", %0" : "=r"(ret));			\
 		return ret;								\
@@ -81,7 +81,7 @@
 #define BTFIXUPDEF_HALF_INIT(__name,__val)						\
 	extern unsigned int ___af_##__name(void) __attribute_const__;		\
 	extern unsigned ___as_##__name[2];						\
-	extern __inline__ unsigned int ___af_##__name(void) {				\
+	static inline unsigned int ___af_##__name(void) {				\
 		unsigned int ret;							\
 		__asm__ ("or %%g0, ___a_" #__name "__btset_" #__val ", %0" : "=r"(ret));\
 		return ret;								\
@@ -92,7 +92,7 @@
 #define BTFIXUPDEF_SETHI(__name)							\
 	extern unsigned int ___hf_##__name(void) __attribute_const__;		\
 	extern unsigned ___hs_##__name[2];						\
-	extern __inline__ unsigned int ___hf_##__name(void) {				\
+	static inline unsigned int ___hf_##__name(void) {				\
 		unsigned int ret;							\
 		__asm__ ("sethi %%hi(___h_" #__name "), %0" : "=r"(ret));		\
 		return ret;								\
@@ -100,7 +100,7 @@
 #define BTFIXUPDEF_SETHI_INIT(__name,__val)						\
 	extern unsigned int ___hf_##__name(void) __attribute_const__;		\
 	extern unsigned ___hs_##__name[2];						\
-	extern __inline__ unsigned int ___hf_##__name(void) {				\
+	static inline unsigned int ___hf_##__name(void) {				\
 		unsigned int ret;							\
 		__asm__ ("sethi %%hi(___h_" #__name "__btset_" #__val "), %0" : 	\
 			 "=r"(ret));							\
--- linux-2.6.13-mm1-full/include/asm-sparc/cache.h.old	2005-09-02 22:14:11.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/cache.h	2005-09-02 22:14:15.000000000 +0200
@@ -27,7 +27,7 @@
  */
 
 /* First, cache-tag access. */
-extern __inline__ unsigned int get_icache_tag(int setnum, int tagnum)
+static inline unsigned int get_icache_tag(int setnum, int tagnum)
 {
 	unsigned int vaddr, retval;
 
@@ -38,7 +38,7 @@
 	return retval;
 }
 
-extern __inline__ void put_icache_tag(int setnum, int tagnum, unsigned int entry)
+static inline void put_icache_tag(int setnum, int tagnum, unsigned int entry)
 {
 	unsigned int vaddr;
 
@@ -51,7 +51,7 @@
 /* Second cache-data access.  The data is returned two-32bit quantities
  * at a time.
  */
-extern __inline__ void get_icache_data(int setnum, int tagnum, int subblock,
+static inline void get_icache_data(int setnum, int tagnum, int subblock,
 				       unsigned int *data)
 {
 	unsigned int value1, value2, vaddr;
@@ -67,7 +67,7 @@
 	data[0] = value1; data[1] = value2;
 }
 
-extern __inline__ void put_icache_data(int setnum, int tagnum, int subblock,
+static inline void put_icache_data(int setnum, int tagnum, int subblock,
 				       unsigned int *data)
 {
 	unsigned int value1, value2, vaddr;
@@ -92,35 +92,35 @@
  */
 
 /* Flushes which clear out both the on-chip and external caches */
-extern __inline__ void flush_ei_page(unsigned int addr)
+static inline void flush_ei_page(unsigned int addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_PAGE) :
 			     "memory");
 }
 
-extern __inline__ void flush_ei_seg(unsigned int addr)
+static inline void flush_ei_seg(unsigned int addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_SEG) :
 			     "memory");
 }
 
-extern __inline__ void flush_ei_region(unsigned int addr)
+static inline void flush_ei_region(unsigned int addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_REGION) :
 			     "memory");
 }
 
-extern __inline__ void flush_ei_ctx(unsigned int addr)
+static inline void flush_ei_ctx(unsigned int addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_CTX) :
 			     "memory");
 }
 
-extern __inline__ void flush_ei_user(unsigned int addr)
+static inline void flush_ei_user(unsigned int addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_USER) :
--- linux-2.6.13-mm1-full/include/asm-sparc/cypress.h.old	2005-09-02 22:14:24.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/cypress.h	2005-09-02 22:14:31.000000000 +0200
@@ -48,25 +48,25 @@
 #define CYPRESS_NFAULT    0x00000002
 #define CYPRESS_MENABLE   0x00000001
 
-extern __inline__ void cypress_flush_page(unsigned long page)
+static inline void cypress_flush_page(unsigned long page)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (page), "i" (ASI_M_FLUSH_PAGE));
 }
 
-extern __inline__ void cypress_flush_segment(unsigned long addr)
+static inline void cypress_flush_segment(unsigned long addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_SEG));
 }
 
-extern __inline__ void cypress_flush_region(unsigned long addr)
+static inline void cypress_flush_region(unsigned long addr)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
 			     "r" (addr), "i" (ASI_M_FLUSH_REGION));
 }
 
-extern __inline__ void cypress_flush_context(void)
+static inline void cypress_flush_context(void)
 {
 	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
 			     "i" (ASI_M_FLUSH_CTX));
--- linux-2.6.13-mm1-full/include/asm-sparc/delay.h.old	2005-09-02 22:14:39.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/delay.h	2005-09-02 22:14:43.000000000 +0200
@@ -10,7 +10,7 @@
 #include <linux/config.h>
 #include <asm/cpudata.h>
 
-extern __inline__ void __delay(unsigned long loops)
+static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__("cmp %0, 0\n\t"
 			     "1: bne 1b\n\t"
--- linux-2.6.13-mm1-full/include/asm-sparc/dma.h.old	2005-09-02 22:14:51.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/dma.h	2005-09-02 22:14:55.000000000 +0200
@@ -198,7 +198,7 @@
 /* Pause until counter runs out or BIT isn't set in the DMA condition
  * register.
  */
-extern __inline__ void sparc_dma_pause(struct sparc_dma_registers *regs,
+static inline void sparc_dma_pause(struct sparc_dma_registers *regs,
 				       unsigned long bit)
 {
 	int ctr = 50000;   /* Let's find some bugs ;) */
--- linux-2.6.13-mm1-full/include/asm-sparc/iommu.h.old	2005-09-02 22:15:05.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/iommu.h	2005-09-02 22:15:10.000000000 +0200
@@ -108,12 +108,12 @@
 	struct bit_map usemap;
 };
 
-extern __inline__ void iommu_invalidate(struct iommu_regs *regs)
+static inline void iommu_invalidate(struct iommu_regs *regs)
 {
 	regs->tlbflush = 0;
 }
 
-extern __inline__ void iommu_invalidate_page(struct iommu_regs *regs, unsigned long ba)
+static inline void iommu_invalidate_page(struct iommu_regs *regs, unsigned long ba)
 {
 	regs->pageflush = (ba & PAGE_MASK);
 }
--- linux-2.6.13-mm1-full/include/asm-sparc/kdebug.h.old	2005-09-02 22:15:18.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/kdebug.h	2005-09-02 22:15:23.000000000 +0200
@@ -46,7 +46,7 @@
 extern struct kernel_debug *linux_dbvec;
 
 /* Use this macro in C-code to enter the debugger. */
-extern __inline__ void sp_enter_debugger(void)
+static inline void sp_enter_debugger(void)
 {
 	__asm__ __volatile__("jmpl %0, %%o7\n\t"
 			     "nop\n\t" : :
--- linux-2.6.13-mm1-full/include/asm-sparc/mbus.h.old	2005-09-02 22:15:32.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/mbus.h	2005-09-02 22:15:36.000000000 +0200
@@ -83,7 +83,7 @@
  */
 #define TBR_ID_SHIFT            20
 
-extern __inline__ int get_cpuid(void)
+static inline int get_cpuid(void)
 {
 	register int retval;
 	__asm__ __volatile__("rd %%tbr, %0\n\t"
@@ -93,7 +93,7 @@
 	return (retval & 3);
 }
 
-extern __inline__ int get_modid(void)
+static inline int get_modid(void)
 {
 	return (get_cpuid() | 0x8);
 }
--- linux-2.6.13-mm1-full/include/asm-sparc/msi.h.old	2005-09-02 22:15:48.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/msi.h	2005-09-02 22:15:52.000000000 +0200
@@ -19,7 +19,7 @@
 #define MSI_ASYNC_MODE  0x80000000	/* Operate the MSI asynchronously */
 
 
-extern __inline__ void msi_set_sync(void)
+static inline void msi_set_sync(void)
 {
 	__asm__ __volatile__ ("lda [%0] %1, %%g3\n\t"
 			      "andn %%g3, %2, %%g3\n\t"
--- linux-2.6.13-mm1-full/include/asm-sparc/mxcc.h.old	2005-09-02 22:15:59.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/mxcc.h	2005-09-02 22:16:04.000000000 +0200
@@ -85,7 +85,7 @@
 
 #ifndef __ASSEMBLY__
 
-extern __inline__ void mxcc_set_stream_src(unsigned long *paddr)
+static inline void mxcc_set_stream_src(unsigned long *paddr)
 {
 	unsigned long data0 = paddr[0];
 	unsigned long data1 = paddr[1];
@@ -98,7 +98,7 @@
 			      "i" (ASI_M_MXCC) : "g2", "g3");
 }
 
-extern __inline__ void mxcc_set_stream_dst(unsigned long *paddr)
+static inline void mxcc_set_stream_dst(unsigned long *paddr)
 {
 	unsigned long data0 = paddr[0];
 	unsigned long data1 = paddr[1];
@@ -111,7 +111,7 @@
 			      "i" (ASI_M_MXCC) : "g2", "g3");
 }
 
-extern __inline__ unsigned long mxcc_get_creg(void)
+static inline unsigned long mxcc_get_creg(void)
 {
 	unsigned long mxcc_control;
 
@@ -125,7 +125,7 @@
 	return mxcc_control;
 }
 
-extern __inline__ void mxcc_set_creg(unsigned long mxcc_control)
+static inline void mxcc_set_creg(unsigned long mxcc_control)
 {
 	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
 			     "r" (mxcc_control), "r" (MXCC_CREG),
--- linux-2.6.13-mm1-full/include/asm-sparc/obio.h.old	2005-09-02 22:16:16.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/obio.h	2005-09-02 22:16:21.000000000 +0200
@@ -98,7 +98,7 @@
 
 #ifndef __ASSEMBLY__
 
-extern __inline__ int bw_get_intr_mask(int sbus_level)
+static inline int bw_get_intr_mask(int sbus_level)
 {
 	int mask;
 	
@@ -109,7 +109,7 @@
 	return mask;
 }
 
-extern __inline__ void bw_clear_intr_mask(int sbus_level, int mask)
+static inline void bw_clear_intr_mask(int sbus_level, int mask)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (mask),
@@ -117,7 +117,7 @@
 			      "i" (ASI_M_CTL));
 }
 
-extern __inline__ unsigned bw_get_prof_limit(int cpu)
+static inline unsigned bw_get_prof_limit(int cpu)
 {
 	unsigned limit;
 	
@@ -128,7 +128,7 @@
 	return limit;
 }
 
-extern __inline__ void bw_set_prof_limit(int cpu, unsigned limit)
+static inline void bw_set_prof_limit(int cpu, unsigned limit)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (limit),
@@ -136,7 +136,7 @@
 			      "i" (ASI_M_CTL));
 }
 
-extern __inline__ unsigned bw_get_ctrl(int cpu)
+static inline unsigned bw_get_ctrl(int cpu)
 {
 	unsigned ctrl;
 	
@@ -147,7 +147,7 @@
 	return ctrl;
 }
 
-extern __inline__ void bw_set_ctrl(int cpu, unsigned ctrl)
+static inline void bw_set_ctrl(int cpu, unsigned ctrl)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (ctrl),
@@ -157,7 +157,7 @@
 
 extern unsigned char cpu_leds[32];
 
-extern __inline__ void show_leds(int cpuid)
+static inline void show_leds(int cpuid)
 {
 	cpuid &= 0x1e;
 	__asm__ __volatile__ ("stba %0, [%1] %2" : :
@@ -166,7 +166,7 @@
 			      "i" (ASI_M_CTL));
 }
 
-extern __inline__ unsigned cc_get_ipen(void)
+static inline unsigned cc_get_ipen(void)
 {
 	unsigned pending;
 	
@@ -177,7 +177,7 @@
 	return pending;
 }
 
-extern __inline__ void cc_set_iclr(unsigned clear)
+static inline void cc_set_iclr(unsigned clear)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (clear),
@@ -185,7 +185,7 @@
 			      "i" (ASI_M_MXCC));
 }
 
-extern __inline__ unsigned cc_get_imsk(void)
+static inline unsigned cc_get_imsk(void)
 {
 	unsigned mask;
 	
@@ -196,7 +196,7 @@
 	return mask;
 }
 
-extern __inline__ void cc_set_imsk(unsigned mask)
+static inline void cc_set_imsk(unsigned mask)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (mask),
@@ -204,7 +204,7 @@
 			      "i" (ASI_M_MXCC));
 }
 
-extern __inline__ unsigned cc_get_imsk_other(int cpuid)
+static inline unsigned cc_get_imsk_other(int cpuid)
 {
 	unsigned mask;
 	
@@ -215,7 +215,7 @@
 	return mask;
 }
 
-extern __inline__ void cc_set_imsk_other(int cpuid, unsigned mask)
+static inline void cc_set_imsk_other(int cpuid, unsigned mask)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (mask),
@@ -223,7 +223,7 @@
 			      "i" (ASI_M_CTL));
 }
 
-extern __inline__ void cc_set_igen(unsigned gen)
+static inline void cc_set_igen(unsigned gen)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (gen),
@@ -239,7 +239,7 @@
 #define IGEN_MESSAGE(bcast, devid, sid, levels) \
 	(((bcast) << 31) | ((devid) << 23) | ((sid) << 15) | (levels))
             
-extern __inline__ void sun4d_send_ipi(int cpu, int level)
+static inline void sun4d_send_ipi(int cpu, int level)
 {
 	cc_set_igen(IGEN_MESSAGE(0, cpu << 3, 6 + ((level >> 1) & 7), 1 << (level - 1)));
 }
--- linux-2.6.13-mm1-full/include/asm-sparc/pci.h.old	2005-09-02 22:16:31.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/pci.h	2005-09-02 22:16:36.000000000 +0200
@@ -15,12 +15,12 @@
 
 #define PCI_IRQ_NONE		0xffffffff
 
-extern inline void pcibios_set_master(struct pci_dev *dev)
+static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
 }
 
-extern inline void pcibios_penalize_isa_irq(int irq, int active)
+static inline void pcibios_penalize_isa_irq(int irq, int active)
 {
 	/* We don't do dynamic PCI IRQ allocation */
 }
@@ -137,7 +137,7 @@
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
+static inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	return 1;
 }
--- linux-2.6.13-mm1-full/include/asm-sparc/pgtable.h.old	2005-09-02 22:16:47.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/pgtable.h	2005-09-02 22:16:51.000000000 +0200
@@ -152,7 +152,7 @@
 BTFIXUPDEF_CALL(void, pte_clear, pte_t *)
 BTFIXUPDEF_CALL(int, pte_read, pte_t)
 
-extern __inline__ int pte_none(pte_t pte)
+static inline int pte_none(pte_t pte)
 {
 	return !(pte_val(pte) & ~BTFIXUP_SETHI(none_mask));
 }
@@ -165,7 +165,7 @@
 BTFIXUPDEF_CALL_CONST(int, pmd_present, pmd_t)
 BTFIXUPDEF_CALL(void, pmd_clear, pmd_t *)
 
-extern __inline__ int pmd_none(pmd_t pmd)
+static inline int pmd_none(pmd_t pmd)
 {
 	return !(pmd_val(pmd) & ~BTFIXUP_SETHI(none_mask));
 }
@@ -193,19 +193,19 @@
 BTFIXUPDEF_HALF(pte_youngi)
 
 extern int pte_write(pte_t pte) __attribute_const__;
-extern __inline__ int pte_write(pte_t pte)
+static inline int pte_write(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_writei);
 }
 
 extern int pte_dirty(pte_t pte) __attribute_const__;
-extern __inline__ int pte_dirty(pte_t pte)
+static inline int pte_dirty(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_dirtyi);
 }
 
 extern int pte_young(pte_t pte) __attribute_const__;
-extern __inline__ int pte_young(pte_t pte)
+static inline int pte_young(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_youngi);
 }
@@ -216,7 +216,7 @@
 BTFIXUPDEF_HALF(pte_filei)
 
 extern int pte_file(pte_t pte) __attribute_const__;
-extern __inline__ int pte_file(pte_t pte)
+static inline int pte_file(pte_t pte)
 {
 	return pte_val(pte) & BTFIXUP_HALF(pte_filei);
 }
@@ -228,19 +228,19 @@
 BTFIXUPDEF_HALF(pte_mkoldi)
 
 extern pte_t pte_wrprotect(pte_t pte) __attribute_const__;
-extern __inline__ pte_t pte_wrprotect(pte_t pte)
+static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_wrprotecti));
 }
 
 extern pte_t pte_mkclean(pte_t pte) __attribute_const__;
-extern __inline__ pte_t pte_mkclean(pte_t pte)
+static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkcleani));
 }
 
 extern pte_t pte_mkold(pte_t pte) __attribute_const__;
-extern __inline__ pte_t pte_mkold(pte_t pte)
+static inline pte_t pte_mkold(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkoldi));
 }
@@ -277,7 +277,7 @@
 BTFIXUPDEF_INT(pte_modify_mask)
 
 extern pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
-extern __inline__ pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & BTFIXUP_INT(pte_modify_mask)) |
 		pgprot_val(newprot));
@@ -384,13 +384,13 @@
 
 #define NO_CONTEXT     -1
 
-extern __inline__ void remove_from_ctx_list(struct ctx_list *entry)
+static inline void remove_from_ctx_list(struct ctx_list *entry)
 {
 	entry->next->prev = entry->prev;
 	entry->prev->next = entry->next;
 }
 
-extern __inline__ void add_to_ctx_list(struct ctx_list *head, struct ctx_list *entry)
+static inline void add_to_ctx_list(struct ctx_list *head, struct ctx_list *entry)
 {
 	entry->next = head;
 	(entry->prev = head->prev)->next = entry;
@@ -399,7 +399,7 @@
 #define add_to_free_ctxlist(entry) add_to_ctx_list(&ctx_free, entry)
 #define add_to_used_ctxlist(entry) add_to_ctx_list(&ctx_used, entry)
 
-extern __inline__ unsigned long
+static inline unsigned long
 __get_phys (unsigned long addr)
 {
 	switch (sparc_cpu_model){
@@ -414,7 +414,7 @@
 	}
 }
 
-extern __inline__ int
+static inline int
 __get_iospace (unsigned long addr)
 {
 	switch (sparc_cpu_model){
--- linux-2.6.13-mm1-full/include/asm-sparc/pgtsrmmu.h.old	2005-09-02 22:17:04.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/pgtsrmmu.h	2005-09-02 22:17:08.000000000 +0200
@@ -148,7 +148,7 @@
 #define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
 
 /* Accessing the MMU control register. */
-extern __inline__ unsigned int srmmu_get_mmureg(void)
+static inline unsigned int srmmu_get_mmureg(void)
 {
         unsigned int retval;
 	__asm__ __volatile__("lda [%%g0] %1, %0\n\t" :
@@ -157,14 +157,14 @@
 	return retval;
 }
 
-extern __inline__ void srmmu_set_mmureg(unsigned long regval)
+static inline void srmmu_set_mmureg(unsigned long regval)
 {
 	__asm__ __volatile__("sta %0, [%%g0] %1\n\t" : :
 			     "r" (regval), "i" (ASI_M_MMUREGS) : "memory");
 
 }
 
-extern __inline__ void srmmu_set_ctable_ptr(unsigned long paddr)
+static inline void srmmu_set_ctable_ptr(unsigned long paddr)
 {
 	paddr = ((paddr >> 4) & SRMMU_CTX_PMASK);
 	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
@@ -173,7 +173,7 @@
 			     "memory");
 }
 
-extern __inline__ unsigned long srmmu_get_ctable_ptr(void)
+static inline unsigned long srmmu_get_ctable_ptr(void)
 {
 	unsigned int retval;
 
@@ -184,14 +184,14 @@
 	return (retval & SRMMU_CTX_PMASK) << 4;
 }
 
-extern __inline__ void srmmu_set_context(int context)
+static inline void srmmu_set_context(int context)
 {
 	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
 			     "r" (context), "r" (SRMMU_CTX_REG),
 			     "i" (ASI_M_MMUREGS) : "memory");
 }
 
-extern __inline__ int srmmu_get_context(void)
+static inline int srmmu_get_context(void)
 {
 	register int retval;
 	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
@@ -201,7 +201,7 @@
 	return retval;
 }
 
-extern __inline__ unsigned int srmmu_get_fstatus(void)
+static inline unsigned int srmmu_get_fstatus(void)
 {
 	unsigned int retval;
 
@@ -211,7 +211,7 @@
 	return retval;
 }
 
-extern __inline__ unsigned int srmmu_get_faddr(void)
+static inline unsigned int srmmu_get_faddr(void)
 {
 	unsigned int retval;
 
@@ -222,7 +222,7 @@
 }
 
 /* This is guaranteed on all SRMMU's. */
-extern __inline__ void srmmu_flush_whole_tlb(void)
+static inline void srmmu_flush_whole_tlb(void)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
 			     "r" (0x400),        /* Flush entire TLB!! */
@@ -231,7 +231,7 @@
 }
 
 /* These flush types are not available on all chips... */
-extern __inline__ void srmmu_flush_tlb_ctx(void)
+static inline void srmmu_flush_tlb_ctx(void)
 {
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
 			     "r" (0x300),        /* Flush TLB ctx.. */
@@ -239,7 +239,7 @@
 
 }
 
-extern __inline__ void srmmu_flush_tlb_region(unsigned long addr)
+static inline void srmmu_flush_tlb_region(unsigned long addr)
 {
 	addr &= SRMMU_PGDIR_MASK;
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
@@ -249,7 +249,7 @@
 }
 
 
-extern __inline__ void srmmu_flush_tlb_segment(unsigned long addr)
+static inline void srmmu_flush_tlb_segment(unsigned long addr)
 {
 	addr &= SRMMU_REAL_PMD_MASK;
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
@@ -258,7 +258,7 @@
 
 }
 
-extern __inline__ void srmmu_flush_tlb_page(unsigned long page)
+static inline void srmmu_flush_tlb_page(unsigned long page)
 {
 	page &= PAGE_MASK;
 	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
@@ -267,7 +267,7 @@
 
 }
 
-extern __inline__ unsigned long srmmu_hwprobe(unsigned long vaddr)
+static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 {
 	unsigned long retval;
 
@@ -279,7 +279,7 @@
 	return retval;
 }
 
-extern __inline__ int
+static inline int
 srmmu_get_pte (unsigned long addr)
 {
 	register unsigned long entry;
--- linux-2.6.13-mm1-full/include/asm-sparc/processor.h.old	2005-09-02 22:17:39.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/processor.h	2005-09-02 22:17:20.000000000 +0200
@@ -79,7 +79,7 @@
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
 /* Do necessary setup to start up a newly executed thread. */
-extern __inline__ void start_thread(struct pt_regs * regs, unsigned long pc,
+static inline void start_thread(struct pt_regs * regs, unsigned long pc,
 				    unsigned long sp)
 {
 	register unsigned long zero asm("g1");
--- linux-2.6.13-mm1-full/include/asm-sparc/psr.h.old	2005-09-02 22:17:47.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/psr.h	2005-09-02 22:17:51.000000000 +0200
@@ -38,7 +38,7 @@
 
 #ifndef __ASSEMBLY__
 /* Get the %psr register. */
-extern __inline__ unsigned int get_psr(void)
+static inline unsigned int get_psr(void)
 {
 	unsigned int psr;
 	__asm__ __volatile__(
@@ -53,7 +53,7 @@
 	return psr;
 }
 
-extern __inline__ void put_psr(unsigned int new_psr)
+static inline void put_psr(unsigned int new_psr)
 {
 	__asm__ __volatile__(
 		"wr	%0, 0x0, %%psr\n\t"
@@ -72,7 +72,7 @@
 
 extern unsigned int fsr_storage;
 
-extern __inline__ unsigned int get_fsr(void)
+static inline unsigned int get_fsr(void)
 {
 	unsigned int fsr = 0;
 
--- linux-2.6.13-mm1-full/include/asm-sparc/sbi.h.old	2005-09-02 22:18:01.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/sbi.h	2005-09-02 22:18:05.000000000 +0200
@@ -65,7 +65,7 @@
 
 #ifndef __ASSEMBLY__
 
-extern __inline__ int acquire_sbi(int devid, int mask)
+static inline int acquire_sbi(int devid, int mask)
 {
 	__asm__ __volatile__ ("swapa [%2] %3, %0" :
 			      "=r" (mask) :
@@ -75,7 +75,7 @@
 	return mask;
 }
 
-extern __inline__ void release_sbi(int devid, int mask)
+static inline void release_sbi(int devid, int mask)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (mask),
@@ -83,7 +83,7 @@
 			      "i" (ASI_M_CTL));
 }
 
-extern __inline__ void set_sbi_tid(int devid, int targetid)
+static inline void set_sbi_tid(int devid, int targetid)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (targetid),
@@ -91,7 +91,7 @@
 			      "i" (ASI_M_CTL));
 }
 
-extern __inline__ int get_sbi_ctl(int devid, int cfgno)
+static inline int get_sbi_ctl(int devid, int cfgno)
 {
 	int cfg;
 	
@@ -102,7 +102,7 @@
 	return cfg;
 }
 
-extern __inline__ void set_sbi_ctl(int devid, int cfgno, int cfg)
+static inline void set_sbi_ctl(int devid, int cfgno, int cfg)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (cfg),
--- linux-2.6.13-mm1-full/include/asm-sparc/sbus.h.old	2005-09-02 22:18:14.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/sbus.h	2005-09-02 22:18:18.000000000 +0200
@@ -28,12 +28,12 @@
  * numbers + offsets, and vice versa.
  */
 
-extern __inline__ unsigned long sbus_devaddr(int slotnum, unsigned long offset)
+static inline unsigned long sbus_devaddr(int slotnum, unsigned long offset)
 {
   return (unsigned long) (SUN_SBUS_BVADDR+((slotnum)<<25)+(offset));
 }
 
-extern __inline__ int sbus_dev_slot(unsigned long dev_addr)
+static inline int sbus_dev_slot(unsigned long dev_addr)
 {
   return (int) (((dev_addr)-SUN_SBUS_BVADDR)>>25);
 }
@@ -80,7 +80,7 @@
 
 extern struct sbus_bus *sbus_root;
 
-extern __inline__ int
+static inline int
 sbus_is_slave(struct sbus_dev *dev)
 {
 	/* XXX Have to write this for sun4c's */
--- linux-2.6.13-mm1-full/include/asm-sparc/smp.h.old	2005-09-02 22:18:26.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/smp.h	2005-09-02 22:18:30.000000000 +0200
@@ -60,22 +60,22 @@
 #define smp_cross_call(func,arg1,arg2,arg3,arg4,arg5) BTFIXUP_CALL(smp_cross_call)(func,arg1,arg2,arg3,arg4,arg5)
 #define smp_message_pass(target,msg,data,wait) BTFIXUP_CALL(smp_message_pass)(target,msg,data,wait)
 
-extern __inline__ void xc0(smpfunc_t func) { smp_cross_call(func, 0, 0, 0, 0, 0); }
-extern __inline__ void xc1(smpfunc_t func, unsigned long arg1)
+static inline void xc0(smpfunc_t func) { smp_cross_call(func, 0, 0, 0, 0, 0); }
+static inline void xc1(smpfunc_t func, unsigned long arg1)
 { smp_cross_call(func, arg1, 0, 0, 0, 0); }
-extern __inline__ void xc2(smpfunc_t func, unsigned long arg1, unsigned long arg2)
+static inline void xc2(smpfunc_t func, unsigned long arg1, unsigned long arg2)
 { smp_cross_call(func, arg1, arg2, 0, 0, 0); }
-extern __inline__ void xc3(smpfunc_t func, unsigned long arg1, unsigned long arg2,
+static inline void xc3(smpfunc_t func, unsigned long arg1, unsigned long arg2,
 			   unsigned long arg3)
 { smp_cross_call(func, arg1, arg2, arg3, 0, 0); }
-extern __inline__ void xc4(smpfunc_t func, unsigned long arg1, unsigned long arg2,
+static inline void xc4(smpfunc_t func, unsigned long arg1, unsigned long arg2,
 			   unsigned long arg3, unsigned long arg4)
 { smp_cross_call(func, arg1, arg2, arg3, arg4, 0); }
-extern __inline__ void xc5(smpfunc_t func, unsigned long arg1, unsigned long arg2,
+static inline void xc5(smpfunc_t func, unsigned long arg1, unsigned long arg2,
 			   unsigned long arg3, unsigned long arg4, unsigned long arg5)
 { smp_cross_call(func, arg1, arg2, arg3, arg4, arg5); }
 
-extern __inline__ int smp_call_function(void (*func)(void *info), void *info, int nonatomic, int wait)
+static inline int smp_call_function(void (*func)(void *info), void *info, int nonatomic, int wait)
 {
 	xc1((smpfunc_t)func, (unsigned long)info);
 	return 0;
@@ -84,16 +84,16 @@
 extern __volatile__ int __cpu_number_map[NR_CPUS];
 extern __volatile__ int __cpu_logical_map[NR_CPUS];
 
-extern __inline__ int cpu_logical_map(int cpu)
+static inline int cpu_logical_map(int cpu)
 {
 	return __cpu_logical_map[cpu];
 }
-extern __inline__ int cpu_number_map(int cpu)
+static inline int cpu_number_map(int cpu)
 {
 	return __cpu_number_map[cpu];
 }
 
-extern __inline__ int hard_smp4m_processor_id(void)
+static inline int hard_smp4m_processor_id(void)
 {
 	int cpuid;
 
@@ -104,7 +104,7 @@
 	return cpuid;
 }
 
-extern __inline__ int hard_smp4d_processor_id(void)
+static inline int hard_smp4d_processor_id(void)
 {
 	int cpuid;
 
@@ -114,7 +114,7 @@
 }
 
 #ifndef MODULE
-extern __inline__ int hard_smp_processor_id(void)
+static inline int hard_smp_processor_id(void)
 {
 	int cpuid;
 
@@ -136,7 +136,7 @@
 	return cpuid;
 }
 #else
-extern __inline__ int hard_smp_processor_id(void)
+static inline int hard_smp_processor_id(void)
 {
 	int cpuid;
 	
--- linux-2.6.13-mm1-full/include/asm-sparc/smpprim.h.old	2005-09-02 22:18:45.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/smpprim.h	2005-09-02 22:18:51.000000000 +0200
@@ -15,7 +15,7 @@
  * atomic.
  */
 
-extern __inline__ __volatile__ char test_and_set(void *addr)
+static inline __volatile__ char test_and_set(void *addr)
 {
 	char state = 0;
 
@@ -27,7 +27,7 @@
 }
 
 /* Initialize a spin-lock. */
-extern __inline__ __volatile__ smp_initlock(void *spinlock)
+static inline __volatile__ smp_initlock(void *spinlock)
 {
 	/* Unset the lock. */
 	*((unsigned char *) spinlock) = 0;
@@ -36,7 +36,7 @@
 }
 
 /* This routine spins until it acquires the lock at ADDR. */
-extern __inline__ __volatile__ smp_lock(void *addr)
+static inline __volatile__ smp_lock(void *addr)
 {
 	while(test_and_set(addr) == 0xff)
 		;
@@ -46,7 +46,7 @@
 }
 
 /* This routine releases the lock at ADDR. */
-extern __inline__ __volatile__ smp_unlock(void *addr)
+static inline __volatile__ smp_unlock(void *addr)
 {
 	*((unsigned char *) addr) = 0;
 }
--- linux-2.6.13-mm1-full/include/asm-sparc/spinlock.h.old	2005-09-02 22:19:02.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/spinlock.h	2005-09-02 22:19:06.000000000 +0200
@@ -17,7 +17,7 @@
 #define __raw_spin_unlock_wait(lock) \
 	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
-extern __inline__ void __raw_spin_lock(raw_spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__(
 	"\n1:\n\t"
@@ -37,7 +37,7 @@
 	: "g2", "memory", "cc");
 }
 
-extern __inline__ int __raw_spin_trylock(raw_spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned int result;
 	__asm__ __volatile__("ldstub [%1], %0"
@@ -47,7 +47,7 @@
 	return (result == 0);
 }
 
-extern __inline__ void __raw_spin_unlock(raw_spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__("stb %%g0, [%0]" : : "r" (lock) : "memory");
 }
@@ -78,7 +78,7 @@
  *
  * Unfortunately this scheme limits us to ~16,000,000 cpus.
  */
-extern __inline__ void __read_lock(raw_rwlock_t *rw)
+static inline void __read_lock(raw_rwlock_t *rw)
 {
 	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
@@ -98,7 +98,7 @@
 	local_irq_restore(flags); \
 } while(0)
 
-extern __inline__ void __read_unlock(raw_rwlock_t *rw)
+static inline void __read_unlock(raw_rwlock_t *rw)
 {
 	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
--- linux-2.6.13-mm1-full/include/asm-sparc/system.h.old	2005-09-02 22:19:16.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/system.h	2005-09-02 22:19:20.000000000 +0200
@@ -214,7 +214,7 @@
 BTFIXUPDEF_CALL(void, ___xchg32, void)
 #endif
 
-extern __inline__ unsigned long xchg_u32(__volatile__ unsigned long *m, unsigned long val)
+static inline unsigned long xchg_u32(__volatile__ unsigned long *m, unsigned long val)
 {
 #ifdef CONFIG_SMP
 	__asm__ __volatile__("swap [%2], %0"
--- linux-2.6.13-mm1-full/include/asm-sparc/traps.h.old	2005-09-02 22:19:29.000000000 +0200
+++ linux-2.6.13-mm1-full/include/asm-sparc/traps.h	2005-09-02 22:19:33.000000000 +0200
@@ -22,7 +22,7 @@
 /* We set this to _start in system setup. */
 extern struct tt_entry *sparc_ttable;
 
-extern __inline__ unsigned long get_tbr(void)
+static inline unsigned long get_tbr(void)
 {
 	unsigned long tbr;
 
