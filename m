Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFJTUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbTFJSk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:40:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33413 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264072AbTFJShg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709641395@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709641098@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1322, 2003/06/09 15:32:18-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/ip2main.c


 drivers/char/ip2main.c |   58 +++++++++++++++++++++++--------------------------
 1 files changed, 28 insertions(+), 30 deletions(-)


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Tue Jun 10 11:22:13 2003
+++ b/drivers/char/ip2main.c	Tue Jun 10 11:22:13 2003
@@ -691,41 +691,39 @@
 				} 
 			} 
 #else /* LINUX_VERSION_CODE > 2.1.99 */
-			if (pci_present()) {
-				struct pci_dev *pci_dev_i = NULL;
-				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
-							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
-				if (pci_dev_i != NULL) {
-					unsigned int addr;
-					unsigned char pci_irq;
+			struct pci_dev *pci_dev_i = NULL;
+			pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
+						  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
+			if (pci_dev_i != NULL) {
+				unsigned int addr;
+				unsigned char pci_irq;
 
-					ip2config.type[i] = PCI;
-					status =
-					pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
-					if ( addr & 1 ) {
-						ip2config.addr[i]=(USHORT)(addr&0xfffe);
-					} else {
-						printk( KERN_ERR "IP2: PCI I/O address error\n");
-					}
-					status =
-					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+				ip2config.type[i] = PCI;
+				status =
+				pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
+				if ( addr & 1 ) {
+					ip2config.addr[i]=(USHORT)(addr&0xfffe);
+				} else {
+					printk( KERN_ERR "IP2: PCI I/O address error\n");
+				}
+				status =
+				pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
 
 //		If the PCI BIOS assigned it, lets try and use it.  If we
 //		can't acquire it or it screws up, deal with it then.
 
-//					if (!is_valid_irq(pci_irq)) {
-//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//						pci_irq = 0;
-//					}
-					ip2config.irq[i] = pci_irq;
-				} else {	// ann error
-					ip2config.addr[i] = 0;
-					if (status == PCIBIOS_DEVICE_NOT_FOUND) {
-						printk( KERN_ERR "IP2: PCI board %d not found\n", i );
-					} else {
-						pcibios_strerror(status);
-					}
-				} 
+//				if (!is_valid_irq(pci_irq)) {
+//					printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
+//					pci_irq = 0;
+//				}
+				ip2config.irq[i] = pci_irq;
+			} else {	// ann error
+				ip2config.addr[i] = 0;
+				if (status == PCIBIOS_DEVICE_NOT_FOUND) {
+					printk( KERN_ERR "IP2: PCI board %d not found\n", i );
+				} else {
+					pcibios_strerror(status);
+				}
 			} 
 #endif	/* ! 2_0_X */
 #else

