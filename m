Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSGUTwW>; Sun, 21 Jul 2002 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSGUTwW>; Sun, 21 Jul 2002 15:52:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39953 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314514AbSGUTwV>; Sun, 21 Jul 2002 15:52:21 -0400
Subject: PATCH: 2.5.27 pci quirk for dunord 
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:19:41 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WNB7-0007Zp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/pci/quirks.c linux-2.5.27-ac1/drivers/pci/quirks.c
--- linux-2.5.27/drivers/pci/quirks.c	Sat Jul 20 20:11:05 2002
+++ linux-2.5.27-ac1/drivers/pci/quirks.c	Sun Jul 21 19:43:26 2002
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/include/linux/pci_ids.h linux-2.5.27-ac1/include/linux/pci_ids.h
--- linux-2.5.27/include/linux/pci_ids.h	Sat Jul 20 20:11:14 2002
+++ linux-2.5.27-ac1/include/linux/pci_ids.h	Sun Jul 21 19:44:09 2002
@@ -1611,6 +1611,9 @@
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 
+#define PCI_VENDOR_ID_DUNORD		0x5544
+#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
+
 #define PCI_VENDOR_ID_GENROCO		0x5555
 #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
 
