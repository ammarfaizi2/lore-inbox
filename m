Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTFKIIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTFKIIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 04:08:37 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:27654 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264203AbTFKIIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 04:08:36 -0400
To: ink@jurassic.park.msu.ru
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][ALPHA] PCI domains warning
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 11 Jun 2003 10:19:34 +0200
Message-ID: <wrpd6hlauw9.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan,

The included patch fixes a warning about pci_domain_nr being doubly
defined whet CONFIG_PCI_DOMAINS is not set (defined to 0 in
include/linux/pci.h and unconditionnaly defined in
include/asm-alpha/pci.h).

It was preventing a Jensen kernel to be built.

Thanks,

        M.

===== include/asm-alpha/pci.h 1.14 vs edited =====
--- 1.14/include/asm-alpha/pci.h	Mon Jun  9 18:25:23 2003
+++ edited/include/asm-alpha/pci.h	Wed Jun 11 09:41:37 2003
@@ -192,7 +192,9 @@
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
 
+#ifdef CONFIG_PCI_DOMAINS
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
+#endif
 
 #endif /* __KERNEL__ */
 

-- 
Places change, faces change. Life is so very strange.
