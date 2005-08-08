Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVHHXyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVHHXyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVHHXyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:54:01 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:47753 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932338AbVHHXyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:54:00 -0400
Date: Tue, 9 Aug 2005 01:53:45 +0200
Message-Id: <200508082353.j78NrjDb028183@wscnet.wsc.cz>
In-reply-to: <42F7426C.1020307@gmail.com>
Subject: [PATCH] removes pci_find_device from parport_pc.c
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
