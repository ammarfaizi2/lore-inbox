Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWACPR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWACPR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWACPR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:17:58 -0500
Received: from [81.2.110.250] ([81.2.110.250]:43712 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932398AbWACPR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:17:57 -0500
Subject: PATCH: Small fixes backported to old IDE SiS driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 15:19:41 +0000
Message-Id: <1136301581.22598.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some quick backport bits from the libata PATA work to fix things found
in the sis driver. The piix driver needs some fixes too but those are
way to large and need someone working on old IDE with time to do them.

This patch fixes the case where random bits get loaded into SIS timing
registers according to the description of the correct behaviour from
Vojtech Pavlik. It also adds the SiS5517 ATA16 chipset which is not
currently supported by the driver. Thanks to Conrad Harriss for loaning
me the machine with the 5517 chipset.

Alan


Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/ide/pci/sis5513.c~	2006-01-03 15:01:24.753952872 +0000
+++ drivers/ide/pci/sis5513.c	2006-01-03 15:01:24.753952872 +0000
@@ -111,6 +111,7 @@
 
 	{ "SiS5596",	PCI_DEVICE_ID_SI_5596,	ATA_16   },
 	{ "SiS5571",	PCI_DEVICE_ID_SI_5571,	ATA_16   },
+	{ "SiS5517",	PCI_DEVICE_ID_SI_5517,	ATA_16   },
 	{ "SiS551x",	PCI_DEVICE_ID_SI_5511,	ATA_16   },
 };
 
@@ -523,6 +524,7 @@
 			case 3:		test1 = 0x30|0x03; break;
 			case 2:		test1 = 0x40|0x04; break;
 			case 1:		test1 = 0x60|0x07; break;
+			case 0:		test1 = 0x00; break;
 			default:	break;
 		}
 		pci_write_config_byte(dev, drive_pci, test1);
--- include/linux/pci_ids.h~	2006-01-03 15:00:52.835805168 +0000
+++ include/linux/pci_ids.h	2006-01-03 15:00:52.836805016 +0000
@@ -632,6 +632,7 @@
 #define PCI_DEVICE_ID_SI_963		0x0963
 #define PCI_DEVICE_ID_SI_5511		0x5511
 #define PCI_DEVICE_ID_SI_5513		0x5513
+#define PCI_DEVICE_ID_SI_5517		0x5517
 #define PCI_DEVICE_ID_SI_5518		0x5518
 #define PCI_DEVICE_ID_SI_5571		0x5571
 #define PCI_DEVICE_ID_SI_5581		0x5581

