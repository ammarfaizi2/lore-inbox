Return-Path: <linux-kernel-owner+w=401wt.eu-S1751263AbXAIKDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXAIKDJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXAIKDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:03:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:13415 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXAIKDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:03:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ks7fZQzSHJgApWMzszpbzBbg+j26iixiv0zJJzymXUxNjPrLeS6QjKBecRFvIWfx8EbyUBPpjoFm1x+b7HK/tXM9lrZqWAu6Cj64SjgN+d6GrQBNcDIgXusm2vkOyWl/gdj/56875sp/fz3WiCOuP3MMeSMW89BpSYly2v2Tmo8=
Message-ID: <5767b9100701090203v5eeecc53if2600ee78554003e@mail.gmail.com>
Date: Tue, 9 Jan 2007 18:03:06 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH] Add pci class code for SATA (patch updated)
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "Andrew Morton" <akpm@osdl.org>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/07, Jeff Garzik <jeff@garzik.org> wrote:
>  ...
> The above seems OK to me...
>
>         Jeff
>

add pci class code for SATA & AHCI, and replace some magic numbers.

Signed-off-by: Conke Hu <conke.hu@amd.com>
------------
diff -Nur linux-2.6.20-rc4.orig/drivers/ata/ahci.c
linux-2.6.20-rc4/drivers/ata/ahci.c
--- linux-2.6.20-rc4.orig/drivers/ata/ahci.c	2007-01-09 15:50:14.000000000 +0800
+++ linux-2.6.20-rc4/drivers/ata/ahci.c	2007-01-09 15:53:52.000000000 +0800
@@ -426,7 +426,7 @@

 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  0x010601, 0xffffff, board_ahci },
+	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },

 	{ }	/* terminate list */
 };
@@ -1594,11 +1594,11 @@
 		speed_s = "?";

 	pci_read_config_word(pdev, 0x0a, &cc);
-	if (cc == 0x0101)
+	if (cc == PCI_CLASS_STORAGE_IDE)
 		scc_s = "IDE";
-	else if (cc == 0x0106)
+	else if (cc == PCI_CLASS_STORAGE_SATA)
 		scc_s = "SATA";
-	else if (cc == 0x0104)
+	else if (cc == PCI_CLASS_STORAGE_RAID)
 		scc_s = "RAID";
 	else
 		scc_s = "unknown";
diff -Nur linux-2.6.20-rc4.orig/drivers/pci/quirks.c
linux-2.6.20-rc4/drivers/pci/quirks.c
--- linux-2.6.20-rc4.orig/drivers/pci/quirks.c	2007-01-09
15:50:14.000000000 +0800
+++ linux-2.6.20-rc4/drivers/pci/quirks.c	2007-01-09 15:52:10.000000000 +0800
@@ -862,7 +862,7 @@
 		pci_write_config_byte(pdev, 0xa, 6);
 		pci_write_config_byte(pdev, 0x40, tmp);

-		pdev->class = 0x010601;
+		pdev->class = PCI_CLASS_STORAGE_SATA_AHCI;
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI,
PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
diff -Nur linux-2.6.20-rc4.orig/include/linux/pci_ids.h
linux-2.6.20-rc4/include/linux/pci_ids.h
--- linux-2.6.20-rc4.orig/include/linux/pci_ids.h	2007-01-09
15:50:14.000000000 +0800
+++ linux-2.6.20-rc4/include/linux/pci_ids.h	2007-01-09 15:51:42.000000000 +0800
@@ -15,6 +15,8 @@
 #define PCI_CLASS_STORAGE_FLOPPY	0x0102
 #define PCI_CLASS_STORAGE_IPI		0x0103
 #define PCI_CLASS_STORAGE_RAID		0x0104
+#define PCI_CLASS_STORAGE_SATA		0x0106
+#define PCI_CLASS_STORAGE_SATA_AHCI	0x010601
 #define PCI_CLASS_STORAGE_SAS		0x0107
 #define PCI_CLASS_STORAGE_OTHER		0x0180
