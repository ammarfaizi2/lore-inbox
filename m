Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVASViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVASViT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVASViT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:38:19 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:40362 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261909AbVASVh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:37:58 -0500
Date: Wed, 19 Jan 2005 22:38:22 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/4] rwsem style cleanups
Message-ID: <20050119213822.GB8471@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	dhowells@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>

Changes some coding style and formatting to match David's preference.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Dominik Brodowski <linux@brodo.de>

---

 linux-2.6-npiggin/lib/rwsem-spinlock.c |   12 +++++++-----
 linux-2.6-npiggin/lib/rwsem.c          |   20 +++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff -puN lib/rwsem.c~rwsem-style lib/rwsem.c
--- linux-2.6/lib/rwsem.c~rwsem-style	2005-01-19 13:34:48.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem.c	2005-01-19 13:39:06.000000000 +1100
@@ -9,9 +9,9 @@
 #include <linux/module.h>
 
 struct rwsem_waiter {
-	struct list_head list;
-	struct task_struct *task;
-	unsigned int flags;
+	struct list_head	list;
+	struct task_struct	*task;
+	unsigned int		flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
 #define RWSEM_WAITING_FOR_WRITE	0x00000002
 };
@@ -28,7 +28,8 @@ void rwsemtrace(struct rw_semaphore *sem
 #endif
 
 /*
- * handle the lock release when processes blocked on it that can now run
+ * handle the lock being released whilst there are processes blocked on it
+ * that can now run.
  * - if we come here from up_xxxx(), then:
  *   - the 'active part' of count (&0x0000ffff) reached 0 (but may have changed)
  *   - the 'waiting part' of count (&0xffff0000) is -ve (and will still be so)
@@ -62,8 +63,9 @@ __rwsem_do_wake(struct rw_semaphore *sem
 	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
 
 	/* try to grant a single write lock if there's a writer at the front
-	 * of the queue - note we leave the 'active part' of the count
-	 * incremented by 1 and the waiting part incremented by 0x00010000
+	 * of the queue
+	 * - note we leave the 'active part' of the count
+	 *   incremented by 1 and the waiting part incremented by 0x00010000
 	 */
 	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
 		goto readers_only;
@@ -159,7 +161,11 @@ rwsem_down_failed_common(struct rw_semap
 	/* we're now waiting on the lock, but no longer actively read-locking */
 	count = rwsem_atomic_update(adjustment, sem);
 
-	/* if there are no active locks, wake the front queued process(es) up */
+	/* if there are no longer active locks, wake the front queued
+	 * process(es) up.
+	 * - it might even be this process, since the waker takes a more
+	 *   active part
+	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem, 0);
 
diff -puN lib/rwsem-spinlock.c~rwsem-style lib/rwsem-spinlock.c
--- linux-2.6/lib/rwsem-spinlock.c~rwsem-style	2005-01-19 13:34:48.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem-spinlock.c	2005-01-19 13:39:06.000000000 +1100
@@ -10,9 +10,9 @@
 #include <linux/module.h>
 
 struct rwsem_waiter {
-	struct list_head list;
-	struct task_struct *task;
-	unsigned int flags;
+	struct list_head	list;
+	struct task_struct	*task;
+	unsigned int		flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
 #define RWSEM_WAITING_FOR_WRITE	0x00000002
 };
@@ -41,7 +41,8 @@ void fastcall init_rwsem(struct rw_semap
 }
 
 /*
- * handle the lock release when processes blocked on it that can now run
+ * handle the lock being released whilst there are processes blocked on it
+ * that can now run.
  * - if we come here, then:
  *   - the 'active count' _reached_ zero
  *   - the 'waiting count' is non-zero
@@ -83,7 +84,8 @@ __rwsem_do_wake(struct rw_semaphore *sem
 		goto out;
 	}
 
-	/* grant an infinite number of read locks to the front of the queue */
+	/* grant an infinite number of read locks to the readers at the front
+	 * of the queue */
  dont_wake_writers:
 	woken = 0;
 	while (waiter->flags & RWSEM_WAITING_FOR_READ) {

_
