Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbULAVmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbULAVmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbULAVmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:42:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29714 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261465AbULAVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:42:08 -0500
Date: Wed, 1 Dec 2004 22:42:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 efi.c: make some code static
Message-ID: <20041201214204.GT2650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes one struct and two functions static.

Additionally, print_efi_memmap is only required #if EFI_DEBUG.


diffstat output:
 arch/i386/kernel/efi.c |    8 +++++---
 include/linux/efi.h    |    1 -
 2 files changed, 5 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/efi.h.old	2004-12-01 07:56:59.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/efi.h	2004-12-01 07:57:09.000000000 +0100
@@ -300,7 +300,6 @@
 extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
-extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
 extern unsigned long __init efi_get_time(void);
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/efi.c.old	2004-12-01 07:56:26.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/efi.c	2004-12-01 08:07:19.000000000 +0100
@@ -46,7 +46,7 @@
 
 struct efi efi;
 EXPORT_SYMBOL(efi);
-struct efi efi_phys __initdata;
+static struct efi efi_phys __initdata;
 struct efi_memory_map memmap __initdata;
 
 /*
@@ -151,7 +151,7 @@
 	return status;
 }
 
-efi_status_t
+static efi_status_t
 phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	efi_status_t status;
@@ -240,7 +240,8 @@
 		printk(KERN_ERR PFX "Could not remap the EFI memmap!\n");
 }
 
-void __init print_efi_memmap(void)
+#if EFI_DEBUG
+static void __init print_efi_memmap(void)
 {
 	efi_memory_desc_t *md;
 	int i;
@@ -254,6 +255,7 @@
 			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
 	}
 }
+#endif  /*  EFI_DEBUG  */
 
 /*
  * Walks the EFI memory map and calls CALLBACK once for each EFI

