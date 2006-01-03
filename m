Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWACVNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWACVNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWACVHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51087 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932538AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 50/50] death of get_thread_info/put_thread_info
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Sp-Js@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

{get,put}_thread_info() were introduced in 2.5.4 and never
had been called by anything in the tree.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-alpha/thread_info.h     |    2 --
 include/asm-arm/thread_info.h       |    3 ---
 include/asm-arm26/thread_info.h     |    3 ---
 include/asm-cris/thread_info.h      |    2 --
 include/asm-frv/thread_info.h       |    2 --
 include/asm-h8300/thread_info.h     |    2 --
 include/asm-i386/thread_info.h      |    2 --
 include/asm-m32r/thread_info.h      |    2 --
 include/asm-m68knommu/thread_info.h |    2 --
 include/asm-mips/thread_info.h      |    2 --
 include/asm-parisc/thread_info.h    |    3 ---
 include/asm-powerpc/thread_info.h   |    3 ---
 include/asm-s390/thread_info.h      |    2 --
 include/asm-sh/thread_info.h        |    2 --
 include/asm-sh64/thread_info.h      |    2 --
 include/asm-sparc/thread_info.h     |    3 ---
 include/asm-um/thread_info.h        |    3 ---
 include/asm-v850/thread_info.h      |    2 --
 include/asm-x86_64/thread_info.h    |    2 --
 include/asm-xtensa/thread_info.h    |    2 --
 20 files changed, 0 insertions(+), 46 deletions(-)

1ad6804fe459ee9421ddf289530f6e795e4b8edc
diff --git a/include/asm-alpha/thread_info.h b/include/asm-alpha/thread_info.h
index d51491e..69ffd93 100644
--- a/include/asm-alpha/thread_info.h
+++ b/include/asm-alpha/thread_info.h
@@ -54,8 +54,6 @@ register struct thread_info *__current_t
 #define alloc_thread_info(tsk) \
   ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/asm-arm/thread_info.h b/include/asm-arm/thread_info.h
index 46a4e98..33a33cb 100644
--- a/include/asm-arm/thread_info.h
+++ b/include/asm-arm/thread_info.h
@@ -96,9 +96,6 @@ static inline struct thread_info *curren
 extern struct thread_info *alloc_thread_info(struct task_struct *task);
 extern void free_thread_info(struct thread_info *);
 
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
-
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(pc_pointer(task_thread_info(tsk)->cpu_context.pc)))
 #define thread_saved_fp(tsk)	\
diff --git a/include/asm-arm26/thread_info.h b/include/asm-arm26/thread_info.h
index 7a35e7a..a65e58a 100644
--- a/include/asm-arm26/thread_info.h
+++ b/include/asm-arm26/thread_info.h
@@ -87,9 +87,6 @@ static inline struct thread_info *curren
 extern struct thread_info *alloc_thread_info(struct task_struct *task);
 extern void free_thread_info(struct thread_info *);
 
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
-
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(pc_pointer(task_thread_info(tsk)->cpu_context.pc)))
 #define thread_saved_fp(tsk)	\
diff --git a/include/asm-cris/thread_info.h b/include/asm-cris/thread_info.h
index cef0140..7ad853c 100644
--- a/include/asm-cris/thread_info.h
+++ b/include/asm-cris/thread_info.h
@@ -69,8 +69,6 @@ struct thread_info {
 /* thread information allocation */
 #define alloc_thread_info(tsk) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-frv/thread_info.h b/include/asm-frv/thread_info.h
index 60f6b2a..a5576e0 100644
--- a/include/asm-frv/thread_info.h
+++ b/include/asm-frv/thread_info.h
@@ -110,8 +110,6 @@ register struct thread_info *__current_t
 #endif
 
 #define free_thread_info(info)	kfree(info)
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
 
 #else /* !__ASSEMBLY__ */
 
diff --git a/include/asm-h8300/thread_info.h b/include/asm-h8300/thread_info.h
index bfcc755..45f09dc 100644
--- a/include/asm-h8300/thread_info.h
+++ b/include/asm-h8300/thread_info.h
@@ -69,8 +69,6 @@ static inline struct thread_info *curren
 #define alloc_thread_info(tsk) ((struct thread_info *) \
 				__get_free_pages(GFP_KERNEL, 1))
 #define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
index 8fbf791..2493e77 100644
--- a/include/asm-i386/thread_info.h
+++ b/include/asm-i386/thread_info.h
@@ -111,8 +111,6 @@ register unsigned long current_stack_poi
 #endif
 
 #define free_thread_info(info)	kfree(info)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #else /* !__ASSEMBLY__ */
 
diff --git a/include/asm-m32r/thread_info.h b/include/asm-m32r/thread_info.h
index 0f58936..22aff32 100644
--- a/include/asm-m32r/thread_info.h
+++ b/include/asm-m32r/thread_info.h
@@ -110,8 +110,6 @@ static inline struct thread_info *curren
 #endif
 
 #define free_thread_info(info) kfree(info)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #define TI_FLAG_FAULT_CODE_SHIFT	28
 
diff --git a/include/asm-m68knommu/thread_info.h b/include/asm-m68knommu/thread_info.h
index 7b9a3fa..b8f009e 100644
--- a/include/asm-m68knommu/thread_info.h
+++ b/include/asm-m68knommu/thread_info.h
@@ -75,8 +75,6 @@ static inline struct thread_info *curren
 #define alloc_thread_info(tsk) ((struct thread_info *) \
 				__get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER))
 #define free_thread_info(ti)	free_pages((unsigned long) (ti), THREAD_SIZE_ORDER)
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
 #endif /* __ASSEMBLY__ */
 
 #define	PREEMPT_ACTIVE	0x4000000
diff --git a/include/asm-mips/thread_info.h b/include/asm-mips/thread_info.h
index e6c2447..1612b3f 100644
--- a/include/asm-mips/thread_info.h
+++ b/include/asm-mips/thread_info.h
@@ -97,8 +97,6 @@ register struct thread_info *__current_t
 #endif
 
 #define free_thread_info(info) kfree(info)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-parisc/thread_info.h b/include/asm-parisc/thread_info.h
index 57bbb76..ac32f14 100644
--- a/include/asm-parisc/thread_info.h
+++ b/include/asm-parisc/thread_info.h
@@ -43,9 +43,6 @@ struct thread_info {
 #define alloc_thread_info(tsk) ((struct thread_info *) \
 			__get_free_pages(GFP_KERNEL, THREAD_ORDER))
 #define free_thread_info(ti)    free_pages((unsigned long) (ti), THREAD_ORDER)
-#define get_thread_info(ti)     get_task_struct((ti)->task)
-#define put_thread_info(ti)     put_task_struct((ti)->task)
-
 
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *)mfctl(30))
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index e525f49..5d7dc48 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -90,9 +90,6 @@ struct thread_info {
 
 #endif /* THREAD_SHIFT < PAGE_SHIFT */
 
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
-
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
diff --git a/include/asm-s390/thread_info.h b/include/asm-s390/thread_info.h
index 6c18a3f..f3797a5 100644
--- a/include/asm-s390/thread_info.h
+++ b/include/asm-s390/thread_info.h
@@ -81,8 +81,6 @@ static inline struct thread_info *curren
 #define alloc_thread_info(tsk) ((struct thread_info *) \
 	__get_free_pages(GFP_KERNEL,THREAD_ORDER))
 #define free_thread_info(ti) free_pages((unsigned long) (ti),THREAD_ORDER)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif
 
diff --git a/include/asm-sh/thread_info.h b/include/asm-sh/thread_info.h
index 46080ce..85f0c11 100644
--- a/include/asm-sh/thread_info.h
+++ b/include/asm-sh/thread_info.h
@@ -60,8 +60,6 @@ static inline struct thread_info *curren
 #define THREAD_SIZE (2*PAGE_SIZE)
 #define alloc_thread_info(ti) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #else /* !__ASSEMBLY__ */
 
diff --git a/include/asm-sh64/thread_info.h b/include/asm-sh64/thread_info.h
index 10f024c..1f825cb 100644
--- a/include/asm-sh64/thread_info.h
+++ b/include/asm-sh64/thread_info.h
@@ -66,8 +66,6 @@ static inline struct thread_info *curren
 
 #define alloc_thread_info(ti) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/asm-sparc/thread_info.h b/include/asm-sparc/thread_info.h
index ff6ccb3..65f060b 100644
--- a/include/asm-sparc/thread_info.h
+++ b/include/asm-sparc/thread_info.h
@@ -92,9 +92,6 @@ BTFIXUPDEF_CALL(struct thread_info *, al
 BTFIXUPDEF_CALL(void, free_thread_info, struct thread_info *)
 #define free_thread_info(ti) BTFIXUP_CALL(free_thread_info)(ti)
 
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
-
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/include/asm-um/thread_info.h b/include/asm-um/thread_info.h
index 97267f0..705c719 100644
--- a/include/asm-um/thread_info.h
+++ b/include/asm-um/thread_info.h
@@ -56,9 +56,6 @@ static inline struct thread_info *curren
 	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
 #define free_thread_info(ti) kfree(ti)
 
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
-
 #endif
 
 #define PREEMPT_ACTIVE		0x10000000
diff --git a/include/asm-v850/thread_info.h b/include/asm-v850/thread_info.h
index e4cfad9..82b8f28 100644
--- a/include/asm-v850/thread_info.h
+++ b/include/asm-v850/thread_info.h
@@ -58,8 +58,6 @@ struct thread_info {
 #define alloc_thread_info(tsk) ((struct thread_info *) \
 				__get_free_pages(GFP_KERNEL, 1))
 #define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti)	get_task_struct((ti)->task)
-#define put_thread_info(ti)	put_task_struct((ti)->task)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/asm-x86_64/thread_info.h b/include/asm-x86_64/thread_info.h
index 08eb6e4..975c0bb 100644
--- a/include/asm-x86_64/thread_info.h
+++ b/include/asm-x86_64/thread_info.h
@@ -76,8 +76,6 @@ static inline struct thread_info *stack_
 #define alloc_thread_info(tsk) \
 	((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #else /* !__ASSEMBLY__ */
 
diff --git a/include/asm-xtensa/thread_info.h b/include/asm-xtensa/thread_info.h
index af208d4..5ae34ab 100644
--- a/include/asm-xtensa/thread_info.h
+++ b/include/asm-xtensa/thread_info.h
@@ -93,8 +93,6 @@ static inline struct thread_info *curren
 /* thread information allocation */
 #define alloc_thread_info(tsk) ((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
-#define get_thread_info(ti) get_task_struct((ti)->task)
-#define put_thread_info(ti) put_task_struct((ti)->task)
 
 #else /* !__ASSEMBLY__ */
 
-- 
0.99.9.GIT

