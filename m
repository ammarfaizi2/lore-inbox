Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUDVPyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUDVPyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUDVPyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:54:50 -0400
Received: from fmr05.intel.com ([134.134.136.6]:44466 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264181AbUDVPwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:52:07 -0400
Date: Thu, 22 Apr 2004 10:36:11 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200404221736.i3MHaBeQ023389@snoqualmie.dp.intel.com>
To: akpm@osdl.org
Subject: [patch 3/3] efivars driver update and move 
Cc: bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matt_Domsch@dell.com,
       matthew.e.tolentino@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Third efivars driver update patch that removes x86 references
to the /proc version of the driver...

matt


diff -urN linux-2.6.6-rc2/arch/i386/kernel/efi.c linux-2.6.6-rc2-mod/arch/i386/kernel/efi.c
--- linux-2.6.6-rc2/arch/i386/kernel/efi.c	2004-04-20 14:29:43.000000000 -0700
+++ linux-2.6.6-rc2-mod/arch/i386/kernel/efi.c	2004-04-21 00:39:39.276757760 -0700
@@ -28,7 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/bootmem.h>
 #include <linux/ioport.h>
-#include <linux/proc_fs.h>
+#include <linux/module.h>
 #include <linux/efi.h>
 
 #include <asm/setup.h>
@@ -46,6 +46,7 @@
 extern efi_status_t asmlinkage efi_call_phys(void *, ...);
 
 struct efi efi;
+EXPORT_SYMBOL(efi);
 struct efi efi_phys __initdata;
 struct efi_memory_map memmap __initdata;
 
@@ -55,18 +56,6 @@
 extern void * boot_ioremap(unsigned long, unsigned long);
 
 /*
- * efi_dir is allocated here, but the directory isn't created
- * here, as proc_mkdir() doesn't work this early in the bootup
- * process.  Therefore, each module, like efivars, must test for
- *    if (!efi_dir) efi_dir = proc_mkdir("efi", NULL);
- * prior to creating their own entries under /proc/efi.
- */
-#ifdef CONFIG_PROC_FS
-struct proc_dir_entry *efi_dir;
-#endif
-
-
-/*
  * To make EFI call EFI runtime service in physical addressing mode we need
  * prelog/epilog before/after the invocation to disable interrupt, to
  * claim EFI runtime service handler exclusively and to duplicate a memory in
