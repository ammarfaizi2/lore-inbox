Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVJKNTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVJKNTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVJKNTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:19:05 -0400
Received: from mail.renesas.com ([202.234.163.13]:30598 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751204AbVJKNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:19:04 -0400
Date: Tue, 11 Oct 2005 22:18:59 +0900 (JST)
Message-Id: <20051011.221859.26277548.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc2-mm2] m32r: fix #if warnings
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warnings for #if directives.
Please apply.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup.c       |   24 ++++++++++++------------
 include/asm-m32r/thread_info.h |    2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.14-rc2-mm2/include/asm-m32r/thread_info.h
===================================================================
--- linux-2.6.14-rc2-mm2.orig/include/asm-m32r/thread_info.h	2005-10-06 10:49:27.000000000 +0900
+++ linux-2.6.14-rc2-mm2/include/asm-m32r/thread_info.h	2005-10-11 17:17:53.272053920 +0900
@@ -95,7 +95,7 @@ static inline struct thread_info *curren
 }
 
 /* thread stack allocation */
-#if CONFIG_DEBUG_STACK_USAGE
+#ifdef CONFIG_DEBUG_STACK_USAGE
 #define alloc_thread_stack(tsk)					\
 	({							\
 		void *ret;					\
Index: linux-2.6.14-rc2-mm2/arch/m32r/kernel/setup.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/m32r/kernel/setup.c	2005-09-20 12:00:41.000000000 +0900
+++ linux-2.6.14-rc2-mm2/arch/m32r/kernel/setup.c	2005-10-11 17:20:32.881789552 +0900
@@ -305,19 +305,19 @@ static int show_cpuinfo(struct seq_file 
 
 	seq_printf(m, "processor\t: %ld\n", cpu);
 
-#ifdef CONFIG_CHIP_VDEC2
+#if defined(CONFIG_CHIP_VDEC2)
 	seq_printf(m, "cpu family\t: VDEC2\n"
 		"cache size\t: Unknown\n");
-#elif  CONFIG_CHIP_M32700
+#elif defined(CONFIG_CHIP_M32700)
 	seq_printf(m,"cpu family\t: M32700\n"
 		"cache size\t: I-8KB/D-8KB\n");
-#elif  CONFIG_CHIP_M32102
+#elif defined(CONFIG_CHIP_M32102)
 	seq_printf(m,"cpu family\t: M32102\n"
 		"cache size\t: I-8KB\n");
-#elif  CONFIG_CHIP_OPSP
+#elif defined(CONFIG_CHIP_OPSP)
 	seq_printf(m,"cpu family\t: OPSP\n"
 		"cache size\t: I-8KB/D-8KB\n");
-#elif  CONFIG_CHIP_MP
+#elif defined(CONFIG_CHIP_MP)
 	seq_printf(m, "cpu family\t: M32R-MP\n"
 		"cache size\t: I-xxKB/D-xxKB\n");
 #else
@@ -326,19 +326,19 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		c->loops_per_jiffy/(500000/HZ),
 		(c->loops_per_jiffy/(5000/HZ)) % 100);
-#ifdef CONFIG_PLAT_MAPPI
+#if defined(CONFIG_PLAT_MAPPI)
 	seq_printf(m, "Machine\t\t: Mappi Evaluation board\n");
-#elif CONFIG_PLAT_MAPPI2
+#elif defined(CONFIG_PLAT_MAPPI2)
 	seq_printf(m, "Machine\t\t: Mappi-II Evaluation board\n");
-#elif CONFIG_PLAT_MAPPI3
+#elif defined(CONFIG_PLAT_MAPPI3)
 	seq_printf(m, "Machine\t\t: Mappi-III Evaluation board\n");
-#elif  CONFIG_PLAT_M32700UT
+#elif defined(CONFIG_PLAT_M32700UT)
 	seq_printf(m, "Machine\t\t: M32700UT Evaluation board\n");
-#elif  CONFIG_PLAT_OPSPUT
+#elif defined(CONFIG_PLAT_OPSPUT)
 	seq_printf(m, "Machine\t\t: OPSPUT Evaluation board\n");
-#elif  CONFIG_PLAT_USRV
+#elif defined(CONFIG_PLAT_USRV)
 	seq_printf(m, "Machine\t\t: uServer\n");
-#elif  CONFIG_PLAT_OAKS32R
+#elif defined(CONFIG_PLAT_OAKS32R)
 	seq_printf(m, "Machine\t\t: OAKS32R\n");
 #else
 	seq_printf(m, "Machine\t\t: Unknown\n");

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
