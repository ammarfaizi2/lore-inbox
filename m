Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUIJDDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUIJDDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUIJDDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:03:42 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:12005 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267526AbUIJDDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:03:30 -0400
Date: Thu, 9 Sep 2004 23:07:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix x86_64 SPINLOCK_MAGIC debugging
In-Reply-To: <Pine.LNX.4.53.0409092233010.2216@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0409092305130.2216@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0409092233010.2216@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a label isn't sufficent anymore for determining the location of the
failed lock. Use __builtin_return_address instead.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

--- linux-2.6-bk/include/asm-x86_64/spinlock.h.orig	2004-09-09 22:58:46.389411752 -0400
+++ linux-2.6-bk/include/asm-x86_64/spinlock.h	2004-09-09 23:00:31.513430472 -0400
@@ -113,10 +113,8 @@ static inline int _raw_spin_trylock(spin
 static inline void _raw_spin_lock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	__label__ here;
-here:
 	if (lock->magic != SPINLOCK_MAGIC) {
-printk("eip: %p\n", &&here);
+		printk("eip: %p\n", __builtin_return_address(0));
 		BUG();
 	}
 #endif
