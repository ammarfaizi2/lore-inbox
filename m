Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267562AbUHELnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267562AbUHELnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUHELnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:43:18 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:46075 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S267562AbUHELnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:43:16 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408051143.NAA23740@cleopatra.math.tu-berlin.de>
Subject: [PATCH] NetMOS 9805 ParPort interface
To: linux-kernel@vger.kernel.org
Date: Thu, 5 Aug 2004 13:43:13 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

here's a tiny patch against parport/parport_pc.c for kernel 2.4.26.
It adds support for the NetMOS 9805 chip, used in several popular
parallel port extension cards available here in germany. The patch below
has been found working in a beige G3 Mac and a Canon BJC just fine.

--- parport_pc_old.c	Wed Jul 28 10:26:23 2004
+++ parport_pc.c	Wed Jul 28 10:28:16 2004
@@ -2692,6 +2692,7 @@
 	syba_2p_epp,
 	syba_1p_ecp,
 	titan_010l,
+	titan_1284p1,
 	titan_1284p2,
 	avlab_1p,
 	avlab_2p,
@@ -2759,6 +2760,7 @@
 	/* syba_2p_epp AP138B */	{ 2, { { 0, 0x078 }, { 0, 0x178 }, } },
 	/* syba_1p_ecp W83787 */	{ 1, { { 0, 0x078 }, } },
 	/* titan_010l */		{ 1, { { 3, -1 }, } },
+	/* titan_1284p1 */              { 1, { { 0, 1 }, } },
 	/* titan_1284p2 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
 	/* avlab_1p		*/	{ 1, { { 0, 1}, } },
 	/* avlab_2p		*/	{ 2, { { 0, 1}, { 2, 3 },} },
@@ -2826,6 +2828,7 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, syba_1p_ecp },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_010L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_010l },
+	{ 0x9710, 0x9805, 0x1000, 0x0010, 0, 0, titan_1284p1 },
 	{ 0x9710, 0x9815, 0x1000, 0x0020, 0, 0, titan_1284p2 },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2120, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1p}, /* AFAVLAB_TK9902 */

The same patch should also apply to more modern kernels since it just adds
some PCI ids.

Similar patches for other NetMOS products might be easy since they're all
documented; I could add a couple of PCI Ids to the parport_pc - I just don't
have the hardware for testing.

So long,
	Thomas

