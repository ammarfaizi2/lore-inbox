Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVHJT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVHJT31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVHJT31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:29:27 -0400
Received: from peabody.ximian.com ([130.57.169.10]:23010 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030213AbVHJT31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:29:27 -0400
Subject: [patch] add inotify & ioprio syscalls to ARM
From: Robert Love <rml@novell.com>
To: rmk@arm.linux.org.uk
Cc: The Cutch <ttb@tentacle.dhs.org>, Mr Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 15:29:27 -0400
Message-Id: <1123702167.23297.4.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

Hey.  Attached patch adds the syscall stubs for the inotify and ioprio
system calls to ARM.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 arch/arm/kernel/calls.S  |    6 ++++++
 include/asm-arm/unistd.h |    5 +++++
 2 files changed, 11 insertions(+)

diff -urN linux-2.6.13-rc6/arch/arm/kernel/calls.S linux/arch/arm/kernel/calls.S
--- linux-2.6.13-rc6/arch/arm/kernel/calls.S	2005-06-17 15:48:29.000000000 -0400
+++ linux/arch/arm/kernel/calls.S	2005-08-10 15:26:10.000000000 -0400
@@ -327,6 +327,12 @@
 /* 310 */	.long	sys_request_key
 		.long	sys_keyctl
 		.long	sys_semtimedop
+/* vserver */	.long	sys_ni_syscall
+		.long	sys_ioprio_set
+/* 315 */	.long	sys_ioprio_get
+		.long	sys_inotify_init
+		.long	sys_inotify_add_watch
+		.long	sys_inotify_rm_watch
 __syscall_end:
 
 		.rept	NR_syscalls - (__syscall_end - __syscall_start) / 4
diff -urN linux-2.6.13-rc6/include/asm-arm/unistd.h linux/include/asm-arm/unistd.h
--- linux-2.6.13-rc6/include/asm-arm/unistd.h	2005-06-17 15:48:29.000000000 -0400
+++ linux/include/asm-arm/unistd.h	2005-08-10 15:26:08.000000000 -0400
@@ -350,6 +350,11 @@
 #endif
 
 #define __NR_vserver			(__NR_SYSCALL_BASE+313)
+#define __NR_ioprio_set			(__NR_SYSCALL_BASE+314)
+#define __NR_ioprio_get			(__NR_SYSCALL_BASE+315)
+#define __NR_inotify_init		(__NR_SYSCALL_BASE+316)
+#define __NR_inotify_add_watch		(__NR_SYSCALL_BASE+317)
+#define __NR_inotify_rm_watch		(__NR_SYSCALL_BASE+318)
 
 /*
  * The following SWIs are ARM private.


