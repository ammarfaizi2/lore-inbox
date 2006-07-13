Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWGMUSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWGMUSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGMUSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:18:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30478 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030354AbWGMUSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:18:38 -0400
Date: Thu, 13 Jul 2006 22:18:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let the the lockdep options depend on DEBUG_KERNEL
Message-ID: <20060713201838.GD32259@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep options should depend on DEBUG_KERNEL since:
- they are kernel debugging options and
- they do otherwise break the DEBUG_KERNEL menu structure

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 lib/Kconfig.debug |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc1-mm1-full/lib/Kconfig.debug.old	2006-07-13 22:00:05.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/lib/Kconfig.debug	2006-07-13 22:06:41.000000000 +0200
@@ -179,7 +179,7 @@
 
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
-	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RWSEMS
@@ -194,7 +194,7 @@
 
 config PROVE_LOCKING
 	bool "Lock debugging: prove locking correctness"
-	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
@@ -237,7 +237,7 @@
 
 config LOCKDEP
 	bool
-	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
 	select FRAME_POINTER
 	select KALLSYMS
@@ -245,13 +245,14 @@
 
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
-	depends on LOCKDEP
+	depends on DEBUG_KERNEL && LOCKDEP
 	help
 	  If you say Y here, the lock dependency engine will do
 	  additional runtime checks to debug itself, at the price
 	  of more runtime overhead.
 
 config TRACE_IRQFLAGS
+	depends on DEBUG_KERNEL
 	bool
 	default y
 	depends on TRACE_IRQFLAGS_SUPPORT
@@ -277,6 +278,7 @@
 
 config STACKTRACE
 	bool
+	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 
 config DEBUG_KOBJECT

