Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUGVCIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUGVCIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266789AbUGVCIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:08:16 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:28429 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S266786AbUGVCIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:08:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Date: Wed, 21 Jul 2004 19:08:07 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Thread-Index: AcRvkLLe+nZ+1ZCLQj2yasNYAT8fdQ==
From: "Andrew Chew" <achew@nvidia.com>
To: <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>
X-OriginalArrivalTime: 22 Jul 2004 02:08:06.0891 (UTC) FILETIME=[BA8BBBB0:01C46F90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates include/linux/pci_ids.h with the CK804 audio
controller ID, and adds the CK804 audio controller to the
sound/pci/intel8x0.c audio driver.

--- linux-2.6.8-rc2/include/linux/pci_ids.h	2004-07-21
15:22:57.000000000 -0700
+++ linux/include/linux/pci_ids.h	2004-07-20 18:49:22.000000000
-0700
@@ -1071,6 +1071,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
+#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
 #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
--- linux-2.6.8-rc2/sound/pci/intel8x0.c	2004-07-21
15:22:59.000000000 -0700
+++ linux/sound/pci/intel8x0.c	2004-07-20 18:52:07.000000000 -0700
@@ -155,6 +155,9 @@
 #ifndef PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO
 #define PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO	0x00ea
 #endif
+#ifndef PCI_DEVICE_ID_NVIDIA_CK804_AUDIO
+#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO 0x0059
+#endif
 
 enum { DEVICE_INTEL, DEVICE_INTEL_ICH4, DEVICE_SIS, DEVICE_ALI,
DEVICE_NFORCE };
 
@@ -465,6 +468,7 @@
 	{ 0x10de, 0x006a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },
/* NFORCE2 */
 	{ 0x10de, 0x00da, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },
/* NFORCE3 */
 	{ 0x10de, 0x00ea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },
/* CK8S */
+	{ 0x10de, 0x0059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },
/* CK804 */
 	{ 0x1022, 0x746d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },
/* AMD8111 */
 	{ 0x1022, 0x7445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },
/* AMD768 */
 	{ 0x10b9, 0x5455, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALI },
/* Ali5455 */
@@ -2614,6 +2618,7 @@
 	{ PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO, "NVidia nForce2" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO, "NVidia nForce3" },
 	{ PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO, "NVidia CK8S" },
+	{ PCI_DEVICE_ID_NVIDIA_CK804_AUDIO, "NVidia CK804" },
 	{ 0x746d, "AMD AMD8111" },
 	{ 0x7445, "AMD AMD768" },
 	{ 0x5455, "ALi M5455" },
