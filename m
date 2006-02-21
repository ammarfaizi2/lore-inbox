Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWBUB1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWBUB1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWBUB1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:27:52 -0500
Received: from fmr20.intel.com ([134.134.136.19]:5597 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161262AbWBUB1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:27:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory take two
Date: Tue, 21 Feb 2006 09:26:37 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101AE95F6@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory take two
Thread-Index: AcY2fEuunbZcy17yT9CIh05UL9QmXwACRzmA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Edgar Hucek" <hostmaster@ed-soft.at>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Feb 2006 01:26:37.0369 (UTC) FILETIME=[DBDA1290:01C63685]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>When EFI is enabled acpi_os_unmap_memory trys to unmap memory
>which was not mapped by acpi_os_map_memory.
Yes, this could solve you problem at hand, but I wonder why we should
always use ioremap in acpi_os_map_memory. It's ACPI tables or pci memory
bar, ioremap should be safe to me.

Thanks,
Shaohua

>
>Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
>
>diff -uNr linux-2.6.16-rc4.orig/drivers/acpi/osl.c linux-2.6.16-
>rc4/drivers/acpi/osl.c
>--- linux-2.6.16-rc4.orig/drivers/acpi/osl.c    2006-02-19
>18:48:58.000000000 +0100
>+++ linux-2.6.16-rc4/drivers/acpi/osl.c 2006-02-20 15:31:44.000000000
+0100
>@@ -208,7 +208,13 @@
>
> void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
> {
>-       iounmap(virt);
>+       if(efi_enabled) {
>+               if (!(EFI_MEMORY_WB &
>efi_mem_attributes(virt_to_phys(virt)))) {
>+                       iounmap(virt);
>+               }
>+       } else {
>+               iounmap(virt);
>+       }
> }
> EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);

