Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUHXNwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUHXNwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUHXNwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:52:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7817 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267840AbUHXNwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:52:47 -0400
Message-Id: <200408241352.i7ODqf73026463@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: ralf@linux-mips.org
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 - #ifdef cleanip for MIPS
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Aug 2004 09:52:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning up some #if to use #ifdef instead, to make life safer for compiling
with -Wundef.

Signed-off-by: valdis.kletnieks@vt.edu

--- linux-2.6.9-rc1/include/asm-mips/mach-atlas/mc146818rtc.h.ifdef	2004-08-14 01:38:04.000000000 -0400
+++ linux-2.6.9-rc1/include/asm-mips/mach-atlas/mc146818rtc.h	2004-08-24 09:45:45.325693506 -0400
@@ -29,7 +29,7 @@
 #define RTC_EXTENT	16
 #define RTC_IRQ		ATLASINT_RTC
 
-#if CONFIG_CPU_LITTLE_ENDIAN
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define ATLAS_RTC_PORT(x) (RTC_PORT(x) + 0)
 #else
 #define ATLAS_RTC_PORT(x) (RTC_PORT(x) + 3)
--- linux-2.6.9-rc1/arch/mips/kernel/syscall.c.ifdef	2004-08-14 01:37:38.000000000 -0400
+++ linux-2.6.9-rc1/arch/mips/kernel/syscall.c	2004-08-24 09:47:24.971655401 -0400
@@ -65,7 +65,7 @@ unsigned long arch_get_unmapped_area(str
 	int do_color_align;
 	unsigned long task_size;
 
-#if CONFIG_MIPS32
+#ifdef CONFIG_MIPS32
 	task_size = TASK_SIZE;
 #else
 	task_size = (current->thread.mflags & MF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE;
--- linux-2.6.9-rc1/arch/mips/mips-boards/generic/memory.c.ifdef	2004-08-14 01:36:17.000000000 -0400
+++ linux-2.6.9-rc1/arch/mips/mips-boards/generic/memory.c	2004-08-24 09:49:52.517869822 -0400
@@ -77,7 +77,7 @@ struct prom_pmemblock * __init prom_getm
 	mdesc[1].base = 0x00001000;
 	mdesc[1].size = 0x000ef000;
 
-#if (CONFIG_MIPS_MALTA)
+#ifdef CONFIG_MIPS_MALTA
 	/*
 	 * The area 0x000f0000-0x000fffff is allocated for BIOS memory by the
 	 * south bridge and PCI access always forwarded to the ISA Bus and
--- linux-2.6.9-rc1/arch/mips/mm/c-r4k.c.ifdef	2004-08-14 01:38:04.000000000 -0400
+++ linux-2.6.9-rc1/arch/mips/mm/c-r4k.c	2004-08-24 09:46:56.957601992 -0400
@@ -587,10 +587,10 @@ static void r4k_flush_cache_sigtramp(uns
 			".set push\n\t"
 			".set noat\n\t"
 			".set mips3\n\t"
-#if CONFIG_MIPS32
+#ifdef CONFIG_MIPS32
 			"la	$at,1f\n\t"
 #endif
-#if CONFIG_MIPS64
+#ifdef CONFIG_MIPS64
 			"dla	$at,1f\n\t"
 #endif
 			"cache	%0,($at)\n\t"
--- linux-2.6.9-rc1/arch/mips/pci/fixup-atlas.c.ifdef	2004-08-24 08:43:33.000000000 -0400
+++ linux-2.6.9-rc1/arch/mips/pci/fixup-atlas.c	2004-08-24 09:48:26.805944425 -0400
@@ -44,7 +44,7 @@ void __init pcibios_fixup_irqs(void)
 {
 }
 
-#if CONFIG_KGDB
+#ifdef CONFIG_KGDB
 /*
  * The PCI scan may have moved the saa9730 I/O address, so reread
  * the address here.


