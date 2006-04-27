Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWD0Ue6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWD0Ue6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWD0Uem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:34:42 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:36767 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751441AbWD0Ue1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:34:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ga8ZCYRATF+fxTOnrTMuXJviZcsZ2A2jXO3j9dlqQwusL4hrrWT1UT/Yk5tqP+eHdaVG5PQS9ZWfR8hsZ6JZojP1MlApLJ466GmHwHr9k+6Q+0qXLE5t+vfQZTA5/FwwN9pZuaMg8A5eOVrUDGSKs9rOA8GSIN1v+V3V8HdwH58=
Date: Fri, 28 Apr 2006 00:32:09 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't trigger full rebuild via CONFIG_MTRR
Message-ID: <20060427203209.GA7166@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only drm, framebuffer, mtrr parts + misc files here and there.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/i386/kernel/cpu/common.c |    1 +
 arch/i386/power/cpu.c         |    1 +
 include/asm-i386/mtrr.h       |    4 ++++
 include/asm-i386/processor.h  |    8 --------
 4 files changed, 6 insertions(+), 8 deletions(-)

--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -11,6 +11,7 @@
 #include <asm/msr.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
+#include <asm/mtrr.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>
--- a/arch/i386/power/cpu.c
+++ b/arch/i386/power/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <asm/mtrr.h>
 
 static struct saved_context saved_context;
 
--- a/include/asm-i386/mtrr.h
+++ b/include/asm-i386/mtrr.h
@@ -77,6 +77,8 @@ extern int mtrr_add_page (unsigned long 
 extern int mtrr_del (int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page (int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
+extern void mtrr_ap_init(void);
+extern void mtrr_bp_init(void);
 #  else
 static __inline__ int mtrr_add (unsigned long base, unsigned long size,
 				unsigned int type, char increment)
@@ -101,6 +103,8 @@ static __inline__ int mtrr_del_page (int
 
 static __inline__ void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi) {;}
 
+#define mtrr_ap_init() do {} while (0)
+#define mtrr_bp_init() do {} while (0)
 #  endif
 
 #endif
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -729,14 +729,6 @@ extern unsigned long boot_option_idle_ov
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-#ifdef CONFIG_MTRR
-extern void mtrr_ap_init(void);
-extern void mtrr_bp_init(void);
-#else
-#define mtrr_ap_init() do {} while (0)
-#define mtrr_bp_init() do {} while (0)
-#endif
-
 #ifdef CONFIG_X86_MCE
 extern void mcheck_init(struct cpuinfo_x86 *c);
 #else

