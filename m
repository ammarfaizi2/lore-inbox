Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSJDUwG>; Fri, 4 Oct 2002 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262347AbSJDUv7>; Fri, 4 Oct 2002 16:51:59 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:43279 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262298AbSJDUvh>;
	Fri, 4 Oct 2002 16:51:37 -0400
Date: Fri, 4 Oct 2002 13:54:11 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004205410.GD8346@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com> <20021004205305.GC8346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004205305.GC8346@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.674.3.5 -> 1.674.3.6
#	drivers/scsi/53c7,8xx.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	greg@kroah.com	1.674.3.6
# PCI: remove pcibios_find_device() from the 53c7,8xx.c SCSI driver
# --------------------------------------------
#
diff -Nru a/drivers/scsi/53c7,8xx.c b/drivers/scsi/53c7,8xx.c
--- a/drivers/scsi/53c7,8xx.c	Fri Oct  4 13:47:23 2002
+++ b/drivers/scsi/53c7,8xx.c	Fri Oct  4 13:47:23 2002
@@ -1533,8 +1533,7 @@
     int i;
     int current_override;
     int count;			/* Number of boards detected */
-    unsigned char pci_bus, pci_device_fn;
-    static short pci_index=0;	/* Device index to PCI BIOS calls */
+    struct pci_dev *pdev = NULL;
 
     tpnt->proc_name = "ncr53c7xx";
 
@@ -1563,13 +1562,11 @@
 
     if (pci_present()) {
 	for (i = 0; i < NPCI_CHIP_IDS; ++i) 
-	    for (pci_index = 0;
-		!pcibios_find_device (PCI_VENDOR_ID_NCR, 
-		    pci_chip_ids[i].pci_device_id, pci_index, &pci_bus, 
-		    &pci_device_fn); 
-    		++pci_index)
+	    while ((pdev = pci_find_device (PCI_VENDOR_ID_NCR,
+					    pci_chip_ids[i].pci_device_id,
+					    pdev)))
 		if (!ncr_pci_init (tpnt, BOARD_GENERIC, pci_chip_ids[i].chip, 
-		    pci_bus, pci_device_fn, /* no options */ 0))
+		    pdev->bus->number, pdev->devfn, /* no options */ 0))
 		    ++count;
     }
     return count;
