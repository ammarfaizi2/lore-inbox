Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311433AbSC1B3x>; Wed, 27 Mar 2002 20:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311405AbSC1B3p>; Wed, 27 Mar 2002 20:29:45 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:17161 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S311403AbSC1B3b>; Wed, 27 Mar 2002 20:29:31 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A773D@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-serial'" <linux-serial@vger.kernel.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Russell King'" <rmk@arm.linux.org.uk>,
        "'Theodore Tso'" <tytso@mit.edu>, "'Martin Mares'" <mj@ucw.cz>,
        "'Fabrizio Gennari'" <fabrizio.gennari@philips.com>
Subject: [PATCH] serial card PCI ID info - discussion
Date: Wed, 27 Mar 2002 17:29:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submitted for discussion and feedback:

Please scan for typos and the scent of any bad ideas. 
Any reason to not put this into 2.4? 

Fabrizio,
Please check that I got the EXSYS and OXCB950 entries right.

Thanks,
Ed Vance

----------------

This patch adds values and symbols for PCI ID info for:
	PLX 9030 PCI hot swap I/O bus bridge
	Macrolink MCCS, MCCR CPCI serial cards
	EXSYS EX-41092 dual 16950 UART serial card
	Oxford Semi OXCB950 PCI/Cardbus 16950 UART
And corrects PCI ID value for:
	Oxford Semi OX16PCI952 PCI dual 16950 UART

For kernel files rev 2.4.19-pre3

Contributors: Fabrizio Gennari [fabrizio.gennari@philips.com]
              Ed Vance [serial24@macrolink.com]

diff -urN -X dontdiff.txt linux-2.4.19-pre3/drivers/pci/pci.ids
patched/drivers/pci/pci.ids
--- linux-2.4.19-pre3/drivers/pci/pci.ids	Thu Mar 14 16:19:07 2002
+++ patched/drivers/pci/pci.ids	Wed Mar 27 16:03:24 2002
@@ -1561,9 +1561,14 @@
 	0001  i960 PCI bus interface
 	1076  VScom 800 8 port serial adaptor
 	1077  VScom 400 4 port serial adaptor
+	9030  PCI <-> IOBus Bridge (Hot Swap)
+		15ed 1002  Macrolink MCCS 8-port Serial (Hot Swap)
+		15ed 1003  Macrolink MCCS 16-port Serial (Hot Swap)
 	9036  9036
 	9050  PCI <-> IOBus Bridge
 		10b5 2273  SH-ARC SoHard ARCnet card
+		15ed 1000  Macrolink MCCS 8-port Serial
+		15ed 1001  Macrolink MCCS 16-port Serial
 		d84d 4006  EX-4006 1P
 		d84d 4008  EX-4008 1P EPP/ECP
 		d84d 4014  EX-4014 2P
@@ -3953,6 +3958,15 @@
 1413  Addonics
 1414  Microsoft Corporation
 1415  Oxford Semiconductor Ltd
+	9501  16PCI954 Function 0
+		15ed 2000  Macrolink MCCR Serial ports 0-3
+		15ed 2001  Macrolink MCCR Serial ports 0-3
+	950A  EXSYS EX-41092 PCI/Dual 16950 Serial
+	950B  Oxford Semi PCI/Cardbus 16950 UART
+	9511  16PCI954 Function 1
+		15ed 2000  Macrolink MCCR Serial ports 4-7
+		15ed 2001  Macrolink MCCR Serial ports 4-15
+	9521  Oxford Semi OX16PCI952 PCI/dual 16950 UART
 1416  Multiwave Innovation pte Ltd
 1417  Convergenet Technologies Inc
 1418  Kyushu electronics systems Inc
diff -urN -X dontdiff.txt linux-2.4.19-pre3/include/linux/pci_ids.h
patched/include/linux/pci_ids.h
--- linux-2.4.19-pre3/include/linux/pci_ids.h	Thu Mar 14 16:19:25 2002
+++ patched/include/linux/pci_ids.h	Wed Mar 27 15:34:02 2002
@@ -762,6 +762,7 @@
 #define PCI_DEVICE_ID_PLX_SPCOM200	0x1103
 #define PCI_DEVICE_ID_PLX_DJINN_ITOO	0x1151
 #define PCI_DEVICE_ID_PLX_R753		0x1152
+#define PCI_DEVICE_ID_PLX_9030		0x9030
 #define PCI_DEVICE_ID_PLX_9050		0x9050
 #define PCI_DEVICE_ID_PLX_9060		0x9060
 #define PCI_DEVICE_ID_PLX_9060ES	0x906E
@@ -1474,9 +1475,12 @@
 #define PCI_VENDOR_ID_OXSEMI		0x1415
 #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
 #define PCI_DEVICE_ID_OXSEMI_16PCI954	0x9501
-#define PCI_DEVICE_ID_OXSEMI_16PCI952	0x950A
+#define PCI_DEVICE_ID_EXSYS_EX41092	0x950A
+#define PCI_DEVICE_ID_OXSEMI_OXCB950	0x950B
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N	0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
+#define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521
+#define PCI_DEVICE_ID_OXSEMI_16PCI952PP	0x9523
 
 #define PCI_VENDOR_ID_AIRONET		0x14b9
 #define PCI_DEVICE_ID_AIRONET_4800_1	0x0001
@@ -1521,6 +1525,14 @@
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841
 
+#define PCI_VENDOR_ID_MACROLINK		0x15ed
+#define PCI_DEVICE_ID_MACROLINK_MCCS8	0x1000
+#define PCI_DEVICE_ID_MACROLINK_MCCS	0x1001
+#define PCI_DEVICE_ID_MACROLINK_MCCS8H	0x1002
+#define PCI_DEVICE_ID_MACROLINK_MCCSH	0x1003
+#define PCI_DEVICE_ID_MACROLINK_MCCR8	0x2000
+#define PCI_DEVICE_ID_MACROLINK_MCCR	0x2001
+
 #define PCI_VENDOR_ID_SYMPHONY		0x1c1c
 #define PCI_DEVICE_ID_SYMPHONY_101	0x0001
 


---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


