Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSHGXoM>; Wed, 7 Aug 2002 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSHGXoM>; Wed, 7 Aug 2002 19:44:12 -0400
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:57049 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S314602AbSHGXoL>; Wed, 7 Aug 2002 19:44:11 -0400
Message-ID: <20020807234744.9365.qmail@operamail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Matthew Bell" <mwsb@operamail.com>
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com
Date: Thu, 08 Aug 2002 07:47:44 +0800
Subject: [PATCH] 2.4.19; 3c515.c <should work with isapnp.o>
X-Originating-Ip: 195.10.121.242
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The isapnp code in 3c515.c should work with isapnp.c as a module(?), so I have changed the '#ifdef CONFIG_ISAPNP's to '#if defined(CONFIG_ISAPNP) || ((MODULE) && (CONFIG_ISAPNP_MODULE))'.
--3c515.diff----------------------------------------------
--- linux-2.4.19.orig/drivers/net/3c515.c       2002-02-25 19:37:59.000000000 +0000
+++ linux-2.4.19/drivers/net/3c515.c    2002-08-03 18:24:05.000000000 +0100
@@ -370,7 +370,7 @@
        { "Default", 0, 0xFF, XCVR_10baseT, 10000},
 };

-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
 static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
        {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
                ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051),
@@ -462,12 +462,12 @@
 {
        int cards_found = 0;
        static int ioaddr;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
        short i;
        static int pnp_cards;
 #endif

-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
        if(nopnp == 1)
                goto no_pnp;
        for(i=0; corkscrew_isapnp_adapters[i].vendor != 0; i++) {
@@ -530,7 +530,7 @@
        /* Check all locations on the ISA bus -- evil! */
        for (ioaddr = 0x100; ioaddr < 0x400; ioaddr += 0x20) {
                int irq;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
                /* Make sure this was not already picked up by isapnp */
                if(ioaddr == corkscrew_isapnp_phys_addr[0]) continue;
                if(ioaddr == corkscrew_isapnp_phys_addr[1]) continue;
--3c515.diff----------------------------------------------
-- 
_______________________________________________
Download the free Opera browser at http://www.opera.com/

Free OperaMail at http://www.operamail.com/

Powered by Outblaze
