Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTFEUpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbTFEUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:45:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52100 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265117AbTFEUpl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:45:41 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468771986@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468772486@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1317, 2003/06/05 12:04:33-07:00, greg@kroah.com

[PATCH] PCI: move pci_present() into drivers/pci/search.c

This will let not have to export the pci_devices variable.


 drivers/pci/search.c |   11 +++++++++++
 include/linux/pci.h  |    6 +-----
 2 files changed, 12 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jun  5 13:52:43 2003
+++ b/drivers/pci/search.c	Thu Jun  5 13:52:43 2003
@@ -171,9 +171,20 @@
 	return NULL;
 }
 
+/**
+ * pci_present - determine if there are any pci devices on this system
+ *
+ * Returns 0 if no pci devices are present, 1 if pci devices are present.
+ */
+int pci_present(void)
+{
+	return !list_empty(&pci_devices);
+}
+
 EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
 EXPORT_SYMBOL(pci_find_subsys);
+EXPORT_SYMBOL(pci_present);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun  5 13:52:43 2003
+++ b/include/linux/pci.h	Thu Jun  5 13:52:43 2003
@@ -522,14 +522,10 @@
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-static inline int pci_present(void)
-{
-	return !list_empty(&pci_devices);
-}
-
 #define pci_for_each_bus(bus) \
 	for(bus = pci_bus_b(pci_root_buses.next); bus != pci_bus_b(&pci_root_buses); bus = pci_bus_b(bus->node.next))
 
+int pci_present(void);
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);

