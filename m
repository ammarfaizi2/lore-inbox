Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGWP50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGWP50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267820AbUGWP5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:57:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:902 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S267807AbUGWPlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:41:06 -0400
Date: Fri, 23 Jul 2004 08:49:26 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 8/11: Arch-specific support
Message-ID: <0407230849.WchaEbYd9c3cLaPbBdbaSa0awclaLcQa17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.lc5bUdlcDaCcGdoa4bzc3bWbjcua2bVa17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the system call hooks of the ufuqueues and ufulocks
for the different architectures we (or somebody else) has
tried this on. So far, the list is i386, ia64, PPC and
PPC64.

The last three ones haven't been tested that much for 2.3, but
nothing should have changed in that matter since release 2.2.


 arch/i386/kernel/entry.S   |    7 +++++++
 arch/ia64/kernel/entry.S   |   14 +++++++-------
 arch/ppc/kernel/misc.S     |    9 ++++++++-
 arch/ppc64/kernel/misc.S   |    7 +++++++
 include/asm-i386/unistd.h  |    9 ++++++++-
 include/asm-ia64/unistd.h  |    9 ++++++++-
 include/asm-ppc/unistd.h   |    9 ++++++++-
 include/asm-ppc64/unistd.h |    9 ++++++++-
 kernel/sys.c               |    6 ++++++
 9 files changed, 67 insertions(+), 12 deletions(-)

--- include/asm-i386/unistd.h:1.1.1.8 Tue Apr 6 01:51:33 2004
+++ include/asm-i386/unistd.h Sat Jul 17 19:34:37 2004
@@ -279,8 +279,15 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_ufulock_lock	274
+#define __NR_ufulock_unlock	275
+#define __NR_ufulock_ctl	276
+#define __NR_ufulock_requeue	277
+#define __NR_ufuqueue_wait	278
+#define __NR_ufuqueue_wake	279
+#define __NR_ufuqueue_ctl	280
 
-#define NR_syscalls 274
+#define NR_syscalls 281
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- include/asm-ia64/unistd.h:1.1.1.7 Tue Apr 6 00:22:52 2004
+++ include/asm-ia64/unistd.h Sat Jul 17 19:42:54 2004
@@ -251,10 +251,17 @@
 #define __NR_reserved1			1259	/* reserved for NUMA interface */
 #define __NR_reserved2			1260	/* reserved for NUMA interface */
 #define __NR_reserved3			1261	/* reserved for NUMA interface */
+#define __NR_ufulock_lock		1262
+#define __NR_ufulock_unlock		1263
+#define __NR_ufulock_ctl		1264
+#define __NR_ufulock_requeue		1265
+#define __NR_ufuqueue_wait		1266
+#define __NR_ufuqueue_wake		1267
+#define __NR_ufuqueue_ctl		1268
 
 #ifdef __KERNEL__
 
-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			263 /* length of syscall table */
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
--- include/asm-ppc/unistd.h:1.1.1.4 Tue Apr 6 00:22:57 2004
+++ include/asm-ppc/unistd.h Sat Jul 17 19:42:55 2004
@@ -260,8 +260,15 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+#define __NR_ufulock_lock	256
+#define __NR_ufulock_unlock	257
+#define __NR_ufulock_ctl	258
+#define __NR_ufulock_requeue	259
+#define __NR_ufuqueue_wait	260
+#define __NR_ufuqueue_wake	261
+#define __NR_ufuqueue_ctl	262
 
-#define __NR_syscalls		256
+#define __NR_syscalls		263
 
 #define __NR(n)	#n
 
--- include/asm-ppc64/unistd.h:1.1.1.4 Tue Apr 6 00:22:57 2004
+++ include/asm-ppc64/unistd.h Sat Jul 17 19:42:55 2004
@@ -266,8 +266,15 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+#define __NR_ufulock_lock	256
+#define __NR_ufulock_unlock	257
+#define __NR_ufulock_ctl	258
+#define __NR_ufulock_requeue	259
+#define __NR_ufuqueue_wait	260
+#define __NR_ufuqueue_wake	261
+#define __NR_ufuqueue_ctl	262
 
-#define __NR_syscalls		256
+#define __NR_syscalls		263
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
--- arch/i386/kernel/entry.S:1.1.1.13 Tue Apr 6 01:51:19 2004
+++ arch/i386/kernel/entry.S Sat Jul 17 19:34:13 2004
@@ -882,5 +882,12 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_ufulock_lock
+	.long sys_ufulock_unlock	/* 275 */
+	.long sys_ufulock_ctl
+	.long sys_ufulock_requeue     
+	.long sys_ufuqueue_wait
+	.long sys_ufuqueue_wake		/* 279 */  	     
+	.long sys_ufuqueue_ctl
 
 syscall_table_size=(.-sys_call_table)
--- kernel/sys.c:1.1.1.13 Tue Apr 6 01:51:37 2004
+++ kernel/sys.c Wed May 26 22:14:57 2004
@@ -260,6 +260,12 @@
 cond_syscall(sys_shmget)
 cond_syscall(sys_shmdt)
 cond_syscall(sys_shmctl)
+cond_syscall(sys_ufuqueue_wait)
+cond_syscall(sys_ufuqueue_wake)
+cond_syscall(sys_ufulock_lock)
+cond_syscall(sys_ufulock_unlock)
+cond_syscall(sys_ufulock_ctl)
+cond_syscall(sys_ufulock_requeue)
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)
--- arch/ia64/kernel/entry.S:1.1.1.8 Tue Apr 6 00:21:45 2004
+++ arch/ia64/kernel/entry.S Sat Jul 17 19:42:55 2004
@@ -1504,13 +1504,13 @@
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall			// 1260
 	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1265
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+	data8 sys_ufulock_lock
+	data8 sys_ufulock_unlock
+	data8 sys_ufulock_ctl
+	data8 sys_ufulock_requeue		// 1265
+	data8 sys_ufuqueue_wait
+	data8 sys_ufuqueue_wake
+	data8 sys_ufuqueue_ctl
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall			// 1270
 	data8 sys_ni_syscall
--- arch/ppc/kernel/misc.S:1.1.1.5 Tue Apr 6 00:22:00 2004
+++ arch/ppc/kernel/misc.S Sat Jul 17 19:42:55 2004
@@ -976,7 +976,7 @@
  * R5    has shift count
  * result in R3/R4
  *
- *  ashrdi3: arithmetic right shift (sign propagation)	
+ *  ashrdi3: arithmetic right shift (sign propagation) 
  *  lshrdi3: logical right shift
  *  ashldi3: left shift
  */
@@ -1370,3 +1370,10 @@
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
 	.long sys_ni_syscall	/* 255 - rtas (used on ppc64) */
+	.long sys_ufulock_lock
+	.long sys_ufulock_unlock
+	.long sys_ufulock_ctl
+	.long sys_ufulock_requeue
+	.long sys_ufuqueue_wait   /* 260 */
+	.long sys_ufuqueue_wake
+	.long sys_ufuqueue_ctl
--- arch/ppc64/kernel/misc.S:1.1.1.5 Tue Apr 6 00:22:01 2004
+++ arch/ppc64/kernel/misc.S Sat Jul 17 19:42:55 2004
@@ -1087,3 +1087,10 @@
 	.llong .sys_fstatfs64
 	.llong .sys_ni_syscall		/* 32bit only fadvise64_64 */
 	.llong .ppc_rtas		/* 255 */
+	.llong .sys_ufulock_lock
+	.llong .sys_ufulock_unlock
+	.llong .sys_ufulock_ctl
+	.llong .sys_ufulock_requeue
+	.llong .sys_ufuqueue_wait	/* 260 */      
+	.llong .sys_ufuqueue_wake
+	.llong .sys_ufuqueue_ctl
