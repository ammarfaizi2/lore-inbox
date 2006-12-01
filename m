Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030804AbWLALwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030804AbWLALwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWLALwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:52:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59654 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030722AbWLALw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:52:29 -0500
Date: Fri, 1 Dec 2006 12:52:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-h8300/: "extern inline" -> "static inline"
Message-ID: <20061201115234.GT11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" generates a warning with -Wmissing-prototypes and I'm
currently working on getting the kernel cleaned up for adding this to
the CFLAGS since it will help us to avoid a nasty class of runtime
errors.

If there are places that really need a forced inline, __always_inline
would be the correct solution.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Nov 2006

 include/asm-h8300/delay.h       |    4 ++--
 include/asm-h8300/mmu_context.h |    4 ++--
 include/asm-h8300/pci.h         |    4 ++--
 include/asm-h8300/tlbflush.h    |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.19-rc5-mm2/include/asm-h8300/delay.h.old	2006-11-22 01:48:48.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-h8300/delay.h	2006-11-22 01:48:52.000000000 +0100
@@ -9,7 +9,7 @@
  * Delay routines, using a pre-computed "loops_per_second" value.
  */
 
-extern __inline__ void __delay(unsigned long loops)
+static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__ ("1:\n\t"
 			      "dec.l #1,%0\n\t"
@@ -27,7 +27,7 @@ extern __inline__ void __delay(unsigned 
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+static inline void udelay(unsigned long usecs)
 {
 	usecs *= 4295;		/* 2**32 / 1000000 */
 	usecs /= (loops_per_jiffy*HZ);
--- linux-2.6.19-rc5-mm2/include/asm-h8300/mmu_context.h.old	2006-11-22 01:49:00.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-h8300/mmu_context.h	2006-11-22 01:49:05.000000000 +0100
@@ -9,7 +9,7 @@ static inline void enter_lazy_tlb(struct
 {
 }
 
-extern inline int
+static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	// mm->context = virt_to_phys(mm->pgd);
@@ -23,7 +23,7 @@ static inline void switch_mm(struct mm_s
 {
 }
 
-extern inline void activate_mm(struct mm_struct *prev_mm,
+static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
 }
--- linux-2.6.19-rc5-mm2/include/asm-h8300/pci.h.old	2006-11-22 01:49:13.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-h8300/pci.h	2006-11-22 01:49:19.000000000 +0100
@@ -10,12 +10,12 @@
 #define pcibios_assign_all_busses()	0
 #define pcibios_scan_all_fns(a, b)	0
 
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
--- linux-2.6.19-rc5-mm2/include/asm-h8300/tlbflush.h.old	2006-11-22 01:49:29.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-h8300/tlbflush.h	2006-11-22 01:49:34.000000000 +0100
@@ -47,12 +47,12 @@ static inline void flush_tlb_range(struc
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

