Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTFXRUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTFXRUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:20:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25298 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262589AbTFXRUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:20:31 -0400
Date: Tue, 24 Jun 2003 19:34:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org,
       Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
Subject: [PATCH][2.5] Fix compilation of ip2main (fwd)
Message-ID: <20030624173434.GU3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could anyone comment on this patch?

This patch by Eduardo Pereira Habkost <ehabkost@conectiva.com.br> or 
something similar is still needed in 2.5.73 to fix the compilation of 
ip2main.c .

TIA
Adrian


----- Forwarded message from Eduardo Pereira Habkost <ehabkost@conectiva.com.br> -----

Date:	Wed, 11 Jun 2003 19:32:21 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] Fix compilation of ip2main

The following patch fix compilation of drivers/char/ip2main.c. It was
broken by the removal of pci_present().

It just adds open and closing braces around the code that declares the
pci_dev_i variable. The rest of the patch just change the indentation.

--
Eduardo


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Wed Jun 11 19:18:27 2003
+++ b/drivers/char/ip2main.c	Wed Jun 11 19:18:27 2003
@@ -691,40 +691,42 @@
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



----- End forwarded message -----

