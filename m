Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUIJCuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUIJCuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIJCuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:50:09 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:1764 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266914AbUIJCuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:50:03 -0400
Date: Thu, 9 Sep 2004 22:54:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix i386 SPINLOCK_MAGIC debugging
Message-ID: <Pine.LNX.4.53.0409092233010.2216@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a label isn't sufficent anymore for determining the location of the 
failed lock. Use __builtin_return_address instead.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

--- linux-2.6-bk/include/asm-i386/spinlock.h.orig	2004-09-09 11:16:43.206108976 -0400
+++ linux-2.6-bk/include/asm-i386/spinlock.h	2004-09-09 11:18:18.131678096 -0400
@@ -128,10 +128,8 @@ static inline int _raw_spin_trylock(spin
 static inline void _raw_spin_lock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	__label__ here;
-here:
 	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("eip: %p\n", &&here);
+		printk("eip: %p\n", __builtin_return_address(0));
 		BUG();
 	}
 #endif
@@ -143,10 +141,8 @@ here:
 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	__label__ here;
-here:
 	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("eip: %p\n", &&here);
+		printk("eip: %p\n", __builtin_return_address(0));
 		BUG();
 	}
 #endif
