Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVG0Rbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVG0Rbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVG0Rbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:31:39 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6327 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262113AbVG0Rbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:31:37 -0400
Subject: [patch] inotify: ppc64 syscalls.
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, ttb@tentacle.dhs.org
In-Reply-To: <20050727095539.602fcc4a.akpm@osdl.org>
References: <1122479106.21253.158.camel@betsy>
	 <20050727095539.602fcc4a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 13:31:36 -0400
Message-Id: <1122485496.21253.170.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 09:55 -0700, Andrew Morton wrote:

> ppc64 likes to keep its 32-bit-syscall table in sync with ppc32 so it'd be
> best to do ppc64 while we're at it (both sys_call_table and
> sys_call_table32)

Sure thing.

Attached find inotify system call support for PPC64.

[ I don't think we need sys32 compatibility versions--and if we do, I
failed in life. ]

	Robert Love

Signed-off-by: Robert Love <rml@novell.com>

 arch/ppc64/kernel/misc.S   |    6 ++++++
 include/asm-ppc64/unistd.h |    5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff -urN linux-2.6.13-rc3-git8/arch/ppc64/kernel/misc.S linux/arch/ppc64/kernel/misc.S
--- linux-2.6.13-rc3-git8/arch/ppc64/kernel/misc.S	2005-07-27 10:59:31.000000000 -0400
+++ linux/arch/ppc64/kernel/misc.S	2005-07-27 13:26:36.000000000 -0400
@@ -1129,6 +1129,9 @@
 	.llong .compat_sys_waitid
 	.llong .sys32_ioprio_set
 	.llong .sys32_ioprio_get
+	.llong .sys_inotify_init	/* 275 */
+	.llong .sys_inotify_add_watch
+	.llong .sys_inotify_rm_watch
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1407,3 +1410,6 @@
 	.llong .sys_waitid
 	.llong .sys_ioprio_set
 	.llong .sys_ioprio_get
+	.llong .sys_inotify_init	/* 275 */
+	.llong .sys_inotify_add_watch
+	.llong .sys_inotify_rm_watch
diff -urN linux-2.6.13-rc3-git8/include/asm-ppc64/unistd.h linux/include/asm-ppc64/unistd.h
--- linux-2.6.13-rc3-git8/include/asm-ppc64/unistd.h	2005-07-27 10:59:32.000000000 -0400
+++ linux/include/asm-ppc64/unistd.h	2005-07-27 13:27:24.000000000 -0400
@@ -285,8 +285,11 @@
 #define __NR_waitid		272
 #define __NR_ioprio_set		273
 #define __NR_ioprio_get		274
+#define __NR_inotify_init	275
+#define __NR_inotify_add_watch	276
+#define __NR_inotify_rm_watch	277
 
-#define __NR_syscalls		275
+#define __NR_syscalls		278
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif


