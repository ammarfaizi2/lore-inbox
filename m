Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSKDVHa>; Mon, 4 Nov 2002 16:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbSKDVHa>; Mon, 4 Nov 2002 16:07:30 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:24377 "EHLO
	brian.localnet") by vger.kernel.org with ESMTP id <S262790AbSKDVH0>;
	Mon, 4 Nov 2002 16:07:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] invalid irqs accepted in serial pci driver
Cc: linus@transmeta.com
Message-Id: <E188oXb-0004Hi-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Mon, 04 Nov 2002 22:13:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	the pci serial driver should not allow the configuration of 
devices which return an irq of 255 - it is illegal according to the 
standard and means the device has not had an irq configured.

The patch adds rejection of these invalid devices.

/Brian

--- drivers/serial/8250_pci.c	1 Nov 2002 23:26:57 -0000	1.4
+++ drivers/serial/8250_pci.c	4 Nov 2002 21:05:31 -0000
@@ -735,6 +735,9 @@
 	memset(&serial_req, 0, sizeof(serial_req));
 	for (k = 0; k < board->num_ports; k++) {
 		serial_req.irq = get_pci_irq(dev, board, k);
+		if (serial_req.irq == 255)
+			/* not initialised */
+			break;
 		if (get_pci_port(dev, board, &serial_req, k))
 			break;
 #ifdef SERIAL_DEBUG_PCI
