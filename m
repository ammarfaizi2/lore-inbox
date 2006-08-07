Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWHGVLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWHGVLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHGVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:43 -0400
Received: from xenotime.net ([66.160.160.81]:25051 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932385AbWHGVLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:18 -0400
Date: Mon, 7 Aug 2006 14:12:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, colpatch@us.ibm.com
Subject: [PATCH 1/9] Replace ARCH_HAS_SCHED_WAKE_IDLE with CONFIG_SCHED_SMT
Message-Id: <20060807141224.4e3ba738.rdunlap@xenotime.net>
In-Reply-To: <20060807120928.c0fe7045.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Replace ARCH_HAS_SCHED_WAKE_IDLE with CONFIG_SCHED_SMT.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/topology.h |    6 ++----
 kernel/sched.c           |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2618-rc4-arch.orig/include/linux/topology.h
+++ linux-2618-rc4-arch/include/linux/topology.h
@@ -80,10 +80,8 @@
  * and allow arch-specific performance tuning of sched_domains.
  */
 #ifdef CONFIG_SCHED_SMT
-/* MCD - Do we really need this?  It is always on if CONFIG_SCHED_SMT is,
- * so can't we drop this in favor of CONFIG_SCHED_SMT?
- */
-#define ARCH_HAS_SCHED_WAKE_IDLE
+/* CONFIG_SCHED_SMT is synonymous with old ARCH_HAS_SCHED_WAKE_IDLE */
+
 /* Common values for SMT siblings */
 #ifndef SD_SIBLING_INIT
 #define SD_SIBLING_INIT (struct sched_domain) {		\
--- linux-2618-rc4-arch.orig/kernel/sched.c
+++ linux-2618-rc4-arch/kernel/sched.c
@@ -1315,7 +1315,7 @@ nextlevel:
  *
  * Returns the CPU we should wake onto.
  */
-#if defined(ARCH_HAS_SCHED_WAKE_IDLE)
+#ifdef CONFIG_SCHED_SMT
 static int wake_idle(int cpu, struct task_struct *p)
 {
 	cpumask_t tmp;


---
