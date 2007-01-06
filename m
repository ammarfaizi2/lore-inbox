Return-Path: <linux-kernel-owner+w=401wt.eu-S1751371AbXAFMO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXAFMO4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 07:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbXAFMO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 07:14:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:46968 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXAFMOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 07:14:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N0SzilJyrmh1Qy3NuAdMexxr7G+Kos5Sa3aBwXW2naFxsdDIv3Nn60b7ECfdJzlK2ugTiOrCi5Jz3rt17/IXRdH35KAK1LoXLjvpeEpOt69LEbTIc38jKsW62wdQsUdKFYiyqg4ttO+XZJ82kgMmNUxlH3nX1fswPw6r1RNAkJU=
Message-ID: <5767b9100701060414j2e2385a8xcbab477bedca34b3@mail.gmail.com>
Date: Sat, 6 Jan 2007 20:14:54 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
Subject: [PATCH 2/3] atiixp.c: sb600 ide only has one channel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMD/ATI SB600 IDE/PATA controller only has one channel.

Signed-off-by: Conke Hu <conke.hu@amd.com>
---------------
--- linux-2.6.20-rc3-git4/drivers/ide/pci/atiixp.c.1	2007-01-06
19:13:55.000000000 +0800
+++ linux-2.6.20-rc3-git4/drivers/ide/pci/atiixp.c.2	2007-01-06
19:19:35.000000000 +0800
@@ -327,7 +327,14 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},
+	},{	/* 1 */
+		.name		= "SB600_PATA",
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
+ 		.bootable	= ON_BOARD,
+ 	},
 };

 /**
@@ -348,7 +355,7 @@ static struct pci_device_id atiixp_pci_t
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
