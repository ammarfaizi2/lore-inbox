Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWEHTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWEHTrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWEHTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:47:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:40130 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWEHTrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:47:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hc+5Ip4gxbcHbQCo1W5JVPtxKa6FUeawPG4aQlWuX0gNJkBQ41B6ni7HZk4u4BkHKNu4bkCwon6tjnTkmDYJdJXuf6/+7x2TPmi/qN43j2J86hUiPJccLDY5d60QeUlTHVHzr8VkLU3i4lUTxxDKkr/osTxW5qsAxHBOb3NRf4Q=
Date: Mon, 8 May 2006 23:45:43 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't trigger full rebuild via CONFIG_X86_MCE
Message-ID: <20060508194542.GC7235@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 To be applied on top of already sent CONFIG_MTRR patch.

--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -10,10 +10,11 @@
 #include <asm/i387.h>
 #include <asm/msr.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/mtrr.h>
+#include <asm/mce.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>
 #include <mach_apic.h>
 #endif
--- a/arch/i386/power/cpu.c
+++ b/arch/i386/power/cpu.c
@@ -9,10 +9,11 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <asm/mtrr.h>
+#include <asm/mce.h>
 
 static struct saved_context saved_context;
 
 unsigned long saved_context_ebx;
 unsigned long saved_context_esp, saved_context_ebp;
--- /dev/null
+++ b/include/asm-i386/mce.h
@@ -0,0 +1,5 @@
+#ifdef CONFIG_X86_MCE
+extern void mcheck_init(struct cpuinfo_x86 *c);
+#else
+#define mcheck_init(c) do {} while(0)
+#endif
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -727,12 +727,6 @@ extern void select_idle_routine(const st
 
 extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-#ifdef CONFIG_X86_MCE
-extern void mcheck_init(struct cpuinfo_x86 *c);
-#else
-#define mcheck_init(c) do {} while(0)
-#endif
-
 #endif /* __ASM_I386_PROCESSOR_H */

