Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756045AbWKQX65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbWKQX65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbWKQX6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:58:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36358 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756045AbWKQX6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:58:34 -0500
Date: Sat, 18 Nov 2006 00:58:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] remove kernel/lockdep.c:lockdep_internal
Message-ID: <20061117235833.GO31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the no longer used lockdep_internal().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/lockdep.h |    6 ------
 kernel/lockdep.c        |    7 -------
 2 files changed, 13 deletions(-)

--- linux-2.6.19-rc5-mm2/include/linux/lockdep.h.old	2006-11-17 18:59:56.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/lockdep.h	2006-11-17 19:00:07.000000000 +0100
@@ -193,7 +193,6 @@
 
 extern void lockdep_off(void);
 extern void lockdep_on(void);
-extern int lockdep_internal(void);
 
 /*
  * These methods are used by specific locking variants (spinlocks,
@@ -255,11 +254,6 @@
 {
 }
 
-static inline int lockdep_internal(void)
-{
-	return 0;
-}
-
 # define lock_acquire(l, s, t, r, c, i)		do { } while (0)
 # define lock_release(l, n, i)			do { } while (0)
 # define lockdep_init()				do { } while (0)
--- linux-2.6.19-rc5-mm2/kernel/lockdep.c.old	2006-11-17 19:00:17.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/lockdep.c	2006-11-17 19:00:33.000000000 +0100
@@ -140,13 +140,6 @@
 
 EXPORT_SYMBOL(lockdep_on);
 
-int lockdep_internal(void)
-{
-	return current->lockdep_recursion != 0;
-}
-
-EXPORT_SYMBOL(lockdep_internal);
-
 /*
  * Debugging switches:
  */

