Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936477AbWLALvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936477AbWLALvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936478AbWLALvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:51:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57862 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S936477AbWLALvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:51:08 -0500
Date: Fri, 1 Dec 2006 12:51:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: starvik@axis.com, dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-cris/: parisc: "extern inline" -> "static inline"
Message-ID: <20061201115112.GS11084@stusta.de>
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

 include/asm-cris/arch-v10/bitops.h  |   10 +++++-----
 include/asm-cris/semaphore-helper.h |    8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.19-rc5-mm2/include/asm-cris/arch-v10/bitops.h.old	2006-11-22 01:51:28.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-cris/arch-v10/bitops.h	2006-11-22 01:51:31.000000000 +0100
@@ -10,7 +10,7 @@
  * number.  They differ in that the first function also inverts all bits
  * in the input.
  */
-extern inline unsigned long cris_swapnwbrlz(unsigned long w)
+static inline unsigned long cris_swapnwbrlz(unsigned long w)
 {
 	/* Let's just say we return the result in the same register as the
 	   input.  Saying we clobber the input but can return the result
@@ -26,7 +26,7 @@ extern inline unsigned long cris_swapnwb
 	return res;
 }
 
-extern inline unsigned long cris_swapwbrlz(unsigned long w)
+static inline unsigned long cris_swapwbrlz(unsigned long w)
 {
 	unsigned res;
 	__asm__ ("swapwbr %0 \n\t"
@@ -40,7 +40,7 @@ extern inline unsigned long cris_swapwbr
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
  */
-extern inline unsigned long ffz(unsigned long w)
+static inline unsigned long ffz(unsigned long w)
 {
 	return cris_swapnwbrlz(w);
 }
@@ -51,7 +51,7 @@ extern inline unsigned long ffz(unsigned
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-extern inline unsigned long __ffs(unsigned long word)
+static inline unsigned long __ffs(unsigned long word)
 {
 	return cris_swapnwbrlz(~word);
 }
@@ -65,7 +65,7 @@ extern inline unsigned long __ffs(unsign
  * differs in spirit from the above ffz (man ffs).
  */
 
-extern inline unsigned long kernel_ffs(unsigned long w)
+static inline unsigned long kernel_ffs(unsigned long w)
 {
 	return w ? cris_swapwbrlz (w) + 1 : 0;
 }
--- linux-2.6.19-rc5-mm2/include/asm-cris/semaphore-helper.h.old	2006-11-22 01:51:39.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-cris/semaphore-helper.h	2006-11-22 01:51:42.000000000 +0100
@@ -20,12 +20,12 @@
 /*
  * These two _must_ execute atomically wrt each other.
  */
-extern inline void wake_one_more(struct semaphore * sem)
+static inline void wake_one_more(struct semaphore * sem)
 {
 	atomic_inc(&sem->waking);
 }
 
-extern inline int waking_non_zero(struct semaphore *sem)
+static inline int waking_non_zero(struct semaphore *sem)
 {
 	unsigned long flags;
 	int ret = 0;
@@ -40,7 +40,7 @@ extern inline int waking_non_zero(struct
 	return ret;
 }
 
-extern inline int waking_non_zero_interruptible(struct semaphore *sem,
+static inline int waking_non_zero_interruptible(struct semaphore *sem,
 						struct task_struct *tsk)
 {
 	int ret = 0;
@@ -59,7 +59,7 @@ extern inline int waking_non_zero_interr
 	return ret;
 }
 
-extern inline int waking_non_zero_trylock(struct semaphore *sem)
+static inline int waking_non_zero_trylock(struct semaphore *sem)
 {
         int ret = 1;
 	unsigned long flags;

