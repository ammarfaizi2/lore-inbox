Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVECOUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVECOUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVECOTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:19:38 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:29589 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261602AbVECORq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:17:46 -0400
Subject: Netmos 9845 patch kernel 2.4.30
From: Jacques Basson <jacques_basson@myrealbox.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 03 May 2005 16:17:30 +0200
Message-Id: <1115129850.4908.5.camel@lancelot.advanced-imaging-technologies>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Support for some Netmos multi-io boards is in kernel 2.4.30, but not for
the 9845 chip (4S/1P). Here is a simple patch to add support for this
card. I have (not fully) tested all of the serial ports with this patch
(currently only with an echo test > /dev/ttyS# on the machine with the
card and minicom running on the other machine).

Please note that the patch was basically taken from the link provided at
http://www.ussg.iu.edu/hypermail/linux/kernel/0310.3/0813.html

diff -Naur pci_ids.h.orig pci_ids.h
--- pci_ids.h.orig      2005-04-04 03:42:20.000000000 +0200
+++ pci_ids.h   2005-05-03 15:59:34.000000000 +0200
@@ -2055,6 +2055,7 @@
 #define PCI_DEVICE_ID_NETMOS_9805      0x9805
 #define PCI_DEVICE_ID_NETMOS_9815      0x9815
 #define PCI_DEVICE_ID_NETMOS_9835      0x9835
+#define PCI_DEVICE_ID_NETMOS_9845      0x9845
 #define PCI_DEVICE_ID_NETMOS_9855      0x9855
 
 #define PCI_SUBVENDOR_ID_EXSYS         0xd84d

diff -Naur parport_serial.c.orig parport_serial.c
--- parport_serial.c.orig       2004-08-08 01:26:04.000000000 +0200
+++ parport_serial.c    2005-05-03 16:05:33.000000000 +0200
@@ -34,6 +34,7 @@
        titan_210l,
        netmos_9735,
        netmos_9835,
+       netmos_9845,
        avlab_1s1p,
        avlab_1s1p_650,
        avlab_1s1p_850,
@@ -74,6 +75,7 @@
        /* titan_210l */                { 1, { { 3, -1 }, } },
        /* netmos_9735 (not tested) */  { 1, { { 2, -1 }, } },
        /* netmos_9835 */               { 1, { { 2, -1 }, } },
+       /* netmos_9845 */               { 1, { { 4, -1 }, } },
        /* avlab_1s1p     */            { 1, { { 1, 2}, } },
        /* avlab_1s1p_650 */            { 1, { { 1, 2}, } },
        /* avlab_1s1p_850 */            { 1, { { 1, 2}, } },
@@ -100,6 +102,8 @@
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
        { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
+       { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
+         PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9845 },
        /* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
        { 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
        { 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
@@ -181,6 +185,7 @@
 /* titan_210l */       { SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2,
921600 },
 /* netmos_9735 (n/t)*/ { SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2,
115200 },
 /* netmos_9835 */      { SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2,
115200 },
+/* netmos_9845 */      { SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4,
115200 },
 /* avlab_1s1p (n/t) */ { SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1,
115200 },
 /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1,
115200 },
 /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1,
115200 },

Jacques

