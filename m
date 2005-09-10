Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVIJMWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVIJMWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVIJMVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:37 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:52871 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750779AbVIJMVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:16 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL9XI017246@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 specialix.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -2502,9 +2502,9 @@ static int __init specialix_init(void)
 				i++;
 				continue;
 			}
-			pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
-			                        PCI_DEVICE_ID_SPECIALIX_IO8, 
-			                        pdev);
+			pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
+					PCI_DEVICE_ID_SPECIALIX_IO8,
+					pdev);
 			if (!pdev) break;
 
 			if (pci_enable_device(pdev))
@@ -2517,7 +2517,10 @@ static int __init specialix_init(void)
 			sx_board[i].flags |= SX_BOARD_IS_PCI;
 			if (!sx_probe(&sx_board[i]))
 				found ++;
+
 		}
+		if (i >= SX_NBOARD)
+			pci_dev_put(pdev);
 	}
 #endif
 
