Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbULBKM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbULBKM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULBKM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:12:57 -0500
Received: from aun.it.uu.se ([130.238.12.36]:4329 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261394AbULBKLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:11:40 -0500
Date: Thu, 2 Dec 2004 11:11:33 +0100 (MET)
Message-Id: <200412021011.iB2ABXmQ004543@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 3/4: x86-64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perfctr sysfs update part 3/4:
- Remove sys_perfctr_info() from x86-64.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/x86_64/ia32/ia32entry.S     |    5 ++---
 include/asm-x86_64/ia32_unistd.h |   13 ++++++-------
 include/asm-x86_64/unistd.h      |   12 +++++-------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff -rupN linux-2.6.10-rc2-mm4/arch/x86_64/ia32/ia32entry.S linux-2.6.10-rc2-mm4.perfctr-x86_64-update/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.10-rc2-mm4/arch/x86_64/ia32/ia32entry.S	2004-11-30 23:52:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-x86_64-update/arch/x86_64/ia32/ia32entry.S	2004-12-02 02:23:57.000000000 +0100
@@ -591,9 +591,8 @@ ia32_sys_call_table:
 	.quad quiet_ni_syscall	/* add_key */
 	.quad quiet_ni_syscall	/* request_key */
 	.quad quiet_ni_syscall	/* keyctl */
-	.quad sys_perfctr_info
-	.quad sys_vperfctr_open		/* 290 */
-	.quad sys_vperfctr_control
+	.quad sys_vperfctr_open
+	.quad sys_vperfctr_control	/* 290 */
 	.quad sys_vperfctr_unlink
 	.quad sys_vperfctr_iresume
 	.quad sys_vperfctr_read
diff -rupN linux-2.6.10-rc2-mm4/include/asm-x86_64/ia32_unistd.h linux-2.6.10-rc2-mm4.perfctr-x86_64-update/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.10-rc2-mm4/include/asm-x86_64/ia32_unistd.h	2004-11-30 23:53:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-x86_64-update/include/asm-x86_64/ia32_unistd.h	2004-12-02 02:23:57.000000000 +0100
@@ -290,13 +290,12 @@
 #define __NR_ia32_mq_getsetattr	(__NR_ia32_mq_open+5)
 #define __NR_ia32_kexec		283
 #define __NR_ia32_waitid		284
-#define __NR_ia32_perfctr_info		289
-#define __NR_ia32_vperfctr_open		(__NR_ia32_perfctr_info+1)
-#define __NR_ia32_vperfctr_control	(__NR_ia32_perfctr_info+2)
-#define __NR_ia32_vperfctr_unlink	(__NR_ia32_perfctr_info+3)
-#define __NR_ia32_vperfctr_iresume	(__NR_ia32_perfctr_info+4)
-#define __NR_ia32_vperfctr_read		(__NR_ia32_perfctr_info+5)
+#define __NR_ia32_vperfctr_open		289
+#define __NR_ia32_vperfctr_control	(__NR_ia32_vperfctr_open+1)
+#define __NR_ia32_vperfctr_unlink	(__NR_ia32_vperfctr_open+2)
+#define __NR_ia32_vperfctr_iresume	(__NR_ia32_vperfctr_open+3)
+#define __NR_ia32_vperfctr_read		(__NR_ia32_vperfctr_open+4)
 
-#define IA32_NR_syscalls 295	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -rupN linux-2.6.10-rc2-mm4/include/asm-x86_64/unistd.h linux-2.6.10-rc2-mm4.perfctr-x86_64-update/include/asm-x86_64/unistd.h
--- linux-2.6.10-rc2-mm4/include/asm-x86_64/unistd.h	2004-11-30 23:53:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-x86_64-update/include/asm-x86_64/unistd.h	2004-12-02 02:23:57.000000000 +0100
@@ -556,17 +556,15 @@ __SYSCALL(__NR_mq_getsetattr, sys_mq_get
 __SYSCALL(__NR_kexec_load, sys_kexec_load)
 #define __NR_waitid		247
 __SYSCALL(__NR_waitid, sys_waitid)
-#define __NR_perfctr_info	248
-__SYSCALL(__NR_perfctr_info, sys_perfctr_info)
-#define __NR_vperfctr_open	(__NR_perfctr_info+1)
+#define __NR_vperfctr_open	248
 __SYSCALL(__NR_vperfctr_open, sys_vperfctr_open)
-#define __NR_vperfctr_control	(__NR_perfctr_info+2)
+#define __NR_vperfctr_control	(__NR_vperfctr_open+1)
 __SYSCALL(__NR_vperfctr_control, sys_vperfctr_control)
-#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
+#define __NR_vperfctr_unlink	(__NR_vperfctr_open+2)
 __SYSCALL(__NR_vperfctr_unlink, sys_vperfctr_unlink)
-#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
+#define __NR_vperfctr_iresume	(__NR_vperfctr_open+3)
 __SYSCALL(__NR_vperfctr_iresume, sys_vperfctr_iresume)
-#define __NR_vperfctr_read	(__NR_perfctr_info+5)
+#define __NR_vperfctr_read	(__NR_vperfctr_open+4)
 __SYSCALL(__NR_vperfctr_read, sys_vperfctr_read)
 
 #define __NR_syscall_max __NR_vperfctr_read
