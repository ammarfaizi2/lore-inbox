Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264290AbTCXRPT>; Mon, 24 Mar 2003 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264293AbTCXQtY>; Mon, 24 Mar 2003 11:49:24 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:56042 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264292AbTCXQbC>; Mon, 24 Mar 2003 11:31:02 -0500
Message-Id: <200303241642.h2OGg635008297@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:53 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: add support for 8 port lava octo cards to 8250_pci
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/serial/8250_pci.c linux-2.5/drivers/serial/8250_pci.c
--- bk-linus/drivers/serial/8250_pci.c	2003-03-16 14:16:04.000000000 +0000
+++ linux-2.5/drivers/serial/8250_pci.c	2003-03-17 23:42:35.000000000 +0000
@@ -897,6 +897,7 @@ enum pci_board_num_t {
 
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_4_460800,
 
 	pbn_b0_bt_1_921600,
 	pbn_b0_bt_2_921600,
@@ -1039,6 +1040,12 @@ static struct pci_board pci_boards[] __d
 		.base_baud	= 460800,
 		.uart_offset	= 8,
 	},
+	[pbn_b0_bt_4_460800] = {
+		.flags		= FL_BASE0|FL_BASE_BARS,
+		.num_ports	= 4,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
 
 	[pbn_b0_bt_1_921600] = {
 		.flags		= FL_BASE0|FL_BASE_BARS,
@@ -1928,6 +1935,12 @@ static struct pci_device_id serial_pci_t
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_460800 },
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pci/pci.ids linux-2.5/drivers/pci/pci.ids
--- bk-linus/drivers/pci/pci.ids	2003-03-17 12:40:51.000000000 +0000
+++ linux-2.5/drivers/pci/pci.ids	2003-03-17 13:09:03.000000000 +0000
@@ -4911,6 +4911,8 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
+	0180  Lava Octo A
+	0181  Lava Octo B
 	0200  Lava Port Plus
 	0201  Lava Quad A
 	0202  Lava Quad B
