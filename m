Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWGHQK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWGHQK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWGHQK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:10:57 -0400
Received: from relay01.pair.com ([209.68.5.15]:17158 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S964882AbWGHQK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:10:57 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make cpu_relax() imply barrier() on all arches
Date: Sat, 8 Jul 2006 11:10:29 -0500
User-Agent: KMail/1.9.3
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607081110.52319.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the recent discussion of taking 'volatile' off of the spinlock, I 
noticed that while most arches #define cpu_relax() such that it implies 
barrier(), some arches define cpu_relax() to be empty.

This patch changes the definition of cpu_relax() for frv, h8300, m68knommu, 
sh, sh64, v850 and xtensa from an empty while(0) to the compiler barrier().

Signed-off-by: Chase Venters <chase.venters@clientec.com>

---

 include/asm-frv/processor.h       |    3 ++-
 include/asm-h8300/processor.h     |    3 ++-
 include/asm-m68knommu/processor.h |    3 ++-
 include/asm-sh/processor.h        |    3 ++-
 include/asm-sh64/processor.h      |    3 ++-
 include/asm-v850/processor.h      |    3 ++-
 include/asm-xtensa/processor.h    |    3 ++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/asm-frv/processor.h b/include/asm-frv/processor.h
index 1c4dba1..3744f2e 100644
--- a/include/asm-frv/processor.h
+++ b/include/asm-frv/processor.h
@@ -21,6 +21,7 @@ #ifndef __ASSEMBLY__
  */
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <asm/sections.h>
 #include <asm/segment.h>
@@ -139,7 +140,7 @@ #define	KSTK_ESP(tsk)	((tsk)->thread.fra
 extern struct task_struct *alloc_task_struct(void);
 extern void free_task_struct(struct task_struct *p);
 
-#define cpu_relax()    do { } while (0)
+#define cpu_relax()    barrier()
 
 /* data cache prefetch */
 #define ARCH_HAS_PREFETCH
diff --git a/include/asm-h8300/processor.h b/include/asm-h8300/processor.h
index c7e2f45..99b664a 100644
--- a/include/asm-h8300/processor.h
+++ b/include/asm-h8300/processor.h
@@ -17,6 +17,7 @@ #define __ASM_H8300_PROCESSOR_H
  */
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
+#include <linux/compiler.h>
 #include <asm/segment.h>
 #include <asm/fpu.h>
 #include <asm/ptrace.h>
@@ -129,6 +130,6 @@ #define	KSTK_EIP(tsk)	\
 	eip; })
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
-#define cpu_relax()    do { } while (0)
+#define cpu_relax()    barrier()
 
 #endif
diff --git a/include/asm-m68knommu/processor.h 
b/include/asm-m68knommu/processor.h
index 0ee158e..9d3a1bf 100644
--- a/include/asm-m68knommu/processor.h
+++ b/include/asm-m68knommu/processor.h
@@ -13,6 +13,7 @@ #define __ASM_M68K_PROCESSOR_H
  */
 #define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
+#include <linux/compiler.h>
 #include <linux/threads.h>
 #include <asm/types.h>
 #include <asm/segment.h>
@@ -137,6 +138,6 @@ #define	KSTK_EIP(tsk)	\
 	eip; })
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
-#define cpu_relax()    do { } while (0)
+#define cpu_relax()    barrier()
 
 #endif
diff --git a/include/asm-sh/processor.h b/include/asm-sh/processor.h
index fa5bd2d..eeb0f48 100644
--- a/include/asm-sh/processor.h
+++ b/include/asm-sh/processor.h
@@ -9,6 +9,7 @@ #ifndef __ASM_SH_PROCESSOR_H
 #define __ASM_SH_PROCESSOR_H
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/types.h>
 #include <asm/cache.h>
@@ -263,7 +264,7 @@ #define KSTK_EIP(tsk)  ((tsk)->thread.pc
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
 
 #define cpu_sleep()	__asm__ __volatile__ ("sleep" : : : "memory")
-#define cpu_relax()	do { } while (0)
+#define cpu_relax()	barrier()
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_PROCESSOR_H */
diff --git a/include/asm-sh64/processor.h b/include/asm-sh64/processor.h
index 1bf252d..eb2bee4 100644
--- a/include/asm-sh64/processor.h
+++ b/include/asm-sh64/processor.h
@@ -22,6 +22,7 @@ #include <asm/types.h>
 #include <asm/cache.h>
 #include <asm/registers.h>
 #include <linux/threads.h>
+#include <linux/compiler.h>
 
 /*
  * Default implementation of macro that returns current
@@ -279,7 +280,7 @@ extern unsigned long get_wchan(struct ta
 #define KSTK_EIP(tsk)  ((tsk)->thread.pc)
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
 
-#define cpu_relax()	do { } while (0)
+#define cpu_relax()	barrier()
 
 #endif	/* __ASSEMBLY__ */
 #endif /* __ASM_SH64_PROCESSOR_H */
diff --git a/include/asm-v850/processor.h b/include/asm-v850/processor.h
index 6965b66..979e346 100644
--- a/include/asm-v850/processor.h
+++ b/include/asm-v850/processor.h
@@ -18,6 +18,7 @@ #ifndef __ASSEMBLY__ /* <linux/thread_in
 #include <linux/thread_info.h>
 #endif
 
+#include <linux/compiler.h>
 #include <asm/ptrace.h>
 #include <asm/entry.h>
 
@@ -106,7 +107,7 @@ #define KSTK_EIP(task)	task_pc (task)
 #define KSTK_ESP(task)	task_sp (task)
 
 
-#define cpu_relax()    ((void)0)
+#define cpu_relax()    barrier()
 
 
 #else /* __ASSEMBLY__ */
diff --git a/include/asm-xtensa/processor.h b/include/asm-xtensa/processor.h
index d1d72ad..8b96e77 100644
--- a/include/asm-xtensa/processor.h
+++ b/include/asm-xtensa/processor.h
@@ -20,6 +20,7 @@ #include <xtensa/config/specreg.h>
 #include <xtensa/config/tie.h>
 #include <xtensa/config/system.h>
 
+#include <linux/compiler.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/coprocessor.h>
@@ -191,7 +192,7 @@ extern unsigned long get_wchan(struct ta
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
 
-#define cpu_relax()  do { } while (0)
+#define cpu_relax()  barrier()
 
 /* Special register access. */
 
