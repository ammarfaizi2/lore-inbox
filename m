Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266399AbTGEQYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266400AbTGEQYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:24:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11651
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266399AbTGEQYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:24:06 -0400
Date: Sat, 5 Jul 2003 17:37:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307051637.h65GbM9Z011595@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: PATCH: make i810 audio compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one still oopses when you unload it but thats a known bug with a known
fix I need to merge later

diff --exclude-from /usr/src/exclude -u --recursive linux.22-bk2/drivers/sound/i810_audio.c linux.22-pre2-ac1/drivers/sound/i810_audio.c
--- linux.22-bk2/drivers/sound/i810_audio.c	2003-07-05 17:01:44.000000000 +0100
+++ linux.22-pre2-ac1/drivers/sound/i810_audio.c	2003-06-29 16:10:11.000000000 +0100
@@ -118,6 +118,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH4
 #define PCI_DEVICE_ID_INTEL_ICH4	0x24c5
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ICH5
+#define PCI_DEVICE_ID_INTEL_ICH5	0x24d5
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
@@ -273,6 +276,7 @@
 	INTELICH2,
 	INTELICH3,
 	INTELICH4,
+	INTELICH5,
 	SI7012,
 	NVIDIA_NFORCE,
 	AMD768,
@@ -286,6 +290,7 @@
 	"Intel ICH2",
 	"Intel ICH3",
 	"Intel ICH4",
+	"Intel ICH5",
 	"SiS 7012",
 	"NVIDIA nForce Audio",
 	"AMD 768",
@@ -304,7 +309,8 @@
 	{  1, 0x0000 }, /* INTEL440MX */
 	{  1, 0x0000 }, /* INTELICH2 */
 	{  2, 0x0000 }, /* INTELICH3 */
-        {  3, 0x0003 }, /* INTELICH4 */
+ 	{  3, 0x0003 }, /* INTELICH4 */
+	{  3, 0x0003 }, /* INTELICH5 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
@@ -324,6 +330,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH4,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH5,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH5},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO,
