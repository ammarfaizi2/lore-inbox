Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSLNUEe>; Sat, 14 Dec 2002 15:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSLNUEe>; Sat, 14 Dec 2002 15:04:34 -0500
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:35762 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265865AbSLNUEc>; Sat, 14 Dec 2002 15:04:32 -0500
Message-ID: <20021214201220.31330.qmail@operamail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Matthew Bell" <mwsb@operamail.com>
To: linux-parport@torque.net, linux-kernel@vger.kernel.org
Date: Sun, 15 Dec 2002 04:12:20 +0800
Subject: [PATCH] Obvious(ish): 3c515 should work if ISAPNP is a module.
X-Originating-Ip: 195.10.122.134
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is valid for at least 2.4.20 and earlier; it works for me, and I can't see any exceptional reason why it shouldn't work when ISAPNP is a module.
--- linux-2.4.19.orig/drivers/net/3c515.c       2002-02-25 19:37:59.000000000 +0000
+++ linux-2.4.19/drivers/net/3c515.c    2002-08-03 18:24:05.000000000 +0100
@@ -370,7 +370,7 @@
        { "Default", 0, 0xFF, XCVR_10baseT, 10000},
 };

-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined (CONFIG_ISAPNP_MODULE)
 static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
        {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
                ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051),
@@ -462,12 +462,12 @@
 {
        int cards_found = 0;
        static int ioaddr;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined (CONFIG_ISAPNP_MODULE)
        short i;
        static int pnp_cards;
 #endif

-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined (CONFIG_ISAPNP_MODULE)
        if(nopnp == 1)
                goto no_pnp;
        for(i=0; corkscrew_isapnp_adapters[i].vendor != 0; i++) {
@@ -530,7 +530,7 @@
        /* Check all locations on the ISA bus -- evil! */
        for (ioaddr = 0x100; ioaddr < 0x400; ioaddr += 0x20) {
                int irq;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined (CONFIG_ISAPNP_MODULE)
                /* Make sure this was not already picked up by isapnp */
                if(ioaddr == corkscrew_isapnp_phys_addr[0]) continue;
                if(ioaddr == corkscrew_isapnp_phys_addr[1]) continue;

-- 
_______________________________________________
Get your free email from http://mymail.operamail.com

Powered by Outblaze
