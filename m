Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131015AbRA2WBO>; Mon, 29 Jan 2001 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130955AbRA2WBF>; Mon, 29 Jan 2001 17:01:05 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:17264
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129956AbRA2WAv>; Mon, 29 Jan 2001 17:00:51 -0500
Date: Mon, 29 Jan 2001 23:00:41 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: groudier@club-internet.fr
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] make sym53c8xx.c and ncr53c8xx.c call pci_enable_device (241p11)
Message-ID: <20010129230041.N603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/sym53c8xx.c and (by way of
sym53c8xx_comm.h::sym53c8xx__detect) ncr53c8xx.c do a
pci_enable_device after finding a device.

It applies against ac12 and 241p11.

Comments?


--- linux-ac11-clean/drivers/scsi/sym53c8xx.c	Mon Jan  1 19:23:21 2001
+++ linux-ac11/drivers/scsi/sym53c8xx.c	Thu Jan 25 23:12:06 2001
@@ -13294,6 +13294,8 @@
 			++j;
 			continue;
 		}
+		if (pci_enable_device(pcidev))
+			continue;
 		/* Some HW as the HP LH4 may report twice PCI devices */
 		for (i = 0; i < count ; i++) {
 			if (devtbl[i].slot.bus	     == PciBusNumber(pcidev) && 
--- linux-ac11-clean/drivers/scsi/sym53c8xx_comm.h	Mon Oct 16 21:56:50 2000
+++ linux-ac11/drivers/scsi/sym53c8xx_comm.h	Fri Jan 26 22:54:19 2001
@@ -2754,6 +2754,8 @@
 			++j;
 			continue;
 		}
+		if (pci_enable_device(pcidev))
+			continue;
 		/* Some HW as the HP LH4 may report twice PCI devices */
 		for (i = 0; i < count ; i++) {
 			if (devtbl[i].slot.bus	     == PciBusNumber(pcidev) && 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

When C++ is your hammer, everything looks like a thumb.      Steven M. Haflich
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
