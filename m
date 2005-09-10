Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVIJMVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVIJMVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVIJMVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:18 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:51591 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750783AbVIJMVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:14 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL9oI017234@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 2/10] drivers/char: pci_find_device remove (drivers/char/istallion.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 istallion.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -4602,11 +4602,12 @@ static int stli_findpcibrds(void)
 	printk("stli_findpcibrds()\n");
 #endif
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_STALLION,
-	    PCI_DEVICE_ID_ECRA, dev))) {
-		if ((rc = stli_initpcibrd(BRD_ECPPCI, dev)))
+	while ((dev = pci_get_device(PCI_VENDOR_ID_STALLION,
+			PCI_DEVICE_ID_ECRA, dev)))
+		if ((rc = stli_initpcibrd(BRD_ECPPCI, dev))) {
+			pci_dev_put(dev);
 			return(rc);
-	}
+		}
 
 	return(0);
 }
