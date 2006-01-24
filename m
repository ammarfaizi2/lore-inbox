Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWAXSKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWAXSKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWAXSKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:10:14 -0500
Received: from users.ccur.com ([66.10.65.2]:28577 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1030431AbWAXSKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:10:12 -0500
Date: Tue, 24 Jan 2006 13:09:54 -0500
From: Joe Korty <joe.korty@ccur.com>
To: mingo@elte.hu
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124180954.GA14506@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make NOPed versions of __raw_read_lock and family available
under uniprocessor kernels.

Discovered when compiling a uniprocessor kernel with the
fusyn patch applied.

The standard kernel does not use __raw_read_lock etc
outside of spinlock.c, which may account for this bug
being undiscovered until now.


 2.6.16-rc1-git4-jak/include/linux/spinlock_up.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff -puNa include/linux/spinlock_up.h~define.__raw_read_lock.and.family.for.uniproc-nodebug.combo include/linux/spinlock_up.h
--- 2.6.16-rc1-git4/include/linux/spinlock_up.h~define.__raw_read_lock.and.family.for.uniproc-nodebug.combo	2006-01-24 12:57:15.000000000 -0500
+++ 2.6.16-rc1-git4-jak/include/linux/spinlock_up.h	2006-01-24 12:58:51.000000000 -0500
@@ -47,16 +47,6 @@ static inline void __raw_spin_unlock(raw
 	lock->slock = 1;
 }
 
-/*
- * Read-write spinlocks. No debug version.
- */
-#define __raw_read_lock(lock)		do { (void)(lock); } while (0)
-#define __raw_write_lock(lock)		do { (void)(lock); } while (0)
-#define __raw_read_trylock(lock)	({ (void)(lock); 1; })
-#define __raw_write_trylock(lock)	({ (void)(lock); 1; })
-#define __raw_read_unlock(lock)		do { (void)(lock); } while (0)
-#define __raw_write_unlock(lock)	do { (void)(lock); } while (0)
-
 #else /* DEBUG_SPINLOCK */
 #define __raw_spin_is_locked(lock)	((void)(lock), 0)
 /* for sched.c and kernel_lock.c: */
@@ -71,4 +61,14 @@ static inline void __raw_spin_unlock(raw
 #define __raw_spin_unlock_wait(lock) \
 		do { cpu_relax(); } while (__raw_spin_is_locked(lock))
 
+/*
+ * Read-write spinlocks. Only non-debug versions available.
+ */
+#define __raw_read_lock(lock)		do { (void)(lock); } while (0)
+#define __raw_write_lock(lock)		do { (void)(lock); } while (0)
+#define __raw_read_trylock(lock)	({ (void)(lock); 1; })
+#define __raw_write_trylock(lock)	({ (void)(lock); 1; })
+#define __raw_read_unlock(lock)		do { (void)(lock); } while (0)
+#define __raw_write_unlock(lock)	do { (void)(lock); } while (0)
+
 #endif /* __LINUX_SPINLOCK_UP_H */

_
