Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUDRRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUDRRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:55:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:20983 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262585AbUDRRyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:54:37 -0400
Date: Sun, 18 Apr 2004 19:54:05 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 437] Amiga eth%d
In-Reply-To: <407C164F.1090501@pobox.com>
Message-ID: <Pine.GSO.4.58.0404181953230.17347@waterleaf.sonytel.be>
References: <200404130838.i3D8cI26018497@callisto.of.borg> <407C164F.1090501@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Jeff Garzik wrote:
> As a further change, can you please add KERN_xxx prefixes to those printk's?

To: akpm, linus, jeff
Cc: lkml
Subject: [PATCH] Amiga Hydra Ethernet KERN_*

Amiga Hydra Ethernet: Add KERN_* prefixes to printk() messages

--- linux-2.6.6-rc1/drivers/net/hydra.c	2004-04-15 11:44:14.000000000 +0200
+++ linux-m68k-2.6.6-rc1/drivers/net/hydra.c	2004-04-16 13:24:08.000000000 +0200
@@ -153,10 +153,11 @@

     zorro_set_drvdata(z, dev);

-    printk("%s: Hydra at 0x%08lx, address %02x:%02x:%02x:%02x:%02x:%02x "
-	   "(hydra.c " HYDRA_VERSION ")\n", dev->name, z->resource.start,
-	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+    printk(KERN_INFO "%s: Hydra at 0x%08lx, address "
+	   "%02x:%02x:%02x:%02x:%02x:%02x (hydra.c " HYDRA_VERSION ")\n",
+	   dev->name, z->resource.start, dev->dev_addr[0], dev->dev_addr[1],
+	   dev->dev_addr[2], dev->dev_addr[3], dev->dev_addr[4],
+	   dev->dev_addr[5]);

     return 0;
 }
@@ -170,14 +171,14 @@
 static int hydra_close(struct net_device *dev)
 {
     if (ei_debug > 1)
-	printk("%s: Shutting down ethercard.\n", dev->name);
+	printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
     ei_close(dev);
     return 0;
 }

 static void hydra_reset_8390(struct net_device *dev)
 {
-    printk("Hydra hw reset not there\n");
+    printk(KERN_INFO "Hydra hw reset not there\n");
 }

 static void hydra_get_8390_hdr(struct net_device *dev,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
