Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTDVT0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDVTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:25:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:63104 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263483AbTDVTYl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:24:41 -0400
Message-Id: <200304221936.h3MJajLq004928@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 - #if cleanup include/* (4/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:36:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the include/* subtree

--- linux-2.5.68-bk3/include/asm-alpha/hardirq.h.dist	2003-04-07 13:31:54.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-alpha/hardirq.h	2003-04-22 14:33:01.257991931 -0400
@@ -79,7 +79,7 @@
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 #define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-alpha/kmap_types.h.dist	2003-04-07 13:33:02.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-alpha/kmap_types.h	2003-04-22 14:33:22.719949673 -0400
@@ -5,7 +5,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
--- linux-2.5.68-bk3/include/asm-alpha/spinlock.h.dist	2003-04-07 13:31:52.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-alpha/spinlock.h	2003-04-22 14:32:41.980007394 -0400
@@ -16,7 +16,7 @@
 
 typedef struct {
 	volatile unsigned int lock /*__attribute__((aligned(32))) */;
-#if CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_DEBUG_SPINLOCK
 	int on_cpu;
 	int line_no;
 	void *previous;
@@ -25,7 +25,7 @@
 #endif
 } spinlock_t;
 
-#if CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define SPIN_LOCK_UNLOCKED (spinlock_t) {0, -1, 0, 0, 0, 0}
 #define spin_lock_init(x)						\
 	((x)->lock = 0, (x)->on_cpu = -1, (x)->previous = 0, (x)->task = 0)
@@ -37,7 +37,7 @@
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	({ do { barrier(); } while ((x)->lock); })
 
-#if CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_DEBUG_SPINLOCK
 extern void _raw_spin_unlock(spinlock_t * lock);
 extern void debug_spin_lock(spinlock_t * lock, const char *, int);
 extern int debug_spin_trylock(spinlock_t * lock, const char *, int);
@@ -102,7 +102,7 @@
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x)	(*(volatile int *)(x) != 0)
 
-#if CONFIG_DEBUG_RWLOCK
+#ifdef CONFIG_DEBUG_RWLOCK
 extern void _raw_write_lock(rwlock_t * lock);
 extern void _raw_read_lock(rwlock_t * lock);
 #else
--- linux-2.5.68-bk3/include/asm-generic/rmap.h.dist	2003-04-07 13:31:50.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-generic/rmap.h	2003-04-22 14:17:03.724069151 -0400
@@ -61,7 +61,7 @@
 	return page->index + low_bits;
 }
 
-#if CONFIG_HIGHPTE
+#ifdef CONFIG_HIGHPTE
 static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
 {
 	pte_addr_t paddr;
--- linux-2.5.68-bk3/include/asm-h8300/hardirq.h.dist	2003-04-22 13:57:12.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-h8300/hardirq.h	2003-04-22 14:36:36.254331065 -0400
@@ -74,13 +74,13 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-i386/kmap_types.h.dist	2003-04-07 13:32:16.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-i386/kmap_types.h	2003-04-22 14:09:28.691688260 -0400
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
--- linux-2.5.68-bk3/include/asm-ia64/hardirq.h.dist	2003-04-07 13:30:58.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-ia64/hardirq.h	2003-04-22 14:22:23.429873916 -0400
@@ -85,7 +85,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()		((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-ia64/kmap_types.h.dist	2003-04-07 13:31:20.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-ia64/kmap_types.h	2003-04-22 14:22:56.645231376 -0400
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
--- linux-2.5.68-bk3/include/asm-ia64/sn/addrs.h.dist	2003-04-07 13:32:17.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-ia64/sn/addrs.h	2003-04-22 14:21:46.958356498 -0400
@@ -215,7 +215,7 @@
 #define REMOTE_HUB_ADDR(_n, _x)	(HUBREG_CAST (NODE_SWIN_BASE(_n, 1) +	\
 					      0x800000 + (_x)))
 #endif
-#if CONFIG_IA64_SGI_SN1
+#ifdef CONFIG_IA64_SGI_SN1
 #define REMOTE_HUB_PI_ADDR(_n, _sn, _x)	(HUBREG_CAST (NODE_SWIN_BASE(_n, 1) +	\
 					      0x800000 + PIREG(_x, _sn)))
 #endif
--- linux-2.5.68-bk3/include/asm-m68k/hardirq.h.dist	2003-04-07 13:31:19.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-m68k/hardirq.h	2003-04-22 14:21:09.957942347 -0400
@@ -73,7 +73,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-m68knommu/hardirq.h.dist	2003-04-07 13:30:39.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-m68knommu/hardirq.h	2003-04-22 14:24:20.771377079 -0400
@@ -72,13 +72,13 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-parisc/hardirq.h.dist	2003-04-07 13:32:49.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-parisc/hardirq.h	2003-04-22 14:25:21.058584265 -0400
@@ -87,7 +87,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # error CONFIG_PREEMT currently not supported.
 # define in_atomic()	 BUG()
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
--- linux-2.5.68-bk3/include/asm-parisc/kmap_types.h.dist	2003-04-07 13:31:25.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-parisc/kmap_types.h	2003-04-22 14:24:44.349898980 -0400
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
--- linux-2.5.68-bk3/include/asm-ppc/hardirq.h.dist	2003-04-07 13:30:33.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-ppc/hardirq.h	2003-04-22 14:18:32.517557368 -0400
@@ -82,7 +82,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-ppc/spinlock.h.dist	2003-04-07 13:31:04.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-ppc/spinlock.h	2003-04-22 14:20:27.011073365 -0400
@@ -17,7 +17,7 @@
 } spinlock_t;
 
 #ifdef __KERNEL__
-#if CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_DEBUG_INIT     , 0, 0
 #else
 #define SPINLOCK_DEBUG_INIT     /* */
@@ -86,7 +86,7 @@
 #endif
 } rwlock_t;
 
-#if CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_DEBUG_INIT     , 0
 #else
 #define RWLOCK_DEBUG_INIT     /* */
--- linux-2.5.68-bk3/include/asm-s390/hardirq.h.dist	2003-04-22 13:57:13.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-s390/hardirq.h	2003-04-22 14:35:16.639676363 -0400
@@ -82,7 +82,7 @@
 
 #define invoke_softirq() do_call_softirq()
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(in_interrupt() || preempt_count() == PREEMPT_ACTIVE)
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-sparc/hardirq.h.dist	2003-04-07 13:33:03.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-sparc/hardirq.h	2003-04-22 14:31:37.338399934 -0400
@@ -90,7 +90,7 @@
 #ifndef CONFIG_SMP
 #define irq_enter()             (preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
@@ -116,7 +116,7 @@
 #define irq_exit()		br_read_unlock(BR_GLOBALIRQ_LOCK)
 #endif
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 #else
 # define in_atomic()	(preempt_count() != 0)
--- linux-2.5.68-bk3/include/asm-sparc64/hardirq.h.dist	2003-04-07 13:32:16.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-sparc64/hardirq.h	2003-04-22 14:35:42.176212765 -0400
@@ -85,7 +85,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	(preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-um/pgtable.h.dist	2003-04-07 13:33:04.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-um/pgtable.h	2003-04-22 14:30:32.294945988 -0400
@@ -71,7 +71,7 @@
 #define VMALLOC_START	(((unsigned long) high_physmem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
 #else
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
--- linux-2.5.68-bk3/include/asm-v850/hardirq.h.dist	2003-04-07 13:30:43.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-v850/hardirq.h	2003-04-22 14:36:10.630013922 -0400
@@ -72,7 +72,7 @@
 
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()    (preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/asm-x86_64/hardirq.h.dist	2003-04-07 13:30:44.000000000 -0400
+++ linux-2.5.68-bk3/include/asm-x86_64/hardirq.h	2003-04-22 14:30:59.932623924 -0400
@@ -81,7 +81,7 @@
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()   ((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
--- linux-2.5.68-bk3/include/linux/blkdev.h.dist	2003-04-22 13:57:47.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/blkdev.h	2003-04-22 14:26:51.832118330 -0400
@@ -301,7 +301,7 @@
 #define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
-#if CONFIG_MMU
+#ifdef CONFIG_MMU
 extern int init_emergency_isa_pool(void);
 extern void blk_queue_bounce(request_queue_t *q, struct bio **bio);
 #else
--- linux-2.5.68-bk3/include/linux/nfs_fs_sb.h.dist	2003-04-22 13:57:15.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/nfs_fs_sb.h	2003-04-22 14:29:11.472369919 -0400
@@ -27,7 +27,7 @@
 	char *			hostname;	/* remote hostname */
 	struct nfs_fh		fh;
 	struct sockaddr_in	addr;
-#if CONFIG_NFS_V4
+#ifdef CONFIG_NFS_V4
 	/* Our own IP address, as a null-terminated string.
 	 * This is used to generate the clientid, and the callback address.
 	 */
--- linux-2.5.68-bk3/include/linux/sched.h.dist	2003-04-22 13:57:47.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/sched.h	2003-04-22 14:25:44.691000514 -0400
@@ -467,7 +467,7 @@
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
--- linux-2.5.68-bk3/include/linux/smp_lock.h.dist	2003-04-07 13:32:23.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/smp_lock.h	2003-04-22 14:28:36.256063695 -0400
@@ -5,7 +5,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 
 extern spinlock_t kernel_flag;
 
--- linux-2.5.68-bk3/include/linux/timer.h.dist	2003-04-07 13:32:16.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/timer.h	2003-04-22 14:28:06.433267476 -0400
@@ -65,7 +65,7 @@
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
   
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list * timer);
 #else
 # define del_timer_sync(t) del_timer(t)
--- linux-2.5.68-bk3/include/linux/tpqic02.h.dist	2003-04-07 13:30:44.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/tpqic02.h	2003-04-22 14:26:26.173990938 -0400
@@ -12,7 +12,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_QIC02_TAPE || CONFIG_QIC02_TAPE_MODULE
+#if defined(CONFIG_QIC02_TAPE) || defined(CONFIG_QIC02_TAPE_MODULE)
 
 /* need to have QIC02_TAPE_DRIVE and QIC02_TAPE_IFC expand to something */
 #include <linux/mtio.h>

