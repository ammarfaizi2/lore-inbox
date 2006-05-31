Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWEaKSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWEaKSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWEaKSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:18:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:39943 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751242AbWEaKSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:18:52 -0400
X-IronPort-AV: i="4.05,192,1146466800"; 
   d="scan'208"; a="44800208:sNHT14572061"
Message-ID: <447D6D3D.5020608@intel.com>
Date: Wed, 31 May 2006 18:17:33 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org
Subject: [Cleanup] cleanup unused variable about msi driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In IA64 platform, msi driver does not use irq_vector variable, and in
x86 platform LAST_DEVICE_VECTOR should one before FIRST_SYSTEM_VECTOR,
this patch modify this.

Signed-off-by: bibo, mao<bibo.mao@intel.com>

Thanks
Bibo,mao
---

diff -Nruap 2.6.17-rc5-mm1.org/drivers/pci/msi.c 2.6.17-rc5-mm1/drivers/pci/msi.c
--- 2.6.17-rc5-mm1.org/drivers/pci/msi.c	2006-05-31 15:10:51.000000000 +0800
+++ 2.6.17-rc5-mm1/drivers/pci/msi.c	2006-05-31 15:21:38.000000000 +0800
@@ -35,7 +35,6 @@ static int nr_msix_devices;
 
 #ifndef CONFIG_X86_IO_APIC
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
-u8 irq_vector[NR_IRQ_VECTORS];
 #endif
 
 static struct msi_ops *msi_ops;
@@ -383,10 +382,6 @@ static int msi_init(void)
 		return status;
 	}
 
-#ifndef CONFIG_X86_IO_APIC
-	irq_vector[0] = FIRST_DEVICE_VECTOR;
-#endif
-
 	if (last_alloc_vector < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: No interrupt vectors available for MSI\n");
diff -Nruap 2.6.17-rc5-mm1.org/include/asm-i386/msi.h 2.6.17-rc5-mm1/include/asm-i386/msi.h
--- 2.6.17-rc5-mm1.org/include/asm-i386/msi.h	2006-05-31 15:10:51.000000000 +0800
+++ 2.6.17-rc5-mm1/include/asm-i386/msi.h	2006-05-31 15:22:10.000000000 +0800
@@ -9,7 +9,7 @@
 #include <asm/desc.h>
 #include <mach_apic.h>
 
-#define LAST_DEVICE_VECTOR		232
+#define LAST_DEVICE_VECTOR	(FIRST_SYSTEM_VECTOR - 1)
 #define MSI_TARGET_CPU_SHIFT	12
 
 extern struct msi_ops msi_apic_ops;
diff -Nruap 2.6.17-rc5-mm1.org/include/asm-x86_64/msi.h 2.6.17-rc5-mm1/include/asm-x86_64/msi.h
--- 2.6.17-rc5-mm1.org/include/asm-x86_64/msi.h	2006-05-31 15:10:50.000000000 +0800
+++ 2.6.17-rc5-mm1/include/asm-x86_64/msi.h	2006-05-31 15:22:28.000000000 +0800
@@ -10,7 +10,7 @@
 #include <asm/mach_apic.h>
 #include <asm/smp.h>
 
-#define LAST_DEVICE_VECTOR		232
+#define LAST_DEVICE_VECTOR	(FIRST_SYSTEM_VECTOR - 1)
 #define MSI_TARGET_CPU_SHIFT	12
 
 extern struct msi_ops msi_apic_ops;
