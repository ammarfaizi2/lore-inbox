Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129392AbQKVWcF>; Wed, 22 Nov 2000 17:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129485AbQKVWby>; Wed, 22 Nov 2000 17:31:54 -0500
Received: from [209.249.10.20] ([209.249.10.20]:23741 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129392AbQKVWbj>; Wed, 22 Nov 2000 17:31:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 22 Nov 2000 14:01:36 -0800
Message-Id: <200011222201.OAA29131@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Just to avoid duplication of effort, I am posting this preliminary
patch which adds PCI MODULE_DEVICE_TABLE declarations to the three PCI
drivers in linux-2.4.0-test11/drivers/block.  In response to input from
Christoph Hellwig, I have reduced my threshhold on using named initializers
to three entries, although I think that may be going to far, as I would
really like to keep the number of files that initialize the pci_device_id
arrays this way low so that changing struct pci_device_id remains feasible.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--- linux-2.4.0-test11/drivers/block/DAC960.c	Thu Oct 26 23:35:47 2000
+++ linux/drivers/block/DAC960.c	Wed Nov 22 12:42:23 2000
@@ -40,11 +40,22 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/segment.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
 
+
+static struct pci_device_id DAC960_pci_tbl[] __initdata = {
+ { PCI_VENDOR_ID_MYLEX, PCI_DEVICE_ID_MYLEX_DAC960_BA, PCI_ANY_ID, PCI_ANY_ID},
+ { PCI_VENDOR_ID_MYLEX, PCI_DEVICE_ID_MYLEX_DAC960_LP, PCI_ANY_ID, PCI_ANY_ID},
+ { PCI_VENDOR_ID_DEC,   PCI_DEVICE_ID_DEC_21285,       PCI_ANY_ID, PCI_ANY_ID},
+ { PCI_VENDOR_ID_MYLEX, PCI_DEVICE_ID_MYLEX_DAC960_PG, PCI_ANY_ID, PCI_ANY_ID},
+ { PCI_VENDOR_ID_MYLEX, PCI_DEVICE_ID_MYLEX_DAC960_PD, PCI_ANY_ID, PCI_ANY_ID},
+ { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, DAC960_pci_tbl);
 
 /*
   DAC960_ControllerCount is the number of DAC960 Controllers detected.
--- linux-2.4.0-test11/drivers/block/cciss.c	Thu Oct 26 23:35:47 2000
+++ linux/drivers/block/cciss.c	Wed Nov 22 12:29:27 2000
@@ -50,6 +50,17 @@
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Charles M. White III - Compaq Computer Corporation");
 MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5300");
+static struct pci_device_id cciss_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_COMPAQ,
+	  device: PCI_DEVICE_ID_COMPAQ_CISS,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, cciss_pci_tbl);
+
 
 #include "cciss_cmd.h"
 #include "cciss.h"
--- linux-2.4.0-test11/drivers/block/cpqarray.c	Thu Nov 16 11:30:29 2000
+++ linux/drivers/block/cpqarray.c	Wed Nov 22 12:34:53 2000
@@ -52,6 +52,16 @@
 MODULE_AUTHOR("Compaq Computer Corporation");
 MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers");
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+static struct pci_device_id cpqarray_pci_tbl[] __initdata = {
+  { PCI_VENDOR_ID_DEC,    PCI_DEVICE_ID_COMPAQ_42XX,   PCI_ANY_ID, PCI_ANY_ID},
+  { PCI_VENDOR_ID_NCR,    PCI_DEVICE_ID_NCR_53C1510,   PCI_ANY_ID, PCI_ANY_ID},
+  { PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,PCI_ANY_ID, PCI_ANY_ID},
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, cpqarray_pci_tbl);
+#endif
+
 #define MAJOR_NR COMPAQ_SMART2_MAJOR
 #include <linux/blk.h>
 #include <linux/blkdev.h>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
