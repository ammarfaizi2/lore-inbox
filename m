Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289296AbSBNBYV>; Wed, 13 Feb 2002 20:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSBNBYM>; Wed, 13 Feb 2002 20:24:12 -0500
Received: from [67.105.126.66] ([67.105.126.66]:529 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S289296AbSBNBX6>; Wed, 13 Feb 2002 20:23:58 -0500
Date: Wed, 13 Feb 2002 17:23:23 -0800 (PST)
From: Jim Treadway <jim@stardot-tech.com>
To: Russell King <linux@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] serial driver 2.4.18-rc1 (Lava Octopus)
Message-ID: <Pine.LNX.4.44.0202131713290.3867-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Russell,

This patch adds support for the "Lava Octopus-550" (a multiport PCI serial
card).

Hopefully you are the current maintainer for the serial driver, please let 
me know if I should send it elsewhere.

Thanks,
Jim


diff -urN linux-2.4.18-rc1/drivers/char/serial.c linux-2.4.18-rc1-lava/drivers/char/serial.c
--- linux-2.4.18-rc1/drivers/char/serial.c	Wed Feb 13 16:53:27 2002
+++ linux-2.4.18-rc1-lava/drivers/char/serial.c	Wed Feb 13 16:57:52 2002
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
diff -urN linux-2.4.18-rc1/include/linux/pci_ids.h linux-2.4.18-rc1-lava/include/linux/pci_ids.h
--- linux-2.4.18-rc1/include/linux/pci_ids.h	Wed Feb 13 16:53:30 2002
+++ linux-2.4.18-rc1-lava/include/linux/pci_ids.h	Wed Feb 13 16:57:52 2002
@@ -1458,6 +1458,8 @@
 #define PCI_DEVICE_ID_LAVA_DSERIAL	0x0100 /* 2x 16550 */
 #define PCI_DEVICE_ID_LAVA_QUATRO_A	0x0101 /* 2x 16550, half of 4 port */
 #define PCI_DEVICE_ID_LAVA_QUATRO_B	0x0102 /* 2x 16550, half of 4 port */
+#define PCI_DEVICE_ID_LAVA_OCTO_A	0x0180 /* 4x 16550A, half of 8 port */
+#define PCI_DEVICE_ID_LAVA_OCTO_B	0x0181 /* 4x 16550A, half of 8 port */
 #define PCI_DEVICE_ID_LAVA_PORT_PLUS	0x0200 /* 2x 16650 */
 #define PCI_DEVICE_ID_LAVA_QUAD_A	0x0201 /* 2x 16650, half of 4 port */
 #define PCI_DEVICE_ID_LAVA_QUAD_B	0x0202 /* 2x 16650, half of 4 port */


