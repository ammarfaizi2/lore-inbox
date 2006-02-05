Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWBES3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWBES3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWBES3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:29:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41998 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750980AbWBES3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:29:31 -0500
Date: Sun, 5 Feb 2006 19:29:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64: unexport ia32_sys_call_table
Message-ID: <20060205182930.GA15767@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This export doesn't seem to do anything but bloating the kernel by
a few bytes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/um/include/sysdep-x86_64/syscalls.h |    2 --
 arch/x86_64/ia32/ia32entry.S             |    1 -
 arch/x86_64/ia32/sys_ia32.c              |    2 --
 3 files changed, 5 deletions(-)

--- linux-2.6.16-rc1-mm5-full/arch/um/include/sysdep-x86_64/syscalls.h.old	2006-02-05 18:42:51.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/um/include/sysdep-x86_64/syscalls.h	2006-02-05 18:42:59.000000000 +0100
@@ -12,8 +12,6 @@
 
 typedef long syscall_handler_t(void);
 
-extern syscall_handler_t *ia32_sys_call_table[];
-
 extern syscall_handler_t *sys_call_table[];
 
 #define EXECUTE_SYSCALL(syscall, regs) \
--- linux-2.6.16-rc1-mm5-full/arch/x86_64/ia32/sys_ia32.c.old	2006-02-05 18:43:18.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/x86_64/ia32/sys_ia32.c	2006-02-05 18:43:25.000000000 +0100
@@ -1004,5 +1004,3 @@
 
 __initcall(ia32_init);
 
-extern unsigned long ia32_sys_call_table[];
-EXPORT_SYMBOL(ia32_sys_call_table);
--- linux-2.6.16-rc1-mm5-full/arch/x86_64/ia32/ia32entry.S.old	2006-02-05 18:49:28.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/x86_64/ia32/ia32entry.S	2006-02-05 18:49:48.000000000 +0100
@@ -371,7 +371,6 @@
 
 	.section .rodata,"a"
 	.align 8
-	.globl ia32_sys_call_table
 ia32_sys_call_table:
 	.quad sys_restart_syscall
 	.quad sys_exit

