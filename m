Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVJBAEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVJBAEc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 20:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVJBAEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 20:04:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1554 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750914AbVJBAEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 20:04:32 -0400
Date: Sun, 2 Oct 2005 02:04:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-v850/ "extern inline" -> "static inline"
Message-ID: <20051002000430.GJ4212@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-v850/atomic.h    |    2 +-
 include/asm-v850/bitops.h    |    6 +++---
 include/asm-v850/delay.h     |    4 ++--
 include/asm-v850/hw_irq.h    |    2 +-
 include/asm-v850/processor.h |    4 ++--
 include/asm-v850/semaphore.h |   10 +++++-----
 include/asm-v850/system.h    |    2 +-
 include/asm-v850/tlbflush.h  |    4 ++--
 include/asm-v850/uaccess.h   |    2 +-
 include/asm-v850/unaligned.h |    6 +++---
 10 files changed, 21 insertions(+), 21 deletions(-)

--- linux-2.6.14-rc2-mm2-full/include/asm-v850/atomic.h.old	2005-10-02 02:00:29.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/atomic.h	2005-10-02 02:00:32.000000000 +0200
@@ -31,7 +31,7 @@
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v,i)		(((v)->counter) = (i))
 
-extern __inline__ int atomic_add_return (int i, volatile atomic_t *v)
+static inline int atomic_add_return (int i, volatile atomic_t *v)
 {
 	unsigned long flags;
 	int res;
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/bitops.h.old	2005-10-02 02:00:43.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/bitops.h	2005-10-02 02:00:46.000000000 +0200
@@ -30,7 +30,7 @@
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
  */
-extern __inline__ unsigned long ffz (unsigned long word)
+static inline unsigned long ffz (unsigned long word)
 {
 	unsigned long result = 0;
 
@@ -135,7 +135,7 @@
 			     "m" (*((const char *)(addr) + ((nr) >> 3))));    \
      __test_bit_res;							      \
   })
-extern __inline__ int __test_bit (int nr, const void *addr)
+static inline int __test_bit (int nr, const void *addr)
 {
 	int res;
 	__asm__ __volatile__ ("tst1 %1, [%2]; setf nz, %0"
@@ -157,7 +157,7 @@
 #define find_first_zero_bit(addr, size) \
   find_next_zero_bit ((addr), (size), 0)
 
-extern __inline__ int find_next_zero_bit(const void *addr, int size, int offset)
+static inline int find_next_zero_bit(const void *addr, int size, int offset)
 {
 	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/delay.h.old	2005-10-02 02:00:54.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/delay.h	2005-10-02 02:00:58.000000000 +0200
@@ -16,7 +16,7 @@
 
 #include <asm/param.h>
 
-extern __inline__ void __delay(unsigned long loops)
+static inline void __delay(unsigned long loops)
 {
 	if (loops)
 		__asm__ __volatile__ ("1: add -1, %0; bnz 1b"
@@ -33,7 +33,7 @@
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+static inline void udelay(unsigned long usecs)
 {
 	register unsigned long full_loops, part_loops;
 
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/hw_irq.h.old	2005-10-02 02:01:06.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/hw_irq.h	2005-10-02 02:01:12.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef __V850_HW_IRQ_H__
 #define __V850_HW_IRQ_H__
 
-extern inline void hw_resend_irq (struct hw_interrupt_type *h, unsigned int i)
+static inline void hw_resend_irq (struct hw_interrupt_type *h, unsigned int i)
 {
 }
 
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/processor.h.old	2005-10-02 02:01:20.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/processor.h	2005-10-02 02:01:24.000000000 +0200
@@ -59,7 +59,7 @@
 
 
 /* Do necessary setup to start up a newly executed thread.  */
-extern inline void start_thread (struct pt_regs *regs,
+static inline void start_thread (struct pt_regs *regs,
 				 unsigned long pc, unsigned long usp)
 {
 	regs->pc = pc;
@@ -68,7 +68,7 @@
 }
 
 /* Free all resources held by a thread. */
-extern inline void release_thread (struct task_struct *dead_task)
+static inline void release_thread (struct task_struct *dead_task)
 {
 }
 
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/semaphore.h.old	2005-10-02 02:01:32.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/semaphore.h	2005-10-02 02:01:35.000000000 +0200
@@ -27,7 +27,7 @@
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC (name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC (name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+static inline void sema_init (struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }
@@ -55,14 +55,14 @@
 extern int  __down_trylock (struct semaphore * sem);
 extern void __up (struct semaphore * sem);
 
-extern inline void down (struct semaphore * sem)
+static inline void down (struct semaphore * sem)
 {
 	might_sleep();
 	if (atomic_dec_return (&sem->count) < 0)
 		__down (sem);
 }
 
-extern inline int down_interruptible (struct semaphore * sem)
+static inline int down_interruptible (struct semaphore * sem)
 {
 	int ret = 0;
 	might_sleep();
@@ -71,7 +71,7 @@
 	return ret;
 }
 
-extern inline int down_trylock (struct semaphore *sem)
+static inline int down_trylock (struct semaphore *sem)
 {
 	int ret = 0;
 	if (atomic_dec_return (&sem->count) < 0)
@@ -79,7 +79,7 @@
 	return ret;
 }
 
-extern inline void up (struct semaphore * sem)
+static inline void up (struct semaphore * sem)
 {
 	if (atomic_inc_return (&sem->count) <= 0)
 		__up (sem);
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/system.h.old	2005-10-02 02:01:44.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/system.h	2005-10-02 02:01:48.000000000 +0200
@@ -81,7 +81,7 @@
   ((__typeof__ (*(ptr)))__xchg ((unsigned long)(with), (ptr), sizeof (*(ptr))))
 #define tas(ptr) (xchg ((ptr), 1))
 
-extern inline unsigned long __xchg (unsigned long with,
+static inline unsigned long __xchg (unsigned long with,
 				    __volatile__ void *ptr, int size)
 {
 	unsigned long tmp, flags;
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/tlbflush.h.old	2005-10-02 02:01:55.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/tlbflush.h	2005-10-02 02:01:58.000000000 +0200
@@ -56,12 +56,12 @@
 	BUG ();
 }
 
-extern inline void flush_tlb_kernel_page(unsigned long addr)
+static inline void flush_tlb_kernel_page(unsigned long addr)
 {
 	BUG ();
 }
 
-extern inline void flush_tlb_pgtables(struct mm_struct *mm,
+static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
 	BUG ();
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/uaccess.h.old	2005-10-02 02:02:06.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/uaccess.h	2005-10-02 02:02:10.000000000 +0200
@@ -14,7 +14,7 @@
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
 
-extern inline int access_ok (int type, const void *addr, unsigned long size)
+static inline int access_ok (int type, const void *addr, unsigned long size)
 {
 	/* XXX I guess we should check against real ram bounds at least, and
 	   possibly make sure ADDR is not within the kernel.
--- linux-2.6.14-rc2-mm2-full/include/asm-v850/unaligned.h.old	2005-10-02 02:02:19.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/include/asm-v850/unaligned.h	2005-10-02 02:02:33.000000000 +0200
@@ -82,19 +82,19 @@
 	})
 
 
-extern inline void __put_unaligned_2(__u32 __v, register __u8 *__p)
+static inline void __put_unaligned_2(__u32 __v, register __u8 *__p)
 {
 	*__p++ = __v;
 	*__p++ = __v >> 8;
 }
 
-extern inline void __put_unaligned_4(__u32 __v, register __u8 *__p)
+static inline void __put_unaligned_4(__u32 __v, register __u8 *__p)
 {
 	__put_unaligned_2(__v >> 16, __p + 2);
 	__put_unaligned_2(__v, __p);
 }
 
-extern inline void __put_unaligned_8(const unsigned long long __v, register __u8 *__p)
+static inline void __put_unaligned_8(const unsigned long long __v, register __u8 *__p)
 {
 	/*
 	 * tradeoff: 8 bytes of stack for all unaligned puts (2

