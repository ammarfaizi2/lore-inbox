Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUIUUzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUIUUzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUIUUzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:55:01 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:16611 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268066AbUIUUyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:54:51 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc2-mm1] floppy ACPI enumeration update
Date: Tue, 21 Sep 2004 14:54:40 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211454.40116.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds ACPI device name ("Floppy Controller") and takes
advantage of acpi_device_bid() rather than the open-coded
equivalent.

Please include in the next -mm patchset.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -ur 2.6.9-rc2-mm1/drivers/block/floppy.c floppy1/drivers/block/floppy.c
--- 2.6.9-rc2-mm1/drivers/block/floppy.c 2004-09-21 12:51:48.000000000 -0600
+++ floppy1/drivers/block/floppy.c 2004-09-21 14:41:11.000000000 -0600
@@ -4301,7 +4301,9 @@
  if (ACPI_FAILURE(status))
   return -ENODEV;
 
- printk("%s: ACPI %s [%s] at I/O 0x%x-0x%x", DEVICE_NAME,
+ strncpy(acpi_device_name(device), "Floppy Controller",
+  sizeof(acpi_device_name(device)));
+ printk("ACPI: %s [%s] at I/O 0x%x-0x%x",
   acpi_device_name(device), acpi_device_bid(device),
   fd.io_region[0].base,
   fd.io_region[0].base + fd.io_region[0].size - 1);
@@ -4335,8 +4337,8 @@
      (port) < (region).base + (region).size)
 
  if (!(contains(fd.io_region[0], dcr) || contains(fd.io_region[1], dcr))) {
-  printk(KERN_WARNING "%s: %s _CRS doesn't include FD_DCR; also claiming 0x%x\n",
-   DEVICE_NAME, device->pnp.bus_id, dcr);
+  printk(KERN_WARNING "ACPI: [%s] doesn't declare FD_DCR; also claiming 0x%x\n",
+   acpi_device_bid(device), dcr);
  }
 
 #undef contains
@@ -4348,11 +4350,11 @@
  } else if (acpi_floppies == 1) {
   FDC2 = base;
   if (fd.irq != FLOPPY_IRQ || fd.dma_channel != FLOPPY_DMA)
-   printk(KERN_WARNING "%s: different IRQ/DMA info for %s; may not work\n",
-    DEVICE_NAME, device->pnp.bus_id);
+   printk(KERN_WARNING "%s: different IRQ/DMA info for [%s]; may not work\n",
+    DEVICE_NAME, acpi_device_bid(device));
  } else {
-  printk(KERN_ERR "%s: only 2 controllers supported; %s ignored\n",
-   DEVICE_NAME, device->pnp.bus_id);
+  printk(KERN_ERR "%s: only 2 controllers supported; [%s] ignored\n",
+   DEVICE_NAME, acpi_device_bid(device));
   return -ENODEV;
  }
 
