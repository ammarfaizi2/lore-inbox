Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUBTTIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUBTTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:08:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:64229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261276AbUBTTGX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:23 -0500
Subject: [PATCH] PCI update for 2.6.3
In-Reply-To: <20040220190413.GA15063@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:17 -0800
Message-Id: <10773039771460@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.1, 2004/02/18 11:15:56-08:00, mgreer@mvista.com

[PATCH] PCI: Changing 'GALILEO' to 'MARVELL'

I'm working with some Marvell components (formerly Galileo Technologies)
and noticed that the entries in include/linux/pci_ids.h have become
dated.  I have attached a patch that changes 'GALILEO' to 'MARVELL',
adds some more devices, and updates the uses of the macros in the code.
Please note that the newer marvell parts start with 'MV' instead of 'GT'
to represent the new name.  Also, I didn't change all uses of galileo to
marvell, only the macro in pci_ids.h.


 arch/mips/pci/pci-cobalt.c |    2 +-
 drivers/net/gt96100eth.c   |    6 +++---
 include/linux/pci_ids.h    |   13 ++++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)


diff -Nru a/arch/mips/pci/pci-cobalt.c b/arch/mips/pci/pci-cobalt.c
--- a/arch/mips/pci/pci-cobalt.c	Fri Feb 20 10:45:28 2004
+++ b/arch/mips/pci/pci-cobalt.c	Fri Feb 20 10:45:28 2004
@@ -258,7 +258,7 @@
 	 qube_raq_via_bmIDE_fixup},
 	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21142,
 	 qube_raq_tulip_fixup},
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_GALILEO, PCI_ANY_ID,
+	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_MARVELL, PCI_ANY_ID,
 	 qube_raq_galileo_fixup},
 	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C860,
 	 qube_raq_scsi_fixup},
diff -Nru a/drivers/net/gt96100eth.c b/drivers/net/gt96100eth.c
--- a/drivers/net/gt96100eth.c	Fri Feb 20 10:45:28 2004
+++ b/drivers/net/gt96100eth.c	Fri Feb 20 10:45:28 2004
@@ -661,9 +661,9 @@
 	pcibios_read_config_word(0, 0, PCI_VENDOR_ID, &vendor_id);
 	pcibios_read_config_word(0, 0, PCI_DEVICE_ID, &device_id);
     
-	if (vendor_id != PCI_VENDOR_ID_GALILEO ||
-	    (device_id != PCI_DEVICE_ID_GALILEO_GT96100 &&
-	     device_id != PCI_DEVICE_ID_GALILEO_GT96100A)) {
+	if (vendor_id != PCI_VENDOR_ID_MARVELL ||
+	    (device_id != PCI_DEVICE_ID_MARVELL_GT96100 &&
+	     device_id != PCI_DEVICE_ID_MARVELL_GT96100A)) {
 		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
 		return -ENODEV;
 	}
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri Feb 20 10:45:28 2004
+++ b/include/linux/pci_ids.h	Fri Feb 20 10:45:28 2004
@@ -1422,11 +1422,14 @@
 #define PCI_SUBVENDOR_ID_KEYSPAN	0x11a9
 #define PCI_SUBDEVICE_ID_KEYSPAN_SX2	0x5334
 
-#define PCI_VENDOR_ID_GALILEO		0x11ab
-#define PCI_DEVICE_ID_GALILEO_GT64011	0x4146
-#define PCI_DEVICE_ID_GALILEO_GT64111	0x4146
-#define PCI_DEVICE_ID_GALILEO_GT96100	0x9652
-#define PCI_DEVICE_ID_GALILEO_GT96100A	0x9653
+#define PCI_VENDOR_ID_MARVELL		0x11ab
+#define PCI_DEVICE_ID_MARVELL_GT64011	0x4146
+#define PCI_DEVICE_ID_MARVELL_GT64111	0x4146
+#define PCI_DEVICE_ID_MARVELL_GT64260	0x6430
+#define PCI_DEVICE_ID_MARVELL_MV64360	0x6460
+#define PCI_DEVICE_ID_MARVELL_MV64460	0x6480
+#define PCI_DEVICE_ID_MARVELL_GT96100	0x9652
+#define PCI_DEVICE_ID_MARVELL_GT96100A	0x9653
 
 #define PCI_VENDOR_ID_LITEON		0x11ad
 #define PCI_DEVICE_ID_LITEON_LNE100TX	0x0002

