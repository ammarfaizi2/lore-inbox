Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUGBAZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUGBAZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 20:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUGBAZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 20:25:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34784 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265971AbUGBAZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 20:25:03 -0400
Date: Fri, 2 Jul 2004 02:25:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: mcalinux@acc.umu.se, tao@acc.umu.se
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [2.6 patch] more MCA_LEGACY dependencies
Message-ID: <20040702002459.GI28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against 2.6.7-mm5 fixes more compile errors with 
MCA_LEGACY=n .

diffstat output:
 drivers/net/Kconfig           |    2 +-
 drivers/net/at1700.c          |   12 ++++++------
 drivers/net/eexpress.c        |    4 ++--
 drivers/net/tokenring/Kconfig |    4 ++--
 drivers/net/tokenring/smctr.c |   12 ++++++------
 drivers/scsi/Kconfig          |    4 ++--
 drivers/scsi/aha1542.c        |    2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-full/drivers/scsi/Kconfig.old	2004-07-02 02:02:01.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/scsi/Kconfig	2004-07-02 02:02:52.000000000 +0200
@@ -628,7 +628,7 @@
 
 config SCSI_FD_MCS
 	tristate "Future Domain MCS-600/700 SCSI support"
-	depends on MCA && SCSI
+	depends on MCA_LEGACY && SCSI
 	---help---
 	  This is support for Future Domain MCS 600/700 MCA SCSI adapters.
 	  Some PS/2 computers are equipped with IBM Fast SCSI Adapter/A which
@@ -699,7 +699,7 @@
 
 config SCSI_IBMMCA
 	tristate "IBMMCA SCSI support"
-	depends on MCA && SCSI
+	depends on MCA_LEGACY && SCSI
 	---help---
 	  This is support for the IBM SCSI adapter found in many of the PS/2
 	  series computers.  These machines have an MCA bus, so you need to
--- linux-2.6.7-mm5-full/drivers/net/Kconfig.old	2004-07-02 01:52:46.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/Kconfig	2004-07-02 01:58:55.000000000 +0200
@@ -666,7 +666,7 @@
 
 config ELMC
 	tristate "3c523 \"EtherLink/MC\" support"
-	depends on NET_VENDOR_3COM && MCA
+	depends on NET_VENDOR_3COM && MCA_LEGACY
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
--- linux-2.6.7-mm5-full/drivers/net/tokenring/Kconfig.old	2004-07-02 01:53:39.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/tokenring/Kconfig	2004-07-02 01:56:18.000000000 +0200
@@ -157,7 +157,7 @@
 
 config MADGEMC
 	tristate "Madge Smart 16/4 Ringnode MicroChannel"
-	depends on TR && TMS380TR && MCA
+	depends on TR && TMS380TR && MCA_LEGACY
 	help
 	  This tms380 module supports the Madge Smart 16/4 MC16 and MC32
 	  MicroChannel adapters.
@@ -167,7 +167,7 @@
 
 config SMCTR
 	tristate "SMC ISA/MCA adapter support"
-	depends on TR && (ISA || MCA)
+	depends on TR && (ISA || MCA_LEGACY)
 	---help---
 	  This is support for the ISA and MCA SMC Token Ring cards,
 	  specifically SMC TokenCard Elite (8115T) and SMC TokenCard Elite/A
--- linux-2.6.7-mm5-full/drivers/scsi/aha1542.c.old	2004-07-02 02:01:08.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/scsi/aha1542.c	2004-07-02 02:01:24.000000000 +0200
@@ -1069,7 +1069,7 @@
 	/*
 	 *	Find MicroChannel cards (AHA1640)
 	 */
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	if(MCA_bus) {
 		int slot = 0;
 		int pos = 0;
--- linux-2.6.7-mm5-full/drivers/net/tokenring/smctr.c.old	2004-07-02 01:56:05.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/tokenring/smctr.c	2004-07-02 01:56:49.000000000 +0200
@@ -69,7 +69,7 @@
 
 #define SMCTR_IO_EXTENT   20
 
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 static unsigned int smctr_posid = 0x6ec6;
 #endif
 
@@ -479,7 +479,7 @@
 
 static int __init smctr_chk_mca(struct net_device *dev)
 {
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	struct net_local *tp = netdev_priv(dev);
 	int current_slot;
 	__u8 r1, r2, r3, r4, r5;
@@ -626,7 +626,7 @@
 	return (0);
 #else
 	return (-1);
-#endif /* CONFIG_MCA */
+#endif /* CONFIG_MCA_LEGACY */
 }
 
 static int smctr_chg_rx_mask(struct net_device *dev)
@@ -3617,7 +3617,7 @@
 		goto out1;
 	return dev;
 out1:
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	{ struct net_local *tp = netdev_priv(dev);
 	  if (tp->slot_num)
 		mca_mark_as_unused(tp->slot_num);
@@ -5685,7 +5685,7 @@
 		goto out1;
 	return dev;
  out1:
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	{ struct net_local *tp = netdev_priv(dev);
 	  if (tp->slot_num)
 		mca_mark_as_unused(tp->slot_num);
@@ -5725,7 +5725,7 @@
 		if (dev) {
 
 			unregister_netdev(dev);
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 			{ struct net_local *tp = netdev_priv(dev);
 			if (tp->slot_num)
 				mca_mark_as_unused(tp->slot_num);
--- linux-2.6.7-mm5-full/drivers/net/at1700.c.old	2004-07-02 01:57:37.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/at1700.c	2004-07-02 01:58:01.000000000 +0200
@@ -89,7 +89,7 @@
 /*
  *	MCA
  */
-#ifdef CONFIG_MCA	
+#ifdef CONFIG_MCA_LEGACY	
 static int at1700_ioaddr_pattern[] __initdata = {
 	0x00, 0x04, 0x01, 0x05, 0x02, 0x06, 0x03, 0x07
 };
@@ -174,7 +174,7 @@
 static void net_tx_timeout (struct net_device *dev);
 
 
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 struct at1720_mca_adapters_struct {
 	char* name;
 	int id;
@@ -202,7 +202,7 @@
 
 static void cleanup_card(struct net_device *dev)
 {
-#ifdef CONFIG_MCA	
+#ifdef CONFIG_MCA_LEGACY	
 	struct net_local *lp = netdev_priv(dev);
 	if (lp->mca_slot >= 0)
 		mca_mark_as_unused(lp->mca_slot);
@@ -288,7 +288,7 @@
 		   read_eeprom(ioaddr, 6), inw(ioaddr + EEPROM_Ctrl));
 #endif
 
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	/* rEnE (rene@bss.lu): got this from 3c509 driver source , adapted for AT1720 */
 
     /* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch, heavily
@@ -359,7 +359,7 @@
 		goto err_out;
 	}
 			
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 found:
 #endif
 
@@ -483,7 +483,7 @@
 	return 0;
 
 err_mca:
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	if (slot >= 0)
 		mca_mark_as_unused(slot);
 #endif
--- linux-2.6.7-mm5-full/drivers/net/eexpress.c.old	2004-07-02 01:59:57.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/eexpress.c	2004-07-02 02:00:22.000000000 +0200
@@ -230,7 +230,7 @@
 /* maps irq number to EtherExpress magic value */
 static char irqrmap[] = { 0,0,1,2,3,4,0,0,0,1,5,6,0,0,0,0 };
 
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 /* mapping of the first four bits of the second POS register */
 static unsigned short mca_iomap[] = {
 	0x270, 0x260, 0x250, 0x240, 0x230, 0x220, 0x210, 0x200,
@@ -345,7 +345,7 @@
 
 	dev->if_port = 0xff; /* not set */
 
-#ifdef CONFIG_MCA
+#ifdef CONFIG_MCA_LEGACY
 	if (MCA_bus) {
 		int slot = 0;
 


