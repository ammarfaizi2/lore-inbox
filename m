Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUCXVeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUCXVeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:34:12 -0500
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:7685 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261984AbUCXVeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:34:05 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] add some cardbus bridges to override list in yenta.c
Date: Wed, 24 Mar 2004 22:28:17 +0100
User-Agent: KMail/1.5.2
Cc: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403242228.17907.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello marcelo

this one adds the missing TI15x0 (already in 2.6) and some TI clones from
ENE to yenta's override list. most importantly the override code enables PCI
card change interrupts which are required by yenta.

against 2.4-bk. please apply.

rgds
-daniel


--- 1.15/drivers/pcmcia/yenta.c	Tue Jan  6 05:55:05 2004
+++ edited/drivers/pcmcia/yenta.c	Wed Mar 24 14:35:38 2004
@@ -870,6 +870,13 @@
 	{ PD(TI,1420),	&ti_ops },
 	{ PD(TI,4410),	&ti_ops },
 	{ PD(TI,4451),	&ti_ops },
+	{ PD(TI,1510),  &ti_ops },
+	{ PD(TI,1520),  &ti_ops },
+
+	{ PD(ENE,1211),  &ti_ops },
+	{ PD(ENE,1225),  &ti_ops },
+	{ PD(ENE,1410),  &ti_ops },
+	{ PD(ENE,1420),  &ti_ops },
 
 	{ PD(RICOH,RL5C465), &ricoh_ops },
 	{ PD(RICOH,RL5C466), &ricoh_ops },
--- 1.85/include/linux/pci_ids.h	Tue Mar 16 14:08:27 2004
+++ edited/include/linux/pci_ids.h	Wed Mar 24 14:36:19 2004
@@ -660,6 +660,8 @@
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
 #define PCI_DEVICE_ID_TI_1420		0xac51
+#define PCI_DEVICE_ID_TI_1520		0xac55
+#define PCI_DEVICE_ID_TI_1510		0xac56
 
 #define PCI_VENDOR_ID_SONY		0x104d
 #define PCI_DEVICE_ID_SONY_CXD3222	0x8039
@@ -1686,6 +1688,12 @@
 #define PCI_DEVICE_ID_TIGON3_5901	0x170d
 #define PCI_DEVICE_ID_TIGON3_5901_2	0x170e
 #define PCI_DEVICE_ID_BCM4401		0x4401
+
+#define PCI_VENDOR_ID_ENE		0x1524
+#define PCI_DEVICE_ID_ENE_1211		0x1211
+#define PCI_DEVICE_ID_ENE_1225		0x1225
+#define PCI_DEVICE_ID_ENE_1410		0x1410
+#define PCI_DEVICE_ID_ENE_1420		0x1420
 
 #define PCI_VENDOR_ID_SYBA		0x1592
 #define PCI_DEVICE_ID_SYBA_2P_EPP	0x0782

