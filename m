Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVC3BAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVC3BAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVC3BAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:00:41 -0500
Received: from mail.renesas.com ([202.234.163.13]:37601 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261699AbVC3BAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:00:19 -0500
Date: Wed, 30 Mar 2005 10:00:09 +0900 (JST)
Message-Id: <20050330.100009.173883059.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1] m32r: Fix spinlock.h for CONFIG_DEBUG_SPINLOCK
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for fixing a build error of asm-m32r/spinlock.h
for CONFIG_DEBUG_SPINLOCK.
Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/spinlock.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -ruNp a/include/asm-m32r/spinlock.h b/include/asm-m32r/spinlock.h
--- a/include/asm-m32r/spinlock.h	2005-03-07 14:10:57.000000000 +0900
+++ b/include/asm-m32r/spinlock.h	2005-03-08 14:08:57.000000000 +0900
@@ -102,10 +102,8 @@ static inline void _raw_spin_lock(spinlo
 	unsigned long tmp0, tmp1;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-	__label__ here;
-here:
-	if (lock->magic != SPINLOCK_MAGIC) {
-		printk("pc: %p\n", &&here);
+	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
+		printk("pc: %p\n", __builtin_return_address(0));
 		BUG();
 	}
 #endif

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

