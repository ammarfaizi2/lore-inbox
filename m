Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbULQMsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbULQMsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbULQMsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:48:54 -0500
Received: from mail.renesas.com ([202.234.163.13]:64703 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262798AbULQMrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:47:47 -0500
Date: Fri, 17 Dec 2004 21:47:35 +0900 (JST)
Message-Id: <20041217.214735.859512432.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Update include/asm-m32r/mmu_context.h
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates include/asm-m32r/mmu_context.h.
Please apply.

	* include/asm-m32r/mmu_context.h:
	- Add #ifdef __KERNEL__
	- Change __inline__ to inline for __KERNEL__ portion.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/mmu_context.h |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)


diff -ruNp a/include/asm-m32r/mmu_context.h b/include/asm-m32r/mmu_context.h
--- a/include/asm-m32r/mmu_context.h	2004-12-15 12:56:47.000000000 +0900
+++ b/include/asm-m32r/mmu_context.h	2004-12-16 18:20:01.000000000 +0900
@@ -1,7 +1,7 @@
 #ifndef _ASM_M32R_MMU_CONTEXT_H
 #define _ASM_M32R_MMU_CONTEXT_H
 
-/* $Id */
+#ifdef __KERNEL__
 
 #include <linux/config.h>
 
@@ -34,13 +34,13 @@ extern unsigned long mmu_context_cache_d
 #define mm_context(mm)		mm->context[smp_processor_id()]
 #endif /* not CONFIG_SMP */
 
-#define set_tlb_tag(entry, tag)	(*entry = (tag & PAGE_MASK)|get_asid())
+#define set_tlb_tag(entry, tag)		(*entry = (tag & PAGE_MASK)|get_asid())
 #define set_tlb_data(entry, data)	(*entry = (data | _PAGE_PRESENT))
 
 #ifdef CONFIG_MMU
 #define enter_lazy_tlb(mm, tsk)	do { } while (0)
 
-static __inline__ void get_new_mmu_context(struct mm_struct *mm)
+static inline void get_new_mmu_context(struct mm_struct *mm)
 {
 	unsigned long mc = ++mmu_context_cache;
 
@@ -59,7 +59,7 @@ static __inline__ void get_new_mmu_conte
 /*
  * Get MMU context if needed.
  */
-static __inline__ void get_mmu_context(struct mm_struct *mm)
+static inline void get_mmu_context(struct mm_struct *mm)
 {
 	if (mm) {
 		unsigned long mc = mmu_context_cache;
@@ -75,7 +75,7 @@ static __inline__ void get_mmu_context(s
  * Initialize the context related info for a new mm_struct
  * instance.
  */
-static __inline__ int init_new_context(struct task_struct *tsk,
+static inline int init_new_context(struct task_struct *tsk,
 	struct mm_struct *mm)
 {
 #ifndef CONFIG_SMP
@@ -97,12 +97,12 @@ static __inline__ int init_new_context(s
  */
 #define destroy_context(mm)	do { } while (0)
 
-static __inline__ void set_asid(unsigned long asid)
+static inline void set_asid(unsigned long asid)
 {
 	*(volatile unsigned long *)MASID = (asid & MMU_CONTEXT_ASID_MASK);
 }
 
-static __inline__ unsigned long get_asid(void)
+static inline unsigned long get_asid(void)
 {
 	unsigned long asid;
 
@@ -116,13 +116,13 @@ static __inline__ unsigned long get_asid
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
-static __inline__ void activate_context(struct mm_struct *mm)
+static inline void activate_context(struct mm_struct *mm)
 {
 	get_mmu_context(mm);
 	set_asid(mm_context(mm) & MMU_CONTEXT_ASID_MASK);
 }
 
-static __inline__ void switch_mm(struct mm_struct *prev,
+static inline void switch_mm(struct mm_struct *prev,
 	struct mm_struct *next, struct task_struct *tsk)
 {
 #ifdef CONFIG_SMP
@@ -165,5 +165,6 @@ static __inline__ void switch_mm(struct 
 
 #endif /* not __ASSEMBLY__ */
 
-#endif /* _ASM_M32R_MMU_CONTEXT_H */
+#endif /* __KERNEL__ */
 
+#endif /* _ASM_M32R_MMU_CONTEXT_H */


--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
