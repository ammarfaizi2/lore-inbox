Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFJX4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTFJX4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:56:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:6806 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262169AbTFJXz4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:55:56 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552903163198@kroah.com>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
In-Reply-To: <10552903152794@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 17:11:56 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1397, 2003/06/10 14:17:50-07:00, greg@kroah.com

[PATCH] PCI: pci_present() can finally be removed, as there are no more users of it.


 drivers/pci/search.c |   11 -----------
 include/linux/pci.h  |    3 ---
 2 files changed, 14 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Tue Jun 10 17:04:04 2003
+++ b/drivers/pci/search.c	Tue Jun 10 17:04:04 2003
@@ -190,20 +190,9 @@
 	return NULL;
 }
 
-/**
- * pci_present - determine if there are any pci devices on this system
- *
- * Returns 0 if no pci devices are present, 1 if pci devices are present.
- */
-int pci_present(void)
-{
-	return !list_empty(&pci_devices);
-}
-
 EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
 EXPORT_SYMBOL(pci_find_subsys);
-EXPORT_SYMBOL(pci_present);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Jun 10 17:04:04 2003
+++ b/include/linux/pci.h	Tue Jun 10 17:04:04 2003
@@ -525,7 +525,6 @@
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
 
-int pci_present(void);
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);
@@ -667,8 +666,6 @@
  */
 
 #ifndef CONFIG_PCI
-static inline int pci_present(void) { return 0; }
-
 #define _PCI_NOP(o,s,t) \
 	static inline int pci_##o##_config_##s (struct pci_dev *dev, int where, t val) \
 		{ return PCIBIOS_FUNC_NOT_SUPPORTED; }

