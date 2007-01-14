Return-Path: <linux-kernel-owner+w=401wt.eu-S1750917AbXANBAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXANBAr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXANBAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:00:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52754 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbXANBAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:00:43 -0500
Subject: [patch 03/12] mark struct file_operations const 3
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:53:58 -0800
Message-Id: <1168736038.3123.323.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 03/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/block/blktrace.c
===================================================================
--- linux-2.6.orig/block/blktrace.c
+++ linux-2.6/block/blktrace.c
@@ -264,7 +264,7 @@ static ssize_t blk_dropped_read(struct f
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
 }
 
-static struct file_operations blk_dropped_fops = {
+static const struct file_operations blk_dropped_fops = {
 	.owner =	THIS_MODULE,
 	.open =		blk_dropped_open,
 	.read =		blk_dropped_read,
Index: linux-2.6/crypto/proc.c
===================================================================
--- linux-2.6.orig/crypto/proc.c
+++ linux-2.6/crypto/proc.c
@@ -101,7 +101,7 @@ static int crypto_info_open(struct inode
 	return seq_open(file, &crypto_seq_ops);
 }
         
-static struct file_operations proc_crypto_ops = {
+static const struct file_operations proc_crypto_ops = {
 	.open		= crypto_info_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/acorn/char/i2c.c
===================================================================
--- linux-2.6.orig/drivers/acorn/char/i2c.c
+++ linux-2.6/drivers/acorn/char/i2c.c
@@ -238,7 +238,7 @@ static int rtc_ioctl(struct inode *inode
 	return -EINVAL;
 }
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.ioctl	= rtc_ioctl,
 };
 
Index: linux-2.6/drivers/block/acsi_slm.c
===================================================================
--- linux-2.6.orig/drivers/block/acsi_slm.c
+++ linux-2.6/drivers/block/acsi_slm.c
@@ -269,7 +269,7 @@ static int slm_get_pagesize( int device,
 
 static DEFINE_TIMER(slm_timer, slm_test_ready, 0, 0);
 
-static struct file_operations slm_fops = {
+static const struct file_operations slm_fops = {
 	.owner =	THIS_MODULE,
 	.read =		slm_read,
 	.write =	slm_write,
Index: linux-2.6/drivers/block/aoe/aoechr.c
===================================================================
--- linux-2.6.orig/drivers/block/aoe/aoechr.c
+++ linux-2.6/drivers/block/aoe/aoechr.c
@@ -233,7 +233,7 @@ loop:
 	}
 }
 
-static struct file_operations aoe_fops = {
+static const struct file_operations aoe_fops = {
 	.write = aoechr_write,
 	.read = aoechr_read,
 	.open = aoechr_open,
Index: linux-2.6/drivers/block/DAC960.c
===================================================================
--- linux-2.6.orig/drivers/block/DAC960.c
+++ linux-2.6/drivers/block/DAC960.c
@@ -7025,7 +7025,7 @@ static int DAC960_gam_ioctl(struct inode
   return -EINVAL;
 }
 
-static struct file_operations DAC960_gam_fops = {
+static const struct file_operations DAC960_gam_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= DAC960_gam_ioctl
 };
Index: linux-2.6/drivers/block/paride/pg.c
===================================================================
--- linux-2.6.orig/drivers/block/paride/pg.c
+++ linux-2.6/drivers/block/paride/pg.c
@@ -227,7 +227,7 @@ static struct class *pg_class;
 
 /* kernel glue structures */
 
-static struct file_operations pg_fops = {
+static const struct file_operations pg_fops = {
 	.owner = THIS_MODULE,
 	.read = pg_read,
 	.write = pg_write,
Index: linux-2.6/drivers/block/paride/pt.c
===================================================================
--- linux-2.6.orig/drivers/block/paride/pt.c
+++ linux-2.6/drivers/block/paride/pt.c
@@ -232,7 +232,7 @@ static char pt_scratch[512];	/* scratch 
 
 /* kernel glue structures */
 
-static struct file_operations pt_fops = {
+static const struct file_operations pt_fops = {
 	.owner = THIS_MODULE,
 	.read = pt_read,
 	.write = pt_write,
Index: linux-2.6/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.orig/drivers/block/pktcdvd.c
+++ linux-2.6/drivers/block/pktcdvd.c
@@ -447,7 +447,7 @@ static int pkt_debugfs_fops_open(struct 
 	return single_open(file, pkt_debugfs_seq_show, inode->i_private);
 }
 
-static struct file_operations debug_fops = {
+static const struct file_operations debug_fops = {
 	.open		= pkt_debugfs_fops_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -2737,7 +2737,7 @@ static int pkt_seq_open(struct inode *in
 	return single_open(file, pkt_seq_show, PDE(inode)->data);
 }
 
-static struct file_operations pkt_proc_fops = {
+static const struct file_operations pkt_proc_fops = {
 	.open	= pkt_seq_open,
 	.read	= seq_read,
 	.llseek	= seq_lseek,
@@ -3064,7 +3064,7 @@ static int pkt_ctl_ioctl(struct inode *i
 }
 
 
-static struct file_operations pkt_ctl_fops = {
+static const struct file_operations pkt_ctl_fops = {
 	.ioctl	 = pkt_ctl_ioctl,
 	.owner	 = THIS_MODULE,
 };
Index: linux-2.6/drivers/bluetooth/hci_vhci.c
===================================================================
--- linux-2.6.orig/drivers/bluetooth/hci_vhci.c
+++ linux-2.6/drivers/bluetooth/hci_vhci.c
@@ -332,7 +332,7 @@ static int vhci_fasync(int fd, struct fi
 	return 0;
 }
 
-static struct file_operations vhci_fops = {
+static const struct file_operations vhci_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= vhci_llseek,
 	.read		= vhci_read,
Index: linux-2.6/drivers/cdrom/viocd.c
===================================================================
--- linux-2.6.orig/drivers/cdrom/viocd.c
+++ linux-2.6/drivers/cdrom/viocd.c
@@ -176,7 +176,7 @@ static int proc_viocd_open(struct inode 
 	return single_open(file, proc_viocd_show, NULL);
 }
 
-static struct file_operations proc_viocd_operations = {
+static const struct file_operations proc_viocd_operations = {
 	.open		= proc_viocd_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/char/briq_panel.c
===================================================================
--- linux-2.6.orig/drivers/char/briq_panel.c
+++ linux-2.6/drivers/char/briq_panel.c
@@ -187,7 +187,7 @@ static ssize_t briq_panel_write(struct f
 	return len;
 }
 
-static struct file_operations briq_panel_fops = {
+static const struct file_operations briq_panel_fops = {
 	.owner		= THIS_MODULE,
 	.read		= briq_panel_read,
 	.write		= briq_panel_write,
Index: linux-2.6/drivers/char/drm/drm_drv.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/drm_drv.c
+++ linux-2.6/drivers/char/drm/drm_drv.c
@@ -371,7 +371,7 @@ void drm_exit(struct drm_driver *driver)
 EXPORT_SYMBOL(drm_exit);
 
 /** File operations structure */
-static struct file_operations drm_stub_fops = {
+static const struct file_operations drm_stub_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_stub_open
 };
Index: linux-2.6/drivers/char/drm/i810_dma.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/i810_dma.c
+++ linux-2.6/drivers/char/drm/i810_dma.c
@@ -112,7 +112,7 @@ static int i810_mmap_buffers(struct file
 	return 0;
 }
 
-static struct file_operations i810_buffer_fops = {
+static const struct file_operations i810_buffer_fops = {
 	.open = drm_open,
 	.release = drm_release,
 	.ioctl = drm_ioctl,
Index: linux-2.6/drivers/char/drm/i830_dma.c
===================================================================
--- linux-2.6.orig/drivers/char/drm/i830_dma.c
+++ linux-2.6/drivers/char/drm/i830_dma.c
@@ -114,7 +114,7 @@ static int i830_mmap_buffers(struct file
 	return 0;
 }
 
-static struct file_operations i830_buffer_fops = {
+static const struct file_operations i830_buffer_fops = {
 	.open = drm_open,
 	.release = drm_release,
 	.ioctl = drm_ioctl,
Index: linux-2.6/drivers/char/generic_nvram.c
===================================================================
--- linux-2.6.orig/drivers/char/generic_nvram.c
+++ linux-2.6/drivers/char/generic_nvram.c
@@ -117,7 +117,7 @@ static int nvram_ioctl(struct inode *ino
 	return 0;
 }
 
-struct file_operations nvram_fops = {
+const struct file_operations nvram_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= nvram_llseek,
 	.read		= read_nvram,
Index: linux-2.6/drivers/char/mbcs.c
===================================================================
--- linux-2.6.orig/drivers/char/mbcs.c
+++ linux-2.6/drivers/char/mbcs.c
@@ -46,7 +46,7 @@ LIST_HEAD(soft_list);
 /*
  * file operations
  */
-struct file_operations mbcs_ops = {
+const struct file_operations mbcs_ops = {
 	.open = mbcs_open,
 	.llseek = mbcs_sram_llseek,
 	.read = mbcs_sram_read,
Index: linux-2.6/drivers/char/mspec.c
===================================================================
--- linux-2.6.orig/drivers/char/mspec.c
+++ linux-2.6/drivers/char/mspec.c
@@ -291,7 +291,7 @@ uncached_mmap(struct file *file, struct 
 	return mspec_mmap(file, vma, MSPEC_UNCACHED);
 }
 
-static struct file_operations fetchop_fops = {
+static const struct file_operations fetchop_fops = {
 	.owner = THIS_MODULE,
 	.mmap = fetchop_mmap
 };
@@ -302,7 +302,7 @@ static struct miscdevice fetchop_miscdev
 	.fops = &fetchop_fops
 };
 
-static struct file_operations cached_fops = {
+static const struct file_operations cached_fops = {
 	.owner = THIS_MODULE,
 	.mmap = cached_mmap
 };
@@ -313,7 +313,7 @@ static struct miscdevice cached_miscdev 
 	.fops = &cached_fops
 };
 
-static struct file_operations uncached_fops = {
+static const struct file_operations uncached_fops = {
 	.owner = THIS_MODULE,
 	.mmap = uncached_mmap
 };
Index: linux-2.6/drivers/char/random.c
===================================================================
--- linux-2.6.orig/drivers/char/random.c
+++ linux-2.6/drivers/char/random.c
@@ -1117,14 +1117,14 @@ random_ioctl(struct inode * inode, struc
 	}
 }
 
-struct file_operations random_fops = {
+const struct file_operations random_fops = {
 	.read  = random_read,
 	.write = random_write,
 	.poll  = random_poll,
 	.ioctl = random_ioctl,
 };
 
-struct file_operations urandom_fops = {
+const struct file_operations urandom_fops = {
 	.read  = urandom_read,
 	.write = random_write,
 	.ioctl = random_ioctl,
Index: linux-2.6/drivers/char/tpm/tpm_bios.c
===================================================================
--- linux-2.6.orig/drivers/char/tpm/tpm_bios.c
+++ linux-2.6/drivers/char/tpm/tpm_bios.c
@@ -443,7 +443,7 @@ static int tpm_ascii_bios_measurements_o
 	return err;
 }
 
-struct file_operations tpm_ascii_bios_measurements_ops = {
+const struct file_operations tpm_ascii_bios_measurements_ops = {
 	.open = tpm_ascii_bios_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -476,7 +476,7 @@ static int tpm_binary_bios_measurements_
 	return err;
 }
 
-struct file_operations tpm_binary_bios_measurements_ops = {
+const struct file_operations tpm_binary_bios_measurements_ops = {
 	.open = tpm_binary_bios_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
Index: linux-2.6/drivers/char/viotape.c
===================================================================
--- linux-2.6.orig/drivers/char/viotape.c
+++ linux-2.6/drivers/char/viotape.c
@@ -872,7 +872,7 @@ free_op:
 	return ret;
 }
 
-struct file_operations viotap_fops = {
+const struct file_operations viotap_fops = {
 	owner: THIS_MODULE,
 	read: viotap_read,
 	write: viotap_write,
Index: linux-2.6/drivers/char/watchdog/iTCO_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/iTCO_wdt.c
+++ linux-2.6/drivers/char/watchdog/iTCO_wdt.c
@@ -539,7 +539,7 @@ static int iTCO_wdt_ioctl (struct inode 
  *	Kernel Interfaces
  */
 
-static struct file_operations iTCO_wdt_fops = {
+static const struct file_operations iTCO_wdt_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.write =	iTCO_wdt_write,
Index: linux-2.6/drivers/char/watchdog/omap_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/omap_wdt.c
+++ linux-2.6/drivers/char/watchdog/omap_wdt.c
@@ -230,7 +230,7 @@ omap_wdt_ioctl(struct inode *inode, stru
 	}
 }
 
-static struct file_operations omap_wdt_fops = {
+static const struct file_operations omap_wdt_fops = {
 	.owner = THIS_MODULE,
 	.write = omap_wdt_write,
 	.ioctl = omap_wdt_ioctl,
Index: linux-2.6/drivers/char/watchdog/pc87413_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/pc87413_wdt.c
+++ linux-2.6/drivers/char/watchdog/pc87413_wdt.c
@@ -526,7 +526,7 @@ static int pc87413_notify_sys(struct not
 
 /* -- Module's structures ---------------------------------------*/
 
-static struct file_operations pc87413_fops = {
+static const struct file_operations pc87413_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= pc87413_write,
Index: linux-2.6/drivers/char/watchdog/pnx4008_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/pnx4008_wdt.c
+++ linux-2.6/drivers/char/watchdog/pnx4008_wdt.c
@@ -238,7 +238,7 @@ static int pnx4008_wdt_release(struct in
 	return 0;
 }
 
-static struct file_operations pnx4008_wdt_fops = {
+static const struct file_operations pnx4008_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.write = pnx4008_wdt_write,
Index: linux-2.6/drivers/char/watchdog/rm9k_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/rm9k_wdt.c
+++ linux-2.6/drivers/char/watchdog/rm9k_wdt.c
@@ -95,7 +95,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog can
 
 
 /* Kernel interfaces */
-static struct file_operations fops = {
+static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
 	.open		= wdt_gpi_open,
 	.release	= wdt_gpi_release,
Index: linux-2.6/drivers/char/watchdog/smsc37b787_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/smsc37b787_wdt.c
+++ linux-2.6/drivers/char/watchdog/smsc37b787_wdt.c
@@ -510,7 +510,7 @@ static int wb_smsc_wdt_notify_sys(struct
 
 /* -- Module's structures ---------------------------------------*/
 
-static struct file_operations wb_smsc_wdt_fops =
+static const struct file_operations wb_smsc_wdt_fops =
 {
 	.owner          = THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6/drivers/char/watchdog/w83697hf_wdt.c
===================================================================
--- linux-2.6.orig/drivers/char/watchdog/w83697hf_wdt.c
+++ linux-2.6/drivers/char/watchdog/w83697hf_wdt.c
@@ -323,7 +323,7 @@ wdt_notify_sys(struct notifier_block *th
  *	Kernel Interfaces
  */
 
-static struct file_operations wdt_fops = {
+static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.write		= wdt_write,
Index: linux-2.6/drivers/i2c/chips/tps65010.c
===================================================================
--- linux-2.6.orig/drivers/i2c/chips/tps65010.c
+++ linux-2.6/drivers/i2c/chips/tps65010.c
@@ -308,7 +308,7 @@ static int dbg_tps_open(struct inode *in
 	return single_open(file, dbg_show, inode->i_private);
 }
 
-static struct file_operations debug_fops = {
+static const struct file_operations debug_fops = {
 	.open		= dbg_tps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/i2c/i2c-dev.c
===================================================================
--- linux-2.6.orig/drivers/i2c/i2c-dev.c
+++ linux-2.6/drivers/i2c/i2c-dev.c
@@ -392,7 +392,7 @@ static int i2cdev_release(struct inode *
 	return 0;
 }
 
-static struct file_operations i2cdev_fops = {
+static const struct file_operations i2cdev_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= i2cdev_read,
Index: linux-2.6/drivers/ide/ide-proc.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-proc.c
+++ linux-2.6/drivers/ide/ide-proc.c
@@ -549,7 +549,7 @@ static int ide_drivers_open(struct inode
 	return single_open(file, &ide_drivers_show, NULL);
 }
 
-static struct file_operations ide_drivers_operations = {
+static const struct file_operations ide_drivers_operations = {
 	.open		= ide_drivers_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/ide/ide-tape.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-tape.c
+++ linux-2.6/drivers/ide/ide-tape.c
@@ -4779,7 +4779,7 @@ static ide_driver_t idetape_driver = {
 /*
  *	Our character device supporting functions, passed to register_chrdev.
  */
-static struct file_operations idetape_fops = {
+static const struct file_operations idetape_fops = {
 	.owner		= THIS_MODULE,
 	.read		= idetape_chrdev_read,
 	.write		= idetape_chrdev_write,
Index: linux-2.6/drivers/ieee1394/dv1394.c
===================================================================
--- linux-2.6.orig/drivers/ieee1394/dv1394.c
+++ linux-2.6/drivers/ieee1394/dv1394.c
@@ -2147,7 +2147,7 @@ out:
 }
 
 static struct cdev dv1394_cdev;
-static struct file_operations dv1394_fops=
+static const struct file_operations dv1394_fops=
 {
 	.owner =	THIS_MODULE,
 	.poll =         dv1394_poll,
Index: linux-2.6/drivers/ieee1394/raw1394.c
===================================================================
--- linux-2.6.orig/drivers/ieee1394/raw1394.c
+++ linux-2.6/drivers/ieee1394/raw1394.c
@@ -3003,7 +3003,7 @@ static struct hpsb_highlevel raw1394_hig
 };
 
 static struct cdev raw1394_cdev;
-static struct file_operations raw1394_fops = {
+static const struct file_operations raw1394_fops = {
 	.owner = THIS_MODULE,
 	.read = raw1394_read,
 	.write = raw1394_write,
Index: linux-2.6/drivers/ieee1394/video1394.c
===================================================================
--- linux-2.6.orig/drivers/ieee1394/video1394.c
+++ linux-2.6/drivers/ieee1394/video1394.c
@@ -1269,7 +1269,7 @@ static long video1394_compat_ioctl(struc
 #endif
 
 static struct cdev video1394_cdev;
-static struct file_operations video1394_fops=
+static const struct file_operations video1394_fops=
 {
 	.owner =	THIS_MODULE,
 	.unlocked_ioctl = video1394_ioctl,
Index: linux-2.6/drivers/infiniband/core/ucma.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/core/ucma.c
+++ linux-2.6/drivers/infiniband/core/ucma.c
@@ -833,7 +833,7 @@ static int ucma_close(struct inode *inod
 	return 0;
 }
 
-static struct file_operations ucma_fops = {
+static const struct file_operations ucma_fops = {
 	.owner 	 = THIS_MODULE,
 	.open 	 = ucma_open,
 	.release = ucma_close,
Index: linux-2.6/drivers/infiniband/core/ucm.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/core/ucm.c
+++ linux-2.6/drivers/infiniband/core/ucm.c
@@ -1221,7 +1221,7 @@ static void ib_ucm_release_class_dev(str
 	kfree(dev);
 }
 
-static struct file_operations ucm_fops = {
+static const struct file_operations ucm_fops = {
 	.owner 	 = THIS_MODULE,
 	.open 	 = ib_ucm_open,
 	.release = ib_ucm_close,
Index: linux-2.6/drivers/infiniband/core/user_mad.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/core/user_mad.c
+++ linux-2.6/drivers/infiniband/core/user_mad.c
@@ -771,7 +771,7 @@ static int ib_umad_close(struct inode *i
 	return 0;
 }
 
-static struct file_operations umad_fops = {
+static const struct file_operations umad_fops = {
 	.owner 	 	= THIS_MODULE,
 	.read 	 	= ib_umad_read,
 	.write 	 	= ib_umad_write,
@@ -846,7 +846,7 @@ static int ib_umad_sm_close(struct inode
 	return ret;
 }
 
-static struct file_operations umad_sm_fops = {
+static const struct file_operations umad_sm_fops = {
 	.owner 	 = THIS_MODULE,
 	.open 	 = ib_umad_sm_open,
 	.release = ib_umad_sm_close
Index: linux-2.6/drivers/infiniband/core/uverbs_main.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/core/uverbs_main.c
+++ linux-2.6/drivers/infiniband/core/uverbs_main.c
@@ -375,7 +375,7 @@ static int ib_uverbs_event_close(struct 
 	return 0;
 }
 
-static struct file_operations uverbs_event_fops = {
+static const struct file_operations uverbs_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read 	 = ib_uverbs_event_read,
 	.poll    = ib_uverbs_event_poll,
@@ -679,14 +679,14 @@ static int ib_uverbs_close(struct inode 
 	return 0;
 }
 
-static struct file_operations uverbs_fops = {
+static const struct file_operations uverbs_fops = {
 	.owner 	 = THIS_MODULE,
 	.write 	 = ib_uverbs_write,
 	.open 	 = ib_uverbs_open,
 	.release = ib_uverbs_close
 };
 
-static struct file_operations uverbs_mmap_fops = {
+static const struct file_operations uverbs_mmap_fops = {
 	.owner 	 = THIS_MODULE,
 	.write 	 = ib_uverbs_write,
 	.mmap    = ib_uverbs_mmap,
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_diag.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_diag.c
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_diag.c
@@ -59,7 +59,7 @@ static ssize_t ipath_diag_read(struct fi
 static ssize_t ipath_diag_write(struct file *fp, const char __user *data,
 				size_t count, loff_t *off);
 
-static struct file_operations diag_file_ops = {
+static const struct file_operations diag_file_ops = {
 	.owner = THIS_MODULE,
 	.write = ipath_diag_write,
 	.read = ipath_diag_read,
@@ -71,7 +71,7 @@ static ssize_t ipath_diagpkt_write(struc
 				   const char __user *data,
 				   size_t count, loff_t *off);
 
-static struct file_operations diagpkt_file_ops = {
+static const struct file_operations diagpkt_file_ops = {
 	.owner = THIS_MODULE,
 	.write = ipath_diagpkt_write,
 };
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_file_ops.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_file_ops.c
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_file_ops.c
@@ -54,7 +54,7 @@ static ssize_t ipath_write(struct file *
 static unsigned int ipath_poll(struct file *, struct poll_table_struct *);
 static int ipath_mmap(struct file *, struct vm_area_struct *);
 
-static struct file_operations ipath_file_ops = {
+static const struct file_operations ipath_file_ops = {
 	.owner = THIS_MODULE,
 	.write = ipath_write,
 	.open = ipath_open,
@@ -2153,7 +2153,7 @@ bail:
 
 static struct class *ipath_class;
 
-static int init_cdev(int minor, char *name, struct file_operations *fops,
+static int init_cdev(int minor, char *name, const struct file_operations *fops,
 		     struct cdev **cdevp, struct class_device **class_devp)
 {
 	const dev_t dev = MKDEV(IPATH_MAJOR, minor);
@@ -2210,7 +2210,7 @@ done:
 	return ret;
 }
 
-int ipath_cdev_init(int minor, char *name, struct file_operations *fops,
+int ipath_cdev_init(int minor, char *name, const struct file_operations *fops,
 		    struct cdev **cdevp, struct class_device **class_devp)
 {
 	return init_cdev(minor, name, fops, cdevp, class_devp);
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_fs.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_fs.c
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_fs.c
@@ -47,7 +47,7 @@
 static struct super_block *ipath_super;
 
 static int ipathfs_mknod(struct inode *dir, struct dentry *dentry,
-			 int mode, struct file_operations *fops,
+			 int mode, const struct file_operations *fops,
 			 void *data)
 {
 	int error;
@@ -81,7 +81,7 @@ bail:
 
 static int create_file(const char *name, mode_t mode,
 		       struct dentry *parent, struct dentry **dentry,
-		       struct file_operations *fops, void *data)
+		       const struct file_operations *fops, void *data)
 {
 	int error;
 
@@ -105,7 +105,7 @@ static ssize_t atomic_stats_read(struct 
 				       sizeof ipath_stats);
 }
 
-static struct file_operations atomic_stats_ops = {
+static const struct file_operations atomic_stats_ops = {
 	.read = atomic_stats_read,
 };
 
@@ -127,7 +127,7 @@ static ssize_t atomic_counters_read(stru
 				       sizeof counters);
 }
 
-static struct file_operations atomic_counters_ops = {
+static const struct file_operations atomic_counters_ops = {
 	.read = atomic_counters_read,
 };
 
@@ -166,7 +166,7 @@ static ssize_t atomic_node_info_read(str
 				       sizeof nodeinfo);
 }
 
-static struct file_operations atomic_node_info_ops = {
+static const struct file_operations atomic_node_info_ops = {
 	.read = atomic_node_info_read,
 };
 
@@ -291,7 +291,7 @@ static ssize_t atomic_port_info_read(str
 				       sizeof portinfo);
 }
 
-static struct file_operations atomic_port_info_ops = {
+static const struct file_operations atomic_port_info_ops = {
 	.read = atomic_port_info_read,
 };
 
@@ -394,7 +394,7 @@ bail:
 	return ret;
 }
 
-static struct file_operations flash_ops = {
+static const struct file_operations flash_ops = {
 	.read = flash_read,
 	.write = flash_write,
 };
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_kernel.h
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_kernel.h
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_kernel.h
@@ -593,7 +593,7 @@ void ipath_shutdown_device(struct ipath_
 void ipath_disarm_senderrbufs(struct ipath_devdata *);
 
 struct file_operations;
-int ipath_cdev_init(int minor, char *name, struct file_operations *fops,
+int ipath_cdev_init(int minor, char *name, const struct file_operations *fops,
 		    struct cdev **cdevp, struct class_device **class_devp);
 void ipath_cdev_cleanup(struct cdev **cdevp,
 			struct class_device **class_devp);
Index: linux-2.6/drivers/infiniband/ulp/ipoib/ipoib_fs.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ linux-2.6/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -146,7 +146,7 @@ static int ipoib_mcg_open(struct inode *
 	return 0;
 }
 
-static struct file_operations ipoib_mcg_fops = {
+static const struct file_operations ipoib_mcg_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ipoib_mcg_open,
 	.read    = seq_read,
@@ -252,7 +252,7 @@ static int ipoib_path_open(struct inode 
 	return 0;
 }
 
-static struct file_operations ipoib_path_fops = {
+static const struct file_operations ipoib_path_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ipoib_path_open,
 	.read    = seq_read,
Index: linux-2.6/drivers/input/input.c
===================================================================
--- linux-2.6.orig/drivers/input/input.c
+++ linux-2.6/drivers/input/input.c
@@ -482,7 +482,7 @@ static int input_proc_devices_open(struc
 	return seq_open(file, &input_devices_seq_ops);
 }
 
-static struct file_operations input_devices_fileops = {
+static const struct file_operations input_devices_fileops = {
 	.owner		= THIS_MODULE,
 	.open		= input_proc_devices_open,
 	.poll		= input_proc_devices_poll,
@@ -533,7 +533,7 @@ static int input_proc_handlers_open(stru
 	return seq_open(file, &input_handlers_seq_ops);
 }
 
-static struct file_operations input_handlers_fileops = {
+static const struct file_operations input_handlers_fileops = {
 	.owner		= THIS_MODULE,
 	.open		= input_proc_handlers_open,
 	.read		= seq_read,
@@ -1142,7 +1142,7 @@ static int input_open_file(struct inode 
 	return err;
 }
 
-static struct file_operations input_fops = {
+static const struct file_operations input_fops = {
 	.owner = THIS_MODULE,
 	.open = input_open_file,
 };
Index: linux-2.6/drivers/input/misc/hp_sdc_rtc.c
===================================================================
--- linux-2.6.orig/drivers/input/misc/hp_sdc_rtc.c
+++ linux-2.6/drivers/input/misc/hp_sdc_rtc.c
@@ -670,7 +670,7 @@ static int hp_sdc_rtc_ioctl(struct inode
 #endif
 }
 
-static struct file_operations hp_sdc_rtc_fops = {
+static const struct file_operations hp_sdc_rtc_fops = {
         .owner =	THIS_MODULE,
         .llseek =	no_llseek,
         .read =		hp_sdc_rtc_read,
Index: linux-2.6/drivers/input/misc/uinput.c
===================================================================
--- linux-2.6.orig/drivers/input/misc/uinput.c
+++ linux-2.6/drivers/input/misc/uinput.c
@@ -627,7 +627,7 @@ static long uinput_ioctl(struct file *fi
 	return retval;
 }
 
-static struct file_operations uinput_fops = {
+static const struct file_operations uinput_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uinput_open,
 	.release	= uinput_release,
Index: linux-2.6/drivers/input/serio/serio_raw.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/serio_raw.c
+++ linux-2.6/drivers/input/serio/serio_raw.c
@@ -234,7 +234,7 @@ static unsigned int serio_raw_poll(struc
 	return 0;
 }
 
-static struct file_operations serio_raw_fops = {
+static const struct file_operations serio_raw_fops = {
 	.owner =	THIS_MODULE,
 	.open =		serio_raw_open,
 	.release =	serio_raw_release,
Index: linux-2.6/drivers/isdn/capi/capi.c
===================================================================
--- linux-2.6.orig/drivers/isdn/capi/capi.c
+++ linux-2.6/drivers/isdn/capi/capi.c
@@ -988,7 +988,7 @@ capi_release(struct inode *inode, struct
 	return 0;
 }
 
-static struct file_operations capi_fops =
+static const struct file_operations capi_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6/drivers/isdn/capi/kcapi_proc.c
===================================================================
--- linux-2.6.orig/drivers/isdn/capi/kcapi_proc.c
+++ linux-2.6/drivers/isdn/capi/kcapi_proc.c
@@ -113,14 +113,14 @@ static int seq_contrstats_open(struct in
 	return seq_open(file, &seq_contrstats_ops);
 }
 
-static struct file_operations proc_controller_ops = {
+static const struct file_operations proc_controller_ops = {
 	.open		= seq_controller_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
 
-static struct file_operations proc_contrstats_ops = {
+static const struct file_operations proc_contrstats_ops = {
 	.open		= seq_contrstats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -218,14 +218,14 @@ seq_applstats_open(struct inode *inode, 
 	return seq_open(file, &seq_applstats_ops);
 }
 
-static struct file_operations proc_applications_ops = {
+static const struct file_operations proc_applications_ops = {
 	.open		= seq_applications_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
 
-static struct file_operations proc_applstats_ops = {
+static const struct file_operations proc_applstats_ops = {
 	.open		= seq_applstats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -302,7 +302,7 @@ seq_capi_driver_open(struct inode *inode
 	return err;
 }
 
-static struct file_operations proc_driver_ops = {
+static const struct file_operations proc_driver_ops = {
 	.open		= seq_capi_driver_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/isdn/divert/divert_procfs.c
===================================================================
--- linux-2.6.orig/drivers/isdn/divert/divert_procfs.c
+++ linux-2.6/drivers/isdn/divert/divert_procfs.c
@@ -256,7 +256,7 @@ isdn_divert_ioctl(struct inode *inode, s
 
 
 #ifdef CONFIG_PROC_FS
-static struct file_operations isdn_fops =
+static const struct file_operations isdn_fops =
 {
 	.owner          = THIS_MODULE,
 	.llseek         = no_llseek,
Index: linux-2.6/drivers/isdn/hardware/eicon/divamnt.c
===================================================================
--- linux-2.6.orig/drivers/isdn/hardware/eicon/divamnt.c
+++ linux-2.6/drivers/isdn/hardware/eicon/divamnt.c
@@ -164,7 +164,7 @@ static ssize_t divas_maint_read(struct f
 	return (maint_read_write(buf, (int) count));
 }
 
-static struct file_operations divas_maint_fops = {
+static const struct file_operations divas_maint_fops = {
 	.owner   = THIS_MODULE,
 	.llseek  = no_llseek,
 	.read    = divas_maint_read,
Index: linux-2.6/drivers/isdn/hardware/eicon/divasi.c
===================================================================
--- linux-2.6.orig/drivers/isdn/hardware/eicon/divasi.c
+++ linux-2.6/drivers/isdn/hardware/eicon/divasi.c
@@ -131,7 +131,7 @@ static void remove_um_idi_proc(void)
 	}
 }
 
-static struct file_operations divas_idi_fops = {
+static const struct file_operations divas_idi_fops = {
 	.owner   = THIS_MODULE,
 	.llseek  = no_llseek,
 	.read    = um_idi_read,
Index: linux-2.6/drivers/isdn/hardware/eicon/divasmain.c
===================================================================
--- linux-2.6.orig/drivers/isdn/hardware/eicon/divasmain.c
+++ linux-2.6/drivers/isdn/hardware/eicon/divasmain.c
@@ -663,7 +663,7 @@ static unsigned int divas_poll(struct fi
 	return (POLLIN | POLLRDNORM);
 }
 
-static struct file_operations divas_fops = {
+static const struct file_operations divas_fops = {
 	.owner   = THIS_MODULE,
 	.llseek  = no_llseek,
 	.read    = divas_read,
Index: linux-2.6/drivers/isdn/hardware/eicon/divasproc.c
===================================================================
--- linux-2.6.orig/drivers/isdn/hardware/eicon/divasproc.c
+++ linux-2.6/drivers/isdn/hardware/eicon/divasproc.c
@@ -113,7 +113,7 @@ static int divas_close(struct inode *ino
 	return (0);
 }
 
-static struct file_operations divas_fops = {
+static const struct file_operations divas_fops = {
 	.owner   = THIS_MODULE,
 	.llseek  = no_llseek,
 	.read    = divas_read,
Index: linux-2.6/drivers/isdn/hysdn/hysdn_procconf.c
===================================================================
--- linux-2.6.orig/drivers/isdn/hysdn/hysdn_procconf.c
+++ linux-2.6/drivers/isdn/hysdn/hysdn_procconf.c
@@ -367,7 +367,7 @@ hysdn_conf_close(struct inode *ino, stru
 /******************************************************/
 /* table for conf filesystem functions defined above. */
 /******************************************************/
-static struct file_operations conf_fops =
+static const struct file_operations conf_fops =
 {
 	.llseek         = no_llseek,
 	.read           = hysdn_conf_read,
Index: linux-2.6/drivers/isdn/hysdn/hysdn_proclog.c
===================================================================
--- linux-2.6.orig/drivers/isdn/hysdn/hysdn_proclog.c
+++ linux-2.6/drivers/isdn/hysdn/hysdn_proclog.c
@@ -383,7 +383,7 @@ hysdn_log_poll(struct file *file, poll_t
 /**************************************************/
 /* table for log filesystem functions defined above. */
 /**************************************************/
-static struct file_operations log_fops =
+static const struct file_operations log_fops =
 {
 	.llseek         = no_llseek,
 	.read           = hysdn_log_read,
Index: linux-2.6/drivers/isdn/i4l/isdn_common.c
===================================================================
--- linux-2.6.orig/drivers/isdn/i4l/isdn_common.c
+++ linux-2.6/drivers/isdn/i4l/isdn_common.c
@@ -1822,7 +1822,7 @@ isdn_close(struct inode *ino, struct fil
 	return 0;
 }
 
-static struct file_operations isdn_fops =
+static const struct file_operations isdn_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,


