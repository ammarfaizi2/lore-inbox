Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVBTO4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVBTO4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBTO4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:56:32 -0500
Received: from aun.it.uu.se ([130.238.12.36]:4790 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261841AbVBTOzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:55:48 -0500
Date: Sun, 20 Feb 2005 15:55:38 +0100 (MET)
Message-Id: <200502201455.j1KEtcSB029474@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-rc3-mm2] perfctr-2.7.10 API update 2/4: i386
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.10 update, 2/4:
- Update i386 syscall table for perfctr-2.7.10 API changes.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/i386/kernel/entry.S         |    3 +--
 arch/x86_64/ia32/ia32entry.S     |    3 +--
 include/asm-i386/unistd.h        |    7 +++----
 include/asm-x86_64/ia32_unistd.h |    7 +++----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff -rupN linux-2.6.11-rc3-mm2/arch/i386/kernel/entry.S linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/arch/i386/kernel/entry.S
--- linux-2.6.11-rc3-mm2/arch/i386/kernel/entry.S	2005-02-20 12:39:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/arch/i386/kernel/entry.S	2005-02-20 13:13:13.000000000 +0100
@@ -901,8 +901,7 @@ ENTRY(sys_call_table)
 	.long sys_keyctl
 	.long sys_vperfctr_open
 	.long sys_vperfctr_control	/* 290 */
-	.long sys_vperfctr_unlink
-	.long sys_vperfctr_iresume
+	.long sys_vperfctr_write
 	.long sys_vperfctr_read
 
 syscall_table_size=(.-sys_call_table)
diff -rupN linux-2.6.11-rc3-mm2/arch/x86_64/ia32/ia32entry.S linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.11-rc3-mm2/arch/x86_64/ia32/ia32entry.S	2005-02-20 12:39:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/arch/x86_64/ia32/ia32entry.S	2005-02-20 13:13:13.000000000 +0100
@@ -597,8 +597,7 @@ ia32_sys_call_table:
 	.quad sys_keyctl
 	.quad sys_vperfctr_open
 	.quad sys_vperfctr_control	/* 290 */
-	.quad sys_vperfctr_unlink
-	.quad sys_vperfctr_iresume
+	.quad sys_vperfctr_write
 	.quad sys_vperfctr_read
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
diff -rupN linux-2.6.11-rc3-mm2/include/asm-i386/unistd.h linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/include/asm-i386/unistd.h
--- linux-2.6.11-rc3-mm2/include/asm-i386/unistd.h	2005-02-20 12:39:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/include/asm-i386/unistd.h	2005-02-20 13:13:13.000000000 +0100
@@ -296,11 +296,10 @@
 #define __NR_keyctl		288
 #define __NR_vperfctr_open	289
 #define __NR_vperfctr_control	(__NR_vperfctr_open+1)
-#define __NR_vperfctr_unlink	(__NR_vperfctr_open+2)
-#define __NR_vperfctr_iresume	(__NR_vperfctr_open+3)
-#define __NR_vperfctr_read	(__NR_vperfctr_open+4)
+#define __NR_vperfctr_write	(__NR_vperfctr_open+2)
+#define __NR_vperfctr_read	(__NR_vperfctr_open+3)
 
-#define NR_syscalls 294
+#define NR_syscalls 293
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -rupN linux-2.6.11-rc3-mm2/include/asm-x86_64/ia32_unistd.h linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.11-rc3-mm2/include/asm-x86_64/ia32_unistd.h	2005-02-20 12:39:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-i386-syscalls-update/include/asm-x86_64/ia32_unistd.h	2005-02-20 13:13:13.000000000 +0100
@@ -296,10 +296,9 @@
 #define __NR_ia32_keyctl		288
 #define __NR_ia32_vperfctr_open		289
 #define __NR_ia32_vperfctr_control	(__NR_ia32_vperfctr_open+1)
-#define __NR_ia32_vperfctr_unlink	(__NR_ia32_vperfctr_open+2)
-#define __NR_ia32_vperfctr_iresume	(__NR_ia32_vperfctr_open+3)
-#define __NR_ia32_vperfctr_read		(__NR_ia32_vperfctr_open+4)
+#define __NR_ia32_vperfctr_write	(__NR_ia32_vperfctr_open+2)
+#define __NR_ia32_vperfctr_read		(__NR_ia32_vperfctr_open+3)
 
-#define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 293	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
