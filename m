Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVDLP1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVDLP1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVDLPYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:24:32 -0400
Received: from village.ehouse.ru ([193.111.92.18]:43790 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262443AbVDLPPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:15:17 -0400
Message-ID: <425BEB66.9030305@dev.ehouse.ru>
Date: Tue, 12 Apr 2005 19:38:14 +0400
From: Ihalainen Nickolay <ihanic@dev.ehouse.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: admin@list.net.ru, linux-kernel@vger.kernel.org
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
References: <425BBB77.9000509@dev.ehouse.ru> <20050412144459.GB9796@infradead.org>
In-Reply-To: <20050412144459.GB9796@infradead.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Apr 12, 2005 at 04:13:43PM +0400, Ihalainen Nickolay wrote:
> Also the driver has changed a little in -mm, can you provide a diff
> against that?
Sorry.
> 
diff -up -r linux-2.6.12-rc2/drivers/serial/jsm/jsm_driver.c 
linux-2.6.12-rc2-modified/drivers/serial/jsm/jsm_driver.c
--- linux-2.6.12-rc2/drivers/serial/jsm/jsm_driver.c    2005-04-11 
13:08:16.000000000 +0000
+++ linux-2.6.12-rc2-modified/drivers/serial/jsm/jsm_driver.c 
2005-04-11 12:58:51.000000000 +0000
@@ -60,11 +60,13 @@ int         jsm_driver_state = DRIVER_INITIALIZ
  spinlock_t     jsm_board_head_lock = SPIN_LOCK_UNLOCKED;
  LIST_HEAD(jsm_board_head);

+
  static struct pci_device_id jsm_pci_tbl[] = {
         { PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 
  0,      0,      0 },
         { PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 
  0,      0,      1 },
         { PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 
  0,      0,      2 },
         { PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI), 
  0,      0,      3 },
+       { PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_NEO_8_DID), 
0,      0,      4 },
         { 0,}                                           /* 0 terminated 
list. */
  };
  MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
@@ -74,6 +76,7 @@ static struct board_id jsm_Ids[] = {
         { PCI_DEVICE_NEO_2DB9PRI_PCI_NAME,      2 },
         { PCI_DEVICE_NEO_2RJ45_PCI_NAME,        2 },
         { PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME,     2 },
+       { PCI_DEVICE_NEO_8_DID          ,       8 },
         { NULL,                                 0 }
  };

@@ -167,6 +170,7 @@ static int jsm_found_board(struct pci_de
         case PCI_DEVICE_ID_NEO_2DB9PRI:
         case PCI_DEVICE_ID_NEO_2RJ45:
         case PCI_DEVICE_ID_NEO_2RJ45PRI:
+       case PCI_DEVICE_NEO_8_DID:

                 /*
                  * This chip is set up 100% when we get to it.
diff -up -r linux-2.6.12-rc2/include/linux/pci_ids.h 
linux-2.6.12-rc2-modified/include/linux/pci_ids.h
--- linux-2.6.12-rc2/include/linux/pci_ids.h    2005-04-11 
13:08:16.000000000 +0000
+++ linux-2.6.12-rc2-modified/include/linux/pci_ids.h   2005-04-11 
12:58:04.000000000 +0000
@@ -1530,6 +1530,7 @@
  #define PCI_DEVICE_ID_NEO_2DB9PRI       0x00C9
  #define PCI_DEVICE_ID_NEO_2RJ45         0x00CA
  #define PCI_DEVICE_ID_NEO_2RJ45PRI      0x00CB
+#define PCI_DEVICE_NEO_8_DID            0x00B1

  #define PCI_VENDOR_ID_MUTECH           0x1159
  #define PCI_DEVICE_ID_MUTECH_MV1000    0x0001

