Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVPak>; Wed, 22 Nov 2000 10:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129585AbQKVPab>; Wed, 22 Nov 2000 10:30:31 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:36101 "EHLO
        orbita.don.sitek.net") by vger.kernel.org with ESMTP
        id <S129150AbQKVPaP>; Wed, 22 Nov 2000 10:30:15 -0500
Date: Wed, 22 Nov 2000 17:53:28 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] net drivers cleanup
Message-ID: <20001122175328.A14736@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: multipart/mixed; boundary="TYecfFk8j8mZq+dy"


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi Jeff,

attached new network drivers cleanup patchset:
	shaper.c, ac3200.c, e2100.c, lne390.c, ne3210.c, es3210.c, ioc3-eth.c,=20
	ni5010.c, ni52.c, hp.c, hp-plus.c, eth16i.c, 3c503.c, 3c505.c, 3c507.c,
	cs89x0.c, wd.c.

Modifications: request_(irq|region) cleanup, printk() cleanup, named initia=
lizers,
some labels (like out & out1 :) got more descriptive names.

All patches are against 2.4.0-test11, because i can't use your CVS for 2 re=
asons:
lack of password and slow internet connection (checkout linux kernel via 33=
.6 kbps
leased line will be very looooooong process :)

Unfortunately I have to make a business trip (new satellite launch mission)
so, it's most probably my last patchset for a some weeks at least.

Best regards,
	    Andrey
--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-shaper

diff -urN /mnt/disk/linux/drivers/net/shaper.c /linux/drivers/net/shaper.c
--- /mnt/disk/linux/drivers/net/shaper.c	Thu Nov 16 22:57:22 2000
+++ /linux/drivers/net/shaper.c	Sun Nov 19 18:33:42 2000
@@ -254,7 +254,7 @@
 	}
 #endif 	
 	if(sh_debug)
- 		printk("Frame queued.\n");
+ 		printk(KERN_DEBUG "Frame queued.\n");
  	if(skb_queue_len(&shaper->sendq)>SHAPER_QLEN)
  	{
  		ptr=skb_dequeue(&shaper->sendq);
@@ -273,13 +273,13 @@
 {
 	struct sk_buff *newskb=skb_clone(skb, GFP_ATOMIC);
 	if(sh_debug)
-		printk("Kick frame on %p\n",newskb);
+		printk(KERN_DEBUG "Kick frame on %p\n",newskb);
 	if(newskb)
 	{
 		newskb->dev=shaper->dev;
 		newskb->priority=2;
 		if(sh_debug)
-			printk("Kick new frame to %s, %d\n",
+			printk(KERN_DEBUG "Kick new frame to %s, %d\n",
 				shaper->dev->name,newskb->priority);
 		dev_queue_xmit(newskb);
 
@@ -287,7 +287,7 @@
 		shaper->stats.tx_packets++;
 
                 if(sh_debug)
-			printk("Kicked new frame out.\n");
+			printk(KERN_DEBUG "Kicked new frame out.\n");
 		dev_kfree_skb(skb);
 	}
 }
@@ -318,7 +318,7 @@
 	if (test_and_set_bit(0, &shaper->locked))
 	{
 		if(sh_debug)
-			printk("Shaper locked.\n");
+			printk(KERN_DEBUG "Shaper locked.\n");
 		mod_timer(&shaper->timer, jiffies);
 		return;
 	}
@@ -336,7 +336,7 @@
 		 */
 		 
 		if(sh_debug)
-			printk("Clock = %d, jiffies = %ld\n", SHAPERCB(skb)->shapeclock, jiffies);
+			printk(KERN_DEBUG "Clock = %d, jiffies = %ld\n", SHAPERCB(skb)->shapeclock, jiffies);
 		if(time_before_eq(SHAPERCB(skb)->shapeclock - jiffies, SHAPER_BURST))
 		{
 			/*
@@ -448,7 +448,7 @@
 	struct shaper *sh=dev->priv;
 	int v;
 	if(sh_debug)
-		printk("Shaper header\n");
+		printk(KERN_DEBUG "Shaper header\n");
 	skb->dev=sh->dev;
 	v=sh->hard_header(skb,sh->dev,type,daddr,saddr,len);
 	skb->dev=dev;
@@ -461,7 +461,7 @@
 	struct net_device *dev=skb->dev;
 	int v;
 	if(sh_debug)
-		printk("Shaper rebuild header\n");
+		printk(KERN_DEBUG "Shaper rebuild header\n");
 	skb->dev=sh->dev;
 	v=sh->rebuild_header(skb);
 	skb->dev=dev;
@@ -475,7 +475,7 @@
 	struct net_device *tmp;
 	int ret;
 	if(sh_debug)
-		printk("Shaper header cache bind\n");
+		printk(KERN_DEBUG "Shaper header cache bind\n");
 	tmp=neigh->dev;
 	neigh->dev=sh->dev;
 	ret=sh->hard_header_cache(neigh,hh);
@@ -488,7 +488,7 @@
 {
 	struct shaper *sh=dev->priv;
 	if(sh_debug)
-		printk("Shaper cache update\n");
+		printk(KERN_DEBUG "Shaper cache update\n");
 	sh->header_cache_update(hh, sh->dev, haddr);
 }
 #endif
@@ -687,23 +687,17 @@
  
 #ifdef MODULE
 
-static struct net_device dev_shape = 
-{
-	"",
-	0, 0, 0, 0,
-	0, 0,
-	0, 0, 0, NULL, shaper_probe 
-};
+static struct net_device dev_shape = { init: shaper_probe };
 
 int init_module(void)
 {
 	int err=dev_alloc_name(&dev_shape,"shaper%d");
 	if(err<0)
 		return err;
-	printk(SHAPER_BANNER);	
+	printk(KERN_INFO SHAPER_BANNER);	
 	if (register_netdev(&dev_shape) != 0)
 		return -EIO;
-	printk("Traffic shaper initialised.\n");
+	printk(KERN_INFO "Traffic shaper initialised.\n");
 	return 0;
 }
 
@@ -728,38 +722,27 @@
 
 #else
 
-static struct net_device dev_sh0 = 
-{
-	"shaper0",
-	0, 0, 0, 0,
-	0, 0,
-	0, 0, 0, NULL, shaper_probe 
+static struct net_device dev_sh0 = {
+	name: "shaper0",
+	init: shaper_probe,
 };
 
 
-static struct net_device dev_sh1 = 
-{
-	"shaper1",
-	0, 0, 0, 0,
-	0, 0,
-	0, 0, 0, NULL, shaper_probe 
+static struct net_device dev_sh1 = {
+	name: "shaper1",
+	init: shaper_probe,
 };
 
 
-static struct net_device dev_sh2 = 
-{
-	"shaper2",
-	0, 0, 0, 0,
-	0, 0,
-	0, 0, 0, NULL, shaper_probe 
+static struct net_device dev_sh2 = {
+	name: "shaper2",
+	init: shaper_probe,
 };
 
 static struct net_device dev_sh3 = 
 {
-	"shaper3",
-	0, 0, 0, 0,
-	0, 0,
-	0, 0, 0, NULL, shaper_probe 
+	name: "shaper3",
+	init: shaper_probe,
 };
 
 void shaper_init(void)

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ac3200

diff -urN /mnt/disk/linux/drivers/net/ac3200.c /linux/drivers/net/ac3200.c
--- /mnt/disk/linux/drivers/net/ac3200.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/ac3200.c	Sun Nov 19 19:55:06 2000
@@ -140,7 +140,7 @@
 		   inb(ioaddr + AC_ID_PORT + 2), inb(ioaddr + AC_ID_PORT + 3));
 #endif
 
-	printk("AC3200 in EISA slot %d, node", ioaddr/0x1000);
+	printk(KERN_INFO "AC3200 in EISA slot %d, node", ioaddr/0x1000);
 	for(i = 0; i < 6; i++)
 		printk(" %02x", dev->dev_addr[i] = inb(ioaddr + AC_SA_PROM + i));
 
@@ -195,7 +195,7 @@
 	dev->if_port = inb(ioaddr + AC_CONFIG) >> 6;
 	dev->mem_start = config2mem(inb(ioaddr + AC_CONFIG));
 
-	printk("%s: AC3200 at %#3x with %dkB memory at physical address %#lx.\n", 
+	printk(KERN_INFO "%s: AC3200 at %#3x with %dkB memory at physical address %#lx.\n", 
 			dev->name, ioaddr, AC_STOP_PG/4, dev->mem_start);
 
 	/*
@@ -220,7 +220,7 @@
 			goto out2;
 		}
 		ei_status.reg0 = 1;	/* Use as remap flag */
-		printk("ac3200.c: remapped %dkB card memory to virtual address %#lx\n",
+		printk(KERN_INFO "ac3200.c: remapped %dkB card memory to virtual address %#lx\n",
 				AC_STOP_PG/4, dev->mem_start);
 	}
 
@@ -235,7 +235,7 @@
 	ei_status.word16 = 1;
 
 	if (ei_debug > 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	ei_status.reset_8390 = &ac_reset_8390;
 	ei_status.block_input = &ac_block_input;
@@ -272,7 +272,7 @@
 	ushort ioaddr = dev->base_addr;
 
 	outb(AC_RESET, ioaddr + AC_RESET_PORT);
-	if (ei_debug > 1) printk("resetting AC3200, t=%ld...", jiffies);
+	if (ei_debug > 1) printk(KERN_DEBUG "resetting AC3200, t=%ld...", jiffies);
 
 	ei_status.txing = 0;
 	outb(AC_ENABLE, ioaddr + AC_RESET_PORT);
@@ -323,7 +323,7 @@
 static int ac_close_card(struct net_device *dev)
 {
 	if (ei_debug > 1)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 
 #ifdef notyet
 	/* We should someday disable shared memory and interrupts. */

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-e2100

diff -urN /mnt/disk/linux/drivers/net/e2100.c /linux/drivers/net/e2100.c
--- /mnt/disk/linux/drivers/net/e2100.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/e2100.c	Sun Nov 19 20:04:48 2000
@@ -140,8 +140,8 @@
 	unsigned char *station_addr = dev->dev_addr;
 	static unsigned version_printed = 0;
 
-	if (!request_region(ioaddr, E21_IO_EXTENT, "e2100"))
-		return -ENODEV;
+	if (!request_region(ioaddr, E21_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 	/* First check the station address for the Ctron prefix. */
 	if (inb(ioaddr + E21_SAPROM + 0) != 0x00
@@ -168,7 +168,7 @@
 	outb(0, ioaddr + E21_ASIC); 	/* and disable the secondary interface. */
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	for (i = 0; i < 6; i++)
 		printk(" %02X", station_addr[i]);
@@ -254,10 +254,12 @@
 static int
 e21_open(struct net_device *dev)
 {
+	int retval;
 	short ioaddr = dev->base_addr;
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "e2100", dev)) {
-		return -EBUSY;
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
+		printk(KERN_ERR "%s: unable to get IRQ%d.\n", dev->name, dev->irq);
+		return retval;
 	}
 
 	/* Set the interrupt line and memory base on the hardware. */
@@ -280,7 +282,7 @@
 	short ioaddr = dev->base_addr;
 
 	outb(0x01, ioaddr);
-	if (ei_debug > 1) printk("resetting the E2180x3 t=%ld...", jiffies);
+	if (ei_debug > 1) printk(KERN_DEBUG "resetting the E2180x3 t=%ld...", jiffies);
 	ei_status.txing = 0;
 
 	/* Set up the ASIC registers, just in case something changed them. */
@@ -352,7 +354,7 @@
 	short ioaddr = dev->base_addr;
 
 	if (ei_debug > 1)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 
 	free_irq(dev->irq, dev);
 	dev->irq = ei_status.saved_irq;

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-lne390

diff -urN /mnt/disk/linux/drivers/net/lne390.c /linux/drivers/net/lne390.c
--- /mnt/disk/linux/drivers/net/lne390.c	Thu Nov 16 22:57:26 2000
+++ /linux/drivers/net/lne390.c	Sun Nov 19 20:07:34 2000
@@ -109,7 +109,7 @@
 	int ret;
 
 	if (ioaddr > 0x1ff) {		/* Check a single specified location. */
-		if (!request_region(ioaddr, LNE390_IO_EXTENT, "lne390"))
+		if (!request_region(ioaddr, LNE390_IO_EXTENT, dev->name))
 			return -EBUSY;
 		ret = lne390_probe1(dev, ioaddr);
 		if (ret)
@@ -121,14 +121,14 @@
 
 	if (!EISA_bus) {
 #if LNE390_DEBUG & LNE390_D_PROBE
-		printk("lne390-debug: Not an EISA bus. Not probing high ports.\n");
+		printk(kern_debug "lne390-debug: Not an EISA bus. Not probing high ports.\n");
 #endif
 		return -ENXIO;
 	}
 
 	/* EISA spec allows for up to 16 slots, but 8 is typical. */
 	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000) {
-		if (!request_region(ioaddr, LNE390_IO_EXTENT, "lne390"))
+		if (!request_region(ioaddr, LNE390_IO_EXTENT, dev->name))
 			continue;
 		if (lne390_probe1(dev, ioaddr) == 0)
 			return 0;
@@ -146,8 +146,9 @@
 	if (inb_p(ioaddr + LNE390_ID_PORT) == 0xff) return -ENODEV;
 
 #if LNE390_DEBUG & LNE390_D_PROBE
-	printk("lne390-debug: probe at %#x, ID %#8x\n", ioaddr, inl(ioaddr + LNE390_ID_PORT));
-	printk("lne390-debug: config regs: %#x %#x\n",
+	printk(KERN_DEBUG "lne390-debug: probe at %#x, ID %#8x\n", 
+		ioaddr, inl(ioaddr + LNE390_ID_PORT));
+	printk(KERN_DEBUG "lne390-debug: config regs: %#x %#x\n",
 		inb(ioaddr + LNE390_CFG1), inb(ioaddr + LNE390_CFG2));
 #endif
 
@@ -165,7 +166,7 @@
 	if (inb(ioaddr + LNE390_SA_PROM + 0) != LNE390_ADDR0
 		|| inb(ioaddr + LNE390_SA_PROM + 1) != LNE390_ADDR1
 		|| inb(ioaddr + LNE390_SA_PROM + 2) != LNE390_ADDR2 ) {
-		printk("lne390.c: card not found");
+		printk(KERN_WARNING "lne390.c: card not found");
 		for(i = 0; i < ETHER_ADDR_LEN; i++)
 			printk(" %02x", inb(ioaddr + LNE390_SA_PROM + i));
 		printk(" (invalid prefix).\n");
@@ -174,11 +175,11 @@
 #endif
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
-		printk ("lne390.c: unable to allocate memory for dev->priv!\n");
+		printk (KERN_ERR "lne390.c: unable to allocate memory for dev->priv!\n");
 		return -ENOMEM;
 	}
 
-	printk("lne390.c: LNE390%X in EISA slot %d, address", 0xa+revision, ioaddr/0x1000);
+	printk(KERN_INFO "lne390.c: LNE390%X in EISA slot %d, address", 0xa+revision, ioaddr/0x1000);
 	for(i = 0; i < ETHER_ADDR_LEN; i++)
 		printk(" %02x", (dev->dev_addr[i] = inb(ioaddr + LNE390_SA_PROM + i)));
 	printk(".\nlne390.c: ");
@@ -195,11 +196,11 @@
 	}
 	printk(" IRQ %d,", dev->irq);
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "lne390", dev)) {
+	if ((ret = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
 		kfree(dev->priv);
 		dev->priv = NULL;
-		return -EAGAIN;
+		return ret;
 	}
 
 	if (dev->mem_start == 0) {
@@ -241,7 +242,7 @@
 			goto cleanup;
 		}
 		ei_status.reg0 = 1;	/* Use as remap flag */
-		printk("lne390.c: remapped %dkB card memory to virtual address %#lx\n",
+		printk(KERN_INFO "lne390.c: remapped %dkB card memory to virtual address %#lx\n",
 				LNE390_STOP_PG/4, dev->mem_start);
 	}
 
@@ -259,7 +260,7 @@
 	ei_status.word16 = 1;
 
 	if (ei_debug > 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	ei_status.reset_8390 = &lne390_reset_8390;
 	ei_status.block_input = &lne390_block_input;
@@ -287,7 +288,7 @@
 	unsigned short ioaddr = dev->base_addr;
 
 	outb(0x04, ioaddr + LNE390_RESET_PORT);
-	if (ei_debug > 1) printk("%s: resetting the LNE390...", dev->name);
+	if (ei_debug > 1) printk(KERN_DEBUG "%s: resetting the LNE390...", dev->name);
 
 	mdelay(2);
 
@@ -364,7 +365,7 @@
 {
 
 	if (ei_debug > 1)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 
 	ei_close(dev);
 	MOD_DEC_USE_COUNT;

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ne3210

diff -urN /mnt/disk/linux/drivers/net/ne3210.c /linux/drivers/net/ne3210.c
--- /mnt/disk/linux/drivers/net/ne3210.c	Thu Nov 16 22:57:26 2000
+++ /linux/drivers/net/ne3210.c	Sun Nov 19 22:21:49 2000
@@ -106,7 +106,7 @@
 
 	if (!EISA_bus) {
 #if NE3210_DEBUG & NE3210_D_PROBE
-		printk("ne3210-debug: Not an EISA bus. Not probing high ports.\n");
+		printk(KERN_DEBUG "ne3210-debug: Not an EISA bus. Not probing high ports.\n");
 #endif
 		return -ENXIO;
 	}
@@ -130,12 +130,13 @@
 
 	if (inb_p(ioaddr + NE3210_ID_PORT) == 0xff) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 #if NE3210_DEBUG & NE3210_D_PROBE
-	printk("ne3210-debug: probe at %#x, ID %#8x\n", ioaddr, inl(ioaddr + NE3210_ID_PORT));
-	printk("ne3210-debug: config regs: %#x %#x\n",
+	printk(KERN_DEBUG "ne3210-debug: probe at %#x, ID %#8x\n", 
+		ioaddr, inl(ioaddr + NE3210_ID_PORT));
+	printk(KERN_DEBUG "ne3210-debug: config regs: %#x %#x\n",
 		inb(ioaddr + NE3210_CFG1), inb(ioaddr + NE3210_CFG2));
 #endif
 
@@ -144,7 +145,7 @@
 	eisa_id = inl(ioaddr + NE3210_ID_PORT);
 	if (eisa_id != NE3210_ID) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	
@@ -153,23 +154,23 @@
 	if (inb(ioaddr + NE3210_SA_PROM + 0) != NE3210_ADDR0
 		|| inb(ioaddr + NE3210_SA_PROM + 1) != NE3210_ADDR1
 		|| inb(ioaddr + NE3210_SA_PROM + 2) != NE3210_ADDR2 ) {
-		printk("ne3210.c: card not found");
+		printk(KERN_WARNING "ne3210.c: card not found");
 		for(i = 0; i < ETHER_ADDR_LEN; i++)
 			printk(" %02x", inb(ioaddr + NE3210_SA_PROM + i));
 		printk(" (invalid prefix).\n");
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 #endif
 
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
-		printk ("ne3210.c: unable to allocate memory for dev->priv!\n");
+		printk (KERN_ERR "ne3210.c: unable to allocate memory for dev->priv!\n");
 		retval = -ENOMEM;
-		goto out;
+		goto err_out;
 	}
 
-	printk("ne3210.c: NE3210 in EISA slot %d, media: %s, addr:",
+	printk(KERN_INFO "ne3210.c: NE3210 in EISA slot %d, media: %s, addr:",
 		ioaddr/0x1000, ifmap[inb(ioaddr + NE3210_CFG2) >> 6]);
 	for(i = 0; i < ETHER_ADDR_LEN; i++)
 		printk(" %02x", (dev->dev_addr[i] = inb(ioaddr + NE3210_SA_PROM + i)));
@@ -190,7 +191,7 @@
 	retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev);
 	if (retval) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
-		goto out1;
+		goto err_out_kfree;
 	}
 
 	if (dev->mem_start == 0) {
@@ -217,7 +218,7 @@
 			printk(KERN_CRIT "ne3210.c: or to an address above 0x%lx.\n", virt_to_bus(high_memory));
 			printk(KERN_CRIT "ne3210.c: Driver NOT installed.\n");
 			retval = -EINVAL;
-			goto out2;
+			goto err_out_free_irq;
 		}
 		dev->mem_start = (unsigned long)ioremap(dev->mem_start, NE3210_STOP_PG*0x100);
 		if (dev->mem_start == 0) {
@@ -225,10 +226,10 @@
 			printk(KERN_ERR "ne3210.c: Try using EISA SCU to set memory below 1MB.\n");
 			printk(KERN_ERR "ne3210.c: Driver NOT installed.\n");
 			retval = -EAGAIN;
-			goto out2;
+			goto err_out_free_irq;
 		}
 		ei_status.reg0 = 1;	/* Use as remap flag */
-		printk("ne3210.c: remapped %dkB card memory to virtual address %#lx\n",
+		printk(KERN_INFO "ne3210.c: remapped %dkB card memory to virtual address %#lx\n",
 				NE3210_STOP_PG/4, dev->mem_start);
 	}
 
@@ -246,7 +247,7 @@
 	ei_status.word16 = 1;
 
 	if (ei_debug > 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	ei_status.reset_8390 = &ne3210_reset_8390;
 	ei_status.block_input = &ne3210_block_input;
@@ -257,12 +258,13 @@
 	dev->stop = &ne3210_close;
 	NS8390_init(dev, 0);
 	return 0;
-out2:
+
+err_out_free_irq:
 	free_irq(dev->irq, dev);	
-out1:
+err_out_kfree:
 	kfree(dev->priv);
 	dev->priv = NULL;
-out:
+err_out:
 	release_region(ioaddr, NE3210_IO_EXTENT);
 	return retval;
 }
@@ -276,7 +278,7 @@
 	unsigned short ioaddr = dev->base_addr;
 
 	outb(0x04, ioaddr + NE3210_RESET_PORT);
-	if (ei_debug > 1) printk("%s: resetting the NE3210...", dev->name);
+	if (ei_debug > 1) printk(KERN_DEBUG "%s: resetting the NE3210...", dev->name);
 
 	mdelay(2);
 
@@ -353,7 +355,7 @@
 {
 
 	if (ei_debug > 1)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 
 	ei_close(dev);
 	MOD_DEC_USE_COUNT;

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-es3210

diff -urN /mnt/disk/linux/drivers/net/es3210.c /linux/drivers/net/es3210.c
--- /mnt/disk/linux/drivers/net/es3210.c	Thu Nov 16 22:57:24 2000
+++ /linux/drivers/net/es3210.c	Sun Nov 19 22:48:57 2000
@@ -135,7 +135,7 @@
 
 	if (!EISA_bus) {
 #if ES_DEBUG & ES_D_PROBE
-		printk("es3210.c: Not EISA bus. Not probing high ports.\n");
+		printk(KERN_DEBUG "es3210.c: Not EISA bus. Not probing high ports.\n");
 #endif
 		return -ENXIO;
 	}
@@ -153,12 +153,13 @@
 	int i, retval;
 	unsigned long eisa_id;
 
-	if (!request_region(ioaddr + ES_SA_PROM, ES_IO_EXTENT, "es3210"))
-		return -ENODEV;
+	if (!request_region(ioaddr + ES_SA_PROM, ES_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 #if ES_DEBUG & ES_D_PROBE
-	printk("es3210.c: probe at %#x, ID %#8x\n", ioaddr, inl(ioaddr + ES_ID_PORT));
-	printk("es3210.c: config regs: %#x %#x %#x %#x %#x %#x\n",
+	printk(KERN_DEBUG "es3210.c: probe at %#x, ID %#8x\n", 
+		ioaddr, inl(ioaddr + ES_ID_PORT));
+	printk(KERN_DEBUG "es3210.c: config regs: %#x %#x %#x %#x %#x %#x\n",
 		inb(ioaddr + ES_CFG1), inb(ioaddr + ES_CFG2), inb(ioaddr + ES_CFG3),
 		inb(ioaddr + ES_CFG4), inb(ioaddr + ES_CFG5), inb(ioaddr + ES_CFG6));
 #endif
@@ -168,22 +169,22 @@
 	eisa_id = inl(ioaddr + ES_ID_PORT);
 	if ((eisa_id != ES_EISA_ID1) && (eisa_id != ES_EISA_ID2)) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 /*	Check the Racal vendor ID as well. */
 	if (inb(ioaddr + ES_SA_PROM + 0) != ES_ADDR0
 		|| inb(ioaddr + ES_SA_PROM + 1) != ES_ADDR1
 		|| inb(ioaddr + ES_SA_PROM + 2) != ES_ADDR2 ) {
-		printk("es3210.c: card not found");
+		printk(KERN_WARNING "es3210.c: card not found");
 		for(i = 0; i < ETHER_ADDR_LEN; i++)
 			printk(" %02x", inb(ioaddr + ES_SA_PROM + i));
 		printk(" (invalid prefix).\n");
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
-	printk("es3210.c: ES3210 rev. %ld at %#x, node", eisa_id>>24, ioaddr);
+	printk(KERN_INFO "es3210.c: ES3210 rev. %ld at %#x, node", eisa_id>>24, ioaddr);
 	for(i = 0; i < ETHER_ADDR_LEN; i++)
 		printk(" %02x", (dev->dev_addr[i] = inb(ioaddr + ES_SA_PROM + i)));
 
@@ -201,7 +202,7 @@
 		}
 		printk(" using IRQ %d", dev->irq);
 #if ES_DEBUG & ES_D_PROBE
-		printk("es3210.c: hi_irq %#x, lo_irq %#x, dev->irq = %d\n",
+		printk(KERN_DEBUG "es3210.c: hi_irq %#x, lo_irq %#x, dev->irq = %d\n",
 					hi_irq, lo_irq, dev->irq);
 #endif
 	} else {
@@ -210,10 +211,10 @@
 		printk(" assigning IRQ %d", dev->irq);
 	}
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "es3210", dev)) {
+	if (request_irq(dev->irq, ei_interrupt, 0, dev->name, dev)) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
 		retval = -EAGAIN;
-		goto out;
+		goto err_out;
 	}
 
 	if (dev->mem_start == 0) {
@@ -223,7 +224,7 @@
 		if (mem_enabled != 0x80) {
 			printk(" shared mem disabled - giving up\n");
 			retval = -ENXIO;
-			goto out1;
+			goto err_out_free_irq;
 		}
 		dev->mem_start = 0xC0000 + mem_bits*0x4000;
 		printk(" using ");
@@ -241,12 +242,12 @@
 	if (ethdev_init(dev)) {
 		printk (" unable to allocate memory for dev->priv.\n");
 		retval = -ENOMEM;
-		goto out1;
+		goto err_out_free_irq;
 	}
 
 #if ES_DEBUG & ES_D_PROBE
 	if (inb(ioaddr + ES_CFG5))
-		printk("es3210: Warning - DMA channel enabled, but not used here.\n");
+		printk(KERN_DEBUG "es3210: Warning - DMA channel enabled, but not used here.\n");
 #endif
 	/* Note, point at the 8390, and not the card... */
 	dev->base_addr = ioaddr + ES_NIC_OFFSET;
@@ -258,7 +259,7 @@
 	ei_status.word16 = 1;
 
 	if (ei_debug > 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	ei_status.reset_8390 = &es_reset_8390;
 	ei_status.block_input = &es_block_input;
@@ -269,9 +270,10 @@
 	dev->stop = &es_close;
 	NS8390_init(dev, 0);
 	return 0;
-out1:
+
+err_out_free_irq:
 	free_irq(dev->irq, dev);
-out:
+err_out:
 	release_region(ioaddr + ES_SA_PROM, ES_IO_EXTENT);
 	return retval;
 }
@@ -287,7 +289,8 @@
 	unsigned long end;
 
 	outb(0x04, ioaddr + ES_RESET_PORT);
-	if (ei_debug > 1) printk("%s: resetting the ES3210...", dev->name);
+	if (ei_debug > 1)
+		printk(KERN_DEBUG "%s: resetting the ES3210...", dev->name);
 
 	end = jiffies + 2*HZ/100;
         while ((signed)(end - jiffies) > 0) continue;
@@ -367,7 +370,7 @@
 {
 
 	if (ei_debug > 1)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 
 	ei_close(dev);
 

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ioc3-eth

diff -urN /mnt/disk/linux/drivers/net/ioc3-eth.c /linux/drivers/net/ioc3-eth.c
--- /mnt/disk/linux/drivers/net/ioc3-eth.c	Thu Nov 16 22:57:26 2000
+++ /linux/drivers/net/ioc3-eth.c	Sun Nov 19 20:12:26 2000
@@ -837,12 +837,13 @@
 static int
 ioc3_open(struct net_device *dev)
 {
+	int retval;
 	struct ioc3_private *ip;
 
-	if (request_irq(dev->irq, ioc3_interrupt, 0, ioc3_str, dev)) {
+	if ((retval = request_irq(dev->irq, ioc3_interrupt, 0, dev->name, dev))) {
 		printk(KERN_ERR "%s: Can't get irq %d\n", dev->name, dev->irq);
 
-		return -EAGAIN;
+		return retval;
 	}
 
 	ip = (struct ioc3_private *) dev->priv;

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ni5010

diff -urN /mnt/disk/linux/drivers/net/ni5010.c /linux/drivers/net/ni5010.c
--- /mnt/disk/linux/drivers/net/ni5010.c	Thu Nov 16 22:57:26 2000
+++ /linux/drivers/net/ni5010.c	Sun Nov 19 18:56:51 2000
@@ -134,20 +134,13 @@
 		return -ENXIO;
 
 #ifdef FULL_IODETECT
-		for (int ioaddr=0x200; ioaddr<0x400; ioaddr+=0x20) {
-			if (check_region(ioaddr, NI5010_IO_EXTENT))
-				continue;
+		for (int ioaddr=0x200; ioaddr<0x400; ioaddr+=0x20)
 			if (ni5010_probe1(dev, ioaddr) == 0)
 				return 0;
-		}
 #else
-		for (port = ni5010_portlist; *port; port++) {
-			int ioaddr = *port;
-			if (check_region(ioaddr, NI5010_IO_EXTENT))
-				continue;
-			if (ni5010_probe1(dev, ioaddr) == 0)
+		for (port = ni5010_portlist; *port; port++)
+			if (ni5010_probe1(dev, *port) == 0)
 				return 0;
-		}
 #endif	/* FULL_IODETECT */
 	return -ENODEV;
 }
@@ -185,8 +178,8 @@
 
 static int __init ni5010_probe1(struct net_device *dev, int ioaddr)
 {
-	static unsigned version_printed = 0;
-	int i;
+	static unsigned version_printed;
+	int i, retval;
 	unsigned int data = 0;
 	int boguscount = 40;
 
@@ -207,19 +200,31 @@
  	PRINTK2((KERN_DEBUG "%s: entering ni5010_probe1(%#3x)\n", 
  		dev->name, ioaddr));
 
-	if (inb(ioaddr+0) == 0xff) return -ENODEV;
+	if (!request_region(ioaddr, NI5010_IO_EXTENT, dev->name))
+		return -EBUSY;
+
+	if (inb(ioaddr+0) == 0xff) {
+		retval = -ENODEV;
+		goto err_out;
+	}
 
 	while ( (rd_port(ioaddr) & rd_port(ioaddr) & rd_port(ioaddr) &
 		 rd_port(ioaddr) & rd_port(ioaddr) & rd_port(ioaddr)) != 0xff)
 	{
-		if (boguscount-- == 0) return -ENODEV;
+		if (boguscount-- == 0) {
+			retval = -ENODEV;
+			goto err_out;
+		}
 	}
 
 	PRINTK2((KERN_DEBUG "%s: I/O #1 passed!\n", dev->name));
 
 	for (i=0; i<32; i++)
 		if ( (data = rd_port(ioaddr)) != 0xff) break;
-	if (data==0xff) return -ENODEV;
+	if (data == 0xff) {
+		retval = -ENODEV;
+		goto err_out;
+	}
 
 	PRINTK2((KERN_DEBUG "%s: I/O #2 passed!\n", dev->name));
 
@@ -229,16 +234,20 @@
 		for (i=0; i<4; i++) rd_port(ioaddr);
 		if ( (rd_port(ioaddr) != NI5010_MAGICVAL1) ||
 		     (rd_port(ioaddr) != NI5010_MAGICVAL2) ) {
-		     	return -ENODEV;
+		     	retval = -ENODEV;
+			goto err_out;
 		}
-	} else return -ENODEV;
+	} else {
+		retval = -ENODEV;
+		goto err_out;
+	}
 	
 	PRINTK2((KERN_DEBUG "%s: I/O #3 passed!\n", dev->name));
 
 	if (NI5010_DEBUG && version_printed++ == 0)
 		printk(KERN_INFO "%s", version);
 
-	printk("NI5010 ethercard probe at 0x%x: ", ioaddr);
+	printk(KERN_INFO "NI5010 ethercard probe at %#x: ", ioaddr);
 
 	dev->base_addr = ioaddr;
 
@@ -263,7 +272,8 @@
 
 		if (dev->irq == 0) {
 			printk(KERN_WARNING "%s: no IRQ found!\n", dev->name);
-			return -EAGAIN;
+			retval = -EAGAIN;
+			goto err_out;
 		}
 		PRINTK2((KERN_DEBUG "%s: I/O #7 passed!\n", dev->name));
 	} else if (dev->irq == 2) {
@@ -278,7 +288,8 @@
 		dev->priv = kmalloc(sizeof(struct ni5010_local), GFP_KERNEL|GFP_DMA);
 		if (dev->priv == NULL) {
 			printk(KERN_WARNING "%s: Failed to allocate private memory\n", dev->name);
-			return -ENOMEM;
+			retval = -ENOMEM;
+			goto err_out;
 		}
 	}
 
@@ -306,9 +317,6 @@
         printk("// bufsize rcv/xmt=%d/%d\n", bufsize_rcv, NI5010_BUFSIZE);
 	memset(dev->priv, 0, sizeof(struct ni5010_local));
 
-	/* Grab the region so we can find another board if autoIRQ fails. */
-	request_region(ioaddr, NI5010_IO_EXTENT, boardname);
-	
 	dev->open		= ni5010_open;
 	dev->stop		= ni5010_close;
 	dev->hard_start_xmit	= ni5010_send_packet;
@@ -335,6 +343,10 @@
 	printk(KERN_INFO "Join the NI5010 driver development team!\n");
 	printk(KERN_INFO "Mail to a.mohr@mailto.de or jvbest@wi.leidenuniv.nl\n");
 	return 0;
+
+err_out:
+	release_region(ioaddr, NI5010_IO_EXTENT);
+	return retval;
 }
 
 /* 
@@ -353,9 +365,9 @@
 
 	PRINTK2((KERN_DEBUG "%s: entering ni5010_open()\n", dev->name)); 
 	
-	if (request_irq(dev->irq, &ni5010_interrupt, 0, boardname, dev)) {
+	if ((i = request_irq(dev->irq, &ni5010_interrupt, 0, dev->name, dev))) {
 		printk(KERN_WARNING "%s: Cannot get irq %#2x\n", dev->name, dev->irq);
-		return -EAGAIN;
+		return i;
 	}
 	PRINTK3((KERN_DEBUG "%s: passed open() #1\n", dev->name));
         /*
@@ -363,10 +375,10 @@
          * and clean up on failure.
          */
 #ifdef jumpered_dma
-        if (request_dma(dev->dma, cardname)) {
+        if ((i = request_dma(dev->dma, dev->name))) {
 		printk(KERN_WARNING "%s: Cannot get dma %#2x\n", dev->name, dev->dma);
                 free_irq(dev->irq, NULL);
-                return -EAGAIN;
+                return i;
         }
 #endif	/* jumpered_dma */
 

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ni52

diff -urN /mnt/disk/linux/drivers/net/ni52.c /linux/drivers/net/ni52.c
--- /mnt/disk/linux/drivers/net/ni52.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/ni52.c	Sun Nov 19 22:24:09 2000
@@ -256,16 +256,18 @@
  */
 static int ni52_open(struct net_device *dev)
 {
+	int retval;
+
 	ni_disint();
 	alloc586(dev);
 	init586(dev);
 	startrecv586(dev);
 	ni_enaint();
 
-	if(request_irq(dev->irq, &ni52_interrupt,0,"ni5210",dev))
+	if((retval = request_irq(dev->irq, &ni52_interrupt, 0, dev->name, dev)))
 	{
 		ni_reset586();
-		return -EAGAIN;
+		return retval;
 	}
 
 	netif_start_queue(dev);
@@ -393,13 +395,13 @@
 {
 	int i, size, retval;
 
-	if (!request_region(ioaddr, NI52_TOTAL_SIZE, "ni5210"))
-		return -ENODEV;
+	if (!request_region(ioaddr, NI52_TOTAL_SIZE, dev->name))
+		return -EBUSY;
 
 	if( !(inb(ioaddr+NI52_MAGIC1) == NI52_MAGICVAL1) ||
 	    !(inb(ioaddr+NI52_MAGIC2) == NI52_MAGICVAL2)) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	for(i=0;i<ETH_ALEN;i++)
@@ -408,7 +410,7 @@
 	if(dev->dev_addr[0] != NI52_ADDR0 || dev->dev_addr[1] != NI52_ADDR1
 		 || dev->dev_addr[2] != NI52_ADDR2) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	printk("%s: NI5210 found at %#3lx, ",dev->name,dev->base_addr);
@@ -421,12 +423,12 @@
 	if(size != 0x2000 && size != 0x4000) {
 		printk("\n%s: Illegal memory size %d. Allowed is 0x2000 or 0x4000 bytes.\n",dev->name,size);
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 	if(!check586(dev,(char *) dev->mem_start,size)) {
 		printk("?memcheck, Can't find memory at 0x%lx with size %d!\n",dev->mem_start,size);
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 #else
 	if(dev->mem_start != 0) /* no auto-mem-probe */
@@ -437,7 +439,7 @@
 			if(!check586(dev,(char *) dev->mem_start,size)) {
 				printk("?memprobe, Can't find memory at 0x%lx!\n",dev->mem_start);
 				retval = -ENODEV;
-				goto out;
+				goto err_out;
 			}
 		}
 	}
@@ -450,7 +452,7 @@
 			if(!memaddrs[i]) {
 				printk("?memprobe, Can't find io-memory!\n");
 				retval = -ENODEV;
-				goto out;
+				goto err_out;
 			}
 			dev->mem_start = memaddrs[i];
 			size = 0x2000; /* check for 8K mem */
@@ -468,7 +470,7 @@
 	if(dev->priv == NULL) {
 		printk("%s: Ooops .. can't allocate private driver memory.\n",dev->name);
 		retval = -ENOMEM;
-		goto out;
+		goto err_out;
 	}
 																	/* warning: we don't free it on errors */
 	memset((char *) dev->priv,0,sizeof(struct priv));
@@ -496,7 +498,7 @@
 			kfree(dev->priv);
 			dev->priv = NULL;
 			retval = -EAGAIN;
-			goto out;
+			goto err_out;
 		}
 		printk("IRQ %d (autodetected).\n",dev->irq);
 	}
@@ -519,7 +521,8 @@
 	ether_setup(dev);
 
 	return 0;
-out:
+
+err_out:
 	release_region(ioaddr, NI52_TOTAL_SIZE);
 	return retval;
 }

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pathc-hp

diff -urN /mnt/disk/linux/drivers/net/hp.c /linux/drivers/net/hp.c
--- /mnt/disk/linux/drivers/net/hp.c	Thu Nov 16 22:57:10 2000
+++ /linux/drivers/net/hp.c	Sun Nov 19 22:04:58 2000
@@ -104,7 +104,7 @@
 	static unsigned version_printed;
 
 	if (!request_region(ioaddr, HP_IO_EXTENT, dev->name))
-		return -ENODEV;
+		return -EBUSY;
 
 	/* Check for the HP physical address, 08 00 09 xx xx xx. */
 	/* This really isn't good enough: we may pick up HP LANCE boards
@@ -114,7 +114,7 @@
 		|| inb(ioaddr+2) != 0x09
 		|| inb(ioaddr+14) == 0x57) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	/* Set up the parameters based on the board ID.
@@ -128,16 +128,16 @@
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
-		printk (" unable to get memory for dev->priv.\n");
+		printk (KERN_ERR "%s: unable to get memory for dev->priv.\n", dev->name);
 		retval = -ENOMEM;
-		goto out;
+		goto err_out;
 	}
 
-	printk("%s: %s (ID %02x) at %#3x,", dev->name, name, board_id, ioaddr);
+	printk(KERN_INFO "%s: %s (ID %02x) at %#3x,", dev->name, name, board_id, ioaddr);
 
 	for(i = 0; i < ETHER_ADDR_LEN; i++)
 		printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
@@ -165,14 +165,14 @@
 		if (*irqp == 0) {
 			printk(" no free IRQ lines.\n");
 			retval = -EBUSY;
-			goto out1;
+			goto err_out_kfree;
 		}
 	} else {
 		if (dev->irq == 2)
 			dev->irq = 9;
 		if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 			printk (" unable to get IRQ %d.\n", dev->irq);
-			goto out1;
+			goto err_out_kfree;
 		}
 	}
 
@@ -194,10 +194,11 @@
 	hp_init_card(dev);
 
 	return 0;
-out1:
+
+err_out_kfree:
 	kfree(dev->priv);
 	dev->priv = NULL;
-out:
+err_out:
 	release_region(ioaddr, HP_IO_EXTENT);
 	return retval;
 }

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hp-plus

diff -urN /mnt/disk/linux/drivers/net/hp-plus.c /linux/drivers/net/hp-plus.c
--- /mnt/disk/linux/drivers/net/hp-plus.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/hp-plus.c	Sun Nov 19 22:18:16 2000
@@ -150,13 +150,13 @@
 	if (inw(ioaddr + HP_ID) != 0x4850
 		|| (inw(ioaddr + HP_PAGING) & 0xfff0) != 0x5300) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
-	printk("%s: %s at %#3x,", dev->name, name, ioaddr);
+	printk(KERN_INFO "%s: %s at %#3x,", dev->name, name, ioaddr);
 
 	/* Retrieve and checksum the station address. */
 	outw(MAC_Page, ioaddr + HP_PAGING);
@@ -172,7 +172,7 @@
 	if (checksum != 0xff) {
 		printk(" bad checksum %2.2x.\n", checksum);
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	} else {
 		/* Point at the Software Configuration Flags. */
 		outw(ID_Page, ioaddr + HP_PAGING);
@@ -181,9 +181,9 @@
 
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
-		printk ("hp-plus.c: unable to allocate memory for dev->priv.\n");
+		printk (KERN_INFO "hp-plus.c: unable to allocate memory for dev->priv.\n");
 		retval = -ENOMEM;
-		goto out;
+		goto err_out;
 	 }
 
 	/* Read the IRQ line. */
@@ -239,7 +239,8 @@
 	outw(inw(ioaddr + HPP_OPTION) & ~EnableIRQ, ioaddr + HPP_OPTION);
 
 	return 0;
-out:
+
+err_out:
 	release_region(ioaddr, HP_IO_EXTENT);
 	return retval;
 }
@@ -295,7 +296,8 @@
 	int ioaddr = dev->base_addr - NIC_OFFSET;
 	int option_reg = inw(ioaddr + HPP_OPTION);
 
-	if (ei_debug > 1) printk("resetting the 8390 time=%ld...", jiffies);
+	if (ei_debug > 1)
+		printk(KERN_DEBUG "resetting the 8390 time=%ld...", jiffies);
 
 	outw(option_reg & ~(NICReset + ChipReset), ioaddr + HPP_OPTION);
 	/* Pause a few cycles for the hardware reset to take place. */
@@ -307,9 +309,9 @@
 
 
 	if ((inb_p(ioaddr+NIC_OFFSET+EN0_ISR) & ENISR_RESET) == 0)
-		printk("%s: hp_reset_8390() did not complete.\n", dev->name);
+		printk(KERN_WARNING "%s: hp_reset_8390() did not complete.\n", dev->name);
 
-	if (ei_debug > 1) printk("8390 reset done (%ld).", jiffies);
+	if (ei_debug > 1) printk(KERN_DEBUG "8390 reset done (%ld).", jiffies);
 	return;
 }
 

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-eth16i

diff -urN /mnt/disk/linux/drivers/net/eth16i.c /linux/drivers/net/eth16i.c
--- /mnt/disk/linux/drivers/net/eth16i.c	Thu Nov 16 22:57:20 2000
+++ /linux/drivers/net/eth16i.c	Sun Nov 19 22:09:20 2000
@@ -486,7 +486,7 @@
 		if(eth16i_portlist[(inb(ioaddr + JUMPERLESS_CONFIG) & 0x07)] 
 		   != ioaddr) {
 			retval = -ENODEV;
-			goto out;
+			goto err_out;
 		}
 	}
 
@@ -494,7 +494,7 @@
 
 	if(eth16i_check_signature(ioaddr) != 0) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	/* 
@@ -522,7 +522,7 @@
 	if ((retval = request_irq(dev->irq, (void *)&eth16i_interrupt, 0, dev->name, dev))) {
 		printk(KERN_WARNING "%s: %s at %#3x, but is unusable due conflicting IRQ %d.\n", 
 		       dev->name, cardname, ioaddr, dev->irq);
-		goto out;
+		goto err_out;
 	}
 
 	printk(KERN_INFO "%s: %s at %#3x, IRQ %d, ",
@@ -544,7 +544,7 @@
 		if(dev->priv == NULL) {
 			free_irq(dev->irq, dev);
 			retval = -ENOMEM;
-			goto out;
+			goto err_out;
 		}
 	}
 
@@ -566,7 +566,8 @@
 	boot = 0;
 
 	return 0;
-out:
+
+err_out:
 	release_region(ioaddr, ETH16I_IO_EXTENT);
 	return retval;
 }
@@ -858,7 +859,7 @@
 		creg[i] = inb(ioaddr + TRANSMIT_MODE_REG + i);
 
 		if(eth16i_debug > 1)
-			printk("eth16i: read signature byte %x at %x\n", 
+			printk(KERN_DEBUG "eth16i: read signature byte %x at %x\n", 
 			       creg[i],
 			       ioaddr + TRANSMIT_MODE_REG + i);
 	}

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c503

diff -urN /mnt/disk/linux/drivers/net/3c503.c /linux/drivers/net/3c503.c
--- /mnt/disk/linux/drivers/net/3c503.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/3c503.c	Sun Nov 19 23:03:21 2000
@@ -150,7 +150,7 @@
     if (inb(ioaddr + 0x408) == 0xff) {
     	mdelay(1);
 	retval = -ENODEV;
-	goto out;
+	goto err_out;
     }
 
     /* We verify that it's a 3C503 board by checking the first three octets
@@ -161,7 +161,7 @@
     if (   (iobase_reg  & (iobase_reg - 1))
 	|| (membase_reg & (membase_reg - 1))) {
 	retval = -ENODEV;
-	goto out;
+	goto err_out;
     }
     saved_406 = inb_p(ioaddr + 0x406);
     outb_p(ECNTRL_RESET|ECNTRL_THIN, ioaddr + 0x406); /* Reset it... */
@@ -174,21 +174,21 @@
 	/* Restore the register we frobbed. */
 	outb(saved_406, ioaddr + 0x406);
 	retval = -ENODEV;
-	goto out;
+	goto err_out;
     }
 
     if (ei_debug  &&  version_printed++ == 0)
-	printk(version);
+	printk(KERN_INFO "%s", version);
 
     dev->base_addr = ioaddr;
     /* Allocate dev->priv and fill in 8390 specific dev fields. */
     if (ethdev_init(dev)) {
-	printk ("3c503: unable to allocate memory for dev->priv.\n");
+	printk (KERN_ERR "3c503: unable to allocate memory for dev->priv.\n");
 	retval = -ENOMEM;
-	goto out;
+	goto err_out;
     }
 
-    printk("%s: 3c503 at i/o base %#3x, node ", dev->name, ioaddr);
+    printk(KERN_INFO "%s: 3c503 at i/o base %#3x, node ", dev->name, ioaddr);
 
     /* Retrieve and print the ethernet address. */
     for (i = 0; i < 6; i++)
@@ -239,7 +239,7 @@
 		isa_writel(test_val, mem_base + i);
 		if (isa_readl(mem_base) != 0xba5eba5e
 		    || isa_readl(mem_base + i) != test_val) {
-		    printk("3c503: memory failure or memory address conflict.\n");
+		    printk(KERN_ERR "3c503: memory failure or memory address conflict.\n");
 		    dev->mem_start = 0;
 		    ei_status.name = "3c503-PIO";
 		    break;
@@ -288,7 +288,7 @@
     if (dev->irq == 2)
 	dev->irq = 9;
     else if (dev->irq > 5 && dev->irq != 9) {
-	printk("3c503: configured interrupt %d invalid, will use autoIRQ.\n",
+	printk(KERN_WARNING "3c503: configured interrupt %d invalid, will use autoIRQ.\n",
 	       dev->irq);
 	dev->irq = 0;
     }
@@ -299,7 +299,7 @@
     dev->stop = &el2_close;
 
     if (dev->mem_start)
-	printk("%s: %s - %dkB RAM, 8kB shared mem window at %#6lx-%#6lx.\n",
+	printk(	KERN_INFO "%s: %s - %dkB RAM, 8kB shared mem window at %#6lx-%#6lx.\n",
 		dev->name, ei_status.name, (wordlength+1)<<3,
 		dev->mem_start, dev->mem_end-1);
 
@@ -307,11 +307,12 @@
     {
 	ei_status.tx_start_page = EL2_MB1_START_PG;
 	ei_status.rx_start_page = EL2_MB1_START_PG + TX_PAGES;
-	printk("\n%s: %s, %dkB RAM, using programmed I/O (REJUMPER for SHARED MEMORY).\n",
-	       dev->name, ei_status.name, (wordlength+1)<<3);
+	printk(	KERN_ERR "\n%s: %s, %dkB RAM, using programmed I/O (REJUMPER for SHARED MEMORY).\n",
+		dev->name, ei_status.name, (wordlength+1)<<3);
     }
     return 0;
-out:
+
+err_out:
     release_region(ioaddr, EL2_IO_EXTENT);
     return retval;
 }
@@ -319,6 +320,7 @@
 static int
 el2_open(struct net_device *dev)
 {
+    int retval;
 
     if (dev->irq < 2) {
 	int irqlist[] = {5, 9, 3, 4, 0};
@@ -332,7 +334,7 @@
 		outb_p(0x04 << ((*irqp == 9) ? 2 : *irqp), E33G_IDCFR);
 		outb_p(0x00, E33G_IDCFR);
 		if (*irqp == probe_irq_off(cookie)	 /* It's a good IRQ line! */
-		    && request_irq (dev->irq = *irqp, ei_interrupt, 0, ei_status.name, dev) == 0)
+		    && request_irq (dev->irq = *irqp, ei_interrupt, 0, dev->name, dev) == 0)
 		    break;
 	    }
 	} while (*++irqp);
@@ -341,8 +343,8 @@
 	    return -EAGAIN;
 	}
     } else {
-	if (request_irq(dev->irq, ei_interrupt, 0, ei_status.name, dev)) {
-	    return -EAGAIN;
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
+	    return retval;
 	}
     }
 
@@ -370,7 +372,7 @@
 el2_reset_8390(struct net_device *dev)
 {
     if (ei_debug > 1) {
-	printk("%s: Resetting the 3c503 board...", dev->name);
+	printk(KERN_DEBUG "%s: Resetting the 3c503 board...", dev->name);
 	printk("%#lx=%#02x %#lx=%#02x %#lx=%#02x...", E33G_IDCFR, inb(E33G_IDCFR),
 	       E33G_CNTRL, inb(E33G_CNTRL), E33G_GACFR, inb(E33G_GACFR));
     }
@@ -464,7 +466,7 @@
         {
             if(!boguscount--)
             {
-                printk("%s: FIFO blocked in el2_block_output.\n", dev->name);
+                printk(KERN_WARNING "%s: FIFO blocked in el2_block_output.\n", dev->name);
                 el2_reset_8390(dev);
                 goto blocked;
             }
@@ -514,7 +516,7 @@
     {
         if(!boguscount--)
         {
-            printk("%s: FIFO blocked in el2_get_8390_hdr.\n", dev->name);
+            printk(KERN_WARNING "%s: FIFO blocked in el2_get_8390_hdr.\n", dev->name);
             memset(hdr, 0x00, sizeof(struct e8390_pkt_hdr));
             el2_reset_8390(dev);
             goto blocked;
@@ -580,7 +582,7 @@
         {
             if(!boguscount--)
             {
-                printk("%s: FIFO blocked in el2_block_input.\n", dev->name);
+                printk(KERN_WARNING "%s: FIFO blocked in el2_block_input.\n", dev->name);
                 el2_reset_8390(dev);
                 goto blocked;
             }

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c505

diff -urN /mnt/disk/linux/drivers/net/3c505.c /linux/drivers/net/3c505.c
--- /mnt/disk/linux/drivers/net/3c505.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/3c505.c	Sun Nov 19 23:37:22 2000
@@ -121,16 +121,16 @@
 
 static const char *filename = __FILE__;
 
-static const char *timeout_msg = "*** timeout at %s:%s (line %d) ***\n";
+static const char *timeout_msg = KERN_ERR "*** timeout at %s:%s (line %d) ***\n";
 #define TIMEOUT_MSG(lineno) \
 	printk(timeout_msg, filename,__FUNCTION__,(lineno))
 
 static const char *invalid_pcb_msg =
-"*** invalid pcb length %d at %s:%s (line %d) ***\n";
+KERN_ERR "*** invalid pcb length %d at %s:%s (line %d) ***\n";
 #define INVALID_PCB_MSG(len) \
 	printk(invalid_pcb_msg, (len),filename,__FUNCTION__,__LINE__)
 
-static char search_msg[] __initdata = "%s: Looking for 3c505 adapter at address %#x...";
+static char search_msg[] __initdata = KERN_INFO"%s: Looking for 3c505 adapter at address %#x...";
 
 static char stilllooking_msg[] __initdata = "still looking...";
 
@@ -138,7 +138,7 @@
 
 static char notfound_msg[] __initdata = "not found (reason = %d)\n";
 
-static char couldnot_msg[] __initdata = "%s: 3c505 not found\n";
+static char couldnot_msg[] __initdata = KERN_INFO"%s: 3c505 not found\n";
 
 /*********************************************************
  *
@@ -303,7 +303,7 @@
 
 	outb_control(orig_hcr, dev);
 	if (!start_receive(dev, &adapter->tx_pcb))
-		printk("%s: start receive command failed \n", dev->name);
+		printk(KERN_ERR "%s: start receive command failed \n", dev->name);
 }
 
 /* Check to make sure that a DMA transfer hasn't timed out.  This should
@@ -315,7 +315,9 @@
 	elp_device *adapter = dev->priv;
 	if (adapter->dmaing && time_after(jiffies, adapter->current_dma.start_time + 10)) {
 		unsigned long flags, f;
-		printk("%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
+		printk(	KERN_ERR "%s: DMA %s timed out, %d bytes left\n",
+			dev->name, adapter->current_dma.direction ? "download" : "upload",
+			get_dma_residue(dev->dma));
 		save_flags(flags);
 		cli();
 		adapter->dmaing = 0;
@@ -341,7 +343,7 @@
 		if (inb_status(base_addr) & HCRE)
 			return FALSE;
 	}
-	printk("3c505: send_pcb_slow timed out\n");
+	printk(KERN_ERR "3c505: send_pcb_slow timed out\n");
 	return TRUE;
 }
 
@@ -353,7 +355,7 @@
 		if (inb_status(base_addr) & HCRE)
 			return FALSE;
 	}
-	printk("3c505: send_pcb_fast timed out\n");
+	printk(KERN_ERR "3c505: send_pcb_fast timed out\n");
 	return TRUE;
 }
 
@@ -405,7 +407,7 @@
 	/* Avoid contention */
 	if (test_and_set_bit(1, &adapter->send_pcb_semaphore)) {
 		if (elp_debug >= 3) {
-			printk("%s: send_pcb entered while threaded\n", dev->name);
+			printk(KERN_DEBUG "%s: send_pcb entered while threaded\n", dev->name);
 		}
 		return FALSE;
 	}
@@ -451,7 +453,7 @@
 	}
 
 	if (elp_debug >= 1)
-		printk("%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
+		printk(KERN_DEBUG "%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
 
       sti_abort:
 	sti();
@@ -499,7 +501,7 @@
 	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 && time_before(jiffies, timeout));
 	if (time_after_eq(jiffies, timeout)) {
 		TIMEOUT_MSG(__LINE__);
-		printk("%s: status %02x\n", dev->name, stat);
+		printk(KERN_DEBUG "%s: status %02x\n", dev->name, stat);
 		return FALSE;
 	}
 	pcb->length = inb_command(dev->base_addr);
@@ -530,7 +532,7 @@
 	/* safety check total length vs data length */
 	if (total_length != (pcb->length + 2)) {
 		if (elp_debug >= 2)
-			printk("%s: mangled PCB received\n", dev->name);
+			printk(KERN_DEBUG "%s: mangled PCB received\n", dev->name);
 		set_hsf(dev, HSF_PCB_NAK);
 		return FALSE;
 	}
@@ -539,7 +541,7 @@
 		if (test_and_set_bit(0, (void *) &adapter->busy)) {
 			if (backlog_next(adapter->rx_backlog.in) == adapter->rx_backlog.out) {
 				set_hsf(dev, HSF_PCB_NAK);
-				printk("%s: PCB rejected, transfer in progress and backlog full\n", dev->name);
+				printk(KERN_DEBUG "%s: PCB rejected, transfer in progress and backlog full\n", dev->name);
 				pcb->command = 0;
 				return TRUE;
 			} else {
@@ -564,7 +566,7 @@
 	elp_device *adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: restarting receiver\n", dev->name);
+		printk(KERN_DEBUG "%s: restarting receiver\n", dev->name);
 	tx_pcb->command = CMD_RECEIVE_PACKET;
 	tx_pcb->length = sizeof(struct Rcv_pkt);
 	tx_pcb->data.rcv_pkt.buf_seg
@@ -598,7 +600,7 @@
 	skb = dev_alloc_skb(rlen + 2);
 
 	if (!skb) {
-		printk("%s: memory squeeze, dropping packet\n", dev->name);
+		printk(KERN_WARNING "%s: memory squeeze, dropping packet\n", dev->name);
 		target = adapter->dma_buffer;
 		adapter->current_dma.target = NULL;
 	} else {
@@ -614,7 +616,7 @@
 
 	/* if this happens, we die */
 	if (test_and_set_bit(0, (void *) &adapter->dmaing))
-		printk("%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);
+		printk(KERN_ERR "%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);
 
 	skb->dev = dev;
 	adapter->current_dma.direction = 0;
@@ -634,14 +636,14 @@
 	release_dma_lock(flags);
 
 	if (elp_debug >= 3) {
-		printk("%s: rx DMA transfer started\n", dev->name);
+		printk(KERN_DEBUG "%s: rx DMA transfer started\n", dev->name);
 	}
 
 	if (adapter->rx_active)
 		adapter->rx_active--;
 
 	if (!adapter->busy)
-		printk("%s: receive_packet called, busy not set.\n", dev->name);
+		printk(KERN_DEBUG "%s: receive_packet called, busy not set.\n", dev->name);
 }
 
 /******************************************************
@@ -670,10 +672,12 @@
 		 */
 		if (inb_status(dev->base_addr) & DONE) {
 			if (!adapter->dmaing) {
-				printk("%s: phantom DMA completed\n", dev->name);
+				printk(KERN_DEBUG "%s: phantom DMA completed\n", dev->name);
 			}
 			if (elp_debug >= 3) {
-				printk("%s: %s DMA complete, status %02x\n", dev->name, adapter->current_dma.direction ? "tx" : "rx", inb_status(dev->base_addr));
+				printk(	KERN_DEBUG "%s: %s DMA complete, status %02x\n", 
+					dev->name, adapter->current_dma.direction ? "tx" : "rx", 
+					inb_status(dev->base_addr));
 			}
 
 			outb_control(adapter->hcr_val & ~(DMAE | TCEN | DIR), dev);
@@ -696,7 +700,7 @@
 				int t = adapter->rx_backlog.length[adapter->rx_backlog.out];
 				adapter->rx_backlog.out = backlog_next(adapter->rx_backlog.out);
 				if (elp_debug >= 2)
-					printk("%s: receiving backlogged packet (%d)\n", dev->name, t);
+					printk(KERN_DEBUG "%s: receiving backlogged packet (%d)\n", dev->name, t);
 				receive_packet(dev, t);
 			} else {
 				adapter->busy = 0;
@@ -730,18 +734,18 @@
 						printk(KERN_ERR "%s: interrupt - packet not received correctly\n", dev->name);
 					} else {
 						if (elp_debug >= 3) {
-							printk("%s: interrupt - packet received of length %i (%i)\n", dev->name, len, dlen);
+							printk(KERN_DEBUG "%s: interrupt - packet received of length %i (%i)\n", dev->name, len, dlen);
 						}
 						if (adapter->irx_pcb.command == 0xff) {
 							if (elp_debug >= 2)
-								printk("%s: adding packet to backlog (len = %d)\n", dev->name, dlen);
+								printk(KERN_DEBUG "%s: adding packet to backlog (len = %d)\n", dev->name, dlen);
 							adapter->rx_backlog.length[adapter->rx_backlog.in] = dlen;
 							adapter->rx_backlog.in = backlog_next(adapter->rx_backlog.in);
 						} else {
 							receive_packet(dev, dlen);
 						}
 						if (elp_debug >= 3)
-							printk("%s: packet received\n", dev->name);
+							printk(KERN_DEBUG "%s: packet received\n", dev->name);
 					}
 					break;
 
@@ -751,7 +755,7 @@
 				case CMD_CONFIGURE_82586_RESPONSE:
 					adapter->got[CMD_CONFIGURE_82586] = 1;
 					if (elp_debug >= 3)
-						printk("%s: interrupt - configure response received\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - configure response received\n", dev->name);
 					break;
 
 					/*
@@ -760,7 +764,7 @@
 				case CMD_CONFIGURE_ADAPTER_RESPONSE:
 					adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Adapter memory configuration %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Adapter memory configuration %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -770,7 +774,7 @@
 				case CMD_LOAD_MULTICAST_RESPONSE:
 					adapter->got[CMD_LOAD_MULTICAST_LIST] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Multicast address list loading %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Multicast address list loading %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -780,7 +784,7 @@
 				case CMD_SET_ADDRESS_RESPONSE:
 					adapter->got[CMD_SET_STATION_ADDRESS] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Ethernet address setting %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Ethernet address setting %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -797,7 +801,7 @@
 					adapter->stats.rx_over_errors += adapter->irx_pcb.data.netstat.err_res;
 					adapter->got[CMD_NETWORK_STATISTICS] = 1;
 					if (elp_debug >= 3)
-						printk("%s: interrupt - statistics response received\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - statistics response received\n", dev->name);
 					break;
 
 					/*
@@ -805,7 +809,7 @@
 					 */
 				case CMD_TRANSMIT_PACKET_COMPLETE:
 					if (elp_debug >= 3)
-						printk("%s: interrupt - packet sent\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - packet sent\n", dev->name);
 					if (!netif_running(dev))
 						break;
 					switch (adapter->irx_pcb.data.xmit_resp.c_stat) {
@@ -829,7 +833,7 @@
 					break;
 				}
 			} else {
-				printk("%s: failed to read PCB on interrupt\n", dev->name);
+				printk(KERN_ERR "%s: failed to read PCB on interrupt\n", dev->name);
 				adapter_reset(dev);
 			}
 		}
@@ -859,13 +863,13 @@
 	adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request to open device\n", dev->name);
+		printk(KERN_DEBUG "%s: request to open device\n", dev->name);
 
 	/*
 	 * make sure we actually found the device
 	 */
 	if (adapter == NULL) {
-		printk("%s: Opening a non-existent physical device\n", dev->name);
+		printk(KERN_ERR "%s: Opening a non-existent physical device\n", dev->name);
 		return -EAGAIN;
 	}
 	/*
@@ -932,7 +936,7 @@
 	adapter->tx_pcb.length = sizeof(struct Memconf);
 	adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send memory configuration command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send memory configuration command\n", dev->name);
 	else {
 		int timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] == 0 && time_before(jiffies, timeout));
@@ -945,13 +949,13 @@
 	 * configure adapter to receive broadcast messages and wait for response
 	 */
 	if (elp_debug >= 3)
-		printk("%s: sending 82586 configure command\n", dev->name);
+		printk(KERN_DEBUG "%s: sending 82586 configure command\n", dev->name);
 	adapter->tx_pcb.command = CMD_CONFIGURE_82586;
 	adapter->tx_pcb.data.configure = NO_LOOPBACK | RECV_BROAD;
 	adapter->tx_pcb.length = 2;
 	adapter->got[CMD_CONFIGURE_82586] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send 82586 configure command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send 82586 configure command\n", dev->name);
 	else {
 		int timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_CONFIGURE_82586] == 0 && time_before(jiffies, timeout));
@@ -967,7 +971,7 @@
 	 */
 	prime_rx(dev);
 	if (elp_debug >= 3)
-		printk("%s: %d receive PCBs active\n", dev->name, adapter->rx_active);
+		printk(KERN_ERR "%s: %d receive PCBs active\n", dev->name, adapter->rx_active);
 
 	/*
 	 * device is now officially open!
@@ -997,7 +1001,7 @@
 
 	if (test_and_set_bit(0, (void *) &adapter->busy)) {
 		if (elp_debug >= 2)
-			printk("%s: transmit blocked\n", dev->name);
+			printk(KERN_DEBUG "%s: transmit blocked\n", dev->name);
 		return FALSE;
 	}
 
@@ -1019,7 +1023,7 @@
 	}
 	/* if this happens, we die */
 	if (test_and_set_bit(0, (void *) &adapter->dmaing))
-		printk("%s: tx: DMA %d in progress\n", dev->name, adapter->current_dma.direction);
+		printk(KERN_ERR "%s: tx: DMA %d in progress\n", dev->name, adapter->current_dma.direction);
 
 	adapter->current_dma.direction = 1;
 	adapter->current_dma.start_time = jiffies;
@@ -1042,7 +1046,7 @@
 	release_dma_lock(flags);
 	
 	if (elp_debug >= 3)
-		printk("%s: DMA transfer started\n", dev->name);
+		printk(KERN_DEBUG "%s: DMA transfer started\n", dev->name);
 
 	return TRUE;
 }
@@ -1059,7 +1063,7 @@
 	stat = inb_status(dev->base_addr);
 	printk(KERN_WARNING "%s: transmit timed out, lost %s?\n", dev->name, (stat & ACRF) ? "interrupt" : "command");
 	if (elp_debug >= 1)
-		printk("%s: status %#02x\n", dev->name, stat);
+		printk(KERN_DEBUG "%s: status %#02x\n", dev->name, stat);
 	dev->trans_start = jiffies;
 	adapter->stats.tx_dropped++;
 	netif_wake_queue(dev);
@@ -1081,7 +1085,7 @@
 	check_3c505_dma(dev);
 
 	if (elp_debug >= 3)
-		printk("%s: request to send packet of length %d\n", dev->name, (int) skb->len);
+		printk(KERN_DEBUG "%s: request to send packet of length %d\n", dev->name, (int) skb->len);
 
 	netif_stop_queue(dev);
 	
@@ -1090,13 +1094,13 @@
 	 */
 	if (!send_packet(dev, skb)) {
 		if (elp_debug >= 2) {
-			printk("%s: failed to transmit packet\n", dev->name);
+			printk(KERN_DEBUG "%s: failed to transmit packet\n", dev->name);
 		}
 		spin_unlock_irqrestore(&adapter->lock, flags);
 		return 1;
 	}
 	if (elp_debug >= 3)
-		printk("%s: packet of length %d sent\n", dev->name, (int) skb->len);
+		printk(KERN_DEBUG "%s: packet of length %d sent\n", dev->name, (int) skb->len);
 
 	/*
 	 * start the transmit timeout
@@ -1120,7 +1124,7 @@
 	elp_device *adapter = (elp_device *) dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request for stats\n", dev->name);
+		printk(KERN_DEBUG "%s: request for stats\n", dev->name);
 
 	/* If the device is closed, just return the latest stats we have,
 	   - we cannot ask from the adapter without interrupts */
@@ -1132,7 +1136,7 @@
 	adapter->tx_pcb.length = 0;
 	adapter->got[CMD_NETWORK_STATISTICS] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send get statistics command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send get statistics command\n", dev->name);
 	else {
 		int timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_NETWORK_STATISTICS] == 0 && time_before(jiffies, timeout));
@@ -1159,7 +1163,7 @@
 	adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request to close device\n", dev->name);
+		printk(KERN_DEBUG "%s: request to close device\n", dev->name);
 
 	netif_stop_queue(dev);
 
@@ -1203,7 +1207,7 @@
 	unsigned long flags;
 
 	if (elp_debug >= 3)
-		printk("%s: request to set multicast list\n", dev->name);
+		printk(KERN_DEBUG "%s: request to set multicast list\n", dev->name);
 
 	spin_lock_irqsave(&adapter->lock, flags);
 	
@@ -1218,7 +1222,7 @@
 		}
 		adapter->got[CMD_LOAD_MULTICAST_LIST] = 0;
 		if (!send_pcb(dev, &adapter->tx_pcb))
-			printk("%s: couldn't send set_multicast command\n", dev->name);
+			printk(KERN_ERR "%s: couldn't send set_multicast command\n", dev->name);
 		else {
 			int timeout = jiffies + TIMEOUT;
 			while (adapter->got[CMD_LOAD_MULTICAST_LIST] == 0 && time_before(jiffies, timeout));
@@ -1237,14 +1241,14 @@
 	 * and wait for response
 	 */
 	if (elp_debug >= 3)
-		printk("%s: sending 82586 configure command\n", dev->name);
+		printk(KERN_DEBUG "%s: sending 82586 configure command\n", dev->name);
 	adapter->tx_pcb.command = CMD_CONFIGURE_82586;
 	adapter->tx_pcb.length = 2;
 	adapter->got[CMD_CONFIGURE_82586] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
 	{
 		spin_unlock_irqrestore(&adapter->lock, flags);
-		printk("%s: couldn't send 82586 configure command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send 82586 configure command\n", dev->name);
 	}
 	else {
 		int timeout = jiffies + TIMEOUT;
@@ -1431,7 +1435,7 @@
 	 */
 	adapter = (elp_device *) (dev->priv = kmalloc(sizeof(elp_device), GFP_KERNEL));
 	if (adapter == NULL) {
-		printk("%s: out of memory\n", dev->name);
+		printk(KERN_ERR "%s: out of memory\n", dev->name);
 		return -ENODEV;
         }
 
@@ -1456,7 +1460,7 @@
 			/* Nope, it's ignoring the command register.  This means that
 			 * either it's still booting up, or it's died.
 			 */
-			printk("%s: command register wouldn't drain, ", dev->name);
+			printk(KERN_WARNING "%s: command register wouldn't drain, ", dev->name);
 			if ((inb_status(dev->base_addr) & 7) == 3) {
 				/* If the adapter status is 3, it *could* still be booting.
 				 * Give it the benefit of the doubt for 10 seconds.
@@ -1465,7 +1469,7 @@
 				timeout = jiffies + 10*HZ;
 				while (time_before(jiffies, timeout) && (inb_status(dev->base_addr) & 7));
 				if (inb_status(dev->base_addr) & 7) {
-					printk("%s: 3c505 failed to start\n", dev->name);
+					printk(KERN_ERR "%s: 3c505 failed to start\n", dev->name);
 				} else {
 					okay = 1;  /* It started */
 				}
@@ -1473,7 +1477,7 @@
 				/* Otherwise, it must just be in a strange
 				 * state.  We probably need to kick it.
 				 */
-				printk("3c505 is sulking\n");
+				printk(KERN_WARNING "3c505 is sulking\n");
 			}
 		}
 		for (tries = 0; tries < 5 && okay; tries++) {
@@ -1486,18 +1490,18 @@
 			adapter->tx_pcb.length = 0;
 			cookie = probe_irq_on();
 			if (!send_pcb(dev, &adapter->tx_pcb)) {
-				printk("%s: could not send first PCB\n", dev->name);
+				printk(KERN_ERR "%s: could not send first PCB\n", dev->name);
 				probe_irq_off(cookie);
 				continue;
 			}
 			if (!receive_pcb(dev, &adapter->rx_pcb)) {
-				printk("%s: could not read first PCB\n", dev->name);
+				printk(KERN_ERR "%s: could not read first PCB\n", dev->name);
 				probe_irq_off(cookie);
 				continue;
 			}
 			if ((adapter->rx_pcb.command != CMD_ADDRESS_RESPONSE) ||
 			    (adapter->rx_pcb.length != 6)) {
-				printk("%s: first PCB wrong (%d, %d)\n", dev->name, adapter->rx_pcb.command, adapter->rx_pcb.length);
+				printk(KERN_ERR "%s: first PCB wrong (%d, %d)\n", dev->name, adapter->rx_pcb.command, adapter->rx_pcb.length);
 				probe_irq_off(cookie);
 				continue;
 			}
@@ -1510,7 +1514,7 @@
 		outb_control(adapter->hcr_val | FLSH | ATTN, dev);
 		outb_control(adapter->hcr_val & ~(FLSH | ATTN), dev);
 	}
-	printk("%s: failed to initialise 3c505\n", dev->name);
+	printk(KERN_ERR "%s: failed to initialise 3c505\n", dev->name);
 	release_region(dev->base_addr, ELP_IO_EXTENT);
 	return -ENODEV;
 
@@ -1518,21 +1522,21 @@
 	if (dev->irq) {		/* Is there a preset IRQ? */
 		int rpt = probe_irq_off(cookie);
 		if (dev->irq != rpt) {
-			printk("%s: warning, irq %d configured but %d detected\n", dev->name, dev->irq, rpt);
+			printk(KERN_WARNING "%s: warning, irq %d configured but %d detected\n", dev->name, dev->irq, rpt);
 		}
 		/* if dev->irq == probe_irq_off(cookie), all is well */
 	} else		       /* No preset IRQ; just use what we can detect */
 		dev->irq = probe_irq_off(cookie);
 	switch (dev->irq) {    /* Legal, sane? */
 	case 0:
-		printk("%s: IRQ probe failed: check 3c505 jumpers.\n",
+		printk(KERN_ERR "%s: IRQ probe failed: check 3c505 jumpers.\n",
 		       dev->name);
 		return -ENODEV;
 	case 1:
 	case 6:
 	case 8:
 	case 13:
-		printk("%s: Impossible IRQ %d reported by probe_irq_off().\n",
+		printk(KERN_ERR "%s: Impossible IRQ %d reported by probe_irq_off().\n",
 		       dev->name, dev->irq);
 		return -ENODEV;
 	}
@@ -1562,7 +1566,7 @@
 	/*
 	 * print remainder of startup message
 	 */
-	printk("%s: 3c505 at %#lx, irq %d, dma %d, ",
+	printk(KERN_INFO "%s: 3c505 at %#lx, irq %d, dma %d, ",
 	       dev->name, dev->base_addr, dev->irq, dev->dma);
 	printk("addr %02x:%02x:%02x:%02x:%02x:%02x, ",
 	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
@@ -1597,10 +1601,10 @@
 	    !receive_pcb(dev, &adapter->rx_pcb) ||
 	    (adapter->rx_pcb.command != CMD_CONFIGURE_ADAPTER_RESPONSE) ||
 	    (adapter->rx_pcb.length != 2)) {
-		printk("%s: could not configure adapter memory\n", dev->name);
+		printk(KERN_WARNING "%s: could not configure adapter memory\n", dev->name);
 	}
 	if (adapter->rx_pcb.data.configure) {
-		printk("%s: adapter configuration failed\n", dev->name);
+		printk(KERN_WARNING "%s: adapter configuration failed\n", dev->name);
 	}
 
 	/*

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c507

diff -urN /mnt/disk/linux/drivers/net/3c507.c /linux/drivers/net/3c507.c
--- /mnt/disk/linux/drivers/net/3c507.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/3c507.c	Sun Nov 19 23:56:06 2000
@@ -323,8 +323,8 @@
 
 static int __init el16_probe1(struct net_device *dev, int ioaddr)
 {
-	static unsigned char init_ID_done = 0, version_printed = 0;
-	int i, irq, irqval, retval;
+	static unsigned char init_ID_done, version_printed;
+	int i, irq, retval;
 	struct net_local *lp;
 
 	if (init_ID_done == 0) {
@@ -342,29 +342,28 @@
 	}
 
 	if (!request_region(ioaddr, EL16_IO_EXTENT, dev->name))
-		return -ENODEV;
+		return -EBUSY;
 
 	if ((inb(ioaddr) != '*') || (inb(ioaddr + 1) != '3') || 
 	    (inb(ioaddr + 2) != 'C') || (inb(ioaddr + 3) != 'O')) {
 		retval = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	if (net_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
-	printk("%s: 3c507 at %#x,", dev->name, ioaddr);
+	printk(KERN_INFO "%s: 3c507 at %#x, ", dev->name, ioaddr);
 
 	/* We should make a few more checks here, like the first three octets of
 	   the S.A. for the manufacturer's code. */
 
 	irq = inb(ioaddr + IRQ_CONFIG) & 0x0f;
 
-	irqval = request_irq(irq, &el16_interrupt, 0, dev->name, dev);
-	if (irqval) {
-		printk ("unable to get IRQ %d (irqval=%d).\n", irq, irqval);
-		retval = -EAGAIN;
-		goto out;
+	retval = request_irq(irq, &el16_interrupt, 0, dev->name, dev);
+	if (retval) {
+		printk ("unable to get IRQ %d (irqval=%d).\n", irq, retval);
+		goto err_out;
 	}
 
 	/* We've committed to using the board, and can start filling in *dev. */
@@ -406,14 +405,11 @@
 	printk(", IRQ %d, %sternal xcvr, memory %#lx-%#lx.\n", dev->irq,
 		   dev->if_port ? "ex" : "in", dev->mem_start, dev->mem_end-1);
 
-	if (net_debug)
-		printk(version);
-
 	/* Initialize the device structure. */
 	lp = dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
 	if (dev->priv == NULL) {
 		retval = -ENOMEM;
-		goto out;
+		goto err_out;
 	}
 	memset(dev->priv, 0, sizeof(struct net_local));
 	spin_lock_init(&lp->lock);
@@ -430,7 +426,8 @@
 	dev->flags&=~IFF_MULTICAST;	/* Multicast doesn't work */
 
 	return 0;
-out:
+
+err_out:
 	release_region(ioaddr, EL16_IO_EXTENT);
 	return retval;
 }
@@ -452,19 +449,19 @@
 	unsigned long shmem = dev->mem_start;
 
 	if (net_debug > 1)
-		printk ("%s: transmit timed out, %s?  ", dev->name,
+		printk (KERN_DEBUG "%s: transmit timed out, %s?  ", dev->name,
 			isa_readw (shmem + iSCB_STATUS) & 0x8000 ? "IRQ conflict" :
 			"network cable problem");
 	/* Try to restart the adaptor. */
 	if (lp->last_restart == lp->stats.tx_packets) {
 		if (net_debug > 1)
-			printk ("Resetting board.\n");
+			printk (KERN_DEBUG "Resetting board.\n");
 		/* Completely reset the adaptor. */
 		init_82586_mem (dev);
 	} else {
 		/* Issue the channel attention signal and hope it "gets better". */
 		if (net_debug > 1)
-			printk ("Kicking board.\n");
+			printk (KERN_DEBUG "Kicking board.\n");
 		isa_writew (0xf000 | CUC_START | RX_START, shmem + iSCB_CMD);
 		outb (0, ioaddr + SIGNAL_CA);	/* Issue channel-attn. */
 		lp->last_restart = lp->stats.tx_packets;
@@ -516,7 +513,7 @@
 	unsigned long shmem;
 
 	if (dev == NULL) {
-		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
+		printk (KERN_ERR "net_interrupt(): irq %d for unknown device.\n", irq);
 		return;
 	}
 
@@ -529,7 +526,7 @@
 	status = isa_readw(shmem+iSCB_STATUS);
 
 	if (net_debug > 4) {
-		printk("%s: 3c507 interrupt, status %4.4x.\n", dev->name, status);
+		printk(KERN_DEBUG "%s: 3c507 interrupt, status %4.4x.\n", dev->name, status);
 	}
 
 	/* Disable the 82586's input to the interrupt line. */
@@ -540,7 +537,8 @@
 	  unsigned short tx_status = isa_readw(shmem+lp->tx_reap);
 
 	  if (tx_status == 0) {
-		if (net_debug > 5)  printk("Couldn't reap %#x.\n", lp->tx_reap);
+		if (net_debug > 5)
+			printk(KERN_DEBUG "Couldn't reap %#x.\n", lp->tx_reap);
 		break;
 	  }
 	  if (tx_status & 0x2000) {
@@ -555,7 +553,7 @@
 		if (tx_status & 0x0020)  lp->stats.tx_aborted_errors++;
 	  }
 	  if (net_debug > 5)
-		  printk("Reaped %x, Tx status %04x.\n" , lp->tx_reap, tx_status);
+		  printk(KERN_DEBUG "Reaped %x, Tx status %04x.\n" , lp->tx_reap, tx_status);
 	  lp->tx_reap += TX_BUF_SIZE;
 	  if (lp->tx_reap > RX_BUF_START - TX_BUF_SIZE)
 		lp->tx_reap = TX_BUF_START;
@@ -565,7 +563,7 @@
 
 	if (status & 0x4000) { /* Packet received. */
 		if (net_debug > 5)
-			printk("Received packet, rx_head %04x.\n", lp->rx_head);
+			printk(KERN_DEBUG "Received packet, rx_head %04x.\n", lp->rx_head);
 		el16_rx(dev);
 	}
 
@@ -574,7 +572,7 @@
 
 	if ((status & 0x0700) != 0x0200 && netif_running(dev)) {
 		if (net_debug)
-			printk("%s: Command unit stopped, status %04x, restarting.\n",
+			printk(KERN_DEBUG "%s: Command unit stopped, status %04x, restarting.\n",
 				   dev->name, status);
 		/* If this ever occurs we should really re-write the idle loop, reset
 		   the Tx list, and do a complete restart of the command unit.
@@ -587,7 +585,7 @@
 		/* The Rx unit is not ready, it must be hung.  Restart the receiver by
 		   initializing the rx buffers, and issuing an Rx start command. */
 		if (net_debug)
-			printk("%s: Rx unit stopped, status %04x, restarting.\n",
+			printk(KERN_DEBUG "%s: Rx unit stopped, status %04x, restarting.\n",
 				   dev->name, status);
 		init_rx_bufs(dev);
 		isa_writew(RX_BUF_START,shmem+iSCB_RFA);
@@ -722,7 +720,7 @@
 		int boguscnt = 50;
 		while (isa_readw(shmem+iSCB_STATUS) == 0)
 			if (--boguscnt == 0) {
-				printk("%s: i82586 initialization timed out with status %04x,"
+				printk(KERN_WARNING "%s: i82586 initialization timed out with status %04x,"
 					   "cmd %04x.\n", dev->name,
 					   isa_readw(shmem+iSCB_STATUS), isa_readw(shmem+iSCB_CMD));
 				break;
@@ -734,7 +732,7 @@
 	/* Disable loopback and enable interrupts. */
 	outb(0x84, ioaddr + MISC_CTRL);
 	if (net_debug > 4)
-		printk("%s: Initialized 82586, status %04x.\n", dev->name,
+		printk(KERN_DEBUG "%s: Initialized 82586, status %04x.\n", dev->name,
 			   isa_readw(shmem+iSCB_STATUS));
 	return;
 }
@@ -776,7 +774,7 @@
 		lp->tx_head = TX_BUF_START;
 
 	if (net_debug > 4) {
-		printk("%s: 3c507 @%x send length = %d, tx_block %3x, next %3x.\n",
+		printk(KERN_DEBUG "%s: 3c507 @%x send length = %d, tx_block %3x, next %3x.\n",
 			   dev->name, ioaddr, length, tx_block, lp->tx_head);
 	}
 
@@ -803,7 +801,7 @@
 
 		if (rfd_cmd != 0 || data_buffer_addr != rx_head + 22
 			|| (pkt_len & 0xC000) != 0xC000) {
-			printk("%s: Rx frame at %#x corrupted, status %04x cmd %04x"
+			printk(KERN_WARNING "%s: Rx frame at %#x corrupted, status %04x cmd %04x"
 				   "next %04x data-buf @%04x %04x.\n", dev->name, rx_head,
 				   frame_status, rfd_cmd, next_rx_frame, data_buffer_addr,
 				   pkt_len);
@@ -822,7 +820,7 @@
 			pkt_len &= 0x3fff;
 			skb = dev_alloc_skb(pkt_len+2);
 			if (skb == NULL) {
-				printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+				printk(KERN_WARNING "%s: Memory squeeze, dropping packet.\n", dev->name);
 				lp->stats.rx_dropped++;
 				break;
 			}
@@ -863,12 +861,12 @@
 int init_module(void)
 {
 	if (io == 0)
-		printk("3c507: You should not use auto-probing with insmod!\n");
+		printk(KERN_NOTICE "3c507: You should not use auto-probing with insmod!\n");
 	dev_3c507.base_addr = io;
 	dev_3c507.irq       = irq;
 	dev_3c507.init	    = el16_probe;
 	if (register_netdev(&dev_3c507) != 0) {
-		printk("3c507: register_netdev() returned non-zero.\n");
+		printk(KERN_ERR "3c507: register_netdev() returned non-zero.\n");
 		return -EIO;
 	}
 	return 0;

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-cs89x0

diff -urN /mnt/disk/linux/drivers/net/cs89x0.c /linux/drivers/net/cs89x0.c
--- /mnt/disk/linux/drivers/net/cs89x0.c	Thu Nov 16 22:57:20 2000
+++ /linux/drivers/net/cs89x0.c	Sun Nov 19 22:39:18 2000
@@ -260,7 +260,7 @@
 	SET_MODULE_OWNER(dev);
 
 	if (net_debug)
-		printk("cs89x0:cs89x0_probe()\n");
+		printk(KERN_DEBUG "cs89x0:cs89x0_probe()\n");
 
 	if (base_addr > 0x1ff)		/* Check a single specified location. */
 		return cs89x0_probe1(dev, base_addr);
@@ -319,7 +319,8 @@
 {
 	int i;
 
-	if (net_debug > 3) printk("EEPROM data from %x for %x:\n",off,len);
+	if (net_debug > 3)
+		printk(KERN_DEBUG "EEPROM data from %x for %x:\n",off,len);
 	for (i = 0; i < len; i++) {
 		if (wait_eeprom_ready(dev) < 0) return -1;
 		/* Now send the EEPROM read command and EEPROM location to read */
@@ -367,7 +368,7 @@
 		dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
 		if (dev->priv == 0) {
 			retval = -ENOMEM;
-			goto out;
+			goto err_out;
 		}
 		lp = (struct net_local *)dev->priv;
 		memset(lp, 0, sizeof(*lp));
@@ -385,7 +386,7 @@
 	/* Grab the region so we can find another board if autoIRQ fails. */
 	if (!request_region(ioaddr, NETCARD_IO_EXTENT, dev->name)) {
 		retval = -EBUSY;
-		goto out1;
+		goto err_out_kfree;
 	}
 
 	/* if they give us an odd I/O address, then do ONE write to
@@ -396,7 +397,7 @@
 	        if ((ioaddr & 2) != 2)
 	        	if ((inw((ioaddr & ~3)+ ADD_PORT) & ADD_MASK) != ADD_SIG) {
 		        	retval = -ENODEV;
-				goto out2;
+				goto err_out_release_region;
 			}
 		ioaddr &= ~3;
 		outw(PP_ChipID, ioaddr + ADD_PORT);
@@ -404,7 +405,7 @@
 
         if (inw(ioaddr + DATA_PORT) != CHIP_EISA_ID_SIG) {
   		retval = -ENODEV;
-  		goto out2;
+  		goto err_out_release_region;
 	}
 
 	/* Fill in the 'dev' fields. */
@@ -424,7 +425,7 @@
 		lp->send_cmd = TX_NOW;
 
 	if (net_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
 	printk(KERN_INFO "%s: cs89%c0%s rev %c found at %#3lx ",
 	       dev->name,
@@ -612,14 +613,15 @@
 
 	printk("\n");
 	if (net_debug)
-		printk("cs89x0_probe1() successful\n");
+		printk(KERN_DEBUG "cs89x0_probe1() successful\n");
 	return 0;
-out2:
+
+err_out_release_region:
 	release_region(ioaddr, NETCARD_IO_EXTENT);
-out1:
+err_out_kfree:
 	kfree(dev->priv);
 	dev->priv = 0;
-out:
+err_out:
 	return retval;
 }
 
@@ -675,17 +677,17 @@
 	if (lp->use_dma) {
 		if ((lp->isa_config & ANY_ISA_DMA) == 0) {
 			if (net_debug > 3)
-				printk("set_dma_cfg(): no DMA\n");
+				printk(KERN_DEBUG "set_dma_cfg(): no DMA\n");
 			return;
 		}
 		if (lp->isa_config & ISA_RxDMA) {
 			lp->curr_rx_cfg |= RX_DMA_ONLY;
 			if (net_debug > 3)
-				printk("set_dma_cfg(): RX_DMA_ONLY\n");
+				printk(KERN_DEBUG "set_dma_cfg(): RX_DMA_ONLY\n");
 		} else {
 			lp->curr_rx_cfg |= AUTO_RX_DMA;	/* not that we support it... */
 			if (net_debug > 3)
-				printk("set_dma_cfg(): AUTO_RX_DMA\n");
+				printk(KERN_DEBUG "set_dma_cfg(): AUTO_RX_DMA\n");
 		}
 	}
 }
@@ -729,7 +731,7 @@
 	length = bp[2] + (bp[3]<<8);
 	bp += 4;
 	if (net_debug > 5) {
-		printk(	"%s: receiving DMA packet at %lx, status %x, length %x\n",
+		printk( KERN_DEBUG "%s: receiving DMA packet at %lx, status %x, length %x\n",
 			dev->name, (unsigned long)bp, status, length);
 	}
 	if ((status & RX_OK) == 0) {
@@ -741,7 +743,7 @@
 	skb = dev_alloc_skb(length + 2);
 	if (skb == NULL) {
 		if (net_debug)	/* I don't think we want to do this to a stressed system */
-			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+			printk(KERN_DEBUG "%s: Memory squeeze, dropping packet.\n", dev->name);
 		lp->stats.rx_dropped++;
 
 		/* AKPM: advance bp to the next frame */
@@ -767,7 +769,7 @@
 	lp->rx_dma_ptr = bp;
 
 	if (net_debug > 3) {
-		printk(	"%s: received %d byte DMA packet of type %x\n",
+		printk(	KERN_DEBUG "%s: received %d byte DMA packet of type %x\n",
 			dev->name, length,
 			(skb->data[ETH_ALEN+ETH_ALEN] << 8) | skb->data[ETH_ALEN+ETH_ALEN+1]);
 	}
@@ -843,7 +845,7 @@
 	int timenow = jiffies;
 	int fdx;
 
-	if (net_debug > 1) printk("%s: Attempting TP\n", dev->name);
+	if (net_debug > 1) printk(KERN_DEBUG "%s: Attempting TP\n", dev->name);
 
         /* If connected to another full duplex capable 10-Base-T card the link pulses
            seem to be lost when the auto detect bit in the LineCTL is set.
@@ -938,7 +940,7 @@
 	/* Write the contents of the packet */
 	outsw(dev->base_addr + TX_FRAME_PORT,test_packet,(ETH_ZLEN+1) >>1);
 
-	if (net_debug > 1) printk("Sending test packet ");
+	if (net_debug > 1) printk(KERN_DEBUG "Sending test packet ");
 	/* wait a couple of jiffies for packet to be received */
 	for (timenow = jiffies; jiffies - timenow < 3; )
                 ;
@@ -956,7 +958,8 @@
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
 
-	if (net_debug > 1) printk("%s: Attempting AUI\n", dev->name);
+	if (net_debug > 1)
+		printk(KERN_DEBUG "%s: Attempting AUI\n", dev->name);
 	control_dc_dc(dev, 0);
 
 	writereg(dev, PP_LineCTL, (lp->linectl &~ AUTO_AUI_10BASET) | AUI_ONLY);
@@ -972,7 +975,8 @@
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
 
-	if (net_debug > 1) printk("%s: Attempting BNC\n", dev->name);
+	if (net_debug > 1)
+		printk(KERN_DEBUG "%s: Attempting BNC\n", dev->name);
 	control_dc_dc(dev, 1);
 
 	writereg(dev, PP_LineCTL, (lp->linectl &~ AUTO_AUI_10BASET) | AUI_ONLY);
@@ -1081,7 +1085,7 @@
 				goto release_irq;
 			}
 			if (net_debug > 1) {
-				printk(	"%s: dma %lx %lx\n",
+				printk(	KERN_DEBUG "%s: dma %lx %lx\n",
 					dev->name,
 					(unsigned long)lp->dma_buff,
 					(unsigned long)virt_to_bus(lp->dma_buff));
@@ -1235,7 +1239,7 @@
                  );
         netif_start_queue(dev);
 	if (net_debug > 1)
-		printk("cs89x0: net_open() succeeded\n");
+		printk(KERN_DEBUG "cs89x0: net_open() succeeded\n");
 	return 0;
 bad_out:
 	return ret;
@@ -1245,7 +1249,7 @@
 {
 	/* If we get here, some higher level has decided we are broken.
 	   There should really be a "kick me" function call instead. */
-	if (net_debug > 0) printk("%s: transmit timed out, %s?\n", dev->name,
+	if (net_debug > 0) printk(KERN_DEBUG "%s: transmit timed out, %s?\n", dev->name,
 		   tx_done(dev) ? "IRQ conflict ?" : "network cable problem");
 	/* Try to restart the adaptor. */
 	netif_wake_queue(dev);
@@ -1256,7 +1260,7 @@
 	struct net_local *lp = (struct net_local *)dev->priv;
 
 	if (net_debug > 3) {
-		printk("%s: sent %d byte packet of type %x\n",
+		printk(	KERN_DEBUG "%s: sent %d byte packet of type %x\n",
 			dev->name, skb->len,
 			(skb->data[ETH_ALEN+ETH_ALEN] << 8) | skb->data[ETH_ALEN+ETH_ALEN+1]);
 	}
@@ -1280,7 +1284,8 @@
 		 */
 		
 		spin_unlock_irq(&lp->lock);
-		if (net_debug) printk("cs89x0: Tx buffer not free!\n");
+		if (net_debug)
+			printk(KERN_DEBUG "cs89x0: Tx buffer not free!\n");
 		return 1;
 	}
 	/* Write the contents of the packet */
@@ -1323,7 +1328,8 @@
            faster than you can read them off, you're screwed.  Hasta la
            vista, baby!  */
 	while ((status = readword(dev, ISQ_PORT))) {
-		if (net_debug > 4)printk("%s: event=%04x\n", dev->name, status);
+		if (net_debug > 4) 
+			printk(KERN_DEBUG "%s: event=%04x\n", dev->name, status);
 		switch(status & ISQ_EVENT_MASK) {
 		case ISQ_RECEIVER_EVENT:
 			/* Got a packet(s). */
@@ -1354,7 +1360,8 @@
 				netif_wake_queue(dev);	/* Inform upper layers. */
 			}
 			if (status & TX_UNDERRUN) {
-				if (net_debug > 0) printk("%s: transmit underrun\n", dev->name);
+				if (net_debug > 0) 
+					printk(KERN_DEBUG "%s: transmit underrun\n", dev->name);
                                 lp->send_underrun++;
                                 if (lp->send_underrun == 3) lp->send_cmd = TX_AFTER_381;
                                 else if (lp->send_underrun == 6) lp->send_cmd = TX_AFTER_ALL;
@@ -1370,14 +1377,14 @@
 				int count = readreg(dev, PP_DmaFrameCnt);
 				while(count) {
 					if (net_debug > 5)
-						printk("%s: receiving %d DMA frames\n", dev->name, count);
+						printk(KERN_DEBUG "%s: receiving %d DMA frames\n", dev->name, count);
 					if (net_debug > 2 && count >1)
-						printk("%s: receiving %d DMA frames\n", dev->name, count);
+						printk(KERN_DEBUG "%s: receiving %d DMA frames\n", dev->name, count);
 					dma_rx(dev);
 					if (--count == 0)
 						count = readreg(dev, PP_DmaFrameCnt);
 					if (net_debug > 2 && count > 0)
-						printk("%s: continuing with %d DMA frames\n", dev->name, count);
+						printk(KERN_DEBUG "%s: continuing with %d DMA frames\n", dev->name, count);
 				}
 			}
 #endif
@@ -1439,7 +1446,7 @@
 		skb->data[length-1] = inw(ioaddr + RX_FRAME_PORT);
 
 	if (net_debug > 3) {
-		printk(	"%s: received %d byte packet of type %x\n",
+		printk(	KERN_DEBUG "%s: received %d byte packet of type %x\n",
 			dev->name, length,
 			(skb->data[ETH_ALEN+ETH_ALEN] << 8) | skb->data[ETH_ALEN+ETH_ALEN+1]);
 	}
@@ -1539,7 +1546,7 @@
 	if (netif_running(dev))
 		return -EBUSY;
 	if (net_debug) {
-		printk("%s: Setting MAC address to ", dev->name);
+		printk(KERN_DEBUG "%s: Setting MAC address to ", dev->name);
 		for (i = 0; i < 6; i++)
 			printk(" %2.2x", dev->dev_addr[i] = ((unsigned char *)addr)[i]);
 		printk(".\n");

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-wd

diff -urN /mnt/disk/linux/drivers/net/wd.c /linux/drivers/net/wd.c
--- /mnt/disk/linux/drivers/net/wd.c	Thu Nov 16 22:57:16 2000
+++ /linux/drivers/net/wd.c	Sun Nov 19 23:08:58 2000
@@ -124,7 +124,7 @@
 	int ancient = 0;			/* An old card without config registers. */
 	int word16 = 0;				/* 0 = 8 bit, 1 = 16 bit */
 	const char *model_name;
-	static unsigned version_printed = 0;
+	static unsigned version_printed;
 
 	for (i = 0; i < 8; i++)
 		checksum += inb(ioaddr + 8 + i);
@@ -141,9 +141,9 @@
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s", version);
 
-	printk("%s: WD80x3 at %#3x,", dev->name, ioaddr);
+	printk(KERN_INFO "%s: WD80x3 at %#3x,", dev->name, ioaddr);
 	for (i = 0; i < 6; i++)
 		printk(" %2.2X", dev->dev_addr[i] = inb(ioaddr + 8 + i));
 
@@ -263,11 +263,11 @@
 
 	/* Snarf the interrupt now.  There's no point in waiting since we cannot
 	   share and the board will usually be enabled. */
-	if (request_irq(dev->irq, ei_interrupt, 0, model_name, dev)) {
+	if ((i = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
 		kfree(dev->priv);
 		dev->priv = NULL;
-		return -EAGAIN;
+		return i;
 	}
 
 	/* OK, were are certain this is going to work.  Setup the device. */
@@ -334,7 +334,8 @@
 	int wd_cmd_port = dev->base_addr - WD_NIC_OFFSET; /* WD_CMDREG */
 
 	outb(WD_RESET, wd_cmd_port);
-	if (ei_debug > 1) printk("resetting the WD80x3 t=%lu...", jiffies);
+	if (ei_debug > 1)
+		printk(KERN_DEBUG "resetting the WD80x3 t=%lu...", jiffies);
 	ei_status.txing = 0;
 
 	/* Set up the ASIC registers, just in case something changed them. */
@@ -421,7 +422,7 @@
 	int wd_cmdreg = dev->base_addr - WD_NIC_OFFSET; /* WD_CMDREG */
 
 	if (ei_debug > 1)
-		printk("%s: Shutting down ethercard.\n", dev->name);
+		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 	ei_close(dev);
 
 	/* Change from 16-bit to 8-bit shared memory so reboot works. */

--TYecfFk8j8mZq+dy--

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6G93oBm4rlNOo3YgRAsjLAKCJK04Tb2krrianJCndnQ/LoZAGxwCfWXCA
+ldvGKj8pgLQ5cvmtSGX1/c=
=aZn6
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
