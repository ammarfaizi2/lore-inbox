Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTFECIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTFECDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:03:55 -0400
Received: from granite.he.net ([216.218.226.66]:57606 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264394AbTFECCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787482556@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787473162@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:48 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.10, 2003/06/04 00:02:59-07:00, greg@kroah.com

[PATCH] PCI: Move more functions out of include/linux/pci.h that don't need to be there.


 drivers/pci/pci.h   |    4 ++++
 include/linux/pci.h |    5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Wed Jun  4 18:11:42 2003
+++ b/drivers/pci/pci.h	Wed Jun  4 18:11:42 2003
@@ -27,6 +27,10 @@
 extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
 extern void pci_remove_bus_device(struct pci_dev *dev);
 extern int pci_remove_device_safe(struct pci_dev *dev);
+extern unsigned char pci_max_busnr(void);
+extern unsigned char pci_bus_max_busnr(struct pci_bus *bus);
+extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
+extern struct pci_bus *pci_find_bus(unsigned char busnr);
 
 struct pci_dev_wrapped {
 	struct pci_dev	*dev;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Jun  4 18:11:42 2003
+++ b/include/linux/pci.h	Wed Jun  4 18:11:42 2003
@@ -563,12 +563,8 @@
 				 unsigned int ss_vendor, unsigned int ss_device,
 				 const struct pci_dev *from);
 struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
-struct pci_bus *pci_find_bus(unsigned char busnr);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
-unsigned char pci_bus_max_busnr(struct pci_bus* bus);
-unsigned char pci_max_busnr(void);
 int pci_find_capability (struct pci_dev *dev, int cap);
-int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -620,7 +616,6 @@
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
-
 void pci_bus_assign_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
 int pci_claim_resource(struct pci_dev *, int);

