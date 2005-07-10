Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVGJTkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVGJTkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVGJTkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:02 -0400
Received: from ns.suse.de ([195.135.220.2]:64658 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261605AbVGJTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:36 -0400
Date: Sun, 10 Jul 2005 19:35:34 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       irda-users@lists.sourceforge.net
Subject: [PATCH 26/82] remove linux/version.h from drivers/net/
Message-ID: <20050710193534.26.SAdzTe2972.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

remove code for obsolete kernels in acenic, irda, tokenring, typhoon
and wireless.
drivers/net/wan/farsync.c  has fstioc_info->kernelVersion,
according to the comment the content doesnt matter

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/net/acenic.c                            |   11 ----
drivers/net/acenic.h                            |    4 -
drivers/net/b44.c                               |    1
drivers/net/dm9000.c                            |    1
drivers/net/gianfar.c                           |    1
drivers/net/gianfar.h                           |    1
drivers/net/gianfar_ethtool.c                   |    1
drivers/net/gianfar_phy.c                       |    1
drivers/net/hp100.c                             |    1
drivers/net/ibmveth.c                           |    1
drivers/net/irda/sir_kthread.c                  |    4 -
drivers/net/irda/vlsi_ir.h                      |   22 --------
drivers/net/iseries_veth.c                      |    1
drivers/net/mac8390.c                           |    1
drivers/net/mv643xx_eth.h                       |    1
drivers/net/ppp_mppe.c                          |    1
drivers/net/s2io.c                              |    1
drivers/net/sk98lin/h/skdrv1st.h                |    3 -
drivers/net/sk_mca.c                            |    1
drivers/net/sk_mca.h                            |    2
drivers/net/starfire.c                          |    3 -
drivers/net/tokenring/lanstreamer.c             |   59 ------------------------
drivers/net/tokenring/lanstreamer.h             |   14 -----
drivers/net/typhoon.c                           |    9 ---
drivers/net/via-velocity.c                      |    1
drivers/net/wan/farsync.c                       |    2
drivers/net/wireless/hostap/hostap.c            |    1
drivers/net/wireless/hostap/hostap_crypt_ccmp.c |    1
drivers/net/wireless/hostap/hostap_crypt_tkip.c |    1
drivers/net/wireless/hostap/hostap_crypt_wep.c  |    1
drivers/net/wireless/hostap/hostap_cs.c         |    1
drivers/net/wireless/hostap/hostap_hw.c         |    1
drivers/net/wireless/hostap/hostap_pci.c        |    1
drivers/net/wireless/hostap/hostap_plx.c        |    1
drivers/net/wireless/ipw2100.c                  |    1
drivers/net/wireless/ipw2100.h                  |    1
drivers/net/wireless/ipw2200.c                  |    8 ---
drivers/net/wireless/ipw2200.h                  |   10 ----
drivers/net/wireless/orinoco.h                  |    1
drivers/net/wireless/prism54/isl_38xx.c         |    1
drivers/net/wireless/prism54/isl_38xx.h         |    1
drivers/net/wireless/prism54/isl_ioctl.c        |    1
drivers/net/wireless/prism54/islpci_dev.c       |    1
drivers/net/wireless/prism54/islpci_dev.h       |    1
drivers/net/wireless/prism54/islpci_eth.c       |    1
drivers/net/wireless/prism54/islpci_hotplug.c   |    1
46 files changed, 5 insertions(+), 179 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/net/acenic.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/acenic.c
+++ linux-2.6.13-rc2-mm1/drivers/net/acenic.c
@@ -53,7 +53,6 @@
#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/ioport.h>
@@ -164,12 +163,6 @@ MODULE_DEVICE_TABLE(pci, acenic_pci_tbl)
#define SET_NETDEV_DEV(net, pdev)	do{} while(0)
#endif

-#if LINUX_VERSION_CODE >= 0x2051c
-#define ace_sync_irq(irq)	synchronize_irq(irq)
-#else
-#define ace_sync_irq(irq)	synchronize_irq()
-#endif
-
#ifndef offset_in_page
#define offset_in_page(ptr)	((unsigned long)(ptr) & ~PAGE_MASK)
#endif
@@ -657,7 +650,7 @@ static void __devexit acenic_remove_one(
* Then release the RX buffers - jumbo buffers were
* already released in ace_close().
*/
-	ace_sync_irq(dev->irq);
+	synchronize_irq(dev->irq);

for (i = 0; i < RX_STD_RING_ENTRIES; i++) {
struct sk_buff *skb = ap->skb->rx_std_skbuff[i].skb;
@@ -2657,7 +2650,7 @@ static int ace_change_mtu(struct net_dev
}
} else {
while (test_and_set_bit(0, &ap->jumbo_refill_busy));
-		ace_sync_irq(dev->irq);
+		synchronize_irq(dev->irq);
ace_set_rxtx_parms(dev, 0);
if (ap->jumbo) {
struct cmd cmd;
Index: linux-2.6.13-rc2-mm1/drivers/net/acenic.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/acenic.h
+++ linux-2.6.13-rc2-mm1/drivers/net/acenic.h
@@ -1,8 +1,6 @@
#ifndef _ACENIC_H_
#define _ACENIC_H_

-#include <linux/config.h>
-
/*
* Generate TX index update each time, when TX ring is closed.
* Normally, this is not useful, because results in more dma (and irqs
@@ -747,7 +745,7 @@ static inline void ace_mask_irq(struct n
else
writel(readl(&regs->HostCtrl) | MASK_INTS, &regs->HostCtrl);

-	ace_sync_irq(dev->irq);
+	synchronize_irq(dev->irq);
}


Index: linux-2.6.13-rc2-mm1/drivers/net/b44.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/b44.c
+++ linux-2.6.13-rc2-mm1/drivers/net/b44.c
@@ -18,7 +18,6 @@
#include <linux/pci.h>
#include <linux/delay.h>
#include <linux/init.h>
-#include <linux/version.h>

#include <asm/uaccess.h>
#include <asm/io.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/dm9000.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/dm9000.c
+++ linux-2.6.13-rc2-mm1/drivers/net/dm9000.c
@@ -56,7 +56,6 @@
#include <linux/etherdevice.h>
#include <linux/init.h>
#include <linux/skbuff.h>
-#include <linux/version.h>
#include <linux/spinlock.h>
#include <linux/crc32.h>
#include <linux/mii.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/gianfar.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/gianfar.c
+++ linux-2.6.13-rc2-mm1/drivers/net/gianfar.c
@@ -94,7 +94,6 @@
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/dma-mapping.h>
#include <linux/crc32.h>

Index: linux-2.6.13-rc2-mm1/drivers/net/gianfar.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/gianfar.h
+++ linux-2.6.13-rc2-mm1/drivers/net/gianfar.h
@@ -43,7 +43,6 @@
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/crc32.h>
#include <linux/workqueue.h>
#include <linux/ethtool.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/gianfar_ethtool.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/gianfar_ethtool.c
+++ linux-2.6.13-rc2-mm1/drivers/net/gianfar_ethtool.c
@@ -34,7 +34,6 @@
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/crc32.h>
#include <asm/types.h>
#include <asm/uaccess.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/gianfar_phy.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/gianfar_phy.c
+++ linux-2.6.13-rc2-mm1/drivers/net/gianfar_phy.c
@@ -36,7 +36,6 @@
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/crc32.h>
#include <linux/mii.h>

Index: linux-2.6.13-rc2-mm1/drivers/net/hp100.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/hp100.c
+++ linux-2.6.13-rc2-mm1/drivers/net/hp100.c
@@ -96,7 +96,6 @@

#undef HP100_MULTICAST_FILTER	/* Need to be debugged... */

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/string.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/ibmveth.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/ibmveth.c
+++ linux-2.6.13-rc2-mm1/drivers/net/ibmveth.c
@@ -35,7 +35,6 @@

#include <linux/config.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/ioport.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/irda/sir_kthread.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/irda/sir_kthread.c
+++ linux-2.6.13-rc2-mm1/drivers/net/irda/sir_kthread.c
@@ -14,7 +14,6 @@

#include <linux/module.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <linux/smp_lock.h>
#include <linux/completion.h>
@@ -140,9 +139,6 @@ static int irda_thread(void *startup)
run_irda_queue();
}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,35)
-	reparent_to_init();
-#endif
complete_and_exit(&irda_rq_queue.exit, 0);
/* never reached */
return 0;
Index: linux-2.6.13-rc2-mm1/drivers/net/irda/vlsi_ir.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/irda/vlsi_ir.h
+++ linux-2.6.13-rc2-mm1/drivers/net/irda/vlsi_ir.h
@@ -49,26 +49,6 @@ typedef void irqreturn_t;
#define IRQ_RETVAL(x)
#endif

-/* some stuff need to check kernelversion. Not all 2.5 stuff was present
- * in early 2.5.x - the test is merely to separate 2.4 from 2.5
- */
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-
-/* PDE() introduced in 2.5.4 */
-#ifdef CONFIG_PROC_FS
-#define PDE(inode) ((inode)->u.generic_ip)
-#endif
-
-/* irda crc16 calculation exported in 2.5.42 */
-#define irda_calc_crc16(fcs,buf,len)	(GOOD_FCS)
-
-/* we use this for unified pci device name access */
-#define PCIDEV_NAME(pdev)	((pdev)->name)
-
-#else /* 2.5 or later */
-
/* recent 2.5/2.6 stores pci device names at varying places ;-) */
#ifdef CONFIG_PCI_NAMES
/* human readable name */
@@ -78,8 +58,6 @@ typedef void irqreturn_t;
#define PCIDEV_NAME(pdev)	(pci_name(pdev))
#endif

-#endif
-
/* ================================================================ */

/* non-standard PCI registers */
Index: linux-2.6.13-rc2-mm1/drivers/net/iseries_veth.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/iseries_veth.c
+++ linux-2.6.13-rc2-mm1/drivers/net/iseries_veth.c
@@ -57,7 +57,6 @@

#include <linux/config.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/ioport.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/mac8390.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/mac8390.c
+++ linux-2.6.13-rc2-mm1/drivers/net/mac8390.c
@@ -15,7 +15,6 @@
* and fixed access to Sonic Sys card which masquerades as a Farallon
* by rayk@knightsmanor.org */

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/mv643xx_eth.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/mv643xx_eth.h
+++ linux-2.6.13-rc2-mm1/drivers/net/mv643xx_eth.h
@@ -1,7 +1,6 @@
#ifndef __MV643XX_ETH_H__
#define __MV643XX_ETH_H__

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/spinlock.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/s2io.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/s2io.c
+++ linux-2.6.13-rc2-mm1/drivers/net/s2io.c
@@ -54,7 +54,6 @@
#include <linux/timex.h>
#include <linux/sched.h>
#include <linux/ethtool.h>
-#include <linux/version.h>
#include <linux/workqueue.h>

#include <asm/io.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/sk98lin/h/skdrv1st.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/sk98lin/h/skdrv1st.h
+++ linux-2.6.13-rc2-mm1/drivers/net/sk98lin/h/skdrv1st.h
@@ -39,9 +39,6 @@
#ifndef __INC_SKDRV1ST_H
#define __INC_SKDRV1ST_H

-/* Check kernel version */
-#include <linux/version.h>
-
typedef struct s_AC	SK_AC;

/* Set card versions */
Index: linux-2.6.13-rc2-mm1/drivers/net/sk_mca.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/sk_mca.c
+++ linux-2.6.13-rc2-mm1/drivers/net/sk_mca.c
@@ -93,7 +93,6 @@ History:
#include <linux/mca-legacy.h>
#include <linux/init.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/skbuff.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/sk_mca.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/sk_mca.h
+++ linux-2.6.13-rc2-mm1/drivers/net/sk_mca.h
@@ -1,5 +1,3 @@
-#include <linux/version.h>
-
#ifndef _SK_MCA_INCLUDE_
#define _SK_MCA_INCLUDE_

Index: linux-2.6.13-rc2-mm1/drivers/net/starfire.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/starfire.c
+++ linux-2.6.13-rc2-mm1/drivers/net/starfire.c
@@ -143,7 +143,6 @@ TODO:	- fix forced speed/duplexing code
#define DRV_RELDATE	"January 19, 2005"

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/pci.h>
@@ -257,7 +256,7 @@ static int full_duplex[MAX_UNITS] = {0,
* This SUCKS.
* We need a much better method to determine if dma_addr_t is 64-bit.
*/
-#if (defined(__i386__) && defined(CONFIG_HIGHMEM) && (LINUX_VERSION_CODE > 0x20500 || defined(CONFIG_HIGHMEM64G))) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
+#if (defined(__i386__) && defined(CONFIG_HIGHMEM)) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
/* 64-bit dma_addr_t */
#define ADDR_64BITS	/* This chip uses 64 bit addresses. */
#define cpu_to_dma(x) cpu_to_le64(x)
Index: linux-2.6.13-rc2-mm1/drivers/net/tokenring/lanstreamer.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/tokenring/lanstreamer.c
+++ linux-2.6.13-rc2-mm1/drivers/net/tokenring/lanstreamer.c
@@ -120,7 +120,6 @@
#include <linux/pci.h>
#include <linux/dma-mapping.h>
#include <linux/spinlock.h>
-#include <linux/version.h>
#include <linux/bitops.h>

#include <net/checksum.h>
@@ -1932,64 +1931,6 @@ static int sprintf_info(char *buffer, st
#endif
#endif

-#if STREAMER_IOCTL && (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-static int streamer_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-        int i;
-	struct streamer_private *streamer_priv = (struct streamer_private *) dev->priv;
-	u8 __iomem *streamer_mmio = streamer_priv->streamer_mmio;
-
-	switch(cmd) {
-	case IOCTL_SISR_MASK:
-		writew(SISR_MI, streamer_mmio + SISR_MASK_SUM);
-		break;
-	case IOCTL_SPIN_LOCK_TEST:
-	        printk(KERN_INFO "spin_lock() called.n");
-		spin_lock(&streamer_priv->streamer_lock);
-		spin_unlock(&streamer_priv->streamer_lock);
-		printk(KERN_INFO "spin_unlock() finished.n");
-		break;
-	case IOCTL_PRINT_BDAS:
-	        printk(KERN_INFO "bdas: RXBDA: %x RXLBDA: %x TX2FDA: %x TX2LFDA: %xn",
-		       readw(streamer_mmio + RXBDA),
-		       readw(streamer_mmio + RXLBDA),
-		       readw(streamer_mmio + TX2FDA),
-		       readw(streamer_mmio + TX2LFDA));
-		break;
-	case IOCTL_PRINT_REGISTERS:
-	        printk(KERN_INFO "registers:n");
-		printk(KERN_INFO "SISR: %04x MISR: %04x LISR: %04x BCTL: %04x BMCTL: %04xnmask  %04x mask  %04xn",
-		       readw(streamer_mmio + SISR),
-		       readw(streamer_mmio + MISR_RUM),
-		       readw(streamer_mmio + LISR),
-		       readw(streamer_mmio + BCTL),
-		       readw(streamer_mmio + BMCTL_SUM),
-		       readw(streamer_mmio + SISR_MASK),
-		       readw(streamer_mmio + MISR_MASK));
-		break;
-	case IOCTL_PRINT_RX_BUFS:
-	        printk(KERN_INFO "Print rx bufs:n");
-		for(i=0; i<STREAMER_RX_RING_SIZE; i++)
-		        printk(KERN_INFO "rx_ring %d status: 0x%xn", i,
-			       streamer_priv->streamer_rx_ring[i].status);
-		break;
-	case IOCTL_PRINT_TX_BUFS:
-	        printk(KERN_INFO "Print tx bufs:n");
-		for(i=0; i<STREAMER_TX_RING_SIZE; i++)
-		        printk(KERN_INFO "tx_ring %d status: 0x%xn", i,
-			       streamer_priv->streamer_tx_ring[i].status);
-		break;
-	case IOCTL_RX_CMD:
-	        streamer_rx(dev);
-		printk(KERN_INFO "Sent rx command.n");
-		break;
-	default:
-	        printk(KERN_INFO "Bad ioctl!n");
-	}
-	return 0;
-}
-#endif
-
static struct pci_driver streamer_pci_driver = {
.name     = "lanstreamer",
.id_table = streamer_pci_tbl,
Index: linux-2.6.13-rc2-mm1/drivers/net/tokenring/lanstreamer.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/tokenring/lanstreamer.h
+++ linux-2.6.13-rc2-mm1/drivers/net/tokenring/lanstreamer.h
@@ -60,20 +60,6 @@
*
*/

-#include <linux/version.h>
-
-#if STREAMER_IOCTL && (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-#include <asm/ioctl.h>
-#define IOCTL_PRINT_RX_BUFS   SIOCDEVPRIVATE
-#define IOCTL_PRINT_TX_BUFS   SIOCDEVPRIVATE+1
-#define IOCTL_RX_CMD          SIOCDEVPRIVATE+2
-#define IOCTL_TX_CMD          SIOCDEVPRIVATE+3
-#define IOCTL_PRINT_REGISTERS SIOCDEVPRIVATE+4
-#define IOCTL_PRINT_BDAS      SIOCDEVPRIVATE+5
-#define IOCTL_SPIN_LOCK_TEST  SIOCDEVPRIVATE+6
-#define IOCTL_SISR_MASK       SIOCDEVPRIVATE+7
-#endif
-
/* MAX_INTR - the maximum number of times we can loop
* inside the interrupt function before returning
* control to the OS (maximum value is 256)
Index: linux-2.6.13-rc2-mm1/drivers/net/typhoon.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/typhoon.c
+++ linux-2.6.13-rc2-mm1/drivers/net/typhoon.c
@@ -128,7 +128,6 @@ static const int multicast_filter_limit
#include <asm/uaccess.h>
#include <linux/in6.h>
#include <asm/checksum.h>
-#include <linux/version.h>
#include <linux/dma-mapping.h>

#include "typhoon.h"
@@ -333,12 +332,6 @@ enum state_values {
#define TYPHOON_RESET_TIMEOUT_NOSLEEP	((6 * 1000000) / TYPHOON_UDELAY)
#define TYPHOON_WAIT_TIMEOUT		((1000000 / 2) / TYPHOON_UDELAY)

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 28)
-#define typhoon_synchronize_irq(x) synchronize_irq()
-#else
-#define typhoon_synchronize_irq(x) synchronize_irq(x)
-#endif
-
#if defined(NETIF_F_TSO)
#define skb_tso_size(x)		(skb_shinfo(x)->tso_size)
#define TSO_NUM_DESCRIPTORS	2
@@ -2173,7 +2166,7 @@ typhoon_close(struct net_device *dev)
printk(KERN_ERR "%s: unable to stop runtimen", dev->name);

/* Make sure there is no irq handler running on a different CPU. */
-	typhoon_synchronize_irq(dev->irq);
+	synchronize_irq(dev->irq);
free_irq(dev->irq, dev);

typhoon_free_rx_rings(tp);
Index: linux-2.6.13-rc2-mm1/drivers/net/via-velocity.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/via-velocity.c
+++ linux-2.6.13-rc2-mm1/drivers/net/via-velocity.c
@@ -61,7 +61,6 @@
#include <linux/timer.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
-#include <linux/version.h>
#include <linux/string.h>
#include <linux/wait.h>
#include <asm/io.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wan/farsync.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wan/farsync.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wan/farsync.c
@@ -17,7 +17,6 @@

#include <linux/module.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/pci.h>
#include <linux/ioport.h>
#include <linux/init.h>
@@ -1807,7 +1806,6 @@ gather_conf_info(struct fst_card_info *c
memset(info, 0, sizeof (struct fstioc_info));

i = port->index;
-	info->kernelVersion = LINUX_VERSION_CODE;
info->nports = card->nports;
info->type = card->type;
info->state = card->state;
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/orinoco.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/orinoco.h
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/orinoco.h
@@ -13,7 +13,6 @@
#include <linux/spinlock.h>
#include <linux/netdevice.h>
#include <linux/wireless.h>
-#include <linux/version.h>

#include "hermes.h"

Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/isl_38xx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/isl_38xx.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/isl_38xx.c
@@ -18,7 +18,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/delay.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/isl_38xx.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/isl_38xx.h
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/isl_38xx.h
@@ -20,7 +20,6 @@
#ifndef _ISL_38XX_H
#define _ISL_38XX_H

-#include <linux/version.h>
#include <asm/io.h>
#include <asm/byteorder.h>

Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/isl_ioctl.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/isl_ioctl.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/isl_ioctl.c
@@ -20,7 +20,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/if_arp.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_dev.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/islpci_dev.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_dev.c
@@ -19,7 +19,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>

#include <linux/netdevice.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_dev.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/islpci_dev.h
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_dev.h
@@ -23,7 +23,6 @@
#ifndef _ISLPCI_DEV_H
#define _ISLPCI_DEV_H

-#include <linux/version.h>
#include <linux/netdevice.h>
#include <linux/wireless.h>
#include <net/iw_handler.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_eth.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/islpci_eth.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_eth.c
@@ -17,7 +17,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>

#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_hotplug.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/prism54/islpci_hotplug.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/prism54/islpci_hotplug.c
@@ -18,7 +18,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/delay.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/ppp_mppe.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/ppp_mppe.c
+++ linux-2.6.13-rc2-mm1/drivers/net/ppp_mppe.c
@@ -44,7 +44,6 @@
#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <linux/types.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap.c
@@ -17,7 +17,6 @@
#endif

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_crypt_ccmp.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_crypt_ccmp.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_crypt_ccmp.c
@@ -10,7 +10,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_crypt_tkip.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_crypt_tkip.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_crypt_tkip.c
@@ -10,7 +10,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_crypt_wep.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_crypt_wep.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_crypt_wep.c
@@ -10,7 +10,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_cs.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_cs.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_cs.c
@@ -1,7 +1,6 @@
#define PRISM2_PCCARD

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/if.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_hw.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_hw.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_hw.c
@@ -31,7 +31,6 @@


#include <linux/config.h>
-#include <linux/version.h>

#include <asm/delay.h>
#include <asm/uaccess.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_pci.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_pci.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_pci.c
@@ -5,7 +5,6 @@
* Andy Warner <andyw@pobox.com> */

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/if.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_plx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/hostap/hostap_plx.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/hostap/hostap_plx.c
@@ -8,7 +8,6 @@


#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/if.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2100.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/ipw2100.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2100.c
@@ -159,7 +159,6 @@ that only one external action is invoked
#include <linux/stringify.h>
#include <linux/tcp.h>
#include <linux/types.h>
-#include <linux/version.h>
#include <linux/time.h>
#include <linux/firmware.h>
#include <linux/acpi.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2100.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/ipw2100.h
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2100.h
@@ -37,7 +37,6 @@
#include <linux/socket.h>
#include <linux/if_arp.h>
#include <linux/wireless.h>
-#include <linux/version.h>
#include <net/iw_handler.h>	// new driver API

#include <net/ieee80211.h>
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2200.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/ipw2200.c
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2200.c
@@ -7242,11 +7242,7 @@ static int ipw_pci_suspend(struct pci_de
/* Remove the PRESENT state of the device */
netif_device_detach(dev);

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	pci_save_state(pdev, priv->pm_state);
-#else
pci_save_state(pdev);
-#endif
pci_disable_device(pdev);
pci_set_power_state(pdev, state);

@@ -7263,11 +7259,7 @@ static int ipw_pci_resume(struct pci_dev

pci_set_power_state(pdev, 0);
pci_enable_device(pdev);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	pci_restore_state(pdev, priv->pm_state);
-#else
pci_restore_state(pdev);
-#endif
/*
* Suspend/Resume resets the PCI configuration space, so we have to
* re-disable the RETRY_TIMEOUT register (0x41) to keep PCI Tx retries
Index: linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2200.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/net/wireless/ipw2200.h
+++ linux-2.6.13-rc2-mm1/drivers/net/wireless/ipw2200.h
@@ -34,7 +34,6 @@
#include <linux/config.h>
#include <linux/init.h>

-#include <linux/version.h>
#include <linux/pci.h>
#include <linux/netdevice.h>
#include <linux/ethtool.h>
@@ -62,15 +61,6 @@ typedef void irqreturn_t;
#define IRQ_RETVAL(x)
#endif

-#if ( LINUX_VERSION_CODE < KERNEL_VERSION(2,6,9) )
-#define __iomem
-#endif
-
-#if ( LINUX_VERSION_CODE < KERNEL_VERSION(2,6,5) )
-#define pci_dma_sync_single_for_cpu	pci_dma_sync_single
-#define pci_dma_sync_single_for_device	pci_dma_sync_single
-#endif
-
#ifndef HAVE_FREE_NETDEV
#define free_netdev(x) kfree(x)
#endif
