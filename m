Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423270AbWANCKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423270AbWANCKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbWANCKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:10:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21010 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423271AbWANCJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:09:50 -0500
Date: Sat, 14 Jan 2006 03:09:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport get_wchan
Message-ID: <20060114020950.GC29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of get_wchan is the proc fs - and proc can't be built 
modular.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Jan 2006

 arch/alpha/kernel/alpha_ksyms.c    |    2 --
 arch/arm/kernel/process.c          |    1 -
 arch/arm26/kernel/armksyms.c       |    2 --
 arch/frv/kernel/frv_ksyms.c        |    3 ---
 arch/h8300/kernel/h8300_ksyms.c    |    2 --
 arch/i386/kernel/process.c         |    1 -
 arch/m68k/kernel/m68k_ksyms.c      |    1 -
 arch/m68knommu/kernel/m68k_ksyms.c |    2 --
 arch/mips/kernel/process.c         |    1 -
 arch/powerpc/kernel/process.c      |    1 -
 arch/ppc/kernel/ppc_ksyms.c        |    1 -
 arch/x86_64/kernel/x8664_ksyms.c   |    2 --
 arch/xtensa/kernel/xtensa_ksyms.c  |    2 --
 13 files changed, 21 deletions(-)

--- linux-2.6.11-rc2-mm2-full/arch/arm/kernel/process.c.old	2005-01-31 14:15:46.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/arm/kernel/process.c	2005-01-31 14:15:52.000000000 +0100
@@ -461,4 +461,3 @@
 	} while (count ++ < 16);
 	return 0;
 }
-EXPORT_SYMBOL(get_wchan);
--- linux-2.6.11-rc2-mm2-full/arch/ppc/kernel/ppc_ksyms.c.old	2005-01-31 14:15:59.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/ppc/kernel/ppc_ksyms.c	2005-01-31 14:16:03.000000000 +0100
@@ -288,7 +288,6 @@
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
-EXPORT_SYMBOL(get_wchan);
 EXPORT_SYMBOL(console_drivers);
 #ifdef CONFIG_XMON
 EXPORT_SYMBOL(xmon);
--- linux-2.6.11-rc2-mm2-full/arch/mips/kernel/process.c.old	2005-01-31 14:16:10.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/mips/kernel/process.c	2005-01-31 14:16:29.000000000 +0100
@@ -361,4 +361,3 @@
 	return pc;
 }
 
-EXPORT_SYMBOL(get_wchan);
--- linux-2.6.11-rc2-mm2-full/arch/m68knommu/kernel/m68k_ksyms.c.old	2005-01-31 14:16:37.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/m68knommu/kernel/m68k_ksyms.c	2005-01-31 14:16:40.000000000 +0100
@@ -60,8 +60,6 @@
 EXPORT_SYMBOL(__down_failed_trylock);
 EXPORT_SYMBOL(__up_wakeup);
 
-EXPORT_SYMBOL(get_wchan);
-
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
--- linux-2.6.11-rc2-mm2-full/arch/arm26/kernel/armksyms.c.old	2005-01-31 14:16:49.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/arm26/kernel/armksyms.c	2005-01-31 14:16:52.000000000 +0100
@@ -213,8 +213,6 @@
 EXPORT_SYMBOL(sys_exit);
 EXPORT_SYMBOL(sys_wait4);
 
-EXPORT_SYMBOL(get_wchan);
-
 #ifdef CONFIG_PREEMPT
 EXPORT_SYMBOL(kernel_flag);
 #endif
--- linux-2.6.11-rc2-mm2-full/arch/m68k/kernel/m68k_ksyms.c.old	2005-01-31 14:17:00.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/m68k/kernel/m68k_ksyms.c	2005-01-31 14:17:05.000000000 +0100
@@ -85,4 +85,3 @@
 EXPORT_SYMBOL(__down_failed_trylock);
 EXPORT_SYMBOL(__up_wakeup);
 
-EXPORT_SYMBOL(get_wchan);
--- linux-2.6.11-rc2-mm2-full/arch/alpha/kernel/alpha_ksyms.c.old	2005-01-31 14:17:12.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/alpha/kernel/alpha_ksyms.c	2005-01-31 14:17:16.000000000 +0100
@@ -228,8 +228,6 @@
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memchr);
 
-EXPORT_SYMBOL(get_wchan);
-
 #ifdef CONFIG_ALPHA_IRONGATE
 EXPORT_SYMBOL(irongate_ioremap);
 EXPORT_SYMBOL(irongate_iounmap);
--- linux-2.6.11-rc2-mm2-full/arch/h8300/kernel/h8300_ksyms.c.old	2005-01-31 14:17:34.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/h8300/kernel/h8300_ksyms.c	2005-01-31 14:17:38.000000000 +0100
@@ -57,8 +57,6 @@
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memmove);
 
-EXPORT_SYMBOL(get_wchan);
-
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
--- linux-2.6.11-rc2-mm2-full/arch/x86_64/kernel/x8664_ksyms.c.old	2005-01-31 14:17:46.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/x86_64/kernel/x8664_ksyms.c	2005-01-31 14:17:50.000000000 +0100
@@ -126,8 +126,6 @@
 EXPORT_SYMBOL(screen_info);
 #endif
 
-EXPORT_SYMBOL(get_wchan);
-
 EXPORT_SYMBOL(rtc_lock);
 
 EXPORT_SYMBOL_GPL(set_nmi_callback);
--- linux-2.6.11-rc2-mm2-full/arch/frv/kernel/frv_ksyms.c.old	2005-01-31 14:17:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/arch/frv/kernel/frv_ksyms.c	2005-01-31 14:18:03.000000000 +0100
@@ -73,8 +73,6 @@
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(strtok);
 
-EXPORT_SYMBOL(get_wchan);
-
 #ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
 EXPORT_SYMBOL(atomic_test_and_ANDNOT_mask);
 EXPORT_SYMBOL(atomic_test_and_OR_mask);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.15-mm1-full/arch/i386/kernel/process.c.old	2006-01-06 01:28:43.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/i386/kernel/process.c	2006-01-06 01:28:50.000000000 +0100
@@ -787,7 +787,6 @@
 	} while (count++ < 16);
 	return 0;
 }
-EXPORT_SYMBOL(get_wchan);
 
 /*
  * sys_alloc_thread_area: get a yet unused TLS descriptor index.
--- linux-2.6.15-mm1-full/arch/powerpc/kernel/process.c.old	2006-01-06 01:29:06.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/powerpc/kernel/process.c	2006-01-06 01:29:10.000000000 +0100
@@ -824,7 +824,6 @@
 	} while (count++ < 16);
 	return 0;
 }
-EXPORT_SYMBOL(get_wchan);
 
 static int kstack_depth_to_print = 64;
 
--- linux-2.6.15-mm1-full/arch/xtensa/kernel/xtensa_ksyms.c.old	2006-01-06 01:29:35.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/xtensa/kernel/xtensa_ksyms.c	2006-01-06 01:29:43.000000000 +0100
@@ -113,8 +113,6 @@
 // FIXME EXPORT_SYMBOL(screen_info);
 #endif
 
-EXPORT_SYMBOL(get_wchan);
-
 EXPORT_SYMBOL(outsb);
 EXPORT_SYMBOL(outsw);
 EXPORT_SYMBOL(outsl);

