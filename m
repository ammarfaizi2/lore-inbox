Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVAQIXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVAQIXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVAQISR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:18:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26637 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261634AbVAQINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:13:52 -0500
Date: Mon, 17 Jan 2005 09:13:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/capability.c: make a spinlock static
Message-ID: <20050117081347.GB4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global spinlock static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>

---

diffstat output:
 include/linux/capability.h |    2 --
 kernel/capability.c        |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)


This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/include/linux/capability.h.old	2004-12-12 02:43:59.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/capability.h	2004-12-12 02:44:05.000000000 +0100
@@ -44,8 +44,6 @@
 
 #include <linux/spinlock.h>
 
-extern spinlock_t task_capability_lock;
-
 /* #define STRICT_CAP_T_TYPECHECKS */
 
 #ifdef STRICT_CAP_T_TYPECHECKS
--- linux-2.6.10-rc2-mm4-full/kernel/capability.c.old	2004-12-12 02:43:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/capability.c	2004-12-12 02:43:45.000000000 +0100
@@ -20,10 +20,10 @@
 EXPORT_SYMBOL(cap_bset);
 
 /*
- * This global lock protects task->cap_* for all tasks including current.
+ * This lock protects task->cap_* for all tasks including current.
  * Locking rule: acquire this prior to tasklist_lock.
  */
-DEFINE_SPINLOCK(task_capability_lock);
+static DEFINE_SPINLOCK(task_capability_lock);
 
 /*
  * For sys_getproccap() and sys_setproccap(), any of the three

