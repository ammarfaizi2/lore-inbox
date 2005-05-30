Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVE3Xy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVE3Xy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVE3Xy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:54:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44170 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261834AbVE3XuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:50:17 -0400
Date: Tue, 31 May 2005 01:50:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: more thread_info patches
In-Reply-To: <Pine.LNX.4.61.0505310113370.10977@scrub.home>
Message-ID: <Pine.LNX.4.61.0505310126400.10977@scrub.home>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
 <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
 <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0505310113370.10977@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does a global rename of alloc_thread_info/free_thread_info to 
alloc_thread_stack/free_thread_stack. This reflects what these functions 
really do, the thread_info part is only a small part of the stack (and 
possibly it's even somewhere else).
Al, I renamed your setup_thread_info to setup_thread_task and changed the 
arguments a bit. I didn't like how it relies on how finds the original 
thread_info data, now it gets it explicitely from the original task.

bye, Roman

---

 arch/arm/kernel/process.c           |    8 ++++----
 arch/arm26/kernel/process.c         |    8 ++++----
 arch/sparc/mm/srmmu.c               |    6 +++---
 arch/sparc/mm/sun4c.c               |   10 +++++-----
 include/asm-alpha/thread_info.h     |    6 +++---
 include/asm-arm/thread_info.h       |    4 ++--
 include/asm-arm26/thread_info.h     |    4 ++--
 include/asm-cris/thread_info.h      |    4 ++--
 include/asm-frv/thread_info.h       |    8 ++++----
 include/asm-h8300/thread_info.h     |    4 ++--
 include/asm-i386/thread_info.h      |    8 ++++----
 include/asm-ia64/thread_info.h      |    4 ++--
 include/asm-m32r/thread_info.h      |    8 ++++----
 include/asm-m68k/thread_info.h      |    8 ++++----
 include/asm-m68knommu/thread_info.h |    4 ++--
 include/asm-mips/thread_info.h      |    8 ++++----
 include/asm-parisc/thread_info.h    |    4 ++--
 include/asm-ppc/thread_info.h       |    4 ++--
 include/asm-ppc64/thread_info.h     |    8 ++++----
 include/asm-s390/thread_info.h      |    4 ++--
 include/asm-sh/thread_info.h        |    4 ++--
 include/asm-sh64/thread_info.h      |    7 ++-----
 include/asm-sparc/thread_info.h     |   10 +++++-----
 include/asm-sparc64/thread_info.h   |   12 ++++++------
 include/asm-um/thread_info.h        |    6 +++---
 include/asm-v850/thread_info.h      |    4 ++--
 include/asm-x86_64/thread_info.h    |    6 +++---
 include/linux/sched.h               |    5 +++--
 kernel/fork.c                       |   15 +++++++--------
 29 files changed, 94 insertions(+), 97 deletions(-)

Index: linux-2.6-mm/include/asm-v850/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-v850/thread_info.h	2005-05-31 01:19:00.719748683 +0200
+++ linux-2.6-mm/include/asm-v850/thread_info.h	2005-05-31 01:19:43.457407286 +0200
@@ -55,9 +55,9 @@ struct thread_info {
  */
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-cris/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-cris/thread_info.h	2005-05-31 01:19:00.719748683 +0200
+++ linux-2.6-mm/include/asm-cris/thread_info.h	2005-05-31 01:19:43.457407286 +0200
@@ -67,8 +67,8 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_stack(tsk) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stack) free_pages((unsigned long)(stack), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-m68knommu/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68knommu/thread_info.h	2005-05-31 01:19:00.719748683 +0200
+++ linux-2.6-mm/include/asm-m68knommu/thread_info.h	2005-05-31 01:19:43.458407115 +0200
@@ -72,9 +72,9 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), THREAD_SIZE_ORDER)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), THREAD_SIZE_ORDER)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-um/thread_info.h	2005-05-31 01:19:00.719748683 +0200
+++ linux-2.6-mm/include/asm-um/thread_info.h	2005-05-31 01:19:43.458407115 +0200
@@ -52,9 +52,9 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) \
-	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
-#define free_thread_info(ti) kfree(ti)
+#define alloc_thread_stack(tsk) \
+	((void *) kmalloc(THREAD_SIZE, GFP_KERNEL))
+#define free_thread_stack(stk) kfree(stk)
 
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
Index: linux-2.6-mm/include/asm-sh64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sh64/thread_info.h	2005-05-31 01:19:00.719748683 +0200
+++ linux-2.6-mm/include/asm-sh64/thread_info.h	2005-05-31 01:19:43.458407115 +0200
@@ -61,11 +61,8 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-
-
-
-#define alloc_thread_info(ti) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_stack(ti) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-sh/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sh/thread_info.h	2005-05-31 01:19:00.719748683 +0200
+++ linux-2.6-mm/include/asm-sh/thread_info.h	2005-05-31 01:19:43.458407115 +0200
@@ -58,8 +58,8 @@ static inline struct thread_info *curren
 
 /* thread information allocation */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info(ti) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_stack(ti) ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-frv/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-frv/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-frv/thread_info.h	2005-05-31 01:19:43.459406943 +0200
@@ -96,9 +96,9 @@ register struct thread_info *__current_t
 
 /* thread information allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 		if (ret)					\
@@ -106,10 +106,10 @@ register struct thread_info *__current_t
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_stack(stk)	kfree(stk)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-sparc64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc64/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-sparc64/thread_info.h	2005-05-31 01:19:43.459406943 +0200
@@ -151,9 +151,9 @@ register struct thread_info *current_thr
 #endif /* PAGE_SHIFT == 13 */
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 ({								\
-	struct thread_info *ret;				\
+	void *ret;						\
 								\
 	ret = (struct thread_info *)				\
 	  __get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER);	\
@@ -162,12 +162,12 @@ register struct thread_info *current_thr
 	ret;							\
 })
 #else
-#define alloc_thread_info(tsk) \
-	((struct thread_info *)__get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER))
+#define alloc_thread_stack(tsk) \
+	((void *)__get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER))
 #endif
 
-#define free_thread_info(ti) \
-	free_pages((unsigned long)(ti),__THREAD_INFO_ORDER)
+#define free_thread_stack(stk) \
+	free_pages((unsigned long)(stk),__THREAD_INFO_ORDER)
 
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
Index: linux-2.6-mm/include/asm-s390/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-s390/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-s390/thread_info.h	2005-05-31 01:19:43.459406943 +0200
@@ -78,9 +78,9 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 	__get_free_pages(GFP_KERNEL,THREAD_ORDER))
-#define free_thread_info(ti) free_pages((unsigned long) (ti),THREAD_ORDER)
+#define free_thread_stack(stk) free_pages((unsigned long)(stk),THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-m32r/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m32r/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-m32r/thread_info.h	2005-05-31 01:19:43.460406771 +0200
@@ -96,9 +96,9 @@ static inline struct thread_info *curren
 
 /* thread information allocation */
 #if CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 	 							\
 	 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 	 	if (ret)					\
@@ -106,10 +106,10 @@ static inline struct thread_info *curren
 	 	ret;						\
 	 })
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info) kfree(info)
+#define free_thread_stack(stk) kfree(stk)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-ia64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ia64/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-ia64/thread_info.h	2005-05-31 01:19:43.460406771 +0200
@@ -53,8 +53,8 @@ struct thread_info {
 
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + IA64_TASK_SIZE))
-#define alloc_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA64_TASK_SIZE))
-#define free_thread_info(ti)	/* nothing */
+#define alloc_thread_stack(tsk)	((void *) ((char *) (tsk) + IA64_TASK_SIZE))
+#define free_thread_stack(stk)	/* nothing */
 
 #define __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
 #define alloc_task_struct()	((task_t *)__get_free_pages(GFP_KERNEL, KERNEL_STACK_SIZE_ORDER))
Index: linux-2.6-mm/include/asm-h8300/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-h8300/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-h8300/thread_info.h	2005-05-31 01:19:43.460406771 +0200
@@ -66,9 +66,9 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-mm/include/asm-ppc/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ppc/thread_info.h	2005-05-31 01:19:00.720748512 +0200
+++ linux-2.6-mm/include/asm-ppc/thread_info.h	2005-05-31 01:19:43.460406771 +0200
@@ -54,9 +54,9 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 				__get_free_pages(GFP_KERNEL, 1))
-#define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-mm/include/asm-parisc/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-parisc/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-parisc/thread_info.h	2005-05-31 01:19:43.460406771 +0200
@@ -40,9 +40,9 @@ struct thread_info {
 #define THREAD_SIZE             (PAGE_SIZE << THREAD_ORDER)
 #define THREAD_SHIFT            (PAGE_SHIFT + THREAD_ORDER)
 
-#define alloc_thread_info(tsk) ((struct thread_info *) \
+#define alloc_thread_stack(tsk) ((void *) \
 			__get_free_pages(GFP_KERNEL, THREAD_ORDER))
-#define free_thread_info(ti)    free_pages((unsigned long) (ti), THREAD_ORDER)
+#define free_thread_stack(stk)	free_pages((unsigned long)(stk), THREAD_ORDER)
 #define get_thread_info(ti)     get_task_struct((ti)->task)
 #define put_thread_info(ti)     put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-mips/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-mips/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-mips/thread_info.h	2005-05-31 01:19:43.461406599 +0200
@@ -82,9 +82,9 @@ register struct thread_info *__current_t
 #define THREAD_MASK (THREAD_SIZE - 1UL)
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 ({								\
-	struct thread_info *ret;				\
+	void *ret;						\
 								\
 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);			\
 	if (ret)						\
@@ -92,10 +92,10 @@ register struct thread_info *__current_t
 	ret;							\
 })
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info) kfree(info)
+#define free_thread_stack(stk) kfree(stk)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-m68k/thread_info.h	2005-05-31 01:19:43.461406599 +0200
@@ -27,11 +27,11 @@ struct thread_info {
 
 /* THREAD_SIZE should be 8k, so handle differently for 4k and 8k machines */
 #if PAGE_SHIFT == 13 /* 8k machines */
-#define alloc_thread_info(tsk)   ((struct thread_info *)__get_free_pages(GFP_KERNEL,0))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),0)
+#define alloc_thread_stack(tsk)   ((void *)__get_free_pages(GFP_KERNEL,0))
+#define free_thread_stack(stk)  free_pages((unsigned long)(stk),0)
 #else /* otherwise assume 4k pages */
-#define alloc_thread_info(tsk)   ((struct thread_info *)__get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti)  free_pages((unsigned long)(ti),1)
+#define alloc_thread_stack(tsk)   ((void *)__get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stk)  free_pages((unsigned long)(stk),1)
 #endif /* PAGE_SHIFT == 13 */
 
 //#define init_thread_info	(init_task.thread.info)
Index: linux-2.6-mm/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-arm/thread_info.h	2005-05-31 01:19:43.461406599 +0200
@@ -92,8 +92,8 @@ static inline struct thread_info *curren
 	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
 }
 
-extern struct thread_info *alloc_thread_info(struct task_struct *task);
-extern void free_thread_info(struct thread_info *);
+extern void *alloc_thread_stack(struct task_struct *task);
+extern void free_thread_stack(void *);
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
Index: linux-2.6-mm/include/asm-x86_64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-x86_64/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-x86_64/thread_info.h	2005-05-31 01:19:43.462406428 +0200
@@ -73,9 +73,9 @@ static inline struct thread_info *stack_
 }
 
 /* thread information allocation */
-#define alloc_thread_info(tsk) \
-	((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER)
+#define alloc_thread_stack(tsk) \
+	((void *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
+#define free_thread_stack(stk) free_pages((unsigned long)(stk), THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-sparc/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-sparc/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-sparc/thread_info.h	2005-05-31 01:19:43.462406428 +0200
@@ -86,11 +86,11 @@ register struct thread_info *current_thr
 #define THREAD_INFO_ORDER  1
 #endif
 
-BTFIXUPDEF_CALL(struct thread_info *, alloc_thread_info, void)
-#define alloc_thread_info(tsk) BTFIXUP_CALL(alloc_thread_info)()
+BTFIXUPDEF_CALL(void *, alloc_thread_stack, void)
+#define alloc_thread_stack(tsk) BTFIXUP_CALL(alloc_thread_stack)()
 
-BTFIXUPDEF_CALL(void, free_thread_info, struct thread_info *)
-#define free_thread_info(ti) BTFIXUP_CALL(free_thread_info)(ti)
+BTFIXUPDEF_CALL(void, free_thread_stack, void *)
+#define free_thread_stack(stk) BTFIXUP_CALL(free_thread_stack)(stk)
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
@@ -99,7 +99,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 
 /*
  * Size of kernel stack for each process.
- * Observe the order of get_free_pages() in alloc_thread_info().
+ * Observe the order of get_free_pages() in alloc_thread_stack().
  * The sun4 has 8K stack too, because it's short on memory, and 16K is a waste.
  */
 #define THREAD_SIZE		8192
Index: linux-2.6-mm/include/asm-arm26/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm26/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-arm26/thread_info.h	2005-05-31 01:19:43.462406428 +0200
@@ -84,8 +84,8 @@ static inline struct thread_info *curren
 #define THREAD_SIZE		(8*32768) // FIXME - this needs attention (see kernel/fork.c which gets a nice div by zero if this is lower than 8*32768
 #define __get_user_regs(x) (((struct pt_regs *)((unsigned long)(x) + THREAD_SIZE - 8)) - 1)
 
-extern struct thread_info *alloc_thread_info(struct task_struct *task);
-extern void free_thread_info(struct thread_info *);
+extern void *alloc_thread_stack(struct task_struct *task);
+extern void free_thread_stack(void *);
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
Index: linux-2.6-mm/include/asm-alpha/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/thread_info.h	2005-05-31 01:19:00.721748340 +0200
+++ linux-2.6-mm/include/asm-alpha/thread_info.h	2005-05-31 01:19:43.462406428 +0200
@@ -51,9 +51,9 @@ register struct thread_info *__current_t
 
 /* Thread information allocation.  */
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_thread_info(tsk) \
-  ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#define alloc_thread_stack(tsk) \
+  ((void *) __get_free_pages(GFP_KERNEL,1))
+#define free_thread_stack(stack) free_pages((unsigned long)(stack), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/arch/arm/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/process.c	2005-05-31 01:19:00.722748168 +0200
+++ linux-2.6-mm/arch/arm/kernel/process.c	2005-05-31 01:19:43.463406256 +0200
@@ -257,7 +257,7 @@ static unsigned int nr_thread_info;
 
 #define EXTRA_TASK_STRUCT	4
 
-struct thread_info *alloc_thread_info(struct task_struct *task)
+void *alloc_thread_stack(struct task_struct *task)
 {
 	struct thread_info *thread = NULL;
 
@@ -286,15 +286,15 @@ struct thread_info *alloc_thread_info(st
 	return thread;
 }
 
-void free_thread_info(struct thread_info *thread)
+void free_thread_stack(void *stack)
 {
 	if (EXTRA_TASK_STRUCT && nr_thread_info < EXTRA_TASK_STRUCT) {
-		unsigned long *p = (unsigned long *)thread;
+		unsigned long *p = (unsigned long *)stack;
 		p[0] = (unsigned long)thread_info_head;
 		thread_info_head = p;
 		nr_thread_info += 1;
 	} else
-		free_pages((unsigned long)thread, THREAD_SIZE_ORDER);
+		free_pages((unsigned long)stack, THREAD_SIZE_ORDER);
 }
 
 /*
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-05-31 01:19:29.954726757 +0200
+++ linux-2.6-mm/kernel/fork.c	2005-05-31 01:20:29.560487745 +0200
@@ -101,7 +101,7 @@ static kmem_cache_t *mm_cachep;
 
 void free_task(struct task_struct *tsk)
 {
-	free_thread_info(tsk->thread_info);
+	free_thread_stack(tsk->stack);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -156,7 +156,7 @@ void __init fork_init(unsigned long memp
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;
-	struct thread_info *ti;
+	void *stack;
 
 	prepare_to_copy(orig);
 
@@ -164,17 +164,16 @@ static struct task_struct *dup_task_stru
 	if (!tsk)
 		return NULL;
 
-	ti = alloc_thread_info(tsk);
-	if (!ti) {
+	stack = alloc_thread_stack(tsk);
+	if (!stack) {
 		free_task_struct(tsk);
 		return NULL;
 	}
 
 	*tsk = *orig;
-	setup_thread_info(tsk, ti);
-	tsk->thread_info = ti;
-	tsk->stack = ti;
-	ti->task = tsk;
+	tsk->stack = stack;
+	tsk->thread_info = stack;
+	setup_thread_stack(tsk, orig);
 
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
Index: linux-2.6-mm/include/asm-ppc64/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-ppc64/thread_info.h	2005-05-31 01:19:00.722748168 +0200
+++ linux-2.6-mm/include/asm-ppc64/thread_info.h	2005-05-31 01:19:43.464406084 +0200
@@ -58,9 +58,9 @@ struct thread_info {
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_ORDER)
 #define THREAD_SHIFT		(PAGE_SHIFT + THREAD_ORDER)
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 		if (ret)					\
@@ -68,9 +68,9 @@ struct thread_info {
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
-#define free_thread_info(ti)	kfree(ti)
+#define free_thread_stack(stk)	kfree(stk)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
 
Index: linux-2.6-mm/include/asm-i386/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/thread_info.h	2005-05-31 01:19:00.722748168 +0200
+++ linux-2.6-mm/include/asm-i386/thread_info.h	2005-05-31 01:19:43.464406084 +0200
@@ -97,9 +97,9 @@ register unsigned long current_stack_poi
 
 /* thread information allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
+#define alloc_thread_stack(tsk)					\
 	({							\
-		struct thread_info *ret;			\
+		void *ret;					\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
 		if (ret)					\
@@ -107,10 +107,10 @@ register unsigned long current_stack_poi
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_stack(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_stack(stk)	kfree(stk)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
Index: linux-2.6-mm/arch/sparc/mm/srmmu.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/mm/srmmu.c	2005-05-31 01:19:00.722748168 +0200
+++ linux-2.6-mm/arch/sparc/mm/srmmu.c	2005-05-31 01:19:43.465405912 +0200
@@ -646,7 +646,7 @@ static void srmmu_unmapiorange(unsigned 
  * mappings on the kernel stack without any special code as we did
  * need on the sun4c.
  */
-struct thread_info *srmmu_alloc_thread_info(void)
+void *srmmu_alloc_thread_stack(void)
 {
 	struct thread_info *ret;
 
@@ -660,9 +660,9 @@ struct thread_info *srmmu_alloc_thread_i
 	return ret;
 }
 
-static void srmmu_free_thread_info(struct thread_info *ti)
+static void srmmu_free_thread_stack(void *stack)
 {
-	free_pages((unsigned long)ti, THREAD_INFO_ORDER);
+	free_pages((unsigned long)stack, THREAD_INFO_ORDER);
 }
 
 /* tsunami.S */
Index: linux-2.6-mm/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/process.c	2005-05-31 01:19:00.722748168 +0200
+++ linux-2.6-mm/arch/arm26/kernel/process.c	2005-05-31 01:19:43.466405741 +0200
@@ -215,7 +215,7 @@ extern void free_page_8k(unsigned long p
 
 //FIXME - do we use *task param below looks like we dont, which is ok?
 //FIXME - if EXTRA_TASK_STRUCT is zero we can optimise the below away permanently. *IF* its supposed to be zero.
-struct thread_info *alloc_thread_info(struct task_struct *task)
+void *alloc_thread_stack(struct task_struct *task)
 {
 	struct thread_info *thread = NULL;
 
@@ -245,15 +245,15 @@ struct thread_info *alloc_thread_info(st
 	return thread;
 }
 
-void free_thread_info(struct thread_info *thread)
+void free_thread_stack(void *stack)
 {
 	if (EXTRA_TASK_STRUCT && nr_thread_info < EXTRA_TASK_STRUCT) {
-		unsigned long *p = (unsigned long *)thread;
+		unsigned long *p = (unsigned long *)stack;
 		p[0] = (unsigned long)thread_info_head;
 		thread_info_head = p;
 		nr_thread_info += 1;
 	} else
-		ll_free_task_struct(thread);
+		ll_free_task_struct(stack);
 }
 
 /*
Index: linux-2.6-mm/arch/sparc/mm/sun4c.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/mm/sun4c.c	2005-05-31 01:19:00.722748168 +0200
+++ linux-2.6-mm/arch/sparc/mm/sun4c.c	2005-05-31 01:19:43.467405569 +0200
@@ -1023,7 +1023,7 @@ static inline void garbage_collect(int e
 	free_locked_segment(BUCKET_ADDR(entry));
 }
 
-static struct thread_info *sun4c_alloc_thread_info(void)
+static void *sun4c_alloc_thread_stack(void)
 {
 	unsigned long addr, pages;
 	int entry;
@@ -1067,9 +1067,9 @@ static struct thread_info *sun4c_alloc_t
 	return (struct thread_info *) addr;
 }
 
-static void sun4c_free_thread_info(struct thread_info *ti)
+static void sun4c_free_thread_stack(void *stack)
 {
-	unsigned long tiaddr = (unsigned long) ti;
+	unsigned long tiaddr = (unsigned long)stack;
 	unsigned long pages = BUCKET_PTE_PAGE(sun4c_get_pte(tiaddr));
 	int entry = BUCKET_NUM(tiaddr);
 
@@ -2265,8 +2265,8 @@ void __init ld_mmu_sun4c(void)
 	BTFIXUPSET_CALL(__swp_offset, sun4c_swp_offset, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__swp_entry, sun4c_swp_entry, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(alloc_thread_info, sun4c_alloc_thread_info, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(free_thread_info, sun4c_free_thread_info, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(alloc_thread_stack, sun4c_alloc_thread_stack, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(free_thread_stack, sun4c_free_thread_stack, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(mmu_info, sun4c_mmu_info, BTFIXUPCALL_NORM);
 
Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-05-31 01:19:05.913856451 +0200
+++ linux-2.6-mm/include/linux/sched.h	2005-05-31 01:19:43.467405569 +0200
@@ -1162,9 +1162,10 @@ static inline void task_unlock(struct ta
 
 #define task_thread_info(task) (task)->thread_info
 
-static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
+static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
 {
-	*ti = *p->thread_info;
+	*task_thread_info(p) = *task_thread_info(org);
+	task_thread_info(p)->task = p;
 }
 
 static inline unsigned long *end_of_stack(struct task_struct *p)
