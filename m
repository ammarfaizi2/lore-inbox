Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSGYNlw>; Thu, 25 Jul 2002 09:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSGYNlD>; Thu, 25 Jul 2002 09:41:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9725 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314551AbSGYNkE>; Thu, 25 Jul 2002 09:40:04 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251457.g6PEvBE9010565@irongate.swansea.linux.org.uk>
Subject: PATH: 2.5.28 (resend #1) Handle dunord pci decode problem
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:57:11 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/pci/quirks.c linux-2.5.28-ac1/drivers/pci/quirks.c
--- linux-2.5.28/drivers/pci/quirks.c	Thu Jul 25 10:49:20 2002
+++ linux-2.5.28-ac1/drivers/pci/quirks.c	Sun Jul 21 19:43:26 2002
@@ -457,10 +457,26 @@
 }
 
 /*
+ *	DreamWorks provided workaround for Dunord I-3000 problem
+ *
+ *	This card decodes and responds to addresses not apparently
+ *	assigned to it. We force a larger allocation to ensure that
+ *	nothing gets put too close to it.
+ */
+
+static void __init quirk_dunord ( struct pci_dev * dev )
+{
+	struct resource * r = & dev -> resource [ 1 ];
+	r -> start = 0;
+	r -> end = 0xffffff;
+}
+
+/*
  *  The main table of quirks.
  */
 
 static struct pci_fixup pci_fixups[] __initdata = {
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	/*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/include/linux/pci_ids.h linux-2.5.28-ac1/include/linux/pci_ids.h
--- linux-2.5.28/include/linux/pci_ids.h	Thu Jul 25 11:09:41 2002
+++ linux-2.5.28-ac1/include/linux/pci_ids.h	Thu Jul 25 11:10:31 2002
@@ -1612,6 +1612,9 @@
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 
+#define PCI_VENDOR_ID_DUNORD		0x5544
+#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
+
 #define PCI_VENDOR_ID_GENROCO		0x5555
 #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
 
