Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279180AbRKFN1Y>; Tue, 6 Nov 2001 08:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279261AbRKFN1F>; Tue, 6 Nov 2001 08:27:05 -0500
Received: from ns.caldera.de ([212.34.180.1]:12447 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S279180AbRKFN0y>;
	Tue, 6 Nov 2001 08:26:54 -0500
Date: Tue, 6 Nov 2001 14:26:15 +0100
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        achim@vortex.de
Subject: PATCH: gdth pci table
Message-ID: <20011106142615.A6158@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To ease automatic hardware detection I have added PCI deviceid table to
gdth. Since I do not have such a card available for testing, I cannot
integrate it further.

Ciao, Marcus

Index: gdth.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/gdth.c,v
retrieving revision 1.15
diff -u -r1.15 gdth.c
--- gdth.c	2001/10/26 15:51:59	1.15
+++ gdth.c	2001/11/06 13:01:43
@@ -799,6 +799,17 @@
     return cnt;
 }
 
+#if LINUX_VERSION_CODE >= 0x20363
+/* Vortex only makes RAID controllers.
+ * We do not really want to specify all 550 ids here, so wildcard match.
+ */
+static struct pci_device_id gdthtable[] = {
+	{PCI_VENDOR_ID_VORTEX,PCI_ANY_ID,PCI_ANY_ID, PCI_ANY_ID },
+	{PCI_VENDOR_ID_INTEL,PCI_DEVICE_ID_INTEL_SRC,PCI_ANY_ID,PCI_ANY_ID }, 
+	{0}
+};
+MODULE_DEVICE_TABLE(pci,gdthtable);
+#endif
 
 GDTH_INITFUNC(static void, gdth_search_dev(gdth_pci_str *pcistr, ushort *cnt,
                                            ushort vendor, ushort device))
