Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTLBCkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTLBCkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 21:40:31 -0500
Received: from host213.137.0.249.manx.net ([213.137.0.249]:64522 "EHLO server")
	by vger.kernel.org with ESMTP id S264280AbTLBCk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 21:40:28 -0500
Date: Tue, 2 Dec 2003 02:40:28 +0000
From: Matthew Bell <m.bell@bvrh.co.uk>
To: becker@scyld.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][OBVIOUS] 3c515.c: Enable ISAPNP when built as a module.
Message-Id: <20031202024028.49265a8f.m.bell@bvrh.co.uk>
Organization: Beach View Residential Home, Ltd.
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.19.orig/drivers/net/3c515.c       2002-02-25 19:37:59.000000000
+0000
+++ linux-2.4.19/drivers/net/3c515.c    2002-08-03 18:24:05.000000000 +0100
@@ -370,7 +370,7 @@
        { "Default", 0, 0xFF, XCVR_10baseT, 10000},
 };
                                                                                
                                                             
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined
(CONFIG_ISAPNP_MODULE))
 static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
        {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
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
