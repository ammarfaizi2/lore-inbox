Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSK1I2j>; Thu, 28 Nov 2002 03:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSK1I2j>; Thu, 28 Nov 2002 03:28:39 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:49259
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265262AbSK1I2g>; Thu, 28 Nov 2002 03:28:36 -0500
Date: Thu, 28 Nov 2002 03:39:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH][2.5] pci_siig* interdependence
Message-ID: <Pine.LNX.4.50.0211280336580.14410-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,
This patch is to fix a compilation problem (functions are shared with
parport_serial) as well as fix a potential oops (parport_serial as module
would try and reference the freed memory)

Russell am i missing something?

Index: linux-2.5.50/drivers/serial/8250_pci.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.50/drivers/serial/8250_pci.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 8250_pci.c
--- linux-2.5.50/drivers/serial/8250_pci.c	28 Nov 2002 01:34:30 -0000	1.1.1.1
+++ linux-2.5.50/drivers/serial/8250_pci.c	28 Nov 2002 05:08:38 -0000
@@ -267,7 +267,7 @@
 #define PCI_DEVICE_ID_SIIG_1S_10x (PCI_DEVICE_ID_SIIG_1S_10x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)

-static int __devinit pci_siig10x_fn(struct pci_dev *dev, int enable)
+int pci_siig10x_fn(struct pci_dev *dev, int enable)
 {
 	u16 data, *p;

@@ -298,7 +298,7 @@
 #define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xfffc)

-static int __devinit pci_siig20x_fn(struct pci_dev *dev, int enable)
+int pci_siig20x_fn(struct pci_dev *dev, int enable)
 {
 	u8 data;

-- 
function.linuxpower.ca
