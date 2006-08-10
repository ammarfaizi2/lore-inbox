Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWHJUT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWHJUT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWHJUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:26091 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932522AbWHJTfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:53 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [38/145] x86_64: Switch rwlocks over to patchable lock prefix
Message-Id: <20060810193552.3748113B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:52 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This way their lock prefix can be patched away on UP

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/spinlock.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/asm-x86_64/spinlock.h
===================================================================
--- linux.orig/include/asm-x86_64/spinlock.h
+++ linux/include/asm-x86_64/spinlock.h
@@ -125,13 +125,13 @@ static inline int __raw_write_trylock(ra
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+	asm volatile(LOCK_PREFIX "incl %0" :"=m" (rw->lock) : : "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0"
-				: "=m" (rw->lock) : : "memory");
+	asm volatile(LOCK_PREFIX "addl %1,%0"
+				: "=m" (rw->lock) : "i" (RW_LOCK_BIAS) : "memory");
 }
 
 #endif /* __ASM_SPINLOCK_H */
