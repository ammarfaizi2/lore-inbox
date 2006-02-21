Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161389AbWBUGEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161389AbWBUGEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161387AbWBUGEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:04:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161385AbWBUGEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:04:06 -0500
Date: Mon, 20 Feb 2006 22:02:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Message-Id: <20060220220219.6d82366a.akpm@osdl.org>
In-Reply-To: <43FA5293.4070807@ed-soft.at>
References: <43FA5293.4070807@ed-soft.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Hucek <hostmaster@ed-soft.at> wrote:
>
> When EFI is enabled acpi_os_unmap_memory trys to unmap memory
>  which was not mapped by acpi_os_map_memory.

Your email client replaces tabs with spaces and wordwraps things.

The patch could be cleaned up a bit..

Matt, ACPi people: please ack or nack asap.



From: Edgar Hucek <hostmaster@ed-soft.at>

When EFI is enabled acpi_os_unmap_memory t] rys to unmap memory
which was not mapped by acpi_os_map_memory.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/osl.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN drivers/acpi/osl.c~efi-iounpam-fix-for-acpi_os_unmap_memory drivers/acpi/osl.c
--- devel/drivers/acpi/osl.c~efi-iounpam-fix-for-acpi_os_unmap_memory	2006-02-20 21:55:48.000000000 -0800
+++ devel-akpm/drivers/acpi/osl.c	2006-02-20 21:58:36.000000000 -0800
@@ -208,6 +208,10 @@ EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
 void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
 {
+	/* Don't unmap memory which was not mapped by acpi_os_map_memory */
+	if (efi_enabled &&
+	    (efi_mem_attributes(virt_to_phys(virt)) & EFI_MEMORY_WB))
+		return;
 	iounmap(virt);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
_

