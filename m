Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWHWAvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWHWAvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWHWAvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:51:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:42678 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932115AbWHWAvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:51:36 -0400
Subject: [PATCH] Make spinlock/rwlock annotations more accurate by using
	parameters, not types
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 17:51:38 -0700
Message-Id: <1156294298.4510.5.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock annotations used on spinlocks and rwlocks currently use
__{acquires,releases}(spinlock_t) and __{acquires,releases}(rwlock_t),
respectively.  This loses the information of which lock actually got acquired
or released, and assumes a different type for the parameter of __acquires and
__releases than the rest of the kernel.  While the current implementations of
__acquires and __releases throw away their argument, this will not always
remain the case.  Change this to use the lock parameter instead, to preserve
this information and increase consistency in usage of __acquires and
__releases.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 include/linux/spinlock_api_smp.h |   50 +++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index b2c4f82..8828b81 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -19,41 +19,41 @@ int in_lock_functions(unsigned long addr
 
 #define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
 
-void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(spinlock_t);
+void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
 void __lockfunc _spin_lock_nested(spinlock_t *lock, int subclass)
-							__acquires(spinlock_t);
-void __lockfunc _read_lock(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(spinlock_t);
-void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(spinlock_t);
-void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
+							__acquires(lock);
+void __lockfunc _read_lock(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _write_lock(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(lock);
+void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(lock);
+void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
-							__acquires(spinlock_t);
+							__acquires(lock);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
-							__acquires(rwlock_t);
+							__acquires(lock);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
-							__acquires(rwlock_t);
+							__acquires(lock);
 int __lockfunc _spin_trylock(spinlock_t *lock);
 int __lockfunc _read_trylock(rwlock_t *lock);
 int __lockfunc _write_trylock(rwlock_t *lock);
 int __lockfunc _spin_trylock_bh(spinlock_t *lock);
-void __lockfunc _spin_unlock(spinlock_t *lock)		__releases(spinlock_t);
-void __lockfunc _read_unlock(rwlock_t *lock)		__releases(rwlock_t);
-void __lockfunc _write_unlock(rwlock_t *lock)		__releases(rwlock_t);
-void __lockfunc _spin_unlock_bh(spinlock_t *lock)	__releases(spinlock_t);
-void __lockfunc _read_unlock_bh(rwlock_t *lock)		__releases(rwlock_t);
-void __lockfunc _write_unlock_bh(rwlock_t *lock)	__releases(rwlock_t);
-void __lockfunc _spin_unlock_irq(spinlock_t *lock)	__releases(spinlock_t);
-void __lockfunc _read_unlock_irq(rwlock_t *lock)	__releases(rwlock_t);
-void __lockfunc _write_unlock_irq(rwlock_t *lock)	__releases(rwlock_t);
+void __lockfunc _spin_unlock(spinlock_t *lock)		__releases(lock);
+void __lockfunc _read_unlock(rwlock_t *lock)		__releases(lock);
+void __lockfunc _write_unlock(rwlock_t *lock)		__releases(lock);
+void __lockfunc _spin_unlock_bh(spinlock_t *lock)	__releases(lock);
+void __lockfunc _read_unlock_bh(rwlock_t *lock)		__releases(lock);
+void __lockfunc _write_unlock_bh(rwlock_t *lock)	__releases(lock);
+void __lockfunc _spin_unlock_irq(spinlock_t *lock)	__releases(lock);
+void __lockfunc _read_unlock_irq(rwlock_t *lock)	__releases(lock);
+void __lockfunc _write_unlock_irq(rwlock_t *lock)	__releases(lock);
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
-							__releases(spinlock_t);
+							__releases(lock);
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
-							__releases(rwlock_t);
+							__releases(lock);
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
-							__releases(rwlock_t);
+							__releases(lock);
 
 #endif /* __LINUX_SPINLOCK_API_SMP_H */
-- 
1.4.1.1


