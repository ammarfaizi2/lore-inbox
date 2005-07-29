Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVG2WJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVG2WJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVG2WGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:06:55 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:55194 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S262881AbVG2WEe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:04:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.4]  Fix incorrect Asus k7m irq router detection
Date: Fri, 29 Jul 2005 15:04:29 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C341E2AF@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4]  Fix incorrect Asus k7m irq router detection
thread-index: AcWUiX306SYGvGFiS+WQ8gnJ9uo3CQ==
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <marcelo.tosatti@cyclades.com>
Cc: <giancarlo.formicuccia@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2005 22:04:31.0115 (UTC) FILETIME=[7EF20DB0:01C59489]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

Here is 2.4 version of a patch submitted earlier for 2.6 by Giancarlo
Formicuccia.

this patch:
http://marc.theaimsgroup.com/?l=bk-commits-head&m=111955644929114&w=2
uncovered a k7m bios bug, where the VT82C686A router is reported as
being "586-compatible". The two chips have different pirq mapping, so
this leads to "irq routing conflict" on many pci devices.

Patch for 2.4.32-pre2

Signed-off-by: Aleksey Gorelov <aleksey_gorelov@phoenix.com>

--- linux-2.4.31-old/arch/i386/kernel/pci-irq.c	2005-07-29
14:44:12.000000000 -0700
+++ linux-2.4.31/arch/i386/kernel/pci-irq.c	2005-07-29
14:47:44.000000000 -0700
@@ -664,6 +664,13 @@
 static __init int via_router_probe(struct irq_router *r, struct pci_dev
*router, u16 device)
 {
 	/* FIXME: We should move some of the quirk fixup stuff here */
+
+	if (router->device == PCI_DEVICE_ID_VIA_82C686 &&
+		device == PCI_DEVICE_ID_VIA_82C586_0) {
+		/* Asus k7m bios wrongly reports 82C686A as
586-compatible */
+		device = PCI_DEVICE_ID_VIA_82C686;
+	}
+
 	switch(device)
 	{
 		case PCI_DEVICE_ID_VIA_82C586_0: 
