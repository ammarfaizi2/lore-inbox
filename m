Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTFTNSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFTNSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:18:45 -0400
Received: from host213.137.8.62.manx.net ([213.137.8.62]:21778 "EHLO server")
	by vger.kernel.org with ESMTP id S261265AbTFTNSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:18:44 -0400
Date: Fri, 20 Jun 2003 14:32:38 +0100
From: Matthew Bell <m.bell@bvrh.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Obvious: CONFIG_ISAPNP #ifdefs wrong in drivers/net/3c515.c
Message-Id: <20030620143239.4a9a801c.m.bell@bvrh.co.uk>
Organization: Beach View Residential Home, Ltd.
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISAPNP should also work if it is built as a module. Here is a patch that works
for me:
--- linux-2.4.19.orig/drivers/net/3c515.c	2002-02-25 19:37:59.000000000 +0000
+++ linux-2.4.19/drivers/net/3c515.c	2002-08-03 18:24:05.000000000 +0100
@@ -370,7 +370,7 @@
 	{ "Default", 0, 0xFF, XCVR_10baseT, 10000},
 };
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined
(CONFIG_ISAPNP_MODULE))
 static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051),
@@ -462,12 +462,12 @@
 {
 	int cards_found = 0;
 	static int ioaddr;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined
(CONFIG_ISAPNP_MODULE))
 	short i;
 	static int pnp_cards;
 #endif
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined
(CONFIG_ISAPNP_MODULE))
 	if(nopnp == 1)
 		goto no_pnp;
 	for(i=0; corkscrew_isapnp_adapters[i].vendor != 0; i++) {
@@ -530,7 +530,7 @@
 	/* Check all locations on the ISA bus -- evil! */
 	for (ioaddr = 0x100; ioaddr < 0x400; ioaddr += 0x20) {
 		int irq;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined
(CONFIG_ISAPNP_MODULE))
 		/* Make sure this was not already picked up by isapnp */
 		if(ioaddr == corkscrew_isapnp_phys_addr[0]) continue;
 		if(ioaddr == corkscrew_isapnp_phys_addr[1]) continue;
