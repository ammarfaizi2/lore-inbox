Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTEKKNO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTEKKNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:13:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3051 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261204AbTEKKMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:12:38 -0400
Date: Sun, 11 May 2003 12:25:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: asj@lanmedia.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] remove kernel 2.0 and 2.2 code from drivers/net/wan/lmc/*
Message-ID: <20030511102515.GE1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes obsolete #if'd code for kernel 2.0 and 2.2 from
drivers/net/wan/lmc/* (this includes the expansion of some #define's 
that were definded differently for different kernel versions).

I've tested the compilation with 2.5.69-bk4.

Please apply
Adrian


--- linux-2.5.55/drivers/net/wan/lmc/lmc_var.h.old	2003-01-10 11:48:33.000000000 +0100
+++ linux-2.5.55/drivers/net/wan/lmc/lmc_var.h	2003-01-10 11:49:14.000000000 +0100
@@ -48,9 +48,6 @@
 #define u_int16_t	u16
 #define u_int8_t	u8
 #define tulip_uint32_t	u32
-#if LINUX_VERSION_CODE < 0x20155
-#define u_int32_t	u32
-#endif
 
 #define LMC_REG_RANGE 0x80
 
@@ -410,9 +407,7 @@
         u32                     last_int;
         u32                     num_int;
 
-#if LINUX_VERSION_CODE >= 0x20200
 	spinlock_t              lmc_lock;
-#endif
         u_int16_t               if_type;       /* PPP or NET */
         struct ppp_device       *pd;
 
@@ -550,10 +545,6 @@
 #define LMC_CRC_LEN_16 2  /* 16-bit CRC */
 #define LMC_CRC_LEN_32 4
 
-#if LINUX_VERSION_CODE < 0x20100
-#define test_and_set_bit(val, addr) set_bit(val, addr)
-#endif
-
 #ifdef LMC_HDLC
 /* definition of an hdlc header. */
 struct hdlc_hdr
--- linux-2.5.55/drivers/net/wan/lmc/lmc_media.c.old	2003-01-10 11:49:50.000000000 +0100
+++ linux-2.5.55/drivers/net/wan/lmc/lmc_media.c	2003-01-10 12:26:54.000000000 +0100
@@ -1,6 +1,5 @@
 /* $Id: lmc_media.c,v 1.13 2000/04/11 05:25:26 asj Exp $ */
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -11,9 +10,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#if LINUX_VERSION_CODE < 0x20155
-#include <linux/bios32.h>
-#endif
 #include <linux/in.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
@@ -28,11 +24,8 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-#if LINUX_VERSION_CODE >= 0x20200
 #include <asm/uaccess.h>
-#endif
 
-#include "lmc_ver.h"
 #include "lmc.h"
 #include "lmc_var.h"
 #include "lmc_ioctl.h"
--- linux-2.5.55/drivers/net/wan/lmc/lmc_debug.c.old	2003-01-10 12:29:02.000000000 +0100
+++ linux-2.5.55/drivers/net/wan/lmc/lmc_debug.c	2003-01-10 12:26:27.000000000 +0100
@@ -2,9 +2,7 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
-#include <linux/version.h>
 
-#include "lmc_ver.h"
 #include "lmc_debug.h"
 
 /*
--- linux-2.5.55/drivers/net/wan/lmc/lmc_proto.c.old	2003-01-10 12:28:52.000000000 +0100
+++ linux-2.5.55/drivers/net/wan/lmc/lmc_proto.c	2003-01-10 12:27:04.000000000 +0100
@@ -19,7 +19,6 @@
   * Driver for the LanMedia LMC5200, LMC5245, LMC1000, LMC1200 cards.
   */
 
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/timer.h>
@@ -46,7 +45,6 @@
 #include <asm/dma.h>
 #include <asm/smp.h>
 
-#include "lmc_ver.h"
 #include "lmc.h"
 #include "lmc_var.h"
 #include "lmc_debug.h"
@@ -66,14 +64,6 @@
 #define SPPP_attach(d)	(void)0
 #define SPPP_do_ioctl(d,i,c)	-EOPNOTSUPP
 #else
-#if LINUX_VERSION_CODE < 0x20363
-#define SPPP_attach(x)	sppp_attach((struct ppp_device *)(x)->lmc_device)
-#define SPPP_detach(x)	sppp_detach((x)->lmc_device)
-#define SPPP_open(x)	sppp_open((x)->lmc_device)
-#define SPPP_reopen(x)	sppp_reopen((x)->lmc_device)
-#define SPPP_close(x)	sppp_close((x)->lmc_device)
-#define SPPP_do_ioctl(x, y, z)	sppp_do_ioctl((x)->lmc_device, (y), (z))
-#else
 #define SPPP_attach(x)	sppp_attach((x)->pd)
 #define SPPP_detach(x)	sppp_detach((x)->pd->dev)
 #define SPPP_open(x)	sppp_open((x)->pd->dev)
@@ -81,7 +71,6 @@
 #define SPPP_close(x)	sppp_close((x)->pd->dev)
 #define SPPP_do_ioctl(x, y, z)	sppp_do_ioctl((x)->pd->dev, (y), (z))
 #endif
-#endif
 
 // init
 void lmc_proto_init(lmc_softc_t *sc) /*FOLD00*/
@@ -89,15 +78,12 @@
     lmc_trace(sc->lmc_device, "lmc_proto_init in");
     switch(sc->if_type){
     case LMC_PPP:
-        
-#if LINUX_VERSION_CODE >= 0x20363
         sc->pd = kmalloc(sizeof(struct ppp_device), GFP_KERNEL);
 	if (!sc->pd) {
 		printk("lmc_proto_init(): kmalloc failure!\n");
 		return;
 	}
         sc->pd->dev = sc->lmc_device;
-#endif
         sc->if_ptr = sc->pd;
         break;
     case LMC_RAW:
--- linux-2.5.55/drivers/net/wan/lmc/lmc_main.c.old	2003-01-10 11:52:23.000000000 +0100
+++ linux-2.5.55/drivers/net/wan/lmc/lmc_main.c	2003-01-10 12:58:53.000000000 +0100
@@ -11,7 +11,7 @@
   * With Help By:
   * David Boggs
   * Ron Crane
-  * Allan Cox
+  * Alan Cox
   *
   * This software may be used and distributed according to the terms
   * of the GNU General Public License version 2, incorporated herein by reference.
@@ -38,7 +38,6 @@
 
 /* $Id: lmc_main.c,v 1.36 2000/04/11 05:25:25 asj Exp $ */
 
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -51,9 +50,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#if LINUX_VERSION_CODE < 0x20155
-#include <linux/bios32.h>
-#endif
 #include <linux/in.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
@@ -67,12 +63,8 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#if LINUX_VERSION_CODE >= 0x20200
 #include <asm/uaccess.h>
 //#include <asm/spinlock.h>
-#else				/* 2.0 kernel */
-#define ARPHRD_HDLC 513
-#endif
 
 #define DRIVER_MAJOR_VERSION     1
 #define DRIVER_MINOR_VERSION    34
@@ -80,7 +72,6 @@
 
 #define DRIVER_VERSION  ((DRIVER_MAJOR_VERSION << 8) + DRIVER_MINOR_VERSION)
 
-#include "lmc_ver.h"
 #include "lmc.h"
 #include "lmc_var.h"
 #include "lmc_ioctl.h"
@@ -127,10 +118,8 @@
 static int lmc_init(struct net_device * const);
 static void lmc_reset(lmc_softc_t * const sc);
 static void lmc_dec_reset(lmc_softc_t * const sc);
-#if LINUX_VERSION_CODE >= 0x20363
 static void lmc_driver_timeout(struct net_device *dev);
 int lmc_setup(void);
-#endif
 
 
 /*
@@ -165,7 +154,8 @@
          * To date internally, just copy this out to the user.
          */
     case LMCIOCGINFO: /*fold01*/
-        LMC_COPY_TO_USER(ifr->ifr_data, &sc->ictl, sizeof (lmc_ctl_t));
+        if (copy_to_user(ifr->ifr_data, &sc->ictl, sizeof (lmc_ctl_t)))
+            return -EFAULT;
         ret = 0;
         break;
 
@@ -181,7 +171,8 @@
             break;
         }
 
-        LMC_COPY_FROM_USER(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t));
+        if (copy_from_user(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t)))
+            return -EFAULT;
 
         sc->lmc_media->set_status (sc, &ctl);
 
@@ -211,7 +202,8 @@
 		break;
 	    }
 
-	    LMC_COPY_FROM_USER(&new_type, ifr->ifr_data, sizeof(u_int16_t));
+	    if (copy_from_user(&new_type, ifr->ifr_data, sizeof(u_int16_t)))
+                return -EFAULT;
 
             
 	    if (new_type == old_type)
@@ -248,8 +240,9 @@
 
         sc->lmc_xinfo.Magic1 = 0xDEADBEEF;
 
-        LMC_COPY_TO_USER(ifr->ifr_data, &sc->lmc_xinfo,
-                         sizeof (struct lmc_xinfo));
+        if (copy_to_user(ifr->ifr_data, &sc->lmc_xinfo,
+                         sizeof (struct lmc_xinfo)))
+            return -EFAULT;
         ret = 0;
 
         break;
@@ -279,8 +272,9 @@
                 regVal & T1FRAMER_SEF_MASK;
         }
 
-        LMC_COPY_TO_USER(ifr->ifr_data, &sc->stats,
-                         sizeof (struct lmc_statistics));
+        if (copy_to_user(ifr->ifr_data, &sc->stats,
+                         sizeof (struct lmc_statistics)))
+            return -EFAULT;
 
         ret = 0;
         break;
@@ -310,7 +304,8 @@
             break;
         }
 
-        LMC_COPY_FROM_USER(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t));
+        if (copy_from_user(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t)))
+            return -EFAULT;
         sc->lmc_media->set_circuit_type(sc, ctl.circuit_type);
         sc->ictl.circuit_type = ctl.circuit_type;
         ret = 0;
@@ -335,8 +330,10 @@
 
 #ifdef DEBUG
     case LMCIOCDUMPEVENTLOG:
-        LMC_COPY_TO_USER(ifr->ifr_data, &lmcEventLogIndex, sizeof (u32));
-        LMC_COPY_TO_USER(ifr->ifr_data + sizeof (u32), lmcEventLogBuf, sizeof (lmcEventLogBuf));
+        if (copy_to_user(ifr->ifr_data, &lmcEventLogIndex, sizeof (u32)))
+            return -EFAULT;
+        if (copy_to_user(ifr->ifr_data + sizeof (u32), lmcEventLogBuf, sizeof (lmcEventLogBuf)))
+            return -EFAULT;
 
         ret = 0;
         break;
@@ -359,9 +356,10 @@
             /*
              * Stop the xwitter whlie we restart the hardware
              */
-            LMC_XMITTER_BUSY(dev);
+            netif_stop_queue(dev);
 
-            LMC_COPY_FROM_USER(&xc, ifr->ifr_data, sizeof (struct lmc_xilinx_control));
+            if (copy_from_user(&xc, ifr->ifr_data, sizeof (struct lmc_xilinx_control)))
+                return -EFAULT;
             switch(xc.command){
             case lmc_xilinx_reset: /*fold02*/
                 {
@@ -620,7 +618,7 @@
                 break;
             }
 
-            LMC_XMITTER_FREE(dev);
+            netif_wake_queue(dev);
             sc->lmc_txfull = 0;
 
         }
@@ -646,7 +644,7 @@
     lmc_softc_t *sc;
     int link_status;
     u_int32_t ticks;
-    LMC_SPIN_FLAGS;
+    unsigned long flags;
 
     sc = dev->priv;
 
@@ -836,11 +834,7 @@
      * Allocate our own device structure
      */
 
-#if LINUX_VERSION_CODE < 0x20363
-    dev = kmalloc (sizeof (struct ppp_device)+8, GFP_KERNEL);
-#else
     dev = kmalloc (sizeof (struct net_device)+8, GFP_KERNEL);
-#endif
     if (dev == NULL){
         printk (KERN_ERR "lmc: kmalloc for device failed\n");
         return NULL;
@@ -909,10 +903,8 @@
     dev->get_stats = lmc_get_stats;
     dev->do_ioctl = lmc_ioctl;
     dev->set_config = lmc_set_config;
-#if LINUX_VERSION_CODE >= 0x20363
     dev->tx_timeout = lmc_driver_timeout;
     dev->watchdog_timeo = (HZ); /* 1 second */
-#endif
     
     /*
      * Why were we changing this???
@@ -923,8 +915,6 @@
 
     spin_lock_init(&sc->lmc_lock);
 
-    LMC_SETUP_20_DEV;
-
     printk ("%s: detected at %lx, irq %d\n", dev->name, ioaddr, dev->irq);
 
     if (register_netdev (dev) != 0) {
@@ -1048,7 +1038,7 @@
      * PCI bus, we are in trouble.
      */
 
-    if (!LMC_PCI_PRESENT()) {
+    if (!pci_present()) {
 /*        printk ("%s: We really want a pci bios!\n", dev->name);*/
         return -1;
     }
@@ -1124,11 +1114,7 @@
     if (cards_found < 1)
         return -1;
 
-#if LINUX_VERSION_CODE >= 0x20200
     return foundaddr;
-#else
-    return 0;
-#endif
 }
 
 /* After this is called, packets can be sent.
@@ -1199,11 +1185,7 @@
     dev->do_ioctl = lmc_ioctl;
 
 
-    LMC_XMITTER_INIT(dev);
-    
-#if LINUX_VERSION_CODE < 0x20363
-    dev->start = 1;
-#endif
+    netif_start_queue(dev);
     
     sc->stats.tx_tbusy0++ ;
 
@@ -1277,7 +1259,7 @@
 
     //dev->flags |= IFF_RUNNING;
     
-    LMC_XMITTER_FREE(dev);
+    netif_wake_queue(dev);
 
     sc->lmc_txfull = 0;
     sc->stats.tx_tbusy0++ ;
@@ -1327,7 +1309,7 @@
     
     /* Don't let anything else go on right now */
     //    dev->start = 0;
-    LMC_XMITTER_BUSY(dev);
+    netif_stop_queue(dev);
     sc->stats.tx_tbusy1++ ;
 
     /* stop interrupts */
@@ -1360,23 +1342,20 @@
         sc->lmc_rxring[i].length = 0;
         sc->lmc_rxring[i].buffer1 = 0xDEADBEEF;
         if (skb != NULL)
-        {
-            LMC_SKB_FREE(skb, 1);
-            LMC_DEV_KFREE_SKB (skb);
-        }
+            dev_kfree_skb(skb);
         sc->lmc_rxq[i] = NULL;
     }
 
     for (i = 0; i < LMC_TXDESCS; i++)
     {
         if (sc->lmc_txq[i] != NULL)
-            LMC_DEV_KFREE_SKB (sc->lmc_txq[i]);
+            dev_kfree_skb(sc->lmc_txq[i]);
         sc->lmc_txq[i] = NULL;
     }
 
     lmc_led_off (sc, LMC_MII16_LED_ALL);
 
-    LMC_XMITTER_FREE(dev);
+    netif_wake_queue(dev);
     sc->stats.tx_tbusy0++ ;
 
     lmc_trace(dev, "lmc_ifdown out");
@@ -1493,14 +1472,12 @@
                 }
                 else {
                     
-#if LINUX_VERSION_CODE >= 0x20200
                     sc->stats.tx_bytes += sc->lmc_txring[i].length & 0x7ff;
-#endif
                     
                     sc->stats.tx_packets++;
                 }
                 
-                //                LMC_DEV_KFREE_SKB (sc->lmc_txq[i]);
+                //                dev_kfree_skb(sc->lmc_txq[i]);
                 dev_kfree_skb_irq(sc->lmc_txq[i]);
                 sc->lmc_txq[i] = 0;
 
@@ -1515,20 +1492,14 @@
             }
             LMC_EVENT_LOG(LMC_EVENT_TBUSY0, n_compl, 0);
             sc->lmc_txfull = 0;
-            LMC_XMITTER_FREE(dev);
+            netif_wake_queue(dev);
             sc->stats.tx_tbusy0++ ;
-#if LINUX_VERSION_CODE < 0x20363
-            mark_bh (NET_BH);	/* Tell Linux to give me more packets */
-#endif
 
 
 #ifdef DEBUG
             sc->stats.dirtyTx = badtx;
             sc->stats.lmc_next_tx = sc->lmc_next_tx;
             sc->stats.lmc_txfull = sc->lmc_txfull;
-#if LINUX_VERSION_CODE < 0x20363
-            sc->stats.tbusy = dev->tbusy;
-#endif
 #endif
             sc->lmc_taint_tx = badtx;
 
@@ -1588,7 +1559,7 @@
     u32 flag;
     int entry;
     int ret = 0;
-    LMC_SPIN_FLAGS;
+    unsigned long flags;
 
     lmc_trace(dev, "lmc_start_xmit in");
 
@@ -1596,60 +1567,6 @@
 
     spin_lock_irqsave(&sc->lmc_lock, flags);
 
-    /*
-     * If the transmitter is busy
-     * this must be the 5 second polling
-     * from the kernel which called us.
-     * Poke the chip and try to get it running
-     *
-     */
-#if LINUX_VERSION_CODE < 0x20363
-    if(dev->tbusy != 0){
-        u32 csr6;
-
-        printk("%s: Xmitter busy|\n", dev->name);
-
-	sc->stats.tx_tbusy_calls++ ;
-        if (jiffies - dev->trans_start < TX_TIMEOUT) {
-            ret = 1;
-            goto lmc_start_xmit_bug_out;
-        }
-
-        /*
-         * Chip seems to have locked up
-         * Reset it
-         * This whips out all our decriptor
-         * table and starts from scartch
-         */
-
-        LMC_EVENT_LOG(LMC_EVENT_XMTPRCTMO,
-                      LMC_CSR_READ (sc, csr_status),
-                      sc->stats.tx_ProcTimeout);
-
-        lmc_running_reset (dev);
-
-        LMC_EVENT_LOG(LMC_EVENT_RESET1, LMC_CSR_READ (sc, csr_status), 0);
-        LMC_EVENT_LOG(LMC_EVENT_RESET2,
-                      lmc_mii_readreg (sc, 0, 16),
-                      lmc_mii_readreg (sc, 0, 17));
-
-        /* restart the tx processes */
-        csr6 = LMC_CSR_READ (sc, csr_command);
-        LMC_CSR_WRITE (sc, csr_command, csr6 | 0x0002);
-        LMC_CSR_WRITE (sc, csr_command, csr6 | 0x2002);
-
-        /* immediate transmit */
-        LMC_CSR_WRITE (sc, csr_txpoll, 0);
-
-        sc->stats.tx_errors++;
-        sc->stats.tx_ProcTimeout++;	/* -baz */
-
-        dev->trans_start = jiffies;
-
-        ret = 1;
-        goto lmc_start_xmit_bug_out;
-    }
-#endif
     /* normal path, tbusy known to be zero */
 
     entry = sc->lmc_next_tx % LMC_TXDESCS;
@@ -1665,26 +1582,26 @@
     {
         /* Do not interrupt on completion of this packet */
         flag = 0x60000000;
-        LMC_XMITTER_FREE(dev);
+        netif_wake_queue(dev);
     }
     else if (sc->lmc_next_tx - sc->lmc_taint_tx == LMC_TXDESCS / 2)
     {
         /* This generates an interrupt on completion of this packet */
         flag = 0xe0000000;
-        LMC_XMITTER_FREE(dev);
+        netif_wake_queue(dev);
     }
     else if (sc->lmc_next_tx - sc->lmc_taint_tx < LMC_TXDESCS - 1)
     {
         /* Do not interrupt on completion of this packet */
         flag = 0x60000000;
-        LMC_XMITTER_FREE(dev);
+        netif_wake_queue(dev);
     }
     else
     {
         /* This generates an interrupt on completion of this packet */
         flag = 0xe0000000;
         sc->lmc_txfull = 1;
-        LMC_XMITTER_BUSY(dev);
+        netif_stop_queue(dev);
     }
 #else
     flag = LMC_TDES_INTERRUPT_ON_COMPLETION;
@@ -1692,7 +1609,7 @@
     if (sc->lmc_next_tx - sc->lmc_taint_tx >= LMC_TXDESCS - 1)
     {				/* ring full, go busy */
         sc->lmc_txfull = 1;
-        LMC_XMITTER_BUSY(dev);
+        netif_stop_queue(dev);
         sc->stats.tx_tbusy1++ ;
         LMC_EVENT_LOG(LMC_EVENT_TBUSY1, entry, 0);
     }
@@ -1722,10 +1639,6 @@
 
     dev->trans_start = jiffies;
 
-#if LINUX_VERSION_CODE < 0x20363
-lmc_start_xmit_bug_out:
-#endif
-
     spin_unlock_irqrestore(&sc->lmc_lock, flags);
 
     lmc_trace(dev, "lmc_start_xmit_out");
@@ -1811,7 +1724,6 @@
         if(skb == 0x0){
             nsb = dev_alloc_skb (LMC_PKT_BUF_SZ + 2);
             if (nsb) {
-                LMC_SKB_FREE(nsb, 1);
                 sc->lmc_rxq[i] = nsb;
                 nsb->dev = dev;
                 sc->lmc_rxring[i].buffer1 = virt_to_bus (nsb->tail);
@@ -1855,7 +1767,6 @@
              */
             nsb = dev_alloc_skb (LMC_PKT_BUF_SZ + 2);
             if (nsb) {
-                LMC_SKB_FREE(nsb, 1);
                 sc->lmc_rxq[i] = nsb;
                 nsb->dev = dev;
                 sc->lmc_rxring[i].buffer1 = virt_to_bus (nsb->tail);
@@ -1944,7 +1855,7 @@
 static struct net_device_stats *lmc_get_stats (struct net_device *dev) /*fold00*/
 {
     lmc_softc_t *sc;
-    LMC_SPIN_FLAGS;
+    unsigned long flags;
 
     lmc_trace(dev, "lmc_get_stats in");
 
@@ -2144,7 +2055,6 @@
         }
 
         skb->dev = sc->lmc_device;
-        LMC_SKB_FREE(skb, 1);
 
         /* owned by 21140 */
         sc->lmc_rxring[i].status = 0x80000000;
@@ -2363,11 +2273,10 @@
     lmc_trace(sc->lmc_device, "lmc_initcsrs out");
 }
 
-#if LINUX_VERSION_CODE >= 0x20363
 static void lmc_driver_timeout(struct net_device *dev) { /*fold00*/
     lmc_softc_t *sc;
     u32 csr6;
-    LMC_SPIN_FLAGS;
+    unsigned long flags;
 
     lmc_trace(dev, "lmc_driver_timeout in");
 
@@ -2426,4 +2335,3 @@
    return lmc_probe(NULL);
 }
 
-#endif

--- linux-2.5.69-bk4/drivers/net/wan/lmc/lmc_ver.h	2003-05-05 01:53:02.000000000 +0200
+++ /dev/null	2003-01-09 00:39:47.000000000 +0100
@@ -1,123 +0,0 @@
-#ifndef _IF_LMC_LINUXVER_
-#define _IF_LMC_LINUXVER_
-
- /*
-  * Copyright (c) 1997-2000 LAN Media Corporation (LMC)
-  * All rights reserved.  www.lanmedia.com
-  *
-  * This code is written by:
-  * Andrew Stanley-Jones (asj@cban.com)
-  * Rob Braun (bbraun@vix.com),
-  * Michael Graff (explorer@vix.com) and
-  * Matt Thomas (matt@3am-software.com).
-  *
-  * This software may be used and distributed according to the terms
-  * of the GNU General Public License version 2, incorporated herein by reference.
-  */
-
- /*
-  * This file defines and controls all linux version
-  * differences.
-  *
-  * This is being done to keep 1 central location where all linux
-  * version differences can be kept and maintained.  as this code was
-  * found version issues where pepered throughout the source code and
-  * made the souce code not only hard to read but version problems hard
-  * to track down.  If I'm overiding a function/etc with something in
-  * this file it will be prefixed by "LMC_" which will mean look
-  * here for the version dependent change that's been done.
-  *
-  */
-
-#if LINUX_VERSION_CODE < 0x20363
-#define net_device device
-#endif
-
-#if LINUX_VERSION_CODE < 0x20363
-#define LMC_XMITTER_BUSY(x) (x)->tbusy = 1
-#define LMC_XMITTER_FREE(x) (x)->tbusy = 0
-#define LMC_XMITTER_INIT(x) (x)->tbusy = 0
-#else
-#define LMC_XMITTER_BUSY(x) netif_stop_queue(x)
-#define LMC_XMITTER_FREE(x) netif_wake_queue(x)
-#define LMC_XMITTER_INIT(x) netif_start_queue(x)
-
-#endif
-
-
-#if LINUX_VERSION_CODE < 0x20100
-//typedef unsigned int u_int32_t;
-
-#define  LMC_SETUP_20_DEV {\
-                             int indx; \
-                             for (indx = 0; indx < DEV_NUMBUFFS; indx++) \
-                                skb_queue_head_init (&dev->buffs[indx]); \
-                          } \
-                          dev->family = AF_INET; \
-                          dev->pa_addr = 0; \
-                          dev->pa_brdaddr = 0; \
-                          dev->pa_mask = 0xFCFFFFFF; \
-                          dev->pa_alen = 4;		/* IP addr.  sizeof(u32) */
-
-#else
-
-#define LMC_SETUP_20_DEV
-
-#endif
-
-
-#if LINUX_VERSION_CODE < 0x20155 /* basically 2.2 plus */
-
-#define LMC_DEV_KFREE_SKB(skb) dev_kfree_skb((skb), FREE_WRITE)
-#define LMC_PCI_PRESENT() pcibios_present()
-
-#else /* Mostly 2.0 kernels */
-
-#define LMC_DEV_KFREE_SKB(skb) dev_kfree_skb(skb)
-#define LMC_PCI_PRESENT() pci_present()
-
-#endif
-
-#if LINUX_VERSION_CODE < 0x20200
-#else
-
-#endif
-
-#if LINUX_VERSION_CODE < 0x20100
-#define LMC_SKB_FREE(skb, val) (skb->free = val)
-#else
-#define LMC_SKB_FREE(skb, val)
-#endif
-
-
-#if (LINUX_VERSION_CODE >= 0x20200)
-
-#define LMC_SPIN_FLAGS                unsigned long flags;
-#define LMC_SPIN_LOCK_INIT(x)         spin_lock_init(&(x)->lmc_lock);
-#define LMC_SPIN_UNLOCK(x)            ((x)->lmc_lock = SPIN_LOCK_UNLOCKED)
-#define LMC_SPIN_LOCK_IRQSAVE(x)      spin_lock_irqsave (&(x)->lmc_lock, flags);
-#define LMC_SPIN_UNLOCK_IRQRESTORE(x) spin_unlock_irqrestore (&(x)->lmc_lock, flags);
-#else
-#define LMC_SPIN_FLAGS
-#define LMC_SPIN_LOCK_INIT(x)
-#define LMC_SPIN_UNLOCK(x)
-#define LMC_SPIN_LOCK_IRQSAVE(x)
-#define LMC_SPIN_UNLOCK_IRQRESTORE(x)
-#endif
-
-
-#if LINUX_VERSION_CODE >= 0x20100
-#define LMC_COPY_FROM_USER(x, y, z) if(copy_from_user ((x), (y), (z))) return -EFAULT
-#define LMC_COPY_TO_USER(x, y, z) if(copy_to_user ((x), (y), (z))) return -EFAULT
-#else
-#define LMC_COPY_FROM_USER(x, y, z) if(verify_area(VERIFY_READ, (y), (z))) \
-			               return -EFAULT; \
-                                    memcpy_fromfs ((x), (y), (z))
-
-#define LMC_COPY_TO_USER(x, y, z)   if(verify_area(VERIFY_WRITE, (x), (z))) \
-	                               return -EFAULT; \
-                                    memcpy_tofs ((x), (y), (z))
-#endif
-
-
-#endif
