Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUAGSKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUAGSKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:10:11 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:56245 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266267AbUAGSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:10:00 -0500
Date: Wed, 7 Jan 2004 18:08:54 +0000
From: Dave Jones <davej@redhat.com>
To: Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Add AGP support for Radeon IGP 345M
Message-ID: <20040107180853.GC14674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcelo Tossati <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another RS200 core.

diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	Wed Jan  7 17:58:49 2004
+++ b/drivers/char/agp/agp.h	Wed Jan  7 17:58:49 2004
@@ -319,6 +319,9 @@
 #ifndef PCI_DEVICE_ID_ATI_RS250
 #define PCI_DEVICE_ID_ATI_RS250		0xcab3
 #endif
+#ifndef PCI_DEVICE_ID_ATI_RS200_B
+#define PCI_DEVICE_ID_ATI_RS200_B	0xcbb3
+#endif
 #ifndef PCI_DEVICE_ID_ATI_RS300_100
 #define PCI_DEVICE_ID_ATI_RS300_100	0x5830
 #endif
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Wed Jan  7 17:58:49 2004
+++ b/drivers/char/agp/agpgart_be.c	Wed Jan  7 17:58:49 2004
@@ -5738,6 +5738,7 @@
 
 	if ((agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS100) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200) ||
+	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200_B) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS250)) {
 		pci_read_config_dword(agp_bridge.dev, ATI_RS100_APSIZE, &temp);
 		temp = (((temp & ~(0x0000000e)) | current_size->size_value)
@@ -5791,6 +5792,7 @@
 
 	if ((agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS100) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200) ||
+	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200_B) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS250)) {
 		pci_read_config_dword(agp_bridge.dev, ATI_RS100_APSIZE, &temp);
 	} else {
@@ -5823,6 +5825,7 @@
 
 	if ((agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS100) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200) ||
+	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200_B) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS250)) {
         	pci_write_config_dword(agp_bridge.dev, ATI_RS100_IG_AGPMODE, 0x20000);
 	} else {
@@ -5860,6 +5863,7 @@
 	/* Write back the previous size and disable gart translation */
 	if ((agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS100) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200) ||
+	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS200_B) ||
 	    (agp_bridge.dev->device == PCI_DEVICE_ID_ATI_RS250)) {
 		pci_read_config_dword(agp_bridge.dev, ATI_RS100_APSIZE, &temp);
 		temp = ((temp & ~(0x0000000f)) | previous_size->size_value);
@@ -6423,6 +6427,12 @@
 	  "IGP320/M",
 	  ati_generic_setup },
 	{ PCI_DEVICE_ID_ATI_RS200,
+	  PCI_VENDOR_ID_ATI,
+	  ATI_RS200,
+	  "ATI",
+	  "IGP330/340/345/350/M",
+	  ati_generic_setup },
+	{ PCI_DEVICE_ID_ATI_RS200_B,
 	  PCI_VENDOR_ID_ATI,
 	  ATI_RS200,
 	  "ATI",
