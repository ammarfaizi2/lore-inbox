Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVHUMKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVHUMKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 08:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVHUMKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 08:10:20 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:46788 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750975AbVHUMKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 08:10:19 -0400
Date: Sun, 21 Aug 2005 21:10:11 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: add pcibios_bus_to_resource
Message-Id: <20050821211011.10b7f4e7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added pcibios_bus_to_resource to MIPS.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/pci/pci.c mm1/arch/mips/pci/pci.c
--- mm1-orig/arch/mips/pci/pci.c	2005-08-21 01:35:21.000000000 +0900
+++ mm1/arch/mips/pci/pci.c	2005-08-21 01:38:06.000000000 +0900
@@ -292,8 +292,25 @@
 	region->end = res->end - offset;
 }
 
+void __devinit
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region)
+{
+	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
+	unsigned long offset = 0;
+
+	if (res->flags & IORESOURCE_IO)
+		offset = hose->io_offset;
+	else if (res->flags & IORESOURCE_MEM)
+		offset = hose->mem_offset;
+
+	res->start = region->start + offset;
+	res->end = region->end + offset;
+}
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_resource_to_bus);
+EXPORT_SYMBOL(pcibios_bus_to_resource);
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
diff -urN -X dontdiff mm1-orig/include/asm-mips/pci.h mm1/include/asm-mips/pci.h
--- mm1-orig/include/asm-mips/pci.h	2005-08-21 01:38:19.000000000 +0900
+++ mm1/include/asm-mips/pci.h	2005-08-21 01:41:01.000000000 +0900
@@ -142,6 +142,8 @@
 
 extern void pcibios_resource_to_bus(struct pci_dev *dev,
 	struct pci_bus_region *region, struct resource *res);
+extern void pcibios_bus_to_resource(struct pci_dev *dev,
+	struct resource *res, struct pci_bus_region *region);
 
 #ifdef CONFIG_PCI_DOMAINS
 


