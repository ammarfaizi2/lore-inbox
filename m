Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUHZJW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUHZJW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUHZJP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:15:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:33983 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268008AbUHZJB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:01:58 -0400
Subject: [PATCH] ppc32: properly export some pcibios_* functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093510767.2172.158.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 18:59:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Recent yenta_socket (and maybe others) rely on some pcibios_* functions
to be available to modules. This patch exports them.

Ben.

===== arch/ppc/kernel/pci.c 1.42 vs edited =====
--- 1.42/arch/ppc/kernel/pci.c	2004-08-04 21:55:48 +10:00
+++ edited/arch/ppc/kernel/pci.c	2004-08-26 16:43:07 +10:00
@@ -144,8 +144,7 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,		PCI_ANY_ID,			pcibios_fixup_resources);
 
-void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res)
 {
 	unsigned long offset = 0;
@@ -158,6 +157,7 @@
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
+EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 /*
  * We need to avoid collisions with `mirrored' VGA ports
@@ -172,8 +172,7 @@
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size,
+void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
 		       unsigned long align)
 {
 	struct pci_dev *dev = data;
@@ -193,7 +192,7 @@
 		}
 	}
 }
-
+EXPORT_SYMBOL(pcibios_align_resource);
 
 /*
  *  Handle resources of PCI devices.  If the world were perfect, we could


