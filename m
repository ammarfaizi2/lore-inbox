Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265798AbUFTRX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265798AbUFTRX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUFTRX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:23:56 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:24911 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S265798AbUFTRUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:20:54 -0400
Date: Sun, 20 Jun 2004 19:20:51 +0200
Message-Id: <200406201720.i5KHKpne001344@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 155] Mac Sonic Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac Sonic Ethernet updates (from Matthias Urlichs in 2.6):
  - Fix memory leak in error path
  - Kill obsolete namespace stuff
  - Kill duplicate `MODULE_LICENSE("GPL");' (already defined in included
    sonic.c) which causes a compile failure

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.27-rc1/drivers/net/macsonic.c	2004-04-27 17:20:37.000000000 +0200
+++ linux-m68k-2.4.27-rc1/drivers/net/macsonic.c	2004-05-04 22:38:58.000000000 +0200
@@ -199,6 +199,7 @@ int __init macsonic_init(struct net_devi
 	if ((lp->rba = (char *)
 	     kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_KERNEL | GFP_DMA)) == NULL) {
 		printk(KERN_ERR "%s: couldn't allocate receive buffers\n", dev->name);
+		kfree(lp);
 		return -ENOMEM;
 	}
 
@@ -635,19 +636,14 @@ int __init mac_nubus_sonic_probe(struct 
 }
 
 #ifdef MODULE
-static char namespace[16] = "";
 static struct net_device dev_macsonic;
 
 MODULE_PARM(sonic_debug, "i");
 MODULE_PARM_DESC(sonic_debug, "macsonic debug level (1-4)");
-MODULE_LICENSE("GPL");
-
-EXPORT_NO_SYMBOLS;
 
 int
 init_module(void)
 {
-        dev_macsonic.name = namespace;
         dev_macsonic.init = macsonic_probe;
 
         if (register_netdev(&dev_macsonic) != 0) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
