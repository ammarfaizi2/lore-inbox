Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291441AbSBMJUX>; Wed, 13 Feb 2002 04:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291448AbSBMJUR>; Wed, 13 Feb 2002 04:20:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291441AbSBMJT5>;
	Wed, 13 Feb 2002 04:19:57 -0500
Message-ID: <3C6A2F86.E5C322D4@zip.com.au>
Date: Wed, 13 Feb 2002 01:19:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] compile fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should fix all the remaining .text.exit problems
which have resulted from recent binutils changes.   For all
files which are accessible to an x86 build.

With these changes I was able to link the entire tree with
CONFIG_HOTPLUG enabled and disabled.

The kernel text+data+bss was 21 megabytes.  The build system
whined about "System is too big. Try using modules." so I couldn't
test it, which would have been rather fun.

Affected files:

drivers/char/mwave/mwavedd.c
drivers/media/video/zr36120.c
drivers/sound/cs4232.c
drivers/sound/mpu401.c
drivers/mtd/maps/elan-104nc.c
drivers/mtd/maps/sbc_gxx.c
drivers/isdn/avmb1/capi.c
drivers/atm/firestream.c
drivers/char/synclink.c
drivers/net/tokenring/abyss.c
drivers/net/tokenring/tmspci.c
drivers/net/hamachi.c
drivers/net/rcpci45.c
drivers/sound/i810_audio.c
drivers/sound/trident.c
drivers/sound/via82cxxx_audio.c
drivers/media/video/bttv-driver.c
drivers/net/wireless/orinoco_plx.c
drivers/video/radeonfb.c


--- linux-2.4.18-pre9/drivers/char/mwave/mwavedd.c	Thu Oct 11 09:14:32 2001
+++ linux-akpm/drivers/char/mwave/mwavedd.c	Tue Feb 12 23:47:28 2002
@@ -462,7 +462,7 @@ static struct miscdevice mwave_misc_dev 
 * mwave_exit is called on module unload
 * mwave_exit is also used to clean up after an aborted mwave_init
 */
-static void __exit mwave_exit(void)
+static void mwave_exit(void)
 {
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
--- linux-2.4.18-pre9/drivers/media/video/zr36120.c	Thu Nov 22 23:02:57 2001
+++ linux-akpm/drivers/media/video/zr36120.c	Tue Feb 12 23:47:28 2002
@@ -2025,7 +2025,7 @@ int __init init_zoran(int card)
 }
 
 static
-void __exit release_zoran(int max)
+void release_zoran(int max)
 {
 	struct zoran *ztv;
 	int i;
--- linux-2.4.18-pre9/drivers/sound/cs4232.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/drivers/sound/cs4232.c	Tue Feb 12 23:47:28 2002
@@ -277,7 +277,7 @@ void __init attach_cs4232(struct address
 	}
 }
 
-void __exit unload_cs4232(struct address_info *hw_config)
+void unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
--- linux-2.4.18-pre9/drivers/sound/mpu401.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/drivers/sound/mpu401.c	Tue Feb 12 23:47:28 2002
@@ -1227,7 +1227,7 @@ int probe_mpu401(struct address_info *hw
 	return ok;
 }
 
-void __exit unload_mpu401(struct address_info *hw_config)
+void unload_mpu401(struct address_info *hw_config)
 {
 	void *p;
 	int n=hw_config->slots[1];
--- linux-2.4.18-pre9/drivers/mtd/maps/elan-104nc.c	Thu Oct  4 15:14:59 2001
+++ linux-akpm/drivers/mtd/maps/elan-104nc.c	Tue Feb 12 23:47:28 2002
@@ -213,7 +213,7 @@ static struct map_info elan_104nc_map = 
 /* MTD device for all of the flash. */
 static struct mtd_info *all_mtd;
 
-static void __exit cleanup_elan_104nc(void)
+static void cleanup_elan_104nc(void)
 {
 	if( all_mtd ) {
 		del_mtd_partitions( all_mtd );
--- linux-2.4.18-pre9/drivers/mtd/maps/sbc_gxx.c	Thu Oct  4 15:14:59 2001
+++ linux-akpm/drivers/mtd/maps/sbc_gxx.c	Tue Feb 12 23:47:28 2002
@@ -221,7 +221,7 @@ static struct map_info sbc_gxx_map = {
 /* MTD device for all of the flash. */
 static struct mtd_info *all_mtd;
 
-static void __exit cleanup_sbc_gxx(void)
+static void cleanup_sbc_gxx(void)
 {
 	if( all_mtd ) {
 		del_mtd_partitions( all_mtd );
--- linux-2.4.18-pre9/drivers/isdn/avmb1/capi.c	Thu Feb  7 13:04:12 2002
+++ linux-akpm/drivers/isdn/avmb1/capi.c	Tue Feb 12 23:49:17 2002
@@ -1772,7 +1772,7 @@ static void __exit proc_exit(void)
 /* -------- init function and module interface ---------------------- */
 
 
-static void __exit alloc_exit(void)
+static void alloc_exit(void)
 {
 	if (capidev_cachep) {
 		(void)kmem_cache_destroy(capidev_cachep);
--- linux-2.4.18-pre9/drivers/atm/firestream.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/atm/firestream.c	Wed Feb 13 00:41:29 2002
@@ -1530,7 +1530,7 @@ static void top_off_fp (struct fs_dev *d
 	fs_dprintk (FS_DEBUG_QUEUE, "Added %d entries. \n", n);
 }
 
-static void __exit free_queue (struct fs_dev *dev, struct queue *txq)
+static void __devexit free_queue (struct fs_dev *dev, struct queue *txq)
 {
 	func_enter ();
 
@@ -1546,7 +1546,7 @@ static void __exit free_queue (struct fs
 	func_exit ();
 }
 
-static void __exit free_freepool (struct fs_dev *dev, struct freepool *fp)
+static void __devexit free_freepool (struct fs_dev *dev, struct freepool *fp)
 {
 	func_enter ();
 
@@ -2088,7 +2088,7 @@ int __init init_PCI (void)
 #endif 
 */
 
-const static struct pci_device_id firestream_pci_tbl[] __devinitdata = {
+static struct pci_device_id firestream_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS50, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, FS_IS50},
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS155, 
--- linux-2.4.18-pre9/drivers/char/synclink.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/char/synclink.c	Wed Feb 13 00:18:08 2002
@@ -940,7 +940,7 @@ static struct pci_driver synclink_pci_dr
 	name:		"synclink",
 	id_table:	synclink_pci_tbl,
 	probe:		synclink_init_one,
-	remove:		synclink_remove_one,
+	remove:		__devexit_p(synclink_remove_one),
 };
 
 static struct tty_driver serial_driver, callout_driver;
@@ -8219,7 +8219,7 @@ static int __init synclink_init_one (str
 	return 0;
 }
 
-static void __exit synclink_remove_one (struct pci_dev *dev)
+static void __devexit synclink_remove_one (struct pci_dev *dev)
 {
 }
 
--- linux-2.4.18-pre9/drivers/net/tokenring/abyss.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/drivers/net/tokenring/abyss.c	Wed Feb 13 00:11:01 2002
@@ -433,7 +433,7 @@ static int abyss_close(struct net_device
 	return 0;
 }
 
-static void __exit abyss_detach (struct pci_dev *pdev)
+static void __devexit abyss_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	
@@ -451,7 +451,7 @@ static struct pci_driver abyss_driver = 
 	name:		"abyss",
 	id_table:	abyss_pci_tbl,
 	probe:		abyss_attach,
-	remove:		abyss_detach,
+	remove:		__devexit_p(abyss_detach),
 };
 
 static int __init abyss_init (void)
--- linux-2.4.18-pre9/drivers/net/tokenring/tmspci.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/drivers/net/tokenring/tmspci.c	Wed Feb 13 00:11:55 2002
@@ -220,7 +220,7 @@ static unsigned short tms_pci_setnselout
 	return val;
 }
 
-static void __exit tms_pci_detach (struct pci_dev *pdev)
+static void __devexit tms_pci_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -238,7 +238,7 @@ static struct pci_driver tms_pci_driver 
 	name:		"tmspci",
 	id_table:	tmspci_pci_tbl,
 	probe:		tms_pci_attach,
-	remove:		tms_pci_detach,
+	remove:		__devexit_p(tms_pci_detach),
 };
 
 static int __init tms_pci_init (void)
--- linux-2.4.18-pre9/drivers/net/hamachi.c	Tue Oct  9 15:13:03 2001
+++ linux-akpm/drivers/net/hamachi.c	Wed Feb 13 00:12:14 2002
@@ -1981,7 +1981,7 @@ static int netdev_ioctl(struct net_devic
 }
 
 
-static void __exit hamachi_remove_one (struct pci_dev *pdev)
+static void __devexit hamachi_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -2011,7 +2011,7 @@ static struct pci_driver hamachi_driver 
 	name:		DRV_NAME,
 	id_table:	hamachi_pci_tbl,
 	probe:		hamachi_init_one,
-	remove:		hamachi_remove_one,
+	remove:		__devexit_p(hamachi_remove_one),
 };
 
 static int __init hamachi_init (void)
--- linux-2.4.18-pre9/drivers/net/rcpci45.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/net/rcpci45.c	Wed Feb 13 00:12:47 2002
@@ -124,7 +124,7 @@ static struct pci_device_id rcpci45_pci_
 MODULE_DEVICE_TABLE (pci, rcpci45_pci_table);
 MODULE_LICENSE("GPL");
 
-static void __exit
+static void __devexit
 rcpci45_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
@@ -267,7 +267,7 @@ static struct pci_driver rcpci45_driver 
 	name:		"rcpci45",
 	id_table:	rcpci45_pci_table,
 	probe:		rcpci45_init_one,
-	remove:		rcpci45_remove_one,
+	remove:		__devexit_p(rcpci45_remove_one),
 };
 
 static int __init
--- linux-2.4.18-pre9/drivers/sound/i810_audio.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/i810_audio.c	Wed Feb 13 00:18:34 2002
@@ -2938,7 +2938,7 @@ static int __init i810_probe(struct pci_
 	return 0;
 }
 
-static void __exit i810_remove(struct pci_dev *pci_dev)
+static void __devexit i810_remove(struct pci_dev *pci_dev)
 {
 	int i;
 	struct i810_card *card = pci_get_drvdata(pci_dev);
@@ -3098,7 +3098,7 @@ static struct pci_driver i810_pci_driver
 	name:		I810_MODULE_NAME,
 	id_table:	i810_pci_tbl,
 	probe:		i810_probe,
-	remove:		i810_remove,
+	remove:		__devexit_p(i810_remove),
 #ifdef CONFIG_PM
 	suspend:	i810_pm_suspend,
 	resume:		i810_pm_resume,
--- linux-2.4.18-pre9/drivers/sound/trident.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/trident.c	Wed Feb 13 00:19:28 2002
@@ -4149,7 +4149,7 @@ out_release_region:
 	goto out;
 }
 
-static void __exit trident_remove(struct pci_dev *pci_dev)
+static void __devexit trident_remove(struct pci_dev *pci_dev)
 {
 	int i;
 	struct trident_card *card = pci_get_drvdata(pci_dev);
@@ -4202,7 +4202,7 @@ static struct pci_driver trident_pci_dri
 	name:		TRIDENT_MODULE_NAME,
 	id_table:	trident_pci_tbl,
 	probe:		trident_probe,
-	remove:		trident_remove,
+	remove:		__devexit_p(trident_remove),
 	suspend:	trident_suspend,
 	resume:		trident_resume
 };
--- linux-2.4.18-pre9/drivers/sound/via82cxxx_audio.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/sound/via82cxxx_audio.c	Wed Feb 13 00:19:50 2002
@@ -311,7 +311,7 @@ static unsigned via_num_cards = 0;
  */
 
 static int via_init_one (struct pci_dev *dev, const struct pci_device_id *id);
-static void via_remove_one (struct pci_dev *pdev);
+static void __devexit via_remove_one (struct pci_dev *pdev);
 
 static ssize_t via_dsp_read(struct file *file, char *buffer, size_t count, loff_t *ppos);
 static ssize_t via_dsp_write(struct file *file, const char *buffer, size_t count, loff_t *ppos);
@@ -365,7 +365,7 @@ static struct pci_driver via_driver = {
 	name:		VIA_MODULE_NAME,
 	id_table:	via_pci_tbl,
 	probe:		via_init_one,
-	remove:		via_remove_one,
+	remove:		__devexit_p(via_remove_one),
 };
 
 
@@ -3271,7 +3271,7 @@ err_out:
 }
 
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 	struct via_info *card;
 
--- linux-2.4.18-pre9/drivers/media/video/bttv-driver.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/media/video/bttv-driver.c	Wed Feb 13 00:56:53 2002
@@ -2820,7 +2820,7 @@ static void bttv_irq(int irq, void *dev_
  *	Scan for a Bt848 card, request the irq and map the io memory 
  */
 
-static void __devexit bttv_remove(struct pci_dev *pci_dev)
+static void bttv_remove(struct pci_dev *pci_dev)
 {
         u8 command;
         int j;
@@ -3025,7 +3025,7 @@ static struct pci_driver bttv_pci_driver
         name:     "bttv",
         id_table: bttv_pci_tbl,
         probe:    bttv_probe,
-        remove:   __devexit_p(bttv_remove),
+        remove:   bttv_remove,
 };
 
 int bttv_init_module(void)
--- linux-2.4.18-pre9/drivers/net/wireless/orinoco_plx.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/net/wireless/orinoco_plx.c	Wed Feb 13 00:58:37 2002
@@ -394,7 +394,7 @@ static struct pci_driver orinoco_plx_dri
 	name:"orinoco_plx",
 	id_table:orinoco_plx_pci_id_table,
 	probe:orinoco_plx_init_one,
-	remove:orinoco_plx_remove_one,
+	remove:__devexit_p(orinoco_plx_remove_one),
 	suspend:0,
 	resume:0
 };
--- linux-2.4.18-pre9/drivers/video/radeonfb.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/video/radeonfb.c	Wed Feb 13 00:59:12 2002
@@ -690,7 +690,7 @@ static struct pci_driver radeonfb_driver
 	name:		"radeonfb",
 	id_table:	radeonfb_pci_table,
 	probe:		radeonfb_pci_register,
-	remove:		radeonfb_pci_unregister,
+	remove:		__devexit_p(radeonfb_pci_unregister),
 };
 
 

-
