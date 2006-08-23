Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWHWAv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWHWAv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHWAv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:51:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:24809 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932246AbWHWAv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:51:58 -0400
Subject: [PATCH] Replace _spin_trylock with spin_trylock in the IRQ
	variants to use __cond_lock
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 17:52:02 -0700
Message-Id: <1156294322.4510.7.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spin_trylock_irq and spin_trylock_irqsave use _spin_trylock, which does not
use the __cond_lock wrapper annotation and thus does not affect the lock
context; change them to use spin_trylock instead, which does use __cond_lock.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 include/linux/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 31473db..456e74f 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -241,14 +241,14 @@ #define spin_trylock_bh(lock)		__cond_lo
 #define spin_trylock_irq(lock) \
 ({ \
 	local_irq_disable(); \
-	_spin_trylock(lock) ? \
+	spin_trylock(lock) ? \
 	1 : ({ local_irq_enable(); 0;  }); \
 })
 
 #define spin_trylock_irqsave(lock, flags) \
 ({ \
 	local_irq_save(flags); \
-	_spin_trylock(lock) ? \
+	spin_trylock(lock) ? \
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
-- 
1.4.1.1


