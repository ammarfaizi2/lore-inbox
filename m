Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTFEUuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbTFEUti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:49:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47285 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265134AbTFEUrt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:47:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468771981@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468771986@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1318, 2003/06/05 12:04:44-07:00, greg@kroah.com

[PATCH] PCI: remove EXPORT_SYMBOL(pci_devices)

Now the only users of this directly should be the pci core and arch specific
pci core code.


 drivers/pci/probe.c |    1 -
 include/linux/pci.h |   11 +++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jun  5 13:52:38 2003
+++ b/drivers/pci/probe.c	Thu Jun  5 13:52:38 2003
@@ -689,7 +689,6 @@
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
-EXPORT_SYMBOL(pci_devices);
 EXPORT_SYMBOL(pci_root_buses);
 
 #ifdef CONFIG_HOTPLUG
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun  5 13:52:38 2003
+++ b/include/linux/pci.h	Thu Jun  5 13:52:38 2003
@@ -468,10 +468,6 @@
 
 #define pci_bus_b(n) list_entry(n, struct pci_bus, node)
 
-extern struct list_head pci_root_buses;	/* list of all known PCI buses */
-extern struct list_head pci_devices;	/* list of all devices */
-extern struct bus_type pci_bus_type;
-
 /*
  * Error values that may be returned by PCI functions.
  */
@@ -521,6 +517,13 @@
 
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
+
+extern struct bus_type pci_bus_type;
+
+/* Do NOT directly access these two variables, unless you are arch specific pci
+ * code, or pci core code. */
+extern struct list_head pci_root_buses;	/* list of all known PCI buses */
+extern struct list_head pci_devices;	/* list of all devices */
 
 #define pci_for_each_bus(bus) \
 	for(bus = pci_bus_b(pci_root_buses.next); bus != pci_bus_b(&pci_root_buses); bus = pci_bus_b(bus->node.next))

