Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVHJAJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVHJAJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVHJAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:09:50 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16263 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750982AbVHJAJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:09:38 -0400
Date: Wed, 10 Aug 2005 02:09:39 +0200
Message-Id: <200508100009.j7A09dhS003704@wscnet.wsc.cz>
In-reply-to: <20050809233744.GA24343@kroah.com>
Subject: [PATCH 2/2] removes pci_find_device from parport_pc.c
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andrew has added this into his tree yet.]

This patch changes pci_find_device to pci_get_device (encapsulated in
for_each_pci_dev).

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -3007,7 +3007,7 @@ static int __init parport_pc_init_superi
 	struct pci_dev *pdev = NULL;
 	int ret = 0;
 
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	for_each_pci_dev(pdev) {
 		id = pci_match_id(parport_pc_pci_tbl, pdev);
 		if (id == NULL || id->driver_data >= last_sio)
 			continue;
