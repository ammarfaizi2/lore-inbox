Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUDRR42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUDRR41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:56:27 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42743 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262796AbUDRRzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:55:23 -0400
Date: Sun, 18 Apr 2004 19:54:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 437] Amiga eth%d
In-Reply-To: <407C164F.1090501@pobox.com>
Message-ID: <Pine.GSO.4.58.0404181954070.17347@waterleaf.sonytel.be>
References: <200404130838.i3D8cI26018497@callisto.of.borg> <407C164F.1090501@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Jeff Garzik wrote:
> As a further change, can you please add KERN_xxx prefixes to those printk's?

To: akpm, linus, jeff
Cc: lkml
Subject: [PATCH] Amiga Zorro8390 Ethernet KERN_*

Amiga Zorro8390 Ethernet: Add KERN_* prefixes to printk() messages

--- linux-2.6.6-rc1/drivers/net/zorro8390.c	2004-04-15 20:40:55.000000000 +0200
+++ linux-m68k-2.6.6-rc1/drivers/net/zorro8390.c	2004-04-16 13:38:09.000000000 +0200
@@ -150,7 +150,7 @@

 	while ((z_readb(ioaddr + NE_EN0_ISR) & ENISR_RESET) == 0)
 	    if (jiffies - reset_start_time > 2*HZ/100) {
-		printk(" not found (no reset ack).\n");
+		printk(KERN_WARNING " not found (no reset ack).\n");
 		return -ENODEV;
 	    }

@@ -233,7 +233,7 @@
 	return err;
     }

-    printk("%s: %s at 0x%08lx, Ethernet Address "
+    printk(KERN_INFO "%s: %s at 0x%08lx, Ethernet Address "
 	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, name, board,
 	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
@@ -250,7 +250,7 @@
 static int zorro8390_close(struct net_device *dev)
 {
     if (ei_debug > 1)
-	printk("%s: Shutting down ethercard.\n", dev->name);
+	printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
     ei_close(dev);
     return 0;
 }
@@ -262,7 +262,7 @@
     unsigned long reset_start_time = jiffies;

     if (ei_debug > 1)
-	printk("resetting the 8390 t=%ld...", jiffies);
+	printk(KERN_DEBUG "resetting the 8390 t=%ld...\n", jiffies);

     z_writeb(z_readb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);

@@ -272,7 +272,8 @@
     /* This check _should_not_ be necessary, omit eventually. */
     while ((z_readb(NE_BASE+NE_EN0_ISR) & ENISR_RESET) == 0)
 	if (jiffies - reset_start_time > 2*HZ/100) {
-	    printk("%s: ne_reset_8390() did not complete.\n", dev->name);
+	    printk(KERN_WARNING "%s: ne_reset_8390() did not complete.\n",
+		   dev->name);
 	    break;
 	}
     z_writeb(ENISR_RESET, NE_BASE + NE_EN0_ISR);	/* Ack intr. */
@@ -291,7 +292,7 @@

     /* This *shouldn't* happen. If it does, it's the last thing you'll see */
     if (ei_status.dmaing) {
-	printk("%s: DMAing conflict in ne_get_8390_hdr "
+	printk(KERN_ERR "%s: DMAing conflict in ne_get_8390_hdr "
 	   "[DMAstat:%d][irqlock:%d].\n", dev->name, ei_status.dmaing,
 	   ei_status.irqlock);
 	return;
@@ -332,7 +333,7 @@

     /* This *shouldn't* happen. If it does, it's the last thing you'll see */
     if (ei_status.dmaing) {
-	printk("%s: DMAing conflict in ne_block_input "
+	printk(KERN_ERR "%s: DMAing conflict in ne_block_input "
 	   "[DMAstat:%d][irqlock:%d].\n",
 	   dev->name, ei_status.dmaing, ei_status.irqlock);
 	return;
@@ -372,7 +373,7 @@

     /* This *shouldn't* happen. If it does, it's the last thing you'll see */
     if (ei_status.dmaing) {
-	printk("%s: DMAing conflict in ne_block_output."
+	printk(KERN_ERR "%s: DMAing conflict in ne_block_output."
 	   "[DMAstat:%d][irqlock:%d]\n", dev->name, ei_status.dmaing,
 	   ei_status.irqlock);
 	return;
@@ -398,7 +399,8 @@

     while ((z_readb(NE_BASE + NE_EN0_ISR) & ENISR_RDC) == 0)
 	if (jiffies - dma_start > 2*HZ/100) {		/* 20ms */
-		printk("%s: timeout waiting for Tx RDC.\n", dev->name);
+		printk(KERN_ERR "%s: timeout waiting for Tx RDC.\n",
+		       dev->name);
 		zorro8390_reset_8390(dev);
 		NS8390_init(dev,1);
 		break;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
