Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTFZAhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTFZAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:36:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34539 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265252AbTFZAfG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884923370@kroah.com>
Subject: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <20030626004551.GA14034@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:12 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.1, 2003/06/24 15:09:07-07:00, ehabkost@conectiva.com.br

[PATCH] Fix compilation of ip2main

The following patch fix compilation of drivers/char/ip2main.c. It was
broken by the removal of pci_present().

It just adds open and closing braces around the code that declares the
pci_dev_i variable. The rest of the patch just change the indentation.


 drivers/char/ip2main.c |   60 +++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 29 deletions(-)


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Wed Jun 25 17:38:28 2003
+++ b/drivers/char/ip2main.c	Wed Jun 25 17:38:28 2003
@@ -707,40 +707,42 @@
 				} 
 			} 
 #else /* LINUX_VERSION_CODE > 2.1.99 */
-			struct pci_dev *pci_dev_i = NULL;
-			pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
-						  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
-			if (pci_dev_i != NULL) {
-				unsigned int addr;
-				unsigned char pci_irq;
+			{
+				struct pci_dev *pci_dev_i = NULL;
+				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
+							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
+				if (pci_dev_i != NULL) {
+					unsigned int addr;
+					unsigned char pci_irq;
 
-				ip2config.type[i] = PCI;
-				status =
-				pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
-				if ( addr & 1 ) {
-					ip2config.addr[i]=(USHORT)(addr&0xfffe);
-				} else {
-					printk( KERN_ERR "IP2: PCI I/O address error\n");
-				}
-				status =
-				pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+					ip2config.type[i] = PCI;
+					status =
+					pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
+					if ( addr & 1 ) {
+						ip2config.addr[i]=(USHORT)(addr&0xfffe);
+					} else {
+						printk( KERN_ERR "IP2: PCI I/O address error\n");
+					}
+					status =
+					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
 
 //		If the PCI BIOS assigned it, lets try and use it.  If we
 //		can't acquire it or it screws up, deal with it then.
 
-//				if (!is_valid_irq(pci_irq)) {
-//					printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//					pci_irq = 0;
-//				}
-				ip2config.irq[i] = pci_irq;
-			} else {	// ann error
-				ip2config.addr[i] = 0;
-				if (status == PCIBIOS_DEVICE_NOT_FOUND) {
-					printk( KERN_ERR "IP2: PCI board %d not found\n", i );
-				} else {
-					pcibios_strerror(status);
-				}
-			} 
+//					if (!is_valid_irq(pci_irq)) {
+//						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
+//						pci_irq = 0;
+//					}
+					ip2config.irq[i] = pci_irq;
+				} else {	// ann error
+					ip2config.addr[i] = 0;
+					if (status == PCIBIOS_DEVICE_NOT_FOUND) {
+						printk( KERN_ERR "IP2: PCI board %d not found\n", i );
+					} else {
+						pcibios_strerror(status);
+					}
+				} 
+			}
 #endif	/* ! 2_0_X */
 #else
 			printk( KERN_ERR "IP2: PCI card specified but PCI support not\n");

