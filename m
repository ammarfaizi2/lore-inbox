Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWEDXJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWEDXJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEDXJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:09:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59568 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932382AbWEDXJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:09:50 -0400
Date: Thu, 4 May 2006 18:09:45 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jes Sorensen <jes@sgi.com>, Jeremy Higdon <jeremy@sgi.com>
Subject: [PATCH] Move various PCI IDs to header file
Message-ID: <20060504180614.X88573@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move various QLogic, Vitesse, and Intel storage
controller PCI IDs to the main header file.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

---

As suggested by Andrew Morton and Jes Sorenson.

 drivers/scsi/qla1280.c  |   24 ------------------------
 drivers/scsi/sata_vsc.c |   11 ++++++-----
 include/linux/pci_ids.h |    9 +++++++++
 3 files changed, 15 insertions(+), 29 deletions(-)

---
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 5a48e55..00662a5 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -397,30 +397,6 @@
 #include "ql1280_fw.h"
 #include "ql1040_fw.h"
 
-
-/*
- * Missing PCI ID's
- */
-#ifndef PCI_DEVICE_ID_QLOGIC_ISP1080
-#define PCI_DEVICE_ID_QLOGIC_ISP1080	0x1080
-#endif
-#ifndef PCI_DEVICE_ID_QLOGIC_ISP1240
-#define PCI_DEVICE_ID_QLOGIC_ISP1240	0x1240
-#endif
-#ifndef PCI_DEVICE_ID_QLOGIC_ISP1280
-#define PCI_DEVICE_ID_QLOGIC_ISP1280	0x1280
-#endif
-#ifndef PCI_DEVICE_ID_QLOGIC_ISP10160
-#define PCI_DEVICE_ID_QLOGIC_ISP10160	0x1016
-#endif
-#ifndef PCI_DEVICE_ID_QLOGIC_ISP12160
-#define PCI_DEVICE_ID_QLOGIC_ISP12160	0x1216
-#endif
-
-#ifndef PCI_VENDOR_ID_AMI
-#define PCI_VENDOR_ID_AMI               0x101e
-#endif
-
 #ifndef BITS_PER_LONG
 #error "BITS_PER_LONG not defined!"
 #endif
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 8a29ce3..27d6587 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -433,13 +433,14 @@ err_out:
 
 
 /*
- * 0x1725/0x7174 is the Vitesse VSC-7174
- * 0x8086/0x3200 is the Intel 31244, which is supposed to be identical
- * compatibility is untested as of yet
+ * Intel 31244 is supposed to be identical.
+ * Compatibility is untested as of yet.
  */
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
-	{ 0x1725, 0x7174, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ 0x8086, 0x3200, PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
+	{ PCI_VENDOR_ID_VITESSE, PCI_DEVICE_ID_VITESSE_VSC7174,
+	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GD31244,
+	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
 	{ }
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d6fe048..c380faf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -848,7 +848,12 @@
 
 
 #define PCI_VENDOR_ID_QLOGIC		0x1077
+#define PCI_DEVICE_ID_QLOGIC_ISP10160	0x1016
 #define PCI_DEVICE_ID_QLOGIC_ISP1020	0x1020
+#define PCI_DEVICE_ID_QLOGIC_ISP1080	0x1080
+#define PCI_DEVICE_ID_QLOGIC_ISP12160	0x1216
+#define PCI_DEVICE_ID_QLOGIC_ISP1240	0x1240
+#define PCI_DEVICE_ID_QLOGIC_ISP1280	0x1280
 #define PCI_DEVICE_ID_QLOGIC_ISP2100	0x2100
 #define PCI_DEVICE_ID_QLOGIC_ISP2200	0x2200
 #define PCI_DEVICE_ID_QLOGIC_ISP2300	0x2300
@@ -1957,6 +1962,9 @@
 #define PCI_VENDOR_ID_NETCELL		0x169c
 #define PCI_DEVICE_ID_REVOLUTION	0x0044
 
+#define PCI_VENDOR_ID_VITESSE		0x1725
+#define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
+
 #define PCI_VENDOR_ID_LINKSYS		0x1737
 #define PCI_DEVICE_ID_LINKSYS_EG1064	0x1064
 
@@ -2135,6 +2143,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
 #define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
+#define PCI_DEVICE_ID_INTEL_GD31244	0x3200
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
