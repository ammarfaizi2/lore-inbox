Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWIZUpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWIZUpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWIZUpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:45:40 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:56517 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964798AbWIZUpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:45:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [patch] i386: replace intermediate array-size definitions with ARRAY_SIZE()
Date: Tue, 26 Sep 2006 14:45:21 -0600
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609261445.21537.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code is easier to validate if array sizes aren't hidden behind extra
#defines.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm3/arch/i386/kernel/setup.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/setup.c	2006-09-26 14:33:24.000000000 -0600
+++ work-mm3/arch/i386/kernel/setup.c	2006-09-26 14:37:57.000000000 -0600
@@ -209,9 +209,6 @@
 	.flags	= IORESOURCE_BUSY | IORESOURCE_READONLY | IORESOURCE_MEM
 } };
 
-#define ADAPTER_ROM_RESOURCES \
-	(sizeof adapter_rom_resources / sizeof adapter_rom_resources[0])
-
 static struct resource video_rom_resource = {
 	.name 	= "Video ROM",
 	.start	= 0xc0000,
@@ -273,9 +270,6 @@
 	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
 } };
 
-#define STANDARD_IO_RESOURCES \
-	(sizeof standard_io_resources / sizeof standard_io_resources[0])
-
 #define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
 
 static int __init romchecksum(unsigned char *rom, unsigned long length)
@@ -332,7 +326,7 @@
 	}
 
 	/* check for adapter roms on 2k boundaries */
-	for (i = 0; i < ADAPTER_ROM_RESOURCES && start < upper; start += 2048) {
+	for (i = 0; i < ARRAY_SIZE(adapter_rom_resources) && start < upper; start += 2048) {
 		rom = isa_bus_to_virt(start);
 		if (!romsignature(rom))
 			continue;
@@ -1292,7 +1286,7 @@
 	request_resource(&iomem_resource, &video_ram_resource);
 
 	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+	for (i = 0; i < ARRAY_SIZE(standard_io_resources); i++)
 		request_resource(&ioport_resource, &standard_io_resources[i]);
 	return 0;
 }
