Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272381AbTHFWNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272559AbTHFWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:13:49 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:1187 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S272381AbTHFWNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:13:35 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Alex Williamson <alex_williamson@hp.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] trivial 2.4/2.6 PCI name change/addition
Date: Wed, 6 Aug 2003 16:13:26 -0600
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, pci-ids@ucw.cz,
       Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F315CDD.12EB17FE@hp.com>
In-Reply-To: <3F315CDD.12EB17FE@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308061613.26982.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 1:54 pm, Alex Williamson wrote:
>    This patch renames the PCI-X adapter found in HP zx1 and sx1000
> ia64 systems to something more generic and descriptive.  It also
> adds an ID for the PCI adapter used in sx1000.  Patches against
> 2.4.21+ia64 and 2.6.0-test2+ia64 attached.  Thanks,

I applied this for the 2.4 ia64 patch.

Marcelo, do we need to do anything else to get this in your tree?


--- linux-2.4.21/include/linux/pci_ids.h~	2003-08-06 13:18:56.000000000 -0600
+++ linux-2.4.21/include/linux/pci_ids.h	2003-08-06 13:19:07.000000000 -0600
@@ -539,11 +539,12 @@
 #define PCI_DEVICE_ID_HP_DIVA1		0x1049
 #define PCI_DEVICE_ID_HP_DIVA2		0x104A
 #define PCI_DEVICE_ID_HP_SP2_0		0x104B
+#define PCI_DEVICE_ID_HP_PCI_LBA	0x1054
 #define PCI_DEVICE_ID_HP_REO_SBA	0x10f0
 #define PCI_DEVICE_ID_HP_REO_IOC	0x10f1
 #define PCI_DEVICE_ID_HP_ZX1_SBA	0x1229
 #define PCI_DEVICE_ID_HP_ZX1_IOC	0x122a
-#define PCI_DEVICE_ID_HP_ZX1_LBA	0x122e
+#define PCI_DEVICE_ID_HP_PCIX_LBA	0x122e
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
--- linux-2.4.21/drivers/pci/pci.ids~	2003-08-06 13:18:30.000000000 -0600
+++ linux-2.4.21/drivers/pci/pci.ids	2003-08-06 13:19:07.000000000 -0600
@@ -1212,6 +1212,7 @@
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
+	1054  PCI Local Bus Adapter
 	1064  79C970 PCnet Ethernet Controller
 	108b  Visualize FXe
 	10c1  NetServer Smart IRQ Router
@@ -1223,7 +1224,7 @@
 	121c  NetServer PCI COM Port Decoder
 	1229  zx1 System Bus Adapter
 	122a  zx1 I/O Controller
-	122e  zx1 Local Bus Adapter
+	122e  PCI-X/AGP Local Bus Adapter
 	1290  Auxiliary Diva Serial Port
 	2910  E2910A PCIBus Exerciser
 	2925  E2925A 32 Bit, 33 MHzPCI Exerciser & Analyzer
--- linux-2.4.21/drivers/char/agp/agpgart_be.c~	2003-08-06 13:18:20.000000000 -0600
+++ linux-2.4.21/drivers/char/agp/agpgart_be.c	2003-08-06 13:19:07.000000000 -0600
@@ -4853,7 +4853,7 @@
 	agp_bridge.type = HP_ZX1;
 
 	fake_bridge_dev.vendor = PCI_VENDOR_ID_HP;
-	fake_bridge_dev.device = PCI_DEVICE_ID_HP_ZX1_LBA;
+	fake_bridge_dev.device = PCI_DEVICE_ID_HP_PCIX_LBA;
 
 	return hp_zx1_ioc_init(ioc_hpa, lba_hpa);
 }

