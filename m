Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTHURdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTHURbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:16326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262856AbTHURbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:31:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870711746@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870703478@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:11 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1285.1.6, 2003/08/21 10:07:11-07:00, greg@kroah.com

PCI: added the pci_pretty_name() macro to pci.h as 2 arches already had it.


 arch/alpha/kernel/sys_marvel.c |    7 -------
 arch/x86_64/kernel/pci-gart.c  |    6 ------
 include/linux/pci.h            |    7 +++++++
 3 files changed, 7 insertions(+), 13 deletions(-)


diff -Nru a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
--- a/arch/alpha/kernel/sys_marvel.c	Thu Aug 21 10:20:18 2003
+++ b/arch/alpha/kernel/sys_marvel.c	Thu Aug 21 10:20:18 2003
@@ -33,13 +33,6 @@
 # error NR_IRQS < MARVEL_NR_IRQS !!!
 #endif
 
-/* ??? Should probably be generic.  */
-#ifdef CONFIG_PCI_NAMES
-#define pci_pretty_name(x) ((x)->pretty_name)
-#else
-#define pci_pretty_name(x) ""
-#endif
-
 
 /*
  * Interrupt handling.
diff -Nru a/arch/x86_64/kernel/pci-gart.c b/arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Thu Aug 21 10:20:18 2003
+++ b/arch/x86_64/kernel/pci-gart.c	Thu Aug 21 10:20:18 2003
@@ -31,12 +31,6 @@
 #include <asm/kdebug.h>
 #include <asm/proto.h>
 
-#ifdef CONFIG_PCI_NAMES
-#define pci_pretty_name(dev) ((dev)->pretty_name)
-#else
-#define pci_pretty_name(dev) ""
-#endif
-
 dma_addr_t bad_dma_address;
 
 unsigned long iommu_bus_base;	/* GART remapping area (physical) */
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Aug 21 10:20:18 2003
+++ b/include/linux/pci.h	Thu Aug 21 10:20:18 2003
@@ -842,6 +842,13 @@
 	return pdev->dev.bus_id;
 }
 
+/* Some archs want to see the pretty pci name, so use this macro */
+#ifdef CONFIG_PCI_NAMES
+#define pci_pretty_name(dev) ((dev)->pretty_name)
+#else
+#define pci_pretty_name(dev) ""
+#endif
+
 /*
  *  The world is not perfect and supplies us with broken PCI devices.
  *  For at least a part of these bugs we need a work-around, so both

