Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263717AbTCUTQs>; Fri, 21 Mar 2003 14:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263733AbTCUTP2>; Fri, 21 Mar 2003 14:15:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42628
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263753AbTCUTOy>; Fri, 21 Mar 2003 14:14:54 -0500
Date: Fri, 21 Mar 2003 20:30:10 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212030.h2LKUApv026359@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Make pci-bios function ids per machine type
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes NEC use *different* function numbers!!

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/pci/pcbios.c linux-2.5.65-ac2/arch/i386/pci/pcbios.c
--- linux-2.5.65/arch/i386/pci/pcbios.c	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.65-ac2/arch/i386/pci/pcbios.c	2003-02-14 23:04:05.000000000 +0000
@@ -5,22 +5,9 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include "pci.h"
+#include "pci-functions.h"
 
 
-#define PCIBIOS_PCI_FUNCTION_ID 	0xb1XX
-#define PCIBIOS_PCI_BIOS_PRESENT 	0xb101
-#define PCIBIOS_FIND_PCI_DEVICE		0xb102
-#define PCIBIOS_FIND_PCI_CLASS_CODE	0xb103
-#define PCIBIOS_GENERATE_SPECIAL_CYCLE	0xb106
-#define PCIBIOS_READ_CONFIG_BYTE	0xb108
-#define PCIBIOS_READ_CONFIG_WORD	0xb109
-#define PCIBIOS_READ_CONFIG_DWORD	0xb10a
-#define PCIBIOS_WRITE_CONFIG_BYTE	0xb10b
-#define PCIBIOS_WRITE_CONFIG_WORD	0xb10c
-#define PCIBIOS_WRITE_CONFIG_DWORD	0xb10d
-#define PCIBIOS_GET_ROUTING_OPTIONS	0xb10e
-#define PCIBIOS_SET_PCI_HW_INT		0xb10f
-
 /* BIOS32 signature: "_32_" */
 #define BIOS32_SIGNATURE	(('_' << 0) + ('3' << 8) + ('2' << 16) + ('_' << 24))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/mach-default/pci-functions.h linux-2.5.65-ac2/include/asm-i386/mach-default/pci-functions.h
--- linux-2.5.65/include/asm-i386/mach-default/pci-functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/include/asm-i386/mach-default/pci-functions.h	2003-02-14 22:54:22.000000000 +0000
@@ -0,0 +1,19 @@
+/*
+ *	PCI BIOS function numbering for conventional PCI BIOS 
+ *	systems
+ */
+
+#define PCIBIOS_PCI_FUNCTION_ID 	0xb1XX
+#define PCIBIOS_PCI_BIOS_PRESENT 	0xb101
+#define PCIBIOS_FIND_PCI_DEVICE		0xb102
+#define PCIBIOS_FIND_PCI_CLASS_CODE	0xb103
+#define PCIBIOS_GENERATE_SPECIAL_CYCLE	0xb106
+#define PCIBIOS_READ_CONFIG_BYTE	0xb108
+#define PCIBIOS_READ_CONFIG_WORD	0xb109
+#define PCIBIOS_READ_CONFIG_DWORD	0xb10a
+#define PCIBIOS_WRITE_CONFIG_BYTE	0xb10b
+#define PCIBIOS_WRITE_CONFIG_WORD	0xb10c
+#define PCIBIOS_WRITE_CONFIG_DWORD	0xb10d
+#define PCIBIOS_GET_ROUTING_OPTIONS	0xb10e
+#define PCIBIOS_SET_PCI_HW_INT		0xb10f
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/mach-pc9800/pci-functions.h linux-2.5.65-ac2/include/asm-i386/mach-pc9800/pci-functions.h
--- linux-2.5.65/include/asm-i386/mach-pc9800/pci-functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/include/asm-i386/mach-pc9800/pci-functions.h	2003-02-14 23:00:56.000000000 +0000
@@ -0,0 +1,20 @@
+/*
+ *	PCI BIOS function codes for the PC9800. Different to
+ *	standard PC systems
+ */
+
+/* Note: PC-9800 confirms PCI 2.1 on only few models */
+
+#define PCIBIOS_PCI_FUNCTION_ID 	0xccXX
+#define PCIBIOS_PCI_BIOS_PRESENT 	0xcc81
+#define PCIBIOS_FIND_PCI_DEVICE		0xcc82
+#define PCIBIOS_FIND_PCI_CLASS_CODE	0xcc83
+/*      PCIBIOS_GENERATE_SPECIAL_CYCLE	0xcc86	(not supported by bios) */
+#define PCIBIOS_READ_CONFIG_BYTE	0xcc88
+#define PCIBIOS_READ_CONFIG_WORD	0xcc89
+#define PCIBIOS_READ_CONFIG_DWORD	0xcc8a
+#define PCIBIOS_WRITE_CONFIG_BYTE	0xcc8b
+#define PCIBIOS_WRITE_CONFIG_WORD	0xcc8c
+#define PCIBIOS_WRITE_CONFIG_DWORD	0xcc8d
+#define PCIBIOS_GET_ROUTING_OPTIONS	0xcc8e	/* PCI 2.1 only */
+#define PCIBIOS_SET_PCI_HW_INT		0xcc8f	/* PCI 2.1 only */
