Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbULWPuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbULWPuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbULWPue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:50:34 -0500
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:15573 "EHLO
	tallyho.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S261257AbULWPuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:50:18 -0500
From: Fred Emmott <mail@fredemmott.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SATA DVD Writer on SiI 3114 controller
Date: Thu, 23 Dec 2004 15:48:30 +0000
User-Agent: KMail/1.7.50
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412231548.31080.mail@fredemmott.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sata-sil driver supports the controller, however it doesn't support ATAPI 
devices. Here's patches for the siimage controller (needs sata support in ide 
config enabled) to use this controller with the siimage module and atapi 
devices, against 2.6.9.

include/linux/pci_ids_h:

923a924
> #define PCI_DEVICE_ID_SII_3114                0x3114

drivers/ide/pci/siimage.c:

48a49
>               case PCI_DEVICE_ID_SII_3114:
1109c1110,1111
<       /* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
---
>       /* 2 */ DECLARE_SII_DEV("SiI3114 Serial ATA"),
>       /* 3 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
1131c1133,1134
<       { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 
0, 0, 2},
---
>       { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3114, PCI_ANY_ID, PCI_ANY_ID, 
0,0, 2},
>       { PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 
0, 0, 3},

-- 
Fred Emmott
(http://www.fredemmott.co.uk)
