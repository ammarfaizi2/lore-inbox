Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUHIIdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUHIIdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHIIdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:33:43 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:52943 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S266327AbUHIIdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:33:21 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408090833.KAA26816@cleopatra.math.tu-berlin.de>
Subject: [PATCH] Generic NetMOS supp. (experimental)
In-Reply-To: <20040806114737.GA19822@logos.cnet>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Mon, 9 Aug 2004 10:33:13 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

here's another patch for NetMOS based parallel port adapters. It applies to
drivers/parport/parport_pc.c of kernel 2.6.7, but since the parport_pc
interface did not change much in this specific part, it should also apply
to kernel 2.4.26 and all versions between. The earlier NetMOS patch for
their 9805 chipset must be applied before.

It adds support for all the NetMOS chips I could get hands
on. However, note that this is *fairly* experimental as I don't have
the hardware with this chips on, only the documentation - so some
testing is required, and this is an EXPERIMENTAL patch.

Specifically, I left parts of the PCI identification open (hopefully
correctly by specifying PCI_ANY_ID), so please test.

--- parport_pc.c.old	Sun Aug  8 17:50:16 2004
+++ parport_pc.c	Sun Aug  8 17:56:16 2004
@@ -2627,6 +2627,11 @@
 	titan_010l,
 	titan_1284p1,
 	titan_1284p2,
+	netmos_9705,  /* thor: a couple of experimental netmos drivers follow... */
+	netmos_9735,
+	netmos_9715,
+	netmos_9835,
+	netmos_9755,  /* thor: netmos modifications end */
 	avlab_1p,
 	avlab_2p,
 	oxsemi_954,
@@ -2695,6 +2700,13 @@
 	/* titan_010l */		{ 1, { { 3, -1 }, } },
 	/* titan_1284p1 */              { 1, { { 0, 1 }, } },
 	/* titan_1284p2 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
+	/* thor: untested experimental netmos cards follow */
+	/* netmos 9705  */              { 1, { { 0, 1 }, } },
+	/* netmos 9735  */              { 1, { { 2, 3 }, } },
+	/* netmos 9715  */              { 2, { { 0, 1}, { 2, 3 },} },
+	/* netmos 9835  */              { 1, { { 2, 3 }, } },
+	/* netmos 9755  */              { 2, { { 0, 1}, { 2, 3 },} },
+	/* thor: netmos addons end */
 	/* avlab_1p		*/	{ 1, { { 0, 1}, } },
 	/* avlab_2p		*/	{ 2, { { 0, 1}, { 2, 3 },} },
 	/* The Oxford Semi cards are unusual: 954 doesn't support ECP,
@@ -2763,6 +2775,13 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_010l },
 	{ 0x9710, 0x9805, 0x1000, 0x0010, 0, 0, titan_1284p1 },
 	{ 0x9710, 0x9815, 0x1000, 0x0020, 0, 0, titan_1284p2 },
+	/* thor: Untested, experimental netmos based cards follow */
+	{ 0x9710, 0x9705, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
+	{ 0x9710, 0x9735, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	{ 0x9710, 0x9715, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
+	{ 0x9710, 0x9835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
+	{ 0x9710, 0x9755, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
+	/* thor: netmos support end */
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2120, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1p}, /* AFAVLAB_TK9902 */
 	{ 0x14db, 0x2121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2p},


So long,
	Thomas

