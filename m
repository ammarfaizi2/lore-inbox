Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVCLXfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVCLXfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCLXdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:33:36 -0500
Received: from aun.it.uu.se ([130.238.12.36]:49354 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262470AbVCLX0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:26:13 -0500
Date: Sun, 13 Mar 2005 00:26:06 +0100 (MET)
Message-Id: <200503122326.j2CNQ6in029072@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr ia32 syscalls on x86-64 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ia32 perfctr syscalls were moved due to addition of ioprio
syscalls, but the ia32 emulation code in x86-64 wasn't updated.
Simple fix below.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 arch/x86_64/ia32/ia32entry.S     |    4 +++-
 include/asm-x86_64/ia32_unistd.h |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff -rupN linux-2.6.11-mm3/arch/x86_64/ia32/ia32entry.S linux-2.6.11-mm3.perfctr-x86_64-ia32-syscalls-fixes/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.11-mm3/arch/x86_64/ia32/ia32entry.S	2005-03-12 19:26:24.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-x86_64-ia32-syscalls-fixes/arch/x86_64/ia32/ia32entry.S	2005-03-12 19:53:32.000000000 +0100
@@ -595,8 +595,10 @@ ia32_sys_call_table:
 	.quad sys_add_key
 	.quad sys_request_key
 	.quad sys_keyctl
+	.quad quiet_ni_syscall		/* sys_ioprio_set */
+	.quad quiet_ni_syscall		/* sys_ioprio_get */	/* 290 */
 	.quad sys_vperfctr_open
-	.quad sys_vperfctr_control	/* 290 */
+	.quad sys_vperfctr_control
 	.quad sys_vperfctr_write
 	.quad sys_vperfctr_read
 	/* don't forget to change IA32_NR_syscalls */
diff -rupN linux-2.6.11-mm3/include/asm-x86_64/ia32_unistd.h linux-2.6.11-mm3.perfctr-x86_64-ia32-syscalls-fixes/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.11-mm3/include/asm-x86_64/ia32_unistd.h	2005-03-12 19:26:26.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-x86_64-ia32-syscalls-fixes/include/asm-x86_64/ia32_unistd.h	2005-03-12 19:53:32.000000000 +0100
@@ -294,11 +294,11 @@
 #define __NR_ia32_add_key		286
 #define __NR_ia32_request_key	287
 #define __NR_ia32_keyctl		288
-#define __NR_ia32_vperfctr_open		289
+#define __NR_ia32_vperfctr_open		291
 #define __NR_ia32_vperfctr_control	(__NR_ia32_vperfctr_open+1)
 #define __NR_ia32_vperfctr_write	(__NR_ia32_vperfctr_open+2)
 #define __NR_ia32_vperfctr_read		(__NR_ia32_vperfctr_open+3)
 
-#define IA32_NR_syscalls 293	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 295	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
