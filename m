Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131033AbRAKOdR>; Thu, 11 Jan 2001 09:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbRAKOdI>; Thu, 11 Jan 2001 09:33:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48657 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129810AbRAKOdC>;
	Thu, 11 Jan 2001 09:33:02 -0500
Message-ID: <3A5DC411.794486B0@mandrakesoft.com>
Date: Thu, 11 Jan 2001 09:32:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dth@lin-gen.com
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Drivers under 2.4
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <20010111115833.A27971@lin-gen.com> <3A5D9AB1.39F6627C@uow.edu.au> <93k75v$r1u$1@voyager.cistron.net> <93ke9q$jnj$1@voyager.cistron.net>
Content-Type: multipart/mixed;
 boundary="------------4545F122E1BF8157473CDD3E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4545F122E1BF8157473CDD3E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Danny ter Haar wrote:
> 
> >Jan 11 12:45:49 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 07f3.
> >Jan 11 12:46:01 multimedia last message repeated 12 times
> 
> hot from the ethernet wire: more info just arrived:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, status 07f3, resetting.
>  Ring data dump: dirty_tx 0 cur_tx 16 (full) cur_rx 0.
>   03b2f012 0608 00000040 0310 03b2f812 0608 00000040 0310
>   03b2e012 0608 00000040 0310 03b2e812 0608 00000040 0310
>   03b2d012 0608 00000040 0310 03b2d812 0608 00000040 0310
>   03b2c012 0608 00000040 0310 03b2c812 0608 00000040 0310
>   03b2b012 0608 00000040 0310 03b2b812 0608 00000040 0310
>   03b2a012 0608 00000040 0310 03b2a812 0608 00000040 0310
>   03b29012 0608 00000040 0310 03b29812 0608 00000040 0310
>   03b28012 0608 00000040 0310 03b28812 0608 00000111 0310
>   03b3f012 0608 000000fc 0310 03b3f812 0608 0000006a 0310
>   03b3e012 0608 00000040 0310 03b3e812 0608 00000040 0310
>   03b3d012 0608 00000040 0310 03b3d812 0608 00000040 0310
>   03b3c012 0608 00000040 0310 03b3c812 0608 00000040 0310
>   03b3a012 0608 00000040 0310 03b3a812 0608 00000040 0310
>   03b39012 0608 00000040 0310 03b39812 0608 00000040 0340
>   03b38012 0608 00000040 0340 03b38812 0608 00000040 0340
>   03b4f012 0608 00000040 0340 03b4f812 0608 00000040 0340
>   03f9a782 0066 00000000 0300 03b4e222 002a 00000000 0300
>   03b4e2a2 002a 00000000 0300 03b4e322 002a 00000000 0300
>   03b4e3a2 002a 00000000 0300 03b4e422 002a 00000000 0300
>   03b4e4a2 002a 00000000 0300 03b4e522 002a 00000000 0300
>   03b4e5a2 002a 00000000 0300 03b4e622 002a 00000000 0300
>   03b4e6a2 002a 00000000 0300 03b4eea2 002a 00000000 0300
>   03b4ef22 002a 00000000 0300 03f9a882 007e 00000000 0300
>   03f9a982 007e 00000000 0300 03f9aa82 007e 00000000 0300
> eth0: pcnet32_start_xmit() called, csr0 05f3.
> eth0: pcnet32_start_xmit() called, csr0 07f3.
> 
> etc...

Does this patch help at all?

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------4545F122E1BF8157473CDD3E
Content-Type: text/plain; charset=us-ascii;
 name="pcnet32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32.patch"

Index: drivers/net/pcnet32.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcnet32.c,v
retrieving revision 1.1.1.7
retrieving revision 1.1.1.7.10.1
diff -u -r1.1.1.7 -r1.1.1.7.10.1
--- drivers/net/pcnet32.c	2000/12/12 03:23:16	1.1.1.7
+++ drivers/net/pcnet32.c	2001/01/11 13:38:07	1.1.1.7.10.1
@@ -1,19 +1,22 @@
 /* pcnet32.c: An AMD PCnet32 ethernet driver for linux. */
 /*
  *	Copyright 1996-1999 Thomas Bogendoerfer
- * 
+ *
  *	Derived from the lance driver written 1993,1994,1995 by Donald Becker.
- * 
+ *
  *	Copyright 1993 United States Government as represented by the
  *	Director, National Security Agency.
- * 
+ *
  *	This software may be used and distributed according to the terms
  *	of the GNU Public License, incorporated herein by reference.
  *
  *	This driver is for PCnet32 and PCnetPCI based ethercards
+ *
+ *	Nov 2000 (jgarzik): SMP, endian, PCI DMA, other fixes.
+ *			    Removed VLB support (use CONFIG_LANCE instead).
  */
 
-static const char *version = "pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de\n";
+static const char *version = "pcnet32.c:v1.25smp Nov 11, 2000 tsbogend@alpha.franken.de\n";
 
 #include <linux/module.h>
 
@@ -37,13 +40,9 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 
-static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
-
 static int pcnet32_debug = 1;
 static int tx_start = 1; /* Mapping -- 0:20, 1:64, 2:128, 3:~220 (depends on chip vers) */
 
-static struct net_device *pcnet32_dev;
-
 static const int max_interrupt_work = 80;
 static const int rx_copybreak = 200;
 
@@ -63,10 +62,10 @@
  * table to translate option values from tulip
  * to internal options
  */
-static unsigned char options_mapping[] = {
+static unsigned char options_mapping[] __initdata = {
     PORT_ASEL,			   /*  0 Auto-select	  */
     PORT_AUI,			   /*  1 BNC/AUI	  */
-    PORT_AUI,			   /*  2 AUI/BNC	  */ 
+    PORT_AUI,			   /*  2 AUI/BNC	  */
     PORT_ASEL,			   /*  3 not supported	  */
     PORT_10BT | PORT_FD,	   /*  4 10baseT-FD	  */
     PORT_ASEL,			   /*  5 not supported	  */
@@ -88,14 +87,14 @@
 
 /*
  *				Theory of Operation
- * 
+ *
  * This driver uses the same software structure as the normal lance
  * driver. So look for a verbose description in lance.c. The differences
  * to the normal lance driver is the use of the 32bit mode of PCnet32
  * and PCnetPCI chips. Because these chips are 32bit chips, there is no
  * 16MB limitation and we don't need bounce buffers.
  */
- 
+
 /*
  * History:
  * v0.01:  Initial version
@@ -149,7 +148,7 @@
  * v1.22:  changed pci scanning code to make PPC people happy
  *	   fixed switching to 32bit mode in pcnet32_open() (thanks
  *	   to Michael Richard <mcr@solidum.com> for noticing this one)
- *	   added sub vendor/device id matching (thanks again to 
+ *	   added sub vendor/device id matching (thanks again to
  *	   Michael Richard <mcr@solidum.com>)
  *	   added chip id for 79c973/975 (thanks to Zach Brown <zab@zabbo.net>)
  * v1.23   fixed small bug, when manual selecting MII speed/duplex
@@ -206,6 +205,10 @@
 #define PCI_DEVICE_ID_AMD_PCNETHOME   0x2001
 #endif
 
+#define DMA_ALLOC_SIZE \
+    	( (sizeof(struct pcnet32_rx_head) * RX_RING_SIZE) +	\
+          (sizeof(struct pcnet32_tx_head) * TX_RING_SIZE) +	\
+	  sizeof(struct pcnet32_init_block) )
 
 #define CRC_POLYNOMIAL_LE 0xedb88320UL	/* Ethernet CRC, little endian */
 
@@ -213,11 +216,11 @@
 struct pcnet32_rx_head {
     u32 base;
     s16 buf_length;
-    s16 status;	   
+    s16 status;
     u32 msg_length;
     u32 reserved;
 };
-	
+
 struct pcnet32_tx_head {
     u32 base;
     s16 length;
@@ -233,7 +236,7 @@
     u8	phys_addr[6];
     u16 reserved;
     u32 filter[2];
-    /* Receive and transmit ring base, along with extra bits. */    
+    /* Receive and transmit ring base, along with extra bits. */
     u32 rx_ring;
     u32 tx_ring;
 };
@@ -250,15 +253,18 @@
 };
 
 /*
- * The first three fields of pcnet32_private are read by the ethernet device 
+ * The first three fields of pcnet32_private are read by the ethernet device
  * so we allocate the structure should be allocated by pci_alloc_consistent().
  */
 struct pcnet32_private {
     /* The Tx and Rx ring entries must be aligned on 16-byte boundaries in 32bit mode. */
-    struct pcnet32_rx_head   rx_ring[RX_RING_SIZE];
-    struct pcnet32_tx_head   tx_ring[TX_RING_SIZE];
-    struct pcnet32_init_block	init_block;
-    dma_addr_t dma_addr;		/* DMA address of beginning of this object, returned by pci_alloc_consistent */
+    struct pcnet32_rx_head   *rx_ring;
+    struct pcnet32_tx_head   *tx_ring;
+    struct pcnet32_init_block	*init_block;
+    dma_addr_t rx_ring_dma;
+    dma_addr_t tx_ring_dma;
+    dma_addr_t init_block_dma;
+
     struct pci_dev *pci_dev;		/* Pointer to the associated pci device structure */
     const char *name;
     /* The saved address of a sent-in-place packet/buffer, for skfree(). */
@@ -271,21 +277,16 @@
     unsigned int cur_rx, cur_tx;		/* The next free ring entry */
     unsigned int dirty_rx, dirty_tx;	/* The ring entries to be free()ed. */
     struct net_device_stats stats;
-    char tx_full;
     int	 options;
-    int	 shared_irq:1,			/* shared irq possible */
-	ltint:1,
+    int	 ltint:1,
 #ifdef DO_DXSUFLO
 	      dxsuflo:1,						    /* disable transmit stop on uflo */
 #endif
 	full_duplex:1,				/* full duplex possible */
 	mii:1;					/* mii port available */
-    struct net_device *next;
 };
 
-static int  pcnet32_probe_vlbus(int cards_found);
-static int  pcnet32_probe_pci(struct pci_dev *, const struct pci_device_id *);
-static int  pcnet32_probe1(unsigned long, unsigned char, int, int, struct pci_dev *);
+static int  pcnet32_probe1(int, struct pci_dev *);
 static int  pcnet32_open(struct net_device *);
 static int  pcnet32_init_ring(struct net_device *);
 static int  pcnet32_start_xmit(struct sk_buff *, struct net_device *);
@@ -299,26 +300,13 @@
 static int  pcnet32_mii_ioctl(struct net_device *, struct ifreq *, int);
 #endif
 
-enum pci_flags_bit {
-    PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
-    PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
-};
-
-struct pcnet32_pci_id_info {
-    const char *name;
-    u16 vendor_id, device_id, svid, sdid, flags;
-    int io_size;
-    int (*probe1) (unsigned long, unsigned char, int, int, struct pci_dev *);
-};
-
-
 /*
  * PCI device identifiers for "new style" Linux PCI Device Drivers
  */
-static struct pci_device_id pcnet32_pci_tbl[] __devinitdata = {
+static struct pci_device_id pcnet32_pci_tbl[] __initdata = {
     { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PCNETHOME, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
     { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, 0x1014, 0x2000, 0, 0, 0 },
+/*    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, 0x1014, 0x2000, 0, 0, 0 }, */
     { 0, }
 };
 
@@ -435,52 +423,15 @@
 
 };
 
-
-
-/* only probes for non-PCI devices, the rest are handled by pci_register_driver via pcnet32_probe_pci*/
-static int __init pcnet32_probe_vlbus(int cards_found)
-{
-    unsigned long ioaddr = 0; // FIXME dev ? dev->base_addr: 0;
-    unsigned int  irq_line = 0; // FIXME dev ? dev->irq : 0;
-    int *port;
-    
-    printk(KERN_INFO "pcnet32_probe_vlbus: cards_found=%d\n", cards_found);
-#ifndef __powerpc__
-    if (ioaddr > 0x1ff) {
-	if (check_region(ioaddr, PCNET32_TOTAL_SIZE) == 0)
-	    return pcnet32_probe1(ioaddr, irq_line, 0, 0, NULL);
-	else
-	    return -ENODEV;
-    } else
-#endif
-	if (ioaddr != 0)
-	    return -ENXIO;
-    
-    /* now look for PCnet32 VLB cards */
-    for (port = pcnet32_portlist; *port; port++) {
-	unsigned long ioaddr = *port;
-	
-	if ( check_region(ioaddr, PCNET32_TOTAL_SIZE) == 0) {
-	    /* check if there is really a pcnet chip on that ioaddr */
-	    if ((inb(ioaddr + 14) == 0x57) &&
-		(inb(ioaddr + 15) == 0x57) &&
-		(pcnet32_probe1(ioaddr, 0, 0, 0, NULL) == 0))
-		cards_found++;
-	}
-    }
-    return cards_found ? 0: -ENODEV;
-}
-
 
-
 static int __init
 pcnet32_probe_pci(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
     static int card_idx;
-    long ioaddr;
-    int err = 0;
+    int err;
+    unsigned long ioaddr;
 
-    printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);
+    printk(KERN_DEBUG "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);
 
     ioaddr = pci_resource_start (pdev, 0);
     printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
@@ -493,37 +444,58 @@
 	printk(KERN_ERR "pcnet32.c: architecture does not support 32bit PCI busmaster DMA\n");
 	return -ENODEV;
     }
+    pdev->dma_mask = PCNET32_DMA_MASK;
 
-    if ((err = pci_enable_device(pdev)) < 0) {
+    err = pci_enable_device(pdev);
+    if (err) {
 	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
 	return err;
     }
-    
+
     pci_set_master(pdev);
-    
-    return pcnet32_probe1(ioaddr, pdev->irq, 1, card_idx, pdev);
+
+    err = pcnet32_probe1(card_idx, pdev);
+
+    if (err == 0)
+    	card_idx++;
+
+    return err;
 }
 
 
-/* pcnet32_probe1 
- *  Called from both pcnet32_probe_vlbus and pcnet_probe_pci.  
- *  pdev will be NULL when called from pcnet32_probe_vlbus.
+/* pcnet32_probe1
+ *  Called from both pcnet32_probe_vlbus and pcnet_probe_pci.
  */
 static int __init
-pcnet32_probe1(unsigned long ioaddr, unsigned char irq_line, int shared, int card_idx, struct pci_dev *pdev)
+pcnet32_probe1(int card_idx, struct pci_dev *pdev)
 {
     struct pcnet32_private *lp;
-    dma_addr_t lp_dma_addr;
     int i,media,fdx = 0, mii = 0, fset = 0;
 #ifdef DO_DXSUFLO
     int dxsuflo = 0;
 #endif
     int ltint = 0;
-    int chip_version;
+    int chip_version, ret = -ENODEV;
     char *chipname;
     struct net_device *dev;
     struct pcnet32_access *a = NULL;
+    unsigned long ioaddr = pci_resource_start(pdev, 0);
 
+    if (!ioaddr) {
+        printk (KERN_ERR "no PCI IO resources, aborting\n");
+        return -ENODEV;
+    }
+
+    dev = init_etherdev(NULL, sizeof(*lp));
+    if (dev == NULL)
+	return -ENOMEM;
+    SET_MODULE_OWNER(dev);
+
+    if (!request_region(ioaddr, PCNET32_TOTAL_SIZE, dev->name)) {
+	ret = -EBUSY;
+	goto err_out;
+    }
+
     /* reset the chip */
     pcnet32_dwio_reset(ioaddr);
     pcnet32_wio_reset(ioaddr);
@@ -534,24 +506,21 @@
 	if (pcnet32_dwio_read_csr (ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
 	    a = &pcnet32_dwio;
 	} else
-	    return -ENODEV;
+	    goto err_out_res;
     }
 
     chip_version = a->read_csr (ioaddr, 88) | (a->read_csr (ioaddr,89) << 16);
     if (pcnet32_debug > 2)
 	printk(KERN_INFO "  PCnet chip version is %#x.\n", chip_version);
     if ((chip_version & 0xfff) != 0x003)
-	return -ENODEV;
+	goto err_out_res;
     chip_version = (chip_version >> 12) & 0xffff;
     switch (chip_version) {
     case 0x2420:
 	chipname = "PCnet/PCI 79C970"; /* PCI */
 	break;
     case 0x2430:
-	if (shared)
-	    chipname = "PCnet/PCI 79C970"; /* 970 gives the wrong chip id back */
-	else
-	    chipname = "PCnet/32 79C965"; /* 486/VL bus */
+	chipname = "PCnet/PCI 79C970"; /* 970 gives the wrong chip id back */
 	break;
     case 0x2621:
 	chipname = "PCnet/PCI II 79C970A"; /* PCI */
@@ -573,7 +542,7 @@
     case 0x2626:
 	chipname = "PCnet/Home 79C978"; /* PCI */
 	fdx = 1;
-	/* 
+	/*
 	 * This is based on specs published at www.amd.com.  This section
 	 * assumes that a card with a 79C978 wants to go into 1Mb HomePNA
 	 * mode.  The 79C978 can also go into standard ethernet, and there
@@ -598,16 +567,16 @@
 	break;
     default:
 	printk(KERN_INFO "pcnet32: PCnet version %#x, no PCnet32 chip.\n",chip_version);
-	return -ENODEV;
+	goto err_out_res;
     }
 
     /*
      *	On selected chips turn on the BCR18:NOUFLO bit. This stops transmit
      *	starting until the packet is loaded. Strike one for reliability, lose
-     *	one for latency - although on PCI this isnt a big loss. Older chips 
+     *	one for latency - although on PCI this isnt a big loss. Older chips
      *	have FIFO's smaller than a packet, so you can't do this.
      */
-	 
+
     if(fset)
     {
 	a->write_bcr(ioaddr, 18, (a->read_bcr(ioaddr, 18) | 0x0800));
@@ -617,10 +586,6 @@
 #endif
 	ltint = 1;
     }
-    
-    dev = init_etherdev(NULL, 0);
-    if(dev==NULL)
-	return -ENOMEM;
 
     printk(KERN_INFO "%s: %s at %#3lx,", dev->name, chipname, ioaddr);
 
@@ -653,22 +618,29 @@
     }
 
     dev->base_addr = ioaddr;
-    request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname);
-    
-    /* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
-    if ((lp = (struct pcnet32_private *)pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) == NULL)
-	return -ENOMEM;
 
-    memset(lp, 0, sizeof(*lp));
-    lp->dma_addr = lp_dma_addr;
-    lp->pci_dev = pdev;
-    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x", lp, lp_dma_addr);
+    lp = dev->priv;
 
+    lp->rx_ring = pci_alloc_consistent(pdev, DMA_ALLOC_SIZE, &lp->rx_ring_dma);
+    if (!lp->rx_ring) {
+	ret = -ENOMEM;
+	goto err_out_res;
+    }
+
+    printk(KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x\n", lp, lp->rx_ring_dma);
+
+    lp->tx_ring = ((void*)lp->rx_ring) +
+    		  sizeof(struct pcnet32_rx_head) * RX_RING_SIZE;
+    lp->init_block = ((void*)lp->tx_ring) +
+		     sizeof(struct pcnet32_rx_head) * TX_RING_SIZE;
+    lp->tx_ring_dma = lp->rx_ring_dma +
+    		      sizeof(struct pcnet32_rx_head) * RX_RING_SIZE;
+    lp->init_block_dma = lp->tx_ring_dma +
+			 sizeof(struct pcnet32_rx_head) * TX_RING_SIZE;
+
     spin_lock_init(&lp->lock);
-    
-    dev->priv = lp;
+    lp->pci_dev = pdev;
     lp->name = chipname;
-    lp->shared_irq = shared;
     lp->full_duplex = fdx;
 #ifdef DO_DXSUFLO
     lp->dxsuflo = dxsuflo;
@@ -679,44 +651,43 @@
 	lp->options = PORT_ASEL;
     else
 	lp->options = options_mapping[options[card_idx]];
-    
+
     if (fdx && !(lp->options & PORT_ASEL) && full_duplex[card_idx])
 	lp->options |= PORT_FD;
-    
+
     if (a == NULL) {
       printk(KERN_ERR "pcnet32: No access methods\n");
-      return -ENODEV;
+      goto err_out_dma_mem;
     }
     lp->a = *a;
-    
+
     /* detect special T1/E1 WAN card by checking for MAC address */
     if (dev->dev_addr[0] == 0x00 && dev->dev_addr[1] == 0xe0 && dev->dev_addr[2] == 0x75)
 	lp->options = PORT_FD | PORT_GPSI;
 
-    lp->init_block.mode = le16_to_cpu(0x0003);	/* Disable Rx and Tx. */
-    lp->init_block.tlen_rlen = le16_to_cpu(TX_RING_LEN_BITS | RX_RING_LEN_BITS); 
+    lp->init_block->mode = cpu_to_le16(0x0003);	/* Disable Rx and Tx. */
+    lp->init_block->tlen_rlen = cpu_to_le16(TX_RING_LEN_BITS | RX_RING_LEN_BITS);
     for (i = 0; i < 6; i++)
-	lp->init_block.phys_addr[i] = dev->dev_addr[i];
-    lp->init_block.filter[0] = 0x00000000;
-    lp->init_block.filter[1] = 0x00000000;
-    lp->init_block.rx_ring = (u32)le32_to_cpu(lp->dma_addr + offsetof(struct pcnet32_private, rx_ring));
-    lp->init_block.tx_ring = (u32)le32_to_cpu(lp->dma_addr + offsetof(struct pcnet32_private, tx_ring));
-    
+	lp->init_block->phys_addr[i] = dev->dev_addr[i];
+    lp->init_block->filter[0] = 0x00000000;
+    lp->init_block->filter[1] = 0x00000000;
+    lp->init_block->rx_ring = cpu_to_le32(lp->rx_ring_dma);
+    lp->init_block->tx_ring = cpu_to_le32(lp->tx_ring_dma);
+
     /* switch pcnet32 to 32bit mode */
     a->write_bcr (ioaddr, 20, 2);
 
-    a->write_csr (ioaddr, 1, (lp->dma_addr + offsetof(struct pcnet32_private, init_block)) & 0xffff);
-    a->write_csr (ioaddr, 2, (lp->dma_addr + offsetof(struct pcnet32_private, init_block)) >> 16);
-    
-    if (irq_line) {
-	dev->irq = irq_line;
-    }
-    
+    /* XXX endian problems here? */
+    a->write_csr (ioaddr, 1, lp->init_block_dma & 0xffff);
+    a->write_csr (ioaddr, 2, lp->init_block_dma >> 16);
+
+    dev->irq = pdev->irq;
+
     if (dev->irq >= 2)
 	printk(" assigned IRQ %d.\n", dev->irq);
     else {
 	unsigned long irq_mask = probe_irq_on();
-	
+
 	/*
 	 * To auto-IRQ we enable the initialization-done and DMA error
 	 * interrupts. For ISA boards we get a DMA error, but VLB and PCI
@@ -725,7 +696,7 @@
 	/* Trigger an initialization just for the interrupt. */
 	a->write_csr (ioaddr, 0, 0x41);
 	mdelay (1);
-	
+
 	dev->irq = probe_irq_off (irq_mask);
 	if (dev->irq)
 	    printk(", probed IRQ %d.\n", dev->irq);
@@ -737,7 +708,7 @@
 
     if (pcnet32_debug > 0)
 	printk(KERN_INFO "%s", version);
-    
+
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
     dev->hard_start_xmit = &pcnet32_start_xmit;
@@ -748,30 +719,32 @@
     dev->do_ioctl = &pcnet32_mii_ioctl;
 #endif
     dev->tx_timeout = pcnet32_tx_timeout;
-    dev->watchdog_timeo = (HZ >> 1);
-
-    lp->next = pcnet32_dev;
-    pcnet32_dev = dev;
+    dev->watchdog_timeo = (1 * HZ);
 
-    /* Fill in the generic fields of the device structure. */
-    ether_setup(dev);
+    pci_set_drvdata(pdev, dev);
     return 0;
+
+err_out_dma_mem:
+    pci_free_consistent(pdev, DMA_ALLOC_SIZE, lp->rx_ring, lp->rx_ring_dma);
+err_out_res:
+    release_region(ioaddr, PCNET32_TOTAL_SIZE);
+err_out:
+    unregister_netdev(dev);
+    kfree(dev);
+    return ret;
 }
+
 
-
 static int
 pcnet32_open(struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     unsigned long ioaddr = dev->base_addr;
     u16 val;
-    int i;
+    int i, ret;
 
-    if (dev->irq == 0 ||
-	request_irq(dev->irq, &pcnet32_interrupt,
-		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
-	return -EAGAIN;
-    }
+    ret = request_irq(dev->irq, &pcnet32_interrupt, SA_SHIRQ, lp->name, dev);
+    if (ret) return ret;
 
     /* Reset the PCNET32 */
     lp->a.reset (ioaddr);
@@ -781,17 +754,15 @@
 
     if (pcnet32_debug > 1)
 	printk(KERN_DEBUG "%s: pcnet32_open() irq %d tx/rx rings %#x/%#x init %#x.\n",
-	       dev->name, dev->irq,
-	       (u32) (lp->dma_addr + offsetof(struct pcnet32_private, tx_ring)),
-	       (u32) (lp->dma_addr + offsetof(struct pcnet32_private, rx_ring)),
-	       (u32) (lp->dma_addr + offsetof(struct pcnet32_private, init_block)));
-    
+	       dev->name, dev->irq, (u32) lp->tx_ring_dma,
+	       (u32) lp->rx_ring_dma, (u32) lp->init_block_dma);
+
     /* set/reset autoselect bit */
     val = lp->a.read_bcr (ioaddr, 2) & ~2;
     if (lp->options & PORT_ASEL)
 	val |= 2;
     lp->a.write_bcr (ioaddr, 2, val);
-    
+
     /* handle full duplex setting */
     if (lp->full_duplex) {
 	val = lp->a.read_bcr (ioaddr, 9) & ~3;
@@ -802,13 +773,13 @@
 	}
 	lp->a.write_bcr (ioaddr, 9, val);
     }
-    
+
     /* set/reset GPSI bit in test register */
     val = lp->a.read_csr (ioaddr, 124) & ~0x10;
     if ((lp->options & PORT_PORTSEL) == PORT_GPSI)
 	val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);
-    
+
     if (lp->mii & !(lp->options & PORT_ASEL)) {
 	val = lp->a.read_bcr (ioaddr, 32) & ~0x38; /* disable Auto Negotiation, set 10Mpbs, HD */
 	if (lp->options & PORT_FD)
@@ -818,7 +789,7 @@
 	lp->a.write_bcr (ioaddr, 32, val);
     }
 
-#ifdef DO_DXSUFLO 
+#ifdef DO_DXSUFLO
     if (lp->dxsuflo) { /* Disable transmit stop on underflow */
 	val = lp->a.read_csr (ioaddr, 3);
 	val |= 0x40;
@@ -830,16 +801,25 @@
 	val |= (1<<14);
 	lp->a.write_csr (ioaddr, 5, val);
     }
-   
-    lp->init_block.mode = le16_to_cpu((lp->options & PORT_PORTSEL) << 7);
-    lp->init_block.filter[0] = 0x00000000;
-    lp->init_block.filter[1] = 0x00000000;
-    if (pcnet32_init_ring(dev))
-	return -ENOMEM;
-    
+
+    lp->init_block->mode = cpu_to_le16((lp->options & PORT_PORTSEL) << 7);
+    lp->init_block->filter[0] = 0x00000000;
+    lp->init_block->filter[1] = 0x00000000;
+    ret = pcnet32_init_ring(dev);
+    if (ret) {
+    	free_irq(dev->irq, dev);
+	for (i = 0; i < RX_RING_SIZE; i++)
+	    if (lp->rx_skbuff[i]) {
+	    	dev_kfree_skb(lp->rx_skbuff[i]);
+		lp->rx_skbuff[i] = NULL;
+	    }
+	return ret;
+    }
+
     /* Re-initialize the PCNET32, and start it when done. */
-    lp->a.write_csr (ioaddr, 1, (lp->dma_addr + offsetof(struct pcnet32_private, init_block)) &0xffff);
-    lp->a.write_csr (ioaddr, 2, (lp->dma_addr + offsetof(struct pcnet32_private, init_block)) >> 16);
+    /* XXX endian problems here? */
+    lp->a.write_csr (ioaddr, 1, lp->init_block_dma & 0xffff);
+    lp->a.write_csr (ioaddr, 2, lp->init_block_dma >> 16);
 
     lp->a.write_csr (ioaddr, 4, 0x0915);
     lp->a.write_csr (ioaddr, 0, 0x0001);
@@ -850,7 +830,7 @@
     while (i++ < 100)
 	if (lp->a.read_csr (ioaddr, 0) & 0x0100)
 	    break;
-    /* 
+    /*
      * We used to clear the InitDone bit, 0x0100, here but Mark Stockton
      * reports that doing so triggers a bug in the '974.
      */
@@ -858,13 +838,10 @@
 
     if (pcnet32_debug > 2)
 	printk(KERN_DEBUG "%s: pcnet32 open after %d ticks, init block %#x csr0 %4.4x.\n",
-	       dev->name, i, (u32) (lp->dma_addr + offsetof(struct pcnet32_private, init_block)),
+	       dev->name, i, (u32) lp->init_block_dma,
 	       lp->a.read_csr (ioaddr, 0));
-
 
-    MOD_INC_USE_COUNT;
-    
-    return 0;	/* Always succeed */
+    return 0;
 }
 
 /*
@@ -880,16 +857,16 @@
  * restarting the chip, but I'm too lazy to do so right now.  dplatt@3do.com
  */
 
-static void 
+static void
 pcnet32_purge_tx_ring(struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     int i;
 
     for (i = 0; i < TX_RING_SIZE; i++) {
 	if (lp->tx_skbuff[i]) {
             pci_unmap_single(lp->pci_dev, lp->tx_dma_addr[i], lp->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
-	    dev_kfree_skb(lp->tx_skbuff[i]); 
+	    dev_kfree_skb_any(lp->tx_skbuff[i]);
 	    lp->tx_skbuff[i] = NULL;
             lp->tx_dma_addr[i] = 0;
 	}
@@ -901,10 +878,9 @@
 static int
 pcnet32_init_ring(struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     int i;
 
-    lp->tx_full = 0;
     lp->cur_rx = lp->cur_tx = 0;
     lp->dirty_rx = lp->dirty_tx = 0;
 
@@ -914,14 +890,14 @@
 	    if (!(rx_skbuff = lp->rx_skbuff[i] = dev_alloc_skb (PKT_BUF_SZ))) {
 		/* there is not much, we can do at this point */
 		printk(KERN_ERR "%s: pcnet32_init_ring dev_alloc_skb failed.\n",dev->name);
-		return -1;
+		return -ENOMEM;
 	    }
 	    skb_reserve (rx_skbuff, 2);
 	}
         lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, rx_skbuff->len, PCI_DMA_FROMDEVICE);
-	lp->rx_ring[i].base = (u32)le32_to_cpu(lp->rx_dma_addr[i]);
-	lp->rx_ring[i].buf_length = le16_to_cpu(-PKT_BUF_SZ);
-	lp->rx_ring[i].status = le16_to_cpu(0x8000);
+	lp->rx_ring[i].base = cpu_to_le32(lp->rx_dma_addr[i]);
+	lp->rx_ring[i].buf_length = cpu_to_le16(-PKT_BUF_SZ);
+	lp->rx_ring[i].status = cpu_to_le16(0x8000);
     }
     /* The Tx buffer address is filled in as needed, but we do need to clear
        the upper ownership bit. */
@@ -931,25 +907,25 @@
         lp->tx_dma_addr[i] = 0;
     }
 
-    lp->init_block.tlen_rlen = le16_to_cpu(TX_RING_LEN_BITS | RX_RING_LEN_BITS);
+    lp->init_block->tlen_rlen = cpu_to_le16(TX_RING_LEN_BITS | RX_RING_LEN_BITS);
     for (i = 0; i < 6; i++)
-	lp->init_block.phys_addr[i] = dev->dev_addr[i];
-    lp->init_block.rx_ring = (u32)le32_to_cpu(lp->dma_addr + offsetof(struct pcnet32_private, rx_ring));
-    lp->init_block.tx_ring = (u32)le32_to_cpu(lp->dma_addr + offsetof(struct pcnet32_private, tx_ring));
+	lp->init_block->phys_addr[i] = dev->dev_addr[i];
+    lp->init_block->rx_ring = cpu_to_le32(lp->rx_ring_dma);
+    lp->init_block->tx_ring = cpu_to_le32(lp->tx_ring_dma);
     return 0;
 }
 
 static void
 pcnet32_restart(struct net_device *dev, unsigned int csr0_bits)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     unsigned long ioaddr = dev->base_addr;
     int i;
-    
+
     pcnet32_purge_tx_ring(dev);
     if (pcnet32_init_ring(dev))
 	return;
-    
+
     /* ReInit Ring */
     lp->a.write_csr (ioaddr, 0, 1);
     i = 0;
@@ -964,30 +940,41 @@
 static void
 pcnet32_tx_timeout (struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
-    unsigned int ioaddr = dev->base_addr;
+	struct pcnet32_private *lp = dev->priv;
+	unsigned int ioaddr = dev->base_addr;
 
-    /* Transmitter timeout, serious problems. */
+	/* Transmitter timeout, serious problems. */
 	printk(KERN_ERR "%s: transmit timed out, status %4.4x, resetting.\n",
 	       dev->name, lp->a.read_csr (ioaddr, 0));
+
+	spin_lock_irq(&lp->lock);
 	lp->a.write_csr (ioaddr, 0, 0x0004);
+	spin_unlock_irq(&lp->lock);
+
 	lp->stats.tx_errors++;
 	if (pcnet32_debug > 2) {
 	    int i;
 	    printk(KERN_DEBUG " Ring data dump: dirty_tx %d cur_tx %d%s cur_rx %d.",
-	       lp->dirty_tx, lp->cur_tx, lp->tx_full ? " (full)" : "",
+	       lp->dirty_tx, lp->cur_tx, netif_queue_stopped(dev) ? " (full)" : "",
 	       lp->cur_rx);
 	    for (i = 0 ; i < RX_RING_SIZE; i++)
 	    printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
-		   lp->rx_ring[i].base, -lp->rx_ring[i].buf_length,
-		   lp->rx_ring[i].msg_length, (unsigned)lp->rx_ring[i].status);
+		   le32_to_cpu(lp->rx_ring[i].base),
+		   -le16_to_cpu(lp->rx_ring[i].buf_length),
+		   le32_to_cpu(lp->rx_ring[i].msg_length),
+		   (unsigned)le16_to_cpu(lp->rx_ring[i].status));
 	    for (i = 0 ; i < TX_RING_SIZE; i++)
 	    printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
-		   lp->tx_ring[i].base, -lp->tx_ring[i].length,
-		   lp->tx_ring[i].misc, (unsigned)lp->tx_ring[i].status);
-	    printk("\n");
+		   le32_to_cpu(lp->tx_ring[i].base),
+		   -le16_to_cpu(lp->tx_ring[i].length),
+		   le32_to_cpu(lp->tx_ring[i].misc),
+		   (unsigned)le16_to_cpu(lp->tx_ring[i].status));
+	    printk(KERN_DEBUG "\n");
 	}
+
+	spin_lock_irq(&lp->lock);
 	pcnet32_restart(dev, 0x0042);
+	spin_unlock_irq(&lp->lock);
 
 	dev->trans_start = jiffies;
 	netif_start_queue(dev);
@@ -997,19 +984,18 @@
 static int
 pcnet32_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     unsigned int ioaddr = dev->base_addr;
     u16 status;
     int entry;
-    unsigned long flags;
 
     if (pcnet32_debug > 3) {
+	spin_lock_irq(&lp->lock);
 	printk(KERN_DEBUG "%s: pcnet32_start_xmit() called, csr0 %4.4x.\n",
 	       dev->name, lp->a.read_csr (ioaddr, 0));
+	spin_unlock_irq(&lp->lock);
     }
 
-    spin_lock_irqsave(&lp->lock, flags);
-
     /* Default status -- will not enable Successful-TxDone
      * interrupt when that option is available to us.
      */
@@ -1025,39 +1011,39 @@
 	 */
 	status = 0x9300;
     }
-  
+
     /* Fill in a Tx ring entry */
-  
+
     /* Mask to ring buffer boundary. */
     entry = lp->cur_tx & TX_RING_MOD_MASK;
-  
+
     /* Caution: the write order is important here, set the base address
        with the "ownership" bits last. */
 
-    lp->tx_ring[entry].length = le16_to_cpu(-skb->len);
+    lp->tx_ring[entry].length = cpu_to_le16(-skb->len);
 
     lp->tx_ring[entry].misc = 0x00000000;
 
     lp->tx_skbuff[entry] = skb;
     lp->tx_dma_addr[entry] = pci_map_single(lp->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE);
-    lp->tx_ring[entry].base = (u32)le32_to_cpu(lp->tx_dma_addr[entry]);
-    lp->tx_ring[entry].status = le16_to_cpu(status);
+    lp->tx_ring[entry].base = cpu_to_le32(lp->tx_dma_addr[entry]);
+    lp->tx_ring[entry].status = cpu_to_le16(status);
 
     lp->cur_tx++;
     lp->stats.tx_bytes += skb->len;
 
     /* Trigger an immediate send poll. */
+    spin_lock_irq(&lp->lock);
     lp->a.write_csr (ioaddr, 0, 0x0048);
+    spin_unlock_irq(&lp->lock);
 
     dev->trans_start = jiffies;
 
-    if (lp->tx_ring[(entry+1) & TX_RING_MOD_MASK].base == 0)
-	netif_start_queue(dev);
-    else {
-	lp->tx_full = 1;
+    if ((lp->cur_tx - lp->dirty_tx) > TX_RING_SIZE)
+	BUG();
+    if ((lp->cur_tx - lp->dirty_tx) == TX_RING_SIZE)
 	netif_stop_queue(dev);
-    }
-    spin_unlock_irqrestore(&lp->lock, flags);
+
     return 0;
 }
 
@@ -1065,7 +1051,7 @@
 static void
 pcnet32_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-    struct net_device *dev = (struct net_device *)dev_id;
+    struct net_device *dev = dev_id;
     struct pcnet32_private *lp;
     unsigned long ioaddr;
     u16 csr0,rap;
@@ -1078,10 +1064,10 @@
     }
 
     ioaddr = dev->base_addr;
-    lp = (struct pcnet32_private *)dev->priv;
-    
+    lp = dev->priv;
+
     spin_lock(&lp->lock);
-    
+
     rap = lp->a.read_rap(ioaddr);
     while ((csr0 = lp->a.read_csr (ioaddr, 0)) & 0x8600 && --boguscnt >= 0) {
 	/* Acknowledge all of the current interrupt sources ASAP. */
@@ -1102,7 +1088,7 @@
 	    while (dirty_tx < lp->cur_tx) {
 		int entry = dirty_tx & TX_RING_MOD_MASK;
 		int status = (short)le16_to_cpu(lp->tx_ring[entry].status);
-			
+
 		if (status < 0)
 		    break;		/* It still hasn't been Txed */
 
@@ -1155,17 +1141,15 @@
 #ifndef final_version
 	    if (lp->cur_tx - dirty_tx >= TX_RING_SIZE) {
 		printk(KERN_ERR "out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
-		       dirty_tx, lp->cur_tx, lp->tx_full);
+		       dirty_tx, lp->cur_tx, netif_queue_stopped(dev) ? 1 : 0);
 		dirty_tx += TX_RING_SIZE;
 	    }
 #endif
-	    if (lp->tx_full &&
-		netif_queue_stopped(dev) &&
-		dirty_tx > lp->cur_tx - TX_RING_SIZE + 2) {
-		/* The ring is no longer full, clear tbusy. */
-		lp->tx_full = 0;
+	    /* If the ring is no longer full, accept more packets. */
+	    if (netif_queue_stopped(dev) &&
+		(dirty_tx > lp->cur_tx - TX_RING_SIZE + 2))
 		netif_wake_queue (dev);
-	    }
+
 	    lp->dirty_tx = dirty_tx;
 	}
 
@@ -1200,7 +1184,7 @@
     /* Clear any other interrupt, and set interrupt enable. */
     lp->a.write_csr (ioaddr, 0, 0x7940);
     lp->a.write_rap(ioaddr,rap);
-    
+
     if (pcnet32_debug > 4)
 	printk(KERN_DEBUG "%s: exiting interrupt, csr0=%#4.4x.\n",
 	       dev->name, lp->a.read_csr (ioaddr, 0));
@@ -1211,7 +1195,7 @@
 static int
 pcnet32_rx(struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     int entry = lp->cur_rx & RX_RING_MOD_MASK;
 
     /* If we own the next entry, it's a new packet. Send it up. */
@@ -1219,7 +1203,7 @@
 	int status = (short)le16_to_cpu(lp->rx_ring[entry].status) >> 8;
 
 	if (status != 0x03) {			/* There was an error. */
-	    /* 
+	    /*
 	     * There is a tricky error noted by John Murphy,
 	     * <murf@perftech.com> to Russ Nelson: Even with full-sized
 	     * buffers it's possible for a jabber packet to use two
@@ -1231,12 +1215,13 @@
 	    if (status & 0x10) lp->stats.rx_over_errors++;
 	    if (status & 0x08) lp->stats.rx_crc_errors++;
 	    if (status & 0x04) lp->stats.rx_fifo_errors++;
-	    lp->rx_ring[entry].status &= le16_to_cpu(0x03ff);
+	    lp->rx_ring[entry].status =
+		cpu_to_le16(le16_to_cpu(lp->rx_ring[entry].status) & 0x03ff);
 	} else {
 	    /* Malloc up new buffer, compatible with net-2e. */
 	    short pkt_len = (le32_to_cpu(lp->rx_ring[entry].msg_length) & 0xfff)-4;
 	    struct sk_buff *skb;
-			
+
 	    if(pkt_len < 60) {
 		printk(KERN_ERR "%s: Runt packet!\n",dev->name);
 		lp->stats.rx_errors++;
@@ -1245,7 +1230,7 @@
 
 		if (pkt_len > rx_copybreak) {
 		    struct sk_buff *newskb;
-				
+
 		    if ((newskb = dev_alloc_skb (PKT_BUF_SZ))) {
 			skb_reserve (newskb, 2);
 			skb = lp->rx_skbuff[entry];
@@ -1253,14 +1238,14 @@
 			lp->rx_skbuff[entry] = newskb;
 			newskb->dev = dev;
                         lp->rx_dma_addr[entry] = pci_map_single(lp->pci_dev, newskb->tail, newskb->len, PCI_DMA_FROMDEVICE);
-			lp->rx_ring[entry].base = le32_to_cpu(lp->rx_dma_addr[entry]);
+			lp->rx_ring[entry].base = cpu_to_le32(lp->rx_dma_addr[entry]);
 			rx_in_place = 1;
 		    } else
 			skb = NULL;
 		} else {
 		    skb = dev_alloc_skb(pkt_len+2);
                 }
-			    
+
 		if (skb == NULL) {
                     int i;
 		    printk(KERN_ERR "%s: Memory squeeze, deferring packet.\n", dev->name);
@@ -1270,7 +1255,8 @@
 
 		    if (i > RX_RING_SIZE -2) {
 			lp->stats.rx_dropped++;
-			lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
+			lp->rx_ring[entry].status =
+			    cpu_to_le16(le16_to_cpu(lp->rx_ring[entry].status) | 0x8000);
 			lp->cur_rx++;
 		    }
 		    break;
@@ -1293,8 +1279,9 @@
 	 * The docs say that the buffer length isn't touched, but Andrew Boyd
 	 * of QNX reports that some revs of the 79C965 clear it.
 	 */
-	lp->rx_ring[entry].buf_length = le16_to_cpu(-PKT_BUF_SZ);
-	lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
+	lp->rx_ring[entry].buf_length = cpu_to_le16(-PKT_BUF_SZ);
+	lp->rx_ring[entry].status =
+	    cpu_to_le16(le16_to_cpu(lp->rx_ring[entry].status) | 0x8000);
 	entry = (++lp->cur_rx) & RX_RING_MOD_MASK;
     }
 
@@ -1305,11 +1292,13 @@
 pcnet32_close(struct net_device *dev)
 {
     unsigned long ioaddr = dev->base_addr;
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     int i;
 
     netif_stop_queue(dev);
 
+    spin_lock_irq(&lp->lock);
+
     lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
 
     if (pcnet32_debug > 1)
@@ -1320,16 +1309,19 @@
     lp->a.write_csr (ioaddr, 0, 0x0004);
 
     /*
-     * Switch back to 16bit mode to avoid problems with dumb 
+     * Switch back to 16bit mode to avoid problems with dumb
      * DOS packet driver after a warm reboot
      */
     lp->a.write_bcr (ioaddr, 20, 4);
 
+    spin_unlock_irq(&lp->lock);
+    synchronize_irq();
+
     free_irq(dev->irq, dev);
-    
+
     /* free all allocated skbuffs */
     for (i = 0; i < RX_RING_SIZE; i++) {
-	lp->rx_ring[i].status = 0;			    
+	lp->rx_ring[i].status = 0;
 	if (lp->rx_skbuff[i]) {
             pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], lp->rx_skbuff[i]->len, PCI_DMA_FROMDEVICE);
 	    dev_kfree_skb(lp->rx_skbuff[i]);
@@ -1337,7 +1329,7 @@
 	lp->rx_skbuff[i] = NULL;
         lp->rx_dma_addr[i] = 0;
     }
-    
+
     for (i = 0; i < TX_RING_SIZE; i++) {
 	if (lp->tx_skbuff[i]) {
             pci_unmap_single(lp->pci_dev, lp->tx_dma_addr[i], lp->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
@@ -1346,8 +1338,6 @@
 	lp->tx_skbuff[i] = NULL;
         lp->tx_dma_addr[i] = 0;
     }
-    
-    MOD_DEC_USE_COUNT;
 
     return 0;
 }
@@ -1355,16 +1345,15 @@
 static struct net_device_stats *
 pcnet32_get_stats(struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;
+    struct pcnet32_private *lp = dev->priv;
     unsigned long ioaddr = dev->base_addr;
     u16 saved_addr;
-    unsigned long flags;
 
-    spin_lock_irqsave(&lp->lock, flags);
+    spin_lock_irq(&lp->lock);
     saved_addr = lp->a.read_rap(ioaddr);
     lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
     lp->a.write_rap(ioaddr, saved_addr);
-    spin_unlock_irqrestore(&lp->lock, flags);
+    spin_unlock_irq(&lp->lock);
 
     return &lp->stats;
 }
@@ -1372,16 +1361,16 @@
 /* taken from the sunlance driver, which it took from the depca driver */
 static void pcnet32_load_multicast (struct net_device *dev)
 {
-    struct pcnet32_private *lp = (struct pcnet32_private *) dev->priv;
-    volatile struct pcnet32_init_block *ib = &lp->init_block;
+    struct pcnet32_private *lp = dev->priv;
+    volatile struct pcnet32_init_block *ib = lp->init_block;
     volatile u16 *mcast_table = (u16 *)&ib->filter;
     struct dev_mc_list *dmi=dev->mc_list;
     char *addrs;
     int i, j, bit, byte;
     u32 crc, poly = CRC_POLYNOMIAL_LE;
-	
+
     /* set all multicast bits */
-    if (dev->flags & IFF_ALLMULTI){ 
+    if (dev->flags & IFF_ALLMULTI){
 	ib->filter [0] = 0xffffffff;
 	ib->filter [1] = 0xffffffff;
 	return;
@@ -1394,24 +1383,24 @@
     for (i = 0; i < dev->mc_count; i++){
 	addrs = dmi->dmi_addr;
 	dmi   = dmi->next;
-	
+
 	/* multicast address? */
 	if (!(*addrs & 1))
 	    continue;
-	
+
 	crc = 0xffffffff;
 	for (byte = 0; byte < 6; byte++)
 	    for (bit = *addrs++, j = 0; j < 8; j++, bit >>= 1) {
 		int test;
-		
+
 		test = ((bit ^ crc) & 0x01);
 		crc >>= 1;
-		
+
 		if (test) {
 		    crc = crc ^ poly;
 		}
 	    }
-	
+
 	crc = crc >> 26;
 	mcast_table [crc >> 4] |= 1 << (crc & 0xf);
     }
@@ -1425,30 +1414,38 @@
 static void pcnet32_set_multicast_list(struct net_device *dev)
 {
     unsigned long ioaddr = dev->base_addr;
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;	 
+    struct pcnet32_private *lp = dev->priv;
+
+    spin_lock_irq(&lp->lock);
 
     if (dev->flags&IFF_PROMISC) {
 	/* Log any net taps. */
 	printk(KERN_INFO "%s: Promiscuous mode enabled.\n", dev->name);
-	lp->init_block.mode = le16_to_cpu(0x8000 | (lp->options & PORT_PORTSEL) << 7);
+	lp->init_block->mode = cpu_to_le16(0x8000 | (lp->options & PORT_PORTSEL) << 7);
     } else {
-	lp->init_block.mode = le16_to_cpu((lp->options & PORT_PORTSEL) << 7);
+	lp->init_block->mode = cpu_to_le16((lp->options & PORT_PORTSEL) << 7);
 	pcnet32_load_multicast (dev);
     }
-    
+
     lp->a.write_csr (ioaddr, 0, 0x0004); /* Temporarily stop the lance. */
 
     pcnet32_restart(dev, 0x0042); /*  Resume normal operation */
+
+    spin_unlock_irq(&lp->lock);
 }
 
 #ifdef HAVE_PRIVATE_IOCTL
 static int pcnet32_mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
     unsigned long ioaddr = dev->base_addr;
-    struct pcnet32_private *lp = (struct pcnet32_private *)dev->priv;	 
+    struct pcnet32_private *lp = dev->priv;
     u16 *data = (u16 *)&rq->ifr_data;
-    int phyaddr = lp->a.read_bcr (ioaddr, 33);
+    int ret = -EOPNOTSUPP, phyaddr;
+
+    spin_lock_irq(&lp->lock);
 
+    phyaddr = lp->a.read_bcr (ioaddr, 33);
+
     if (lp->mii) {
 	switch(cmd) {
 	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
@@ -1458,27 +1455,45 @@
 	    lp->a.write_bcr (ioaddr, 33, ((data[0] & 0x1f) << 5) | (data[1] & 0x1f));
 	    data[3] = lp->a.read_bcr (ioaddr, 34);
 	    lp->a.write_bcr (ioaddr, 33, phyaddr);
-	    return 0;
+	    ret = 0;
+	    break;
 	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */
 	    if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 	    lp->a.write_bcr (ioaddr, 33, ((data[0] & 0x1f) << 5) | (data[1] & 0x1f));
 	    lp->a.write_bcr (ioaddr, 34, data[2]);
 	    lp->a.write_bcr (ioaddr, 33, phyaddr);
-	    return 0;
-	default:
-	    return -EOPNOTSUPP;
+	    ret = 0;
+	    break;
+	default: /* do nothing */
+	    break;
 	}
     }
-    return -EOPNOTSUPP;
+
+    spin_unlock_irq(&lp->lock);
+    return ret;
 }
 #endif	/* HAVE_PRIVATE_IOCTL */
-					    
+
+static void __exit pcnet32_remove_one (struct pci_dev *pdev)
+{
+    struct net_device *dev = pci_get_drvdata(pdev);
+    struct pcnet32_private *lp = dev->priv;
+
+    if (!dev)
+	BUG();
+    unregister_netdev(dev);
+    release_region(dev->base_addr, PCNET32_TOTAL_SIZE);
+    pci_free_consistent(pdev, DMA_ALLOC_SIZE, lp->rx_ring, lp->rx_ring_dma);
+    kfree(dev);
+    pci_set_drvdata(pdev, NULL);
+}
+
 static struct pci_driver pcnet32_driver = {
-    name:  "pcnet32",
-    probe: pcnet32_probe_pci,
-    remove: NULL,
-    id_table: pcnet32_pci_tbl,
+    name:	"pcnet32",
+    probe:	pcnet32_probe_pci,
+    remove:	pcnet32_remove_one,
+    id_table:	pcnet32_pci_tbl,
 };
 
 MODULE_PARM(debug, "i");
@@ -1496,52 +1511,29 @@
 
 static int __init pcnet32_init_module(void)
 {
-    int cards_found = 0;
-    int err;
+    int cards_found;
 
     if (debug > 0)
 	pcnet32_debug = debug;
+
     if ((tx_start_pt >= 0) && (tx_start_pt <= 3))
 	tx_start = tx_start_pt;
-    
-    pcnet32_dev = NULL;
+
     /* find the PCI devices */
-#define USE_PCI_REGISTER_DRIVER
-#ifdef USE_PCI_REGISTER_DRIVER
-    if ((err = pci_module_init(&pcnet32_driver)) < 0 )
-       return err;
-#else
-    {
-        struct pci_device_id *devid = pcnet32_pci_tbl;
-        for (devid = pcnet32_pci_tbl; devid != NULL && devid->vendor != 0; devid++) {
-            struct pci_dev *pdev = pci_find_subsys(devid->vendor, devid->device, devid->subvendor, devid->subdevice, NULL);
-            if (pdev != NULL) {
-                if (pcnet32_probe_pci(pdev, devid) >= 0) {
-                    cards_found++;
-                }
-            }
-        }
+    cards_found = pci_register_driver(&pcnet32_driver);
+    if (cards_found < 0)
+	return cards_found;
+    if (cards_found == 0) {
+	pci_unregister_driver(&pcnet32_driver);
+	return -ENODEV;
     }
-#endif
+
     return 0;
-    /* find any remaining VLbus devices */
-    return pcnet32_probe_vlbus(cards_found);
 }
 
 static void __exit pcnet32_cleanup_module(void)
 {
-    struct net_device *next_dev;
-
-    /* No need to check MOD_IN_USE, as sys_delete_module() checks. */
-    while (pcnet32_dev) {
-        struct pcnet32_private *lp = (struct pcnet32_private *) pcnet32_dev->priv;
-	next_dev = lp->next;
-	unregister_netdev(pcnet32_dev);
-	release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
-        pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
-	kfree(pcnet32_dev);
-	pcnet32_dev = next_dev;
-    }
+    pci_unregister_driver(&pcnet32_driver);
 }
 
 module_init(pcnet32_init_module);

--------------4545F122E1BF8157473CDD3E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
