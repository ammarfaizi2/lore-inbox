Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTBQO1i>; Mon, 17 Feb 2003 09:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTBQOMR>; Mon, 17 Feb 2003 09:12:17 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:30336 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267215AbTBQOJh>; Mon, 17 Feb 2003 09:09:37 -0500
Date: Mon, 17 Feb 2003 23:18:11 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (19/26) PCI BIOS
Message-ID: <20030217141811.GS4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (19/26).

PCI BIOS function support using mach-* scheme.

diff -Nru linux-2.5.53/arch/i386/pci/pcbios.c linux98-2.5.53/arch/i386/pci/pcbios.c
--- linux-2.5.53/arch/i386/pci/pcbios.c	2002-11-25 15:09:13.000000000 +0000
+++ linux98-2.5.53/arch/i386/pci/pcbios.c	2002-10-31 15:05:49.000000000 +0000
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
 
diff -Nru linux-2.5.53/include/asm-i386/mach-default/pci-functions.h linux98-2.5.53/include/asm-i386/mach-default/pci-functions.h
--- linux-2.5.53/include/asm-i386/mach-default/pci-functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-default/pci-functions.h	2002-10-31 15:05:52.000000000 +0000
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
diff -Nru linux-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h linux98-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,20 @@
+/*
+ *	PCI BIOS function codes for the PC9800. Different from
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
