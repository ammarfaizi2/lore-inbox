Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272518AbTGZOlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272547AbTGZOjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:39:51 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:11812 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272523AbTGZOcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:48 -0400
Date: Sat, 26 Jul 2003 16:51:55 +0200
Message-Id: <200307261451.h6QEptZf002430@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Rename ariadne2 to zorro8390
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename ariadne2 to zorro8390, since this driver supports several NS8390-based
Zorro Ethernet cards. Kill all never used occurrencies of CONFIG_NE2K_ZORRO.

--- linux-2.6.x/arch/m68k/defconfig	Tue Nov  5 10:09:41 2002
+++ linux-m68k-2.6.x/arch/m68k/defconfig	Sat Jun 28 17:56:01 2003
@@ -177,7 +177,7 @@
 # CONFIG_PPP is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_ARIADNE is not set
-# CONFIG_ARIADNE2 is not set
+# CONFIG_ZORRO8390 is not set
 # CONFIG_A2065 is not set
 # CONFIG_HYDRA is not set
 
--- linux-2.6.x/arch/ppc/configs/apus_defconfig	Tue Jun 17 11:20:10 2003
+++ linux-m68k-2.6.x/arch/ppc/configs/apus_defconfig	Sat Jun 28 17:56:44 2003
@@ -423,8 +423,7 @@
 # CONFIG_MII is not set
 # CONFIG_OAKNET is not set
 CONFIG_ARIADNE=y
-# CONFIG_ARIADNE2 is not set
-CONFIG_NE2K_ZORRO=y
+# CONFIG_ZORRO8390 is not set
 CONFIG_A2065=y
 CONFIG_HYDRA=y
 # CONFIG_HAPPYMEAL is not set
--- linux-2.6.x/drivers/net/8390.h	Mon May  5 10:31:25 2003
+++ linux-m68k-2.6.x/drivers/net/8390.h	Sat Jun 28 17:57:01 2003
@@ -110,7 +110,7 @@
  */
  
 #if defined(CONFIG_MAC) ||  \
-    defined(CONFIG_ARIADNE2) || defined(CONFIG_ARIADNE2_MODULE) || \
+    defined(CONFIG_ZORRO8390) || defined(CONFIG_ZORRO8390_MODULE) || \
     defined(CONFIG_HYDRA) || defined(CONFIG_HYDRA_MODULE)
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #undef inb
--- linux-2.6.x/drivers/net/Kconfig	Sun Jun 15 09:38:26 2003
+++ linux-m68k-2.6.x/drivers/net/Kconfig	Sat Jun 28 19:43:48 2003
@@ -282,23 +282,6 @@
 	  want). The module is called ariadne. If you want to compile it as
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
-config ARIADNE2
-	tristate "Ariadne II support"
-	depends on NETDEVICES && ZORRO
-	help
-	  This driver is for the Village Tronic Ariadne II and the Individual
-	  Computers X-Surf Ethernet cards. If you have such a card, say Y.
-	  Otherwise, say N.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called ariadne2. If you want to compile it as
-	  a module, say M here and read <file:Documentation/modules.txt>.
-
-config NE2K_ZORRO
-	tristate "Ariadne II and X-Surf support"
-	depends on NET_ETHERNET && ZORRO
-
 config A2065
 	tristate "A2065 support"
 	depends on NET_ETHERNET && ZORRO
@@ -321,6 +304,20 @@
 	  inserted in and removed from the running kernel whenever you
 	  want). The module is called hydra. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
+
+config ZORRO8390
+	tristate "Zorro NS8390-based Ethernet support"
+	depends on NET_ETHERNET && ZORRO
+	help
+	  This driver is for Zorro Ethernet cards using an NS8390-compatible
+	  chipset, like the Village Tronic Ariadne II and the Individual
+	  Computers X-Surf Ethernet cards. If you have such a card, say Y.
+	  Otherwise, say N.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called zorro8390. If you want to compile it as
+	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config APNE
 	tristate "PCMCIA NE2000 support"
--- linux-2.6.x/drivers/net/Makefile	Sun Jun 15 09:38:26 2003
+++ linux-m68k-2.6.x/drivers/net/Makefile	Sat Jun 28 17:23:26 2003
@@ -150,7 +150,7 @@
 obj-$(CONFIG_LP486E) += lp486e.o
 
 obj-$(CONFIG_ETH16I) += eth16i.o
-obj-$(CONFIG_ARIADNE2) += ariadne2.o 8390.o
+obj-$(CONFIG_ZORRO8390) += zorro8390.o 8390.o
 obj-$(CONFIG_HPLANCE) += hplance.o 7990.o
 obj-$(CONFIG_MVME147_NET) += mvme147.o 7990.o
 obj-$(CONFIG_EQUALIZER) += eql.o
--- linux-2.6.x/drivers/net/Makefile.lib	Tue Mar 25 10:06:41 2003
+++ linux-m68k-2.6.x/drivers/net/Makefile.lib	Sat Jun 28 17:23:47 2003
@@ -69,5 +69,5 @@
 obj-$(CONFIG_LNE390)		+= crc32.o
 obj-$(CONFIG_NE3210)		+= crc32.o
 obj-$(CONFIG_AC3200)		+= crc32.o
-obj-$(CONFIG_ARIADNE2)		+= crc32.o
+obj-$(CONFIG_ZORRO8390)		+= crc32.o
 obj-$(CONFIG_HYDRA)		+= crc32.o
--- linux-2.6.x/drivers/net/ariadne2.c	Tue Nov 26 10:41:25 2002
+++ linux-m68k-2.6.x/drivers/net/ariadne2.c	Thu Jan  1 01:00:00 1970
@@ -1,425 +0,0 @@
-/*
- *  Amiga Linux/m68k and Linux/PPC Ariadne II and X-Surf Ethernet Driver
- *
- *  (C) Copyright 1998-2000 by some Elitist 680x0 Users(TM)
- *
- *  ---------------------------------------------------------------------------
- *
- *  This program is based on all the other NE2000 drivers for Linux
- *
- *  ---------------------------------------------------------------------------
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of the Linux
- *  distribution for more details.
- *
- *  ---------------------------------------------------------------------------
- *
- *  The Ariadne II and X-Surf are Zorro-II boards containing Realtek RTL8019AS
- *  Ethernet Controllers.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/zorro.h>
-
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/amigaints.h>
-#include <asm/amigahw.h>
-
-#include "8390.h"
-
-
-#define NE_BASE		(dev->base_addr)
-#define NE_CMD		(0x00*2)
-#define NE_DATAPORT	(0x10*2)	/* NatSemi-defined port window offset. */
-#define NE_RESET	(0x1f*2)	/* Issue a read to reset, a write to clear. */
-#define NE_IO_EXTENT	(0x20*2)
-
-#define NE_EN0_ISR	(0x07*2)
-#define NE_EN0_DCFG	(0x0e*2)
-
-#define NE_EN0_RSARLO	(0x08*2)
-#define NE_EN0_RSARHI	(0x09*2)
-#define NE_EN0_RCNTLO	(0x0a*2)
-#define NE_EN0_RXCR	(0x0c*2)
-#define NE_EN0_TXCR	(0x0d*2)
-#define NE_EN0_RCNTHI	(0x0b*2)
-#define NE_EN0_IMR	(0x0f*2)
-
-#define NESM_START_PG	0x40	/* First page of TX buffer */
-#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
-
-
-#define WORDSWAP(a)	((((a)>>8)&0xff) | ((a)<<8))
-
-#ifdef MODULE
-static struct net_device *root_ariadne2_dev;
-#endif
-
-static const struct card_info {
-    zorro_id id;
-    const char *name;
-    unsigned int offset;
-} cards[] __initdata = {
-    { ZORRO_PROD_VILLAGE_TRONIC_ARIADNE2, "Ariadne II", 0x0600 },
-    { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, "X-Surf", 0x8600 },
-};
-
-static int __init ariadne2_probe(void);
-static int __init ariadne2_init(struct net_device *dev, unsigned long board,
-				const char *name, unsigned long ioaddr);
-static int ariadne2_open(struct net_device *dev);
-static int ariadne2_close(struct net_device *dev);
-static void ariadne2_reset_8390(struct net_device *dev);
-static void ariadne2_get_8390_hdr(struct net_device *dev,
-				  struct e8390_pkt_hdr *hdr, int ring_page);
-static void ariadne2_block_input(struct net_device *dev, int count,
-				 struct sk_buff *skb, int ring_offset);
-static void ariadne2_block_output(struct net_device *dev, const int count,
-				  const unsigned char *buf,
-				  const int start_page);
-static void __exit ariadne2_cleanup(void);
-
-static int __init ariadne2_probe(void)
-{
-    struct net_device *dev;
-    struct zorro_dev *z = NULL;
-    unsigned long board, ioaddr;
-    int err = -ENODEV;
-    int i;
-
-    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-	for (i = ARRAY_SIZE(cards)-1; i >= 0; i--)
-	    if (z->id == cards[i].id)
-		break;
-	if (i < 0)
-	    continue;
-	board = z->resource.start;
-	ioaddr = board+cards[i].offset;
-	dev = init_etherdev(0, 0);
-	SET_MODULE_OWNER(dev);
-	if (!dev)
-	    return -ENOMEM;
-	if (!request_mem_region(ioaddr, NE_IO_EXTENT*2, dev->name)) {
-	    kfree(dev);
-	    continue;
-	}
-	if ((err = ariadne2_init(dev, board, cards[i].name,
-				 ZTWO_VADDR(ioaddr)))) {
-	    release_mem_region(ioaddr, NE_IO_EXTENT*2);
-	    kfree(dev);
-	    return err;
-	}
-	err = 0;
-    }
-
-    if (err == -ENODEV)
-	printk("No Ariadne II or X-Surf ethernet card found.\n");
-    return err;
-}
-
-static int __init ariadne2_init(struct net_device *dev, unsigned long board,
-				const char *name, unsigned long ioaddr)
-{
-    int i;
-    unsigned char SA_prom[32];
-    int start_page, stop_page;
-    static u32 ariadne2_offsets[16] = {
-	0x00, 0x02, 0x04, 0x06, 0x08, 0x0a, 0x0c, 0x0e,
-	0x10, 0x12, 0x14, 0x16, 0x18, 0x1a, 0x1c, 0x1e,
-    };
-
-    /* Reset card. Who knows what dain-bramaged state it was left in. */
-    {
-	unsigned long reset_start_time = jiffies;
-
-	z_writeb(z_readb(ioaddr + NE_RESET), ioaddr + NE_RESET);
-
-	while ((z_readb(ioaddr + NE_EN0_ISR) & ENISR_RESET) == 0)
-	    if (jiffies - reset_start_time > 2*HZ/100) {
-		printk(" not found (no reset ack).\n");
-		return -ENODEV;
-	    }
-
-	z_writeb(0xff, ioaddr + NE_EN0_ISR);		/* Ack all intr. */
-    }
-
-    /* Read the 16 bytes of station address PROM.
-       We must first initialize registers, similar to NS8390_init(eifdev, 0).
-       We can't reliably read the SAPROM address without this.
-       (I learned the hard way!). */
-    {
-	struct {
-	    u32 value;
-	    u32 offset;
-	} program_seq[] = {
-	    {E8390_NODMA+E8390_PAGE0+E8390_STOP, NE_CMD}, /* Select page 0*/
-	    {0x48,	NE_EN0_DCFG},	/* Set byte-wide (0x48) access. */
-	    {0x00,	NE_EN0_RCNTLO},	/* Clear the count regs. */
-	    {0x00,	NE_EN0_RCNTHI},
-	    {0x00,	NE_EN0_IMR},	/* Mask completion irq. */
-	    {0xFF,	NE_EN0_ISR},
-	    {E8390_RXOFF, NE_EN0_RXCR},	/* 0x20  Set to monitor */
-	    {E8390_TXOFF, NE_EN0_TXCR},	/* 0x02  and loopback mode. */
-	    {32,	NE_EN0_RCNTLO},
-	    {0x00,	NE_EN0_RCNTHI},
-	    {0x00,	NE_EN0_RSARLO},	/* DMA starting at 0x0000. */
-	    {0x00,	NE_EN0_RSARHI},
-	    {E8390_RREAD+E8390_START, NE_CMD},
-	};
-	for (i = 0; i < sizeof(program_seq)/sizeof(program_seq[0]); i++) {
-	    z_writeb(program_seq[i].value, ioaddr + program_seq[i].offset);
-	}
-    }
-    for (i = 0; i < 16; i++) {
-	SA_prom[i] = z_readb(ioaddr + NE_DATAPORT);
-	(void)z_readb(ioaddr + NE_DATAPORT);
-    }
-
-    /* We must set the 8390 for word mode. */
-    z_writeb(0x49, ioaddr + NE_EN0_DCFG);
-    start_page = NESM_START_PG;
-    stop_page = NESM_STOP_PG;
-
-    dev->base_addr = ioaddr;
-    dev->irq = IRQ_AMIGA_PORTS;
-
-    /* Install the Interrupt handler */
-    i = request_irq(IRQ_AMIGA_PORTS, ei_interrupt, SA_SHIRQ, dev->name, dev);
-    if (i) return i;
-
-    /* Allocate dev->priv and fill in 8390 specific dev fields. */
-    if (ethdev_init(dev)) {
-	printk("Unable to get memory for dev->priv.\n");
-	return -ENOMEM;
-    }
-
-    for(i = 0; i < ETHER_ADDR_LEN; i++) {
-#ifdef DEBUG
-	printk(" %2.2x", SA_prom[i]);
-#endif
-	dev->dev_addr[i] = SA_prom[i];
-    }
-
-    printk("%s: %s at 0x%08lx, Ethernet Address "
-	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, name, board,
-	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
-    ei_status.name = name;
-    ei_status.tx_start_page = start_page;
-    ei_status.stop_page = stop_page;
-    ei_status.word16 = 1;
-
-    ei_status.rx_start_page = start_page + TX_PAGES;
-
-    ei_status.reset_8390 = &ariadne2_reset_8390;
-    ei_status.block_input = &ariadne2_block_input;
-    ei_status.block_output = &ariadne2_block_output;
-    ei_status.get_8390_hdr = &ariadne2_get_8390_hdr;
-    ei_status.reg_offset = ariadne2_offsets;
-    dev->open = &ariadne2_open;
-    dev->stop = &ariadne2_close;
-#ifdef MODULE
-    ei_status.priv = (unsigned long)root_ariadne2_dev;
-    root_ariadne2_dev = dev;
-#endif
-    NS8390_init(dev, 0);
-    return 0;
-}
-
-static int ariadne2_open(struct net_device *dev)
-{
-    ei_open(dev);
-    return 0;
-}
-
-static int ariadne2_close(struct net_device *dev)
-{
-    if (ei_debug > 1)
-	printk("%s: Shutting down ethercard.\n", dev->name);
-    ei_close(dev);
-    return 0;
-}
-
-/* Hard reset the card.  This used to pause for the same period that a
-   8390 reset command required, but that shouldn't be necessary. */
-static void ariadne2_reset_8390(struct net_device *dev)
-{
-    unsigned long reset_start_time = jiffies;
-
-    if (ei_debug > 1)
-	printk("resetting the 8390 t=%ld...", jiffies);
-
-    z_writeb(z_readb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);
-
-    ei_status.txing = 0;
-    ei_status.dmaing = 0;
-
-    /* This check _should_not_ be necessary, omit eventually. */
-    while ((z_readb(NE_BASE+NE_EN0_ISR) & ENISR_RESET) == 0)
-	if (jiffies - reset_start_time > 2*HZ/100) {
-	    printk("%s: ne_reset_8390() did not complete.\n", dev->name);
-	    break;
-	}
-    z_writeb(ENISR_RESET, NE_BASE + NE_EN0_ISR);	/* Ack intr. */
-}
-
-/* Grab the 8390 specific header. Similar to the block_input routine, but
-   we don't need to be concerned with ring wrap as the header will be at
-   the start of a page, so we optimize accordingly. */
-
-static void ariadne2_get_8390_hdr(struct net_device *dev,
-				  struct e8390_pkt_hdr *hdr, int ring_page)
-{
-    int nic_base = dev->base_addr;
-    int cnt;
-    short *ptrs;
-
-    /* This *shouldn't* happen. If it does, it's the last thing you'll see */
-    if (ei_status.dmaing) {
-	printk("%s: DMAing conflict in ne_get_8390_hdr "
-	   "[DMAstat:%d][irqlock:%d].\n", dev->name, ei_status.dmaing,
-	   ei_status.irqlock);
-	return;
-    }
-
-    ei_status.dmaing |= 0x01;
-    z_writeb(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
-    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);
-    z_writeb(sizeof(struct e8390_pkt_hdr), nic_base + NE_EN0_RCNTLO);
-    z_writeb(0, nic_base + NE_EN0_RCNTHI);
-    z_writeb(0, nic_base + NE_EN0_RSARLO);		/* On page boundary */
-    z_writeb(ring_page, nic_base + NE_EN0_RSARHI);
-    z_writeb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
-
-    ptrs = (short*)hdr;
-    for (cnt = 0; cnt < (sizeof(struct e8390_pkt_hdr)>>1); cnt++)
-	*ptrs++ = z_readw(NE_BASE + NE_DATAPORT);
-
-    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);	/* Ack intr. */
-
-    hdr->count = WORDSWAP(hdr->count);
-
-    ei_status.dmaing &= ~0x01;
-}
-
-/* Block input and output, similar to the Crynwr packet driver.  If you
-   are porting to a new ethercard, look at the packet driver source for hints.
-   The NEx000 doesn't share the on-board packet memory -- you have to put
-   the packet out through the "remote DMA" dataport using z_writeb. */
-
-static void ariadne2_block_input(struct net_device *dev, int count,
-				 struct sk_buff *skb, int ring_offset)
-{
-    int nic_base = dev->base_addr;
-    char *buf = skb->data;
-    short *ptrs;
-    int cnt;
-
-    /* This *shouldn't* happen. If it does, it's the last thing you'll see */
-    if (ei_status.dmaing) {
-	printk("%s: DMAing conflict in ne_block_input "
-	   "[DMAstat:%d][irqlock:%d].\n",
-	   dev->name, ei_status.dmaing, ei_status.irqlock);
-	return;
-    }
-    ei_status.dmaing |= 0x01;
-    z_writeb(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
-    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);
-    z_writeb(count & 0xff, nic_base + NE_EN0_RCNTLO);
-    z_writeb(count >> 8, nic_base + NE_EN0_RCNTHI);
-    z_writeb(ring_offset & 0xff, nic_base + NE_EN0_RSARLO);
-    z_writeb(ring_offset >> 8, nic_base + NE_EN0_RSARHI);
-    z_writeb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
-    ptrs = (short*)buf;
-    for (cnt = 0; cnt < (count>>1); cnt++)
-	*ptrs++ = z_readw(NE_BASE + NE_DATAPORT);
-    if (count & 0x01)
-	buf[count-1] = z_readb(NE_BASE + NE_DATAPORT);
-
-    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);	/* Ack intr. */
-    ei_status.dmaing &= ~0x01;
-}
-
-static void ariadne2_block_output(struct net_device *dev, int count,
-				  const unsigned char *buf,
-				  const int start_page)
-{
-    int nic_base = NE_BASE;
-    unsigned long dma_start;
-    short *ptrs;
-    int cnt;
-
-    /* Round the count up for word writes.  Do we need to do this?
-       What effect will an odd byte count have on the 8390?
-       I should check someday. */
-    if (count & 0x01)
-	count++;
-
-    /* This *shouldn't* happen. If it does, it's the last thing you'll see */
-    if (ei_status.dmaing) {
-	printk("%s: DMAing conflict in ne_block_output."
-	   "[DMAstat:%d][irqlock:%d]\n", dev->name, ei_status.dmaing,
-	   ei_status.irqlock);
-	return;
-    }
-    ei_status.dmaing |= 0x01;
-    /* We should already be in page 0, but to be safe... */
-    z_writeb(E8390_PAGE0+E8390_START+E8390_NODMA, nic_base + NE_CMD);
-
-    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);
-
-   /* Now the normal output. */
-    z_writeb(count & 0xff, nic_base + NE_EN0_RCNTLO);
-    z_writeb(count >> 8,   nic_base + NE_EN0_RCNTHI);
-    z_writeb(0x00, nic_base + NE_EN0_RSARLO);
-    z_writeb(start_page, nic_base + NE_EN0_RSARHI);
-
-    z_writeb(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
-    ptrs = (short*)buf;
-    for (cnt = 0; cnt < count>>1; cnt++)
-	z_writew(*ptrs++, NE_BASE+NE_DATAPORT);
-
-    dma_start = jiffies;
-
-    while ((z_readb(NE_BASE + NE_EN0_ISR) & ENISR_RDC) == 0)
-	if (jiffies - dma_start > 2*HZ/100) {		/* 20ms */
-		printk("%s: timeout waiting for Tx RDC.\n", dev->name);
-		ariadne2_reset_8390(dev);
-		NS8390_init(dev,1);
-		break;
-	}
-
-    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);	/* Ack intr. */
-    ei_status.dmaing &= ~0x01;
-    return;
-}
-
-static void __exit ariadne2_cleanup(void)
-{
-#ifdef MODULE
-    struct net_device *dev, *next;
-
-    while ((dev = root_ariadne2_dev)) {
-	next = (struct net_device *)(ei_status.priv);
-	unregister_netdev(dev);
-	free_irq(IRQ_AMIGA_PORTS, dev);
-	release_mem_region(ZTWO_PADDR(dev->base_addr), NE_IO_EXTENT*2);
-	kfree(dev);
-	root_ariadne2_dev = next;
-    }
-#endif
-}
-
-module_init(ariadne2_probe);
-module_exit(ariadne2_cleanup);
-
-MODULE_LICENSE("GPL");
--- linux-2.6.x/drivers/net/zorro8390.c	Thu Jan  1 01:00:00 1970
+++ linux-m68k-2.6.x/drivers/net/zorro8390.c	Sat Jun 28 17:33:02 2003
@@ -0,0 +1,425 @@
+/*
+ *  Amiga Linux/m68k and Linux/PPC Zorro NS8390 Ethernet Driver
+ *
+ *  (C) Copyright 1998-2000 by some Elitist 680x0 Users(TM)
+ *
+ *  ---------------------------------------------------------------------------
+ *
+ *  This program is based on all the other NE2000 drivers for Linux
+ *
+ *  ---------------------------------------------------------------------------
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ *
+ *  ---------------------------------------------------------------------------
+ *
+ *  The Ariadne II and X-Surf are Zorro-II boards containing Realtek RTL8019AS
+ *  Ethernet Controllers.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/zorro.h>
+
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/amigaints.h>
+#include <asm/amigahw.h>
+
+#include "8390.h"
+
+
+#define NE_BASE		(dev->base_addr)
+#define NE_CMD		(0x00*2)
+#define NE_DATAPORT	(0x10*2)	/* NatSemi-defined port window offset. */
+#define NE_RESET	(0x1f*2)	/* Issue a read to reset, a write to clear. */
+#define NE_IO_EXTENT	(0x20*2)
+
+#define NE_EN0_ISR	(0x07*2)
+#define NE_EN0_DCFG	(0x0e*2)
+
+#define NE_EN0_RSARLO	(0x08*2)
+#define NE_EN0_RSARHI	(0x09*2)
+#define NE_EN0_RCNTLO	(0x0a*2)
+#define NE_EN0_RXCR	(0x0c*2)
+#define NE_EN0_TXCR	(0x0d*2)
+#define NE_EN0_RCNTHI	(0x0b*2)
+#define NE_EN0_IMR	(0x0f*2)
+
+#define NESM_START_PG	0x40	/* First page of TX buffer */
+#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
+
+
+#define WORDSWAP(a)	((((a)>>8)&0xff) | ((a)<<8))
+
+#ifdef MODULE
+static struct net_device *root_zorro8390_dev;
+#endif
+
+static const struct card_info {
+    zorro_id id;
+    const char *name;
+    unsigned int offset;
+} cards[] __initdata = {
+    { ZORRO_PROD_VILLAGE_TRONIC_ARIADNE2, "Ariadne II", 0x0600 },
+    { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, "X-Surf", 0x8600 },
+};
+
+static int __init zorro8390_probe(void);
+static int __init zorro8390_init(struct net_device *dev, unsigned long board,
+				 const char *name, unsigned long ioaddr);
+static int zorro8390_open(struct net_device *dev);
+static int zorro8390_close(struct net_device *dev);
+static void zorro8390_reset_8390(struct net_device *dev);
+static void zorro8390_get_8390_hdr(struct net_device *dev,
+				   struct e8390_pkt_hdr *hdr, int ring_page);
+static void zorro8390_block_input(struct net_device *dev, int count,
+				  struct sk_buff *skb, int ring_offset);
+static void zorro8390_block_output(struct net_device *dev, const int count,
+				   const unsigned char *buf,
+				   const int start_page);
+static void __exit zorro8390_cleanup(void);
+
+static int __init zorro8390_probe(void)
+{
+    struct net_device *dev;
+    struct zorro_dev *z = NULL;
+    unsigned long board, ioaddr;
+    int err = -ENODEV;
+    int i;
+
+    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
+	for (i = ARRAY_SIZE(cards)-1; i >= 0; i--)
+	    if (z->id == cards[i].id)
+		break;
+	if (i < 0)
+	    continue;
+	board = z->resource.start;
+	ioaddr = board+cards[i].offset;
+	dev = init_etherdev(0, 0);
+	SET_MODULE_OWNER(dev);
+	if (!dev)
+	    return -ENOMEM;
+	if (!request_mem_region(ioaddr, NE_IO_EXTENT*2, dev->name)) {
+	    kfree(dev);
+	    continue;
+	}
+	if ((err = zorro8390_init(dev, board, cards[i].name,
+				  ZTWO_VADDR(ioaddr)))) {
+	    release_mem_region(ioaddr, NE_IO_EXTENT*2);
+	    kfree(dev);
+	    return err;
+	}
+	err = 0;
+    }
+
+    if (err == -ENODEV)
+	printk("No Ariadne II or X-Surf ethernet card found.\n");
+    return err;
+}
+
+static int __init zorro8390_init(struct net_device *dev, unsigned long board,
+				 const char *name, unsigned long ioaddr)
+{
+    int i;
+    unsigned char SA_prom[32];
+    int start_page, stop_page;
+    static u32 zorro8390_offsets[16] = {
+	0x00, 0x02, 0x04, 0x06, 0x08, 0x0a, 0x0c, 0x0e,
+	0x10, 0x12, 0x14, 0x16, 0x18, 0x1a, 0x1c, 0x1e,
+    };
+
+    /* Reset card. Who knows what dain-bramaged state it was left in. */
+    {
+	unsigned long reset_start_time = jiffies;
+
+	z_writeb(z_readb(ioaddr + NE_RESET), ioaddr + NE_RESET);
+
+	while ((z_readb(ioaddr + NE_EN0_ISR) & ENISR_RESET) == 0)
+	    if (jiffies - reset_start_time > 2*HZ/100) {
+		printk(" not found (no reset ack).\n");
+		return -ENODEV;
+	    }
+
+	z_writeb(0xff, ioaddr + NE_EN0_ISR);		/* Ack all intr. */
+    }
+
+    /* Read the 16 bytes of station address PROM.
+       We must first initialize registers, similar to NS8390_init(eifdev, 0).
+       We can't reliably read the SAPROM address without this.
+       (I learned the hard way!). */
+    {
+	struct {
+	    u32 value;
+	    u32 offset;
+	} program_seq[] = {
+	    {E8390_NODMA+E8390_PAGE0+E8390_STOP, NE_CMD}, /* Select page 0*/
+	    {0x48,	NE_EN0_DCFG},	/* Set byte-wide (0x48) access. */
+	    {0x00,	NE_EN0_RCNTLO},	/* Clear the count regs. */
+	    {0x00,	NE_EN0_RCNTHI},
+	    {0x00,	NE_EN0_IMR},	/* Mask completion irq. */
+	    {0xFF,	NE_EN0_ISR},
+	    {E8390_RXOFF, NE_EN0_RXCR},	/* 0x20  Set to monitor */
+	    {E8390_TXOFF, NE_EN0_TXCR},	/* 0x02  and loopback mode. */
+	    {32,	NE_EN0_RCNTLO},
+	    {0x00,	NE_EN0_RCNTHI},
+	    {0x00,	NE_EN0_RSARLO},	/* DMA starting at 0x0000. */
+	    {0x00,	NE_EN0_RSARHI},
+	    {E8390_RREAD+E8390_START, NE_CMD},
+	};
+	for (i = 0; i < sizeof(program_seq)/sizeof(program_seq[0]); i++) {
+	    z_writeb(program_seq[i].value, ioaddr + program_seq[i].offset);
+	}
+    }
+    for (i = 0; i < 16; i++) {
+	SA_prom[i] = z_readb(ioaddr + NE_DATAPORT);
+	(void)z_readb(ioaddr + NE_DATAPORT);
+    }
+
+    /* We must set the 8390 for word mode. */
+    z_writeb(0x49, ioaddr + NE_EN0_DCFG);
+    start_page = NESM_START_PG;
+    stop_page = NESM_STOP_PG;
+
+    dev->base_addr = ioaddr;
+    dev->irq = IRQ_AMIGA_PORTS;
+
+    /* Install the Interrupt handler */
+    i = request_irq(IRQ_AMIGA_PORTS, ei_interrupt, SA_SHIRQ, dev->name, dev);
+    if (i) return i;
+
+    /* Allocate dev->priv and fill in 8390 specific dev fields. */
+    if (ethdev_init(dev)) {
+	printk("Unable to get memory for dev->priv.\n");
+	return -ENOMEM;
+    }
+
+    for(i = 0; i < ETHER_ADDR_LEN; i++) {
+#ifdef DEBUG
+	printk(" %2.2x", SA_prom[i]);
+#endif
+	dev->dev_addr[i] = SA_prom[i];
+    }
+
+    printk("%s: %s at 0x%08lx, Ethernet Address "
+	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, name, board,
+	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
+
+    ei_status.name = name;
+    ei_status.tx_start_page = start_page;
+    ei_status.stop_page = stop_page;
+    ei_status.word16 = 1;
+
+    ei_status.rx_start_page = start_page + TX_PAGES;
+
+    ei_status.reset_8390 = &zorro8390_reset_8390;
+    ei_status.block_input = &zorro8390_block_input;
+    ei_status.block_output = &zorro8390_block_output;
+    ei_status.get_8390_hdr = &zorro8390_get_8390_hdr;
+    ei_status.reg_offset = zorro8390_offsets;
+    dev->open = &zorro8390_open;
+    dev->stop = &zorro8390_close;
+#ifdef MODULE
+    ei_status.priv = (unsigned long)root_zorro8390_dev;
+    root_zorro8390_dev = dev;
+#endif
+    NS8390_init(dev, 0);
+    return 0;
+}
+
+static int zorro8390_open(struct net_device *dev)
+{
+    ei_open(dev);
+    return 0;
+}
+
+static int zorro8390_close(struct net_device *dev)
+{
+    if (ei_debug > 1)
+	printk("%s: Shutting down ethercard.\n", dev->name);
+    ei_close(dev);
+    return 0;
+}
+
+/* Hard reset the card.  This used to pause for the same period that a
+   8390 reset command required, but that shouldn't be necessary. */
+static void zorro8390_reset_8390(struct net_device *dev)
+{
+    unsigned long reset_start_time = jiffies;
+
+    if (ei_debug > 1)
+	printk("resetting the 8390 t=%ld...", jiffies);
+
+    z_writeb(z_readb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);
+
+    ei_status.txing = 0;
+    ei_status.dmaing = 0;
+
+    /* This check _should_not_ be necessary, omit eventually. */
+    while ((z_readb(NE_BASE+NE_EN0_ISR) & ENISR_RESET) == 0)
+	if (jiffies - reset_start_time > 2*HZ/100) {
+	    printk("%s: ne_reset_8390() did not complete.\n", dev->name);
+	    break;
+	}
+    z_writeb(ENISR_RESET, NE_BASE + NE_EN0_ISR);	/* Ack intr. */
+}
+
+/* Grab the 8390 specific header. Similar to the block_input routine, but
+   we don't need to be concerned with ring wrap as the header will be at
+   the start of a page, so we optimize accordingly. */
+
+static void zorro8390_get_8390_hdr(struct net_device *dev,
+				   struct e8390_pkt_hdr *hdr, int ring_page)
+{
+    int nic_base = dev->base_addr;
+    int cnt;
+    short *ptrs;
+
+    /* This *shouldn't* happen. If it does, it's the last thing you'll see */
+    if (ei_status.dmaing) {
+	printk("%s: DMAing conflict in ne_get_8390_hdr "
+	   "[DMAstat:%d][irqlock:%d].\n", dev->name, ei_status.dmaing,
+	   ei_status.irqlock);
+	return;
+    }
+
+    ei_status.dmaing |= 0x01;
+    z_writeb(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
+    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);
+    z_writeb(sizeof(struct e8390_pkt_hdr), nic_base + NE_EN0_RCNTLO);
+    z_writeb(0, nic_base + NE_EN0_RCNTHI);
+    z_writeb(0, nic_base + NE_EN0_RSARLO);		/* On page boundary */
+    z_writeb(ring_page, nic_base + NE_EN0_RSARHI);
+    z_writeb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+
+    ptrs = (short*)hdr;
+    for (cnt = 0; cnt < (sizeof(struct e8390_pkt_hdr)>>1); cnt++)
+	*ptrs++ = z_readw(NE_BASE + NE_DATAPORT);
+
+    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);	/* Ack intr. */
+
+    hdr->count = WORDSWAP(hdr->count);
+
+    ei_status.dmaing &= ~0x01;
+}
+
+/* Block input and output, similar to the Crynwr packet driver.  If you
+   are porting to a new ethercard, look at the packet driver source for hints.
+   The NEx000 doesn't share the on-board packet memory -- you have to put
+   the packet out through the "remote DMA" dataport using z_writeb. */
+
+static void zorro8390_block_input(struct net_device *dev, int count,
+				 struct sk_buff *skb, int ring_offset)
+{
+    int nic_base = dev->base_addr;
+    char *buf = skb->data;
+    short *ptrs;
+    int cnt;
+
+    /* This *shouldn't* happen. If it does, it's the last thing you'll see */
+    if (ei_status.dmaing) {
+	printk("%s: DMAing conflict in ne_block_input "
+	   "[DMAstat:%d][irqlock:%d].\n",
+	   dev->name, ei_status.dmaing, ei_status.irqlock);
+	return;
+    }
+    ei_status.dmaing |= 0x01;
+    z_writeb(E8390_NODMA+E8390_PAGE0+E8390_START, nic_base+ NE_CMD);
+    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);
+    z_writeb(count & 0xff, nic_base + NE_EN0_RCNTLO);
+    z_writeb(count >> 8, nic_base + NE_EN0_RCNTHI);
+    z_writeb(ring_offset & 0xff, nic_base + NE_EN0_RSARLO);
+    z_writeb(ring_offset >> 8, nic_base + NE_EN0_RSARHI);
+    z_writeb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
+    ptrs = (short*)buf;
+    for (cnt = 0; cnt < (count>>1); cnt++)
+	*ptrs++ = z_readw(NE_BASE + NE_DATAPORT);
+    if (count & 0x01)
+	buf[count-1] = z_readb(NE_BASE + NE_DATAPORT);
+
+    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);	/* Ack intr. */
+    ei_status.dmaing &= ~0x01;
+}
+
+static void zorro8390_block_output(struct net_device *dev, int count,
+				   const unsigned char *buf,
+				   const int start_page)
+{
+    int nic_base = NE_BASE;
+    unsigned long dma_start;
+    short *ptrs;
+    int cnt;
+
+    /* Round the count up for word writes.  Do we need to do this?
+       What effect will an odd byte count have on the 8390?
+       I should check someday. */
+    if (count & 0x01)
+	count++;
+
+    /* This *shouldn't* happen. If it does, it's the last thing you'll see */
+    if (ei_status.dmaing) {
+	printk("%s: DMAing conflict in ne_block_output."
+	   "[DMAstat:%d][irqlock:%d]\n", dev->name, ei_status.dmaing,
+	   ei_status.irqlock);
+	return;
+    }
+    ei_status.dmaing |= 0x01;
+    /* We should already be in page 0, but to be safe... */
+    z_writeb(E8390_PAGE0+E8390_START+E8390_NODMA, nic_base + NE_CMD);
+
+    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);
+
+   /* Now the normal output. */
+    z_writeb(count & 0xff, nic_base + NE_EN0_RCNTLO);
+    z_writeb(count >> 8,   nic_base + NE_EN0_RCNTHI);
+    z_writeb(0x00, nic_base + NE_EN0_RSARLO);
+    z_writeb(start_page, nic_base + NE_EN0_RSARHI);
+
+    z_writeb(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
+    ptrs = (short*)buf;
+    for (cnt = 0; cnt < count>>1; cnt++)
+	z_writew(*ptrs++, NE_BASE+NE_DATAPORT);
+
+    dma_start = jiffies;
+
+    while ((z_readb(NE_BASE + NE_EN0_ISR) & ENISR_RDC) == 0)
+	if (jiffies - dma_start > 2*HZ/100) {		/* 20ms */
+		printk("%s: timeout waiting for Tx RDC.\n", dev->name);
+		zorro8390_reset_8390(dev);
+		NS8390_init(dev,1);
+		break;
+	}
+
+    z_writeb(ENISR_RDC, nic_base + NE_EN0_ISR);	/* Ack intr. */
+    ei_status.dmaing &= ~0x01;
+    return;
+}
+
+static void __exit zorro8390_cleanup(void)
+{
+#ifdef MODULE
+    struct net_device *dev, *next;
+
+    while ((dev = root_zorro8390_dev)) {
+	next = (struct net_device *)(ei_status.priv);
+	unregister_netdev(dev);
+	free_irq(IRQ_AMIGA_PORTS, dev);
+	release_mem_region(ZTWO_PADDR(dev->base_addr), NE_IO_EXTENT*2);
+	kfree(dev);
+	root_zorro8390_dev = next;
+    }
+#endif
+}
+
+module_init(zorro8390_probe);
+module_exit(zorro8390_cleanup);
+
+MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
