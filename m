Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSKMUGz>; Wed, 13 Nov 2002 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKMUGz>; Wed, 13 Nov 2002 15:06:55 -0500
Received: from fmr05.intel.com ([134.134.136.6]:7661 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id <S262780AbSKMUGy>;
	Wed, 13 Nov 2002 15:06:54 -0500
Date: Wed, 13 Nov 2002 12:13:43 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200211132013.gADKDhS01389@linux.intel.com>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH][2.5.47]Add exported valid_kernel_address()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a small patch to the 2.5.47 kernel that adds an exported
function called valid_kernel_address() that allows kernel code to verify
a kernel-mapped address is valid.

valid_kernel_address just calls the static inline kernel_text_address()
function defined in arch/i386/kernel/traps.c 

	   -rustyl

diff -urN linux-2.5.47/arch/i386/kernel/i386_ksyms.c linux-2.5.47-vka-patch/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.47/arch/i386/kernel/i386_ksyms.c	2002-11-10 19:28:32.000000000 -0800
+++ linux-2.5.47-vka-patch/arch/i386/kernel/i386_ksyms.c	2002-11-13 11:46:49.000000000 -0800
@@ -59,6 +59,8 @@
 extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);
 
+extern int valid_kernel_address(unsigned long addr);
+
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
 #ifdef CONFIG_EISA
@@ -91,6 +93,7 @@
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
+EXPORT_SYMBOL(valid_kernel_address);
 
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
diff -urN linux-2.5.47/arch/i386/kernel/traps.c linux-2.5.47-vka-patch/arch/i386/kernel/traps.c
--- linux-2.5.47/arch/i386/kernel/traps.c	2002-11-10 19:28:05.000000000 -0800
+++ linux-2.5.47-vka-patch/arch/i386/kernel/traps.c	2002-11-13 11:51:58.000000000 -0800
@@ -129,6 +129,11 @@
 
 #endif
 
+int valid_kernel_address(unsigned long addr)
+{
+	return kernel_text_address(addr);
+}
+
 void show_trace(unsigned long * stack)
 {
 	int i;
