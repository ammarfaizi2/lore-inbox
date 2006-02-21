Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWBUAQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWBUAQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWBUAQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:16:06 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:54484
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1161217AbWBUAQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:16:04 -0500
Message-ID: <43FA5BC4.7050206@ed-soft.at>
Date: Tue, 21 Feb 2006 01:16:04 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory take two
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When EFI is enabled acpi_os_unmap_memory trys to unmap memory
which was not mapped by acpi_os_map_memory.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

diff -uNr linux-2.6.16-rc4.orig/drivers/acpi/osl.c linux-2.6.16-rc4/drivers/acpi/osl.c
--- linux-2.6.16-rc4.orig/drivers/acpi/osl.c    2006-02-19 18:48:58.000000000 +0100
+++ linux-2.6.16-rc4/drivers/acpi/osl.c 2006-02-20 15:31:44.000000000 +0100
@@ -208,7 +208,13 @@

 void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
 {
-       iounmap(virt);
+       if(efi_enabled) {
+               if (!(EFI_MEMORY_WB & efi_mem_attributes(virt_to_phys(virt)))) {
+                       iounmap(virt);
+               }
+       } else {
+               iounmap(virt);
+       }
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);


