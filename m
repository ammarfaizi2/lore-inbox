Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291319AbSBHBjU>; Thu, 7 Feb 2002 20:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291339AbSBHBjL>; Thu, 7 Feb 2002 20:39:11 -0500
Received: from [67.105.126.66] ([67.105.126.66]:53257 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S291319AbSBHBjC>; Thu, 7 Feb 2002 20:39:02 -0500
Date: Thu, 7 Feb 2002 17:38:42 -0800 (PST)
From: Jim Treadway <jim@stardot-tech.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add support for Lava Octopus PCI serial card
Message-ID: <Pine.LNX.4.44.0202071722230.11456-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch (against 2.4.17) adds support for the "Lava Octopus-550" (a 
multiport PCI serial card).

I'm not sure exactly who the maintainer of the serial driver for the 2.4.X
branch is, and the linux-serial list seems to be rather dead, so I'm
sending it here.

If anyone knows of a better place to send this, please let me know. ;)


diff -ur linux-2.4.17-orig/drivers/char/serial.c linux-2.4.17/drivers/char/serial.c
--- linux-2.4.17-orig/drivers/char/serial.c	Fri Dec 21 09:41:54 2001
+++ linux-2.4.17/drivers/char/serial.c	Wed Jan 23 23:33:31 2002
@@ -4244,6 +4244,7 @@
 	pbn_b0_bt_2_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_4_460800,
 
 	pbn_b1_1_115200,
 	pbn_b1_2_115200,
@@ -4322,6 +4323,7 @@
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 460800 }, /* pbn_b0_bt_4_460800 */
 
 	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
 	{ SPCI_FL_BASE1, 2, 115200 },		/* pbn_b1_2_115200 */
@@ -4829,6 +4831,12 @@
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_1_115200 },
diff -ur linux-2.4.17-orig/include/linux/pci_ids.h linux-2.4.17/include/linux/pci_ids.h
--- linux-2.4.17-orig/include/linux/pci_ids.h	Fri Dec 21 09:42:03 2001
+++ linux-2.4.17/include/linux/pci_ids.h	Wed Jan 23 23:22:57 2002
@@ -1441,6 +1441,8 @@
 #define PCI_DEVICE_ID_LAVA_DSERIAL	0x0100 /* 2x 16550 */
 #define PCI_DEVICE_ID_LAVA_QUATRO_A	0x0101 /* 2x 16550, half of 4 port */
 #define PCI_DEVICE_ID_LAVA_QUATRO_B	0x0102 /* 2x 16550, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_OCTO_A	0x0180 /* 4x 16550A, half of 8 port */
+#define PCI_DEVICE_ID_LAVA_OCTO_B	0x0181 /* 4x 16550A, half of 8 port */
 #define PCI_DEVICE_ID_LAVA_PORT_PLUS	0x0200 /* 2x 16650 */
 #define PCI_DEVICE_ID_LAVA_QUAD_A	0x0201 /* 2x 16650, half of 4 port */
 #define PCI_DEVICE_ID_LAVA_QUAD_B	0x0202 /* 2x 16650, half of 4 port */

