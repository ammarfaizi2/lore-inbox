Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUDMIwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUDMItK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:49:10 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:42018 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263271AbUDMIiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:20 -0400
Date: Tue, 13 Apr 2004 10:38:18 +0200
Message-Id: <200404130838.i3D8cI26018497@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 437] Amiga eth%d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Ethernet drivers: Print card info after calling register_netdev(), to
avoid dev->name still being 'eth%d'.

--- linux-2.6.5/drivers/net/a2065.c	2004-03-16 09:57:30.000000000 +0100
+++ linux-m68k-2.6.5/drivers/net/a2065.c	2004-04-11 12:05:20.000000000 +0200
@@ -764,11 +764,6 @@
 	dev->dev_addr[3] = (z->rom.er_SerialNumber>>16) & 0xff;
 	dev->dev_addr[4] = (z->rom.er_SerialNumber>>8) & 0xff;
 	dev->dev_addr[5] = z->rom.er_SerialNumber & 0xff;
-	printk("%s: A2065 at 0x%08lx, Ethernet Address "
-	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
-	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
 	dev->base_addr = ZTWO_VADDR(base_addr);
 	dev->mem_start = ZTWO_VADDR(mem_start);
 	dev->mem_end = dev->mem_start+A2065_RAM_SIZE;
@@ -807,6 +802,11 @@
 	}
 	zorro_set_drvdata(z, dev);
 
+	printk("%s: A2065 at 0x%08lx, Ethernet Address "
+	       "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
+	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
 	return 0;
 }
 
--- linux-2.6.5/drivers/net/ariadne.c	2004-03-16 09:57:30.000000000 +0100
+++ linux-m68k-2.6.5/drivers/net/ariadne.c	2004-04-11 12:01:27.000000000 +0200
@@ -195,11 +195,6 @@
     dev->dev_addr[3] = (z->rom.er_SerialNumber>>16) & 0xff;
     dev->dev_addr[4] = (z->rom.er_SerialNumber>>8) & 0xff;
     dev->dev_addr[5] = z->rom.er_SerialNumber & 0xff;
-    printk("%s: Ariadne at 0x%08lx, Ethernet Address "
-	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
-	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
     dev->base_addr = ZTWO_VADDR(base_addr);
     dev->mem_start = ZTWO_VADDR(mem_start);
     dev->mem_end = dev->mem_start+ARIADNE_RAM_SIZE;
@@ -221,6 +216,11 @@
     }
     zorro_set_drvdata(z, dev);
 
+    printk("%s: Ariadne at 0x%08lx, Ethernet Address "
+	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
+	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
     return 0;
 }
 
--- linux-2.6.5/drivers/net/hydra.c	2004-03-16 09:57:31.000000000 +0100
+++ linux-m68k-2.6.5/drivers/net/hydra.c	2004-04-11 12:09:50.000000000 +0200
@@ -123,10 +123,6 @@
 	return -EAGAIN;
     }
 
-    printk("%s: hydra at 0x%08lx, address %02x:%02x:%02x:%02x:%02x:%02x (hydra.c " HYDRA_VERSION ")\n", dev->name, z->resource.start,
-	dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
     ei_status.name = name;
     ei_status.tx_start_page = start_page;
     ei_status.stop_page = stop_page;
@@ -156,6 +152,12 @@
     }
 
     zorro_set_drvdata(z, dev);
+
+    printk("%s: Hydra at 0x%08lx, address %02x:%02x:%02x:%02x:%02x:%02x "
+	   "(hydra.c " HYDRA_VERSION ")\n", dev->name, z->resource.start,
+	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
     return 0;
 }
 
--- linux-2.6.5/drivers/net/zorro8390.c	2004-04-05 10:41:52.000000000 +0200
+++ linux-m68k-2.6.5/drivers/net/zorro8390.c	2004-04-11 12:08:08.000000000 +0200
@@ -208,11 +208,6 @@
 	dev->dev_addr[i] = SA_prom[i];
     }
 
-    printk("%s: %s at 0x%08lx, Ethernet Address "
-	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, name, board,
-	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
     ei_status.name = name;
     ei_status.tx_start_page = start_page;
     ei_status.stop_page = stop_page;
@@ -233,9 +228,17 @@
 
     NS8390_init(dev, 0);
     err = register_netdev(dev);
-    if (err)
+    if (err) {
 	free_irq(IRQ_AMIGA_PORTS, dev);
-    return err;
+	return err;
+    }
+
+    printk("%s: %s at 0x%08lx, Ethernet Address "
+	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, name, board,
+	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
+    return 0;
 }
 
 static int zorro8390_open(struct net_device *dev)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
