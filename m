Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUJXO0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUJXO0j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUJXO0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:26:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:61896 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261496AbUJXO0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:26:34 -0400
Date: Sun, 24 Oct 2004 16:26:27 +0200 (MEST)
Message-Id: <200410241426.i9OEQRDB015961@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.9-mm1] perfctr x86-64 ia32 emulation fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The perfctr syscall numbers changed in the i386 kernel
recently, but the x86-64 kernel's ia32 emulation was not
updated at the same time. This patch fixes that.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/x86_64/ia32/ia32entry.S     |    6 +++++-
 include/asm-x86_64/ia32_unistd.h |    4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff -rupN linux-2.6.9-mm1/arch/x86_64/ia32/ia32entry.S linux-2.6.9-mm1.perfctr-x86_64-fix/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.9-mm1/arch/x86_64/ia32/ia32entry.S	2004-10-24 01:06:07.000000000 +0200
+++ linux-2.6.9-mm1.perfctr-x86_64-fix/arch/x86_64/ia32/ia32entry.S	2004-10-24 12:46:27.750487000 +0200
@@ -587,8 +587,12 @@ ia32_sys_call_table:
 	.quad compat_sys_mq_getsetattr
 	.quad quiet_ni_syscall		/* reserved for kexec */
 	.quad sys32_waitid
+	.quad quiet_ni_syscall	/* sys_setaltroot */	/* 285 */
+	.quad quiet_ni_syscall	/* add_key */
+	.quad quiet_ni_syscall	/* request_key */
+	.quad quiet_ni_syscall	/* keyctl */
 	.quad sys_perfctr_info
-	.quad sys_vperfctr_open
+	.quad sys_vperfctr_open		/* 290 */
 	.quad sys_vperfctr_control
 	.quad sys_vperfctr_unlink
 	.quad sys_vperfctr_iresume
diff -rupN linux-2.6.9-mm1/include/asm-x86_64/ia32_unistd.h linux-2.6.9-mm1.perfctr-x86_64-fix/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.9-mm1/include/asm-x86_64/ia32_unistd.h	2004-10-24 01:06:17.000000000 +0200
+++ linux-2.6.9-mm1.perfctr-x86_64-fix/include/asm-x86_64/ia32_unistd.h	2004-10-24 12:43:12.640487000 +0200
@@ -290,13 +290,13 @@
 #define __NR_ia32_mq_getsetattr	(__NR_ia32_mq_open+5)
 #define __NR_ia32_kexec		283
 #define __NR_ia32_waitid		284
-#define __NR_ia32_perfctr_info		285
+#define __NR_ia32_perfctr_info		289
 #define __NR_ia32_vperfctr_open		(__NR_ia32_perfctr_info+1)
 #define __NR_ia32_vperfctr_control	(__NR_ia32_perfctr_info+2)
 #define __NR_ia32_vperfctr_unlink	(__NR_ia32_perfctr_info+3)
 #define __NR_ia32_vperfctr_iresume	(__NR_ia32_perfctr_info+4)
 #define __NR_ia32_vperfctr_read		(__NR_ia32_perfctr_info+5)
 
-#define IA32_NR_syscalls 291	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 295	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
