Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRA2VyY>; Mon, 29 Jan 2001 16:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRA2VyO>; Mon, 29 Jan 2001 16:54:14 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:15984
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129334AbRA2VyG>; Mon, 29 Jan 2001 16:54:06 -0500
Date: Mon, 29 Jan 2001 22:53:57 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: ballabio_dario@emc.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [uPATCH] make drivers/scsi/eata.c call pci_enable_device before rs. probing (241p11)
Message-ID: <20010129225357.K603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/eata.c wait with probing
pci resources until we have called pci_enable_device. This is recommended
due to hot-plug considerations (according to Jeff Garzik).

It applies against ac12 and 241p11.

Comments?


--- linux-ac12-clean/drivers/scsi/eata.c	Tue Nov 28 02:49:00 2000
+++ linux-ac12/drivers/scsi/eata.c	Sat Jan 27 21:24:20 2001
@@ -835,9 +835,9 @@
 
       if (!(dev = pci_find_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) break;
 
-      addr = pci_resource_start (dev, 0);
-
       if (pci_enable_device (dev)) continue;
+
+      addr = pci_resource_start (dev, 0);
 
 #if defined(DEBUG_PCI_DETECT)
       printk("%s: tune_pci_port, bus %d, devfn 0x%x, addr 0x%x.\n",


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

While the Melissa license is a bit unclear, Melissa aggressively
encourages free distribution of its source code.
  -- Kevin Dalley on Melissa being Open Source
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
