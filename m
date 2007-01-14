Return-Path: <linux-kernel-owner+w=401wt.eu-S1750955AbXANBBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXANBBx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbXANBBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:01:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52772 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbXANBBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:01:49 -0500
Subject: [patch 06/12] mark struct file_operations const 6
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:55:23 -0800
Message-Id: <1168736128.3123.329.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 06/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/drivers/sbus/char/bpp.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/bpp.c
+++ linux-2.6/drivers/sbus/char/bpp.c
@@ -846,7 +846,7 @@ static int bpp_ioctl(struct inode *inode
       return errno;
 }
 
-static struct file_operations bpp_fops = {
+static const struct file_operations bpp_fops = {
 	.owner =	THIS_MODULE,
 	.read =		bpp_read,
 	.write =	bpp_write,
Index: linux-2.6/drivers/sbus/char/cpwatchdog.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/cpwatchdog.c
+++ linux-2.6/drivers/sbus/char/cpwatchdog.c
@@ -459,7 +459,7 @@ static irqreturn_t wd_interrupt(int irq,
 	return IRQ_HANDLED;
 }
 
-static struct file_operations wd_fops = {
+static const struct file_operations wd_fops = {
 	.owner =	THIS_MODULE,
 	.ioctl =	wd_ioctl,
 	.compat_ioctl =	wd_compat_ioctl,
Index: linux-2.6/drivers/sbus/char/display7seg.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/display7seg.c
+++ linux-2.6/drivers/sbus/char/display7seg.c
@@ -166,7 +166,7 @@ static long d7s_ioctl(struct file *file,
 	return error;
 }
 
-static struct file_operations d7s_fops = {
+static const struct file_operations d7s_fops = {
 	.owner =		THIS_MODULE,
 	.unlocked_ioctl =	d7s_ioctl,
 	.compat_ioctl =		d7s_ioctl,
Index: linux-2.6/drivers/sbus/char/envctrl.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/envctrl.c
+++ linux-2.6/drivers/sbus/char/envctrl.c
@@ -705,7 +705,7 @@ envctrl_release(struct inode *inode, str
 	return 0;
 }
 
-static struct file_operations envctrl_fops = {
+static const struct file_operations envctrl_fops = {
 	.owner =		THIS_MODULE,
 	.read =			envctrl_read,
 	.unlocked_ioctl =	envctrl_ioctl,
Index: linux-2.6/drivers/sbus/char/flash.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/flash.c
+++ linux-2.6/drivers/sbus/char/flash.c
@@ -142,7 +142,7 @@ flash_release(struct inode *inode, struc
 	return 0;
 }
 
-static struct file_operations flash_fops = {
+static const struct file_operations flash_fops = {
 	/* no write to the Flash, use mmap
 	 * and play flash dependent tricks.
 	 */
Index: linux-2.6/drivers/sbus/char/jsflash.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/jsflash.c
+++ linux-2.6/drivers/sbus/char/jsflash.c
@@ -431,7 +431,7 @@ static int jsf_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations jsf_fops = {
+static const struct file_operations jsf_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	jsf_lseek,
 	.read =		jsf_read,
Index: linux-2.6/drivers/sbus/char/openprom.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/openprom.c
+++ linux-2.6/drivers/sbus/char/openprom.c
@@ -704,7 +704,7 @@ static int openprom_release(struct inode
 	return 0;
 }
 
-static struct file_operations openprom_fops = {
+static const struct file_operations openprom_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.ioctl =	openprom_ioctl,
Index: linux-2.6/drivers/sbus/char/riowatchdog.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/riowatchdog.c
+++ linux-2.6/drivers/sbus/char/riowatchdog.c
@@ -193,7 +193,7 @@ static ssize_t riowd_write(struct file *
 	return 0;
 }
 
-static struct file_operations riowd_fops = {
+static const struct file_operations riowd_fops = {
 	.owner =	THIS_MODULE,
 	.ioctl =	riowd_ioctl,
 	.open =		riowd_open,
Index: linux-2.6/drivers/sbus/char/rtc.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/rtc.c
+++ linux-2.6/drivers/sbus/char/rtc.c
@@ -233,7 +233,7 @@ static int rtc_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations rtc_fops = {
+static const struct file_operations rtc_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.ioctl =	rtc_ioctl,
Index: linux-2.6/drivers/sbus/char/uctrl.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/uctrl.c
+++ linux-2.6/drivers/sbus/char/uctrl.c
@@ -224,7 +224,7 @@ static irqreturn_t uctrl_interrupt(int i
 	return IRQ_HANDLED;
 }
 
-static struct file_operations uctrl_fops = {
+static const struct file_operations uctrl_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.ioctl =	uctrl_ioctl,
Index: linux-2.6/drivers/sbus/char/vfc_dev.c
===================================================================
--- linux-2.6.orig/drivers/sbus/char/vfc_dev.c
+++ linux-2.6/drivers/sbus/char/vfc_dev.c
@@ -44,7 +44,7 @@
 #include "vfc.h"
 #include <asm/vfc_ioctls.h>
 
-static struct file_operations vfc_fops;
+static const struct file_operations vfc_fops;
 struct vfc_dev **vfc_dev_lst;
 static char vfcstr[]="vfc";
 static unsigned char saa9051_init_array[VFC_SAA9051_NR] = {
@@ -633,7 +633,7 @@ static int vfc_mmap(struct file *file, s
 }
 
 
-static struct file_operations vfc_fops = {
+static const struct file_operations vfc_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.ioctl =	vfc_ioctl,
Index: linux-2.6/drivers/scsi/3w-9xxx.c
===================================================================
--- linux-2.6.orig/drivers/scsi/3w-9xxx.c
+++ linux-2.6/drivers/scsi/3w-9xxx.c
@@ -197,7 +197,7 @@ static struct class_device_attribute *tw
 };
 
 /* File operations struct for character device */
-static struct file_operations twa_fops = {
+static const struct file_operations twa_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= twa_chrdev_ioctl,
 	.open		= twa_chrdev_open,
Index: linux-2.6/drivers/scsi/3w-xxxx.c
===================================================================
--- linux-2.6.orig/drivers/scsi/3w-xxxx.c
+++ linux-2.6/drivers/scsi/3w-xxxx.c
@@ -1049,7 +1049,7 @@ static int tw_chrdev_open(struct inode *
 } /* End tw_chrdev_open() */
 
 /* File operations struct for character device */
-static struct file_operations tw_fops = {
+static const struct file_operations tw_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= tw_chrdev_ioctl,
 	.open		= tw_chrdev_open,
Index: linux-2.6/drivers/scsi/aacraid/linit.c
===================================================================
--- linux-2.6.orig/drivers/scsi/aacraid/linit.c
+++ linux-2.6/drivers/scsi/aacraid/linit.c
@@ -768,7 +768,7 @@ static struct class_device_attribute *aa
 };
 
 
-static struct file_operations aac_cfg_fops = {
+static const struct file_operations aac_cfg_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= aac_cfg_ioctl,
 #ifdef CONFIG_COMPAT
Index: linux-2.6/drivers/scsi/ch.c
===================================================================
--- linux-2.6.orig/drivers/scsi/ch.c
+++ linux-2.6/drivers/scsi/ch.c
@@ -129,7 +129,7 @@ static struct scsi_driver ch_template =
 	},
 };
 
-static struct file_operations changer_fops =
+static const struct file_operations changer_fops =
 {
 	.owner        = THIS_MODULE,
 	.open         = ch_open,
Index: linux-2.6/drivers/scsi/dpt_i2o.c
===================================================================
--- linux-2.6.orig/drivers/scsi/dpt_i2o.c
+++ linux-2.6/drivers/scsi/dpt_i2o.c
@@ -116,7 +116,7 @@ static int sys_tbl_len = 0;
 static adpt_hba* hba_chain = NULL;
 static int hba_count = 0;
 
-static struct file_operations adpt_fops = {
+static const struct file_operations adpt_fops = {
 	.ioctl		= adpt_ioctl,
 	.open		= adpt_open,
 	.release	= adpt_close
Index: linux-2.6/drivers/scsi/gdth.c
===================================================================
--- linux-2.6.orig/drivers/scsi/gdth.c
+++ linux-2.6/drivers/scsi/gdth.c
@@ -687,7 +687,7 @@ MODULE_AUTHOR("Achim Leubner");
 MODULE_LICENSE("GPL");
 
 /* ioctl interface */
-static struct file_operations gdth_fops = {
+static const struct file_operations gdth_fops = {
     .ioctl   = gdth_ioctl,
     .open    = gdth_open,
     .release = gdth_close,
Index: linux-2.6/drivers/scsi/megaraid/megaraid_mm.c
===================================================================
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mm.c
+++ linux-2.6/drivers/scsi/megaraid/megaraid_mm.c
@@ -67,7 +67,7 @@ static struct list_head adapters_list_g;
 
 static wait_queue_head_t wait_q;
 
-static struct file_operations lsi_fops = {
+static const struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,
 	.ioctl	= mraid_mm_ioctl,
 #ifdef CONFIG_COMPAT
Index: linux-2.6/drivers/scsi/megaraid/megaraid_sas.c
===================================================================
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_sas.c
+++ linux-2.6/drivers/scsi/megaraid/megaraid_sas.c
@@ -2913,7 +2913,7 @@ megasas_mgmt_compat_ioctl(struct file *f
 /*
  * File operations structure for management interface
  */
-static struct file_operations megasas_mgmt_fops = {
+static const struct file_operations megasas_mgmt_fops = {
 	.owner = THIS_MODULE,
 	.open = megasas_mgmt_open,
 	.release = megasas_mgmt_release,
Index: linux-2.6/drivers/scsi/megaraid.c
===================================================================
--- linux-2.6.orig/drivers/scsi/megaraid.c
+++ linux-2.6/drivers/scsi/megaraid.c
@@ -92,7 +92,7 @@ static struct mega_hbas mega_hbas[MAX_CO
 /*
  * The File Operations structure for the serial/ioctl interface of the driver
  */
-static struct file_operations megadev_fops = {
+static const struct file_operations megadev_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= megadev_ioctl,
 	.open		= megadev_open,
Index: linux-2.6/drivers/scsi/osst.c
===================================================================
--- linux-2.6.orig/drivers/scsi/osst.c
+++ linux-2.6/drivers/scsi/osst.c
@@ -5522,7 +5522,7 @@ __setup("osst=", osst_setup);
 
 #endif
 
-static struct file_operations osst_fops = {
+static const struct file_operations osst_fops = {
 	.owner =        THIS_MODULE,
 	.read =         osst_read,
 	.write =        osst_write,
Index: linux-2.6/drivers/scsi/scsi_proc.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_proc.c
+++ linux-2.6/drivers/scsi/scsi_proc.c
@@ -308,7 +308,7 @@ static int proc_scsi_open(struct inode *
 	return single_open(file, proc_scsi_show, NULL);
 }
 
-static struct file_operations proc_scsi_operations = {
+static const struct file_operations proc_scsi_operations = {
 	.open		= proc_scsi_open,
 	.read		= seq_read,
 	.write		= proc_scsi_write,
Index: linux-2.6/drivers/scsi/scsi_tgt_if.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_tgt_if.c
+++ linux-2.6/drivers/scsi/scsi_tgt_if.c
@@ -280,7 +280,7 @@ static int tgt_open(struct inode *inode,
 	return 0;
 }
 
-static struct file_operations tgt_fops = {
+static const struct file_operations tgt_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tgt_open,
 	.poll		= tgt_poll,
Index: linux-2.6/drivers/scsi/st.c
===================================================================
--- linux-2.6.orig/drivers/scsi/st.c
+++ linux-2.6/drivers/scsi/st.c
@@ -3858,7 +3858,7 @@ __setup("st=", st_setup);
 
 #endif
 
-static struct file_operations st_fops =
+static const struct file_operations st_fops =
 {
 	.owner =	THIS_MODULE,
 	.read =		st_read,
Index: linux-2.6/drivers/telephony/ixj.c
===================================================================
--- linux-2.6.orig/drivers/telephony/ixj.c
+++ linux-2.6/drivers/telephony/ixj.c
@@ -6662,7 +6662,7 @@ static int ixj_fasync(int fd, struct fil
 	return fasync_helper(fd, file_p, mode, &j->async_queue);
 }
 
-static struct file_operations ixj_fops =
+static const struct file_operations ixj_fops =
 {
         .owner          = THIS_MODULE,
         .read           = ixj_enhanced_read,
Index: linux-2.6/drivers/telephony/phonedev.c
===================================================================
--- linux-2.6.orig/drivers/telephony/phonedev.c
+++ linux-2.6/drivers/telephony/phonedev.c
@@ -127,7 +127,7 @@ void phone_unregister_device(struct phon
 }
 
 
-static struct file_operations phone_fops =
+static const struct file_operations phone_fops =
 {
 	.owner		= THIS_MODULE,
 	.open		= phone_open,
Index: linux-2.6/drivers/usb/misc/adutux.c
===================================================================
--- linux-2.6.orig/drivers/usb/misc/adutux.c
+++ linux-2.6/drivers/usb/misc/adutux.c
@@ -644,7 +644,7 @@ exit:
 }
 
 /* file operations needed when we register this driver */
-static struct file_operations adu_fops = {
+static const struct file_operations adu_fops = {
 	.owner = THIS_MODULE,
 	.read  = adu_read,
 	.write = adu_write,
Index: linux-2.6/drivers/usb/misc/ftdi-elan.c
===================================================================
--- linux-2.6.orig/drivers/usb/misc/ftdi-elan.c
+++ linux-2.6/drivers/usb/misc/ftdi-elan.c
@@ -1209,7 +1209,7 @@ error_1:
 	return retval;
 }
 
-static struct file_operations ftdi_elan_fops = {
+static const struct file_operations ftdi_elan_fops = {
         .owner = THIS_MODULE,
         .llseek = no_llseek,
         .ioctl = ftdi_elan_ioctl,
Index: linux-2.6/drivers/video/mbx/mbxdebugfs.c
===================================================================
--- linux-2.6.orig/drivers/video/mbx/mbxdebugfs.c
+++ linux-2.6/drivers/video/mbx/mbxdebugfs.c
@@ -170,37 +170,37 @@ static ssize_t misc_read_file(struct fil
 }
 
 
-static struct file_operations sysconf_fops = {
+static const struct file_operations sysconf_fops = {
 	.read = sysconf_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations clock_fops = {
+static const struct file_operations clock_fops = {
 	.read = clock_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations display_fops = {
+static const struct file_operations display_fops = {
 	.read = display_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations gsctl_fops = {
+static const struct file_operations gsctl_fops = {
 	.read = gsctl_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations sdram_fops = {
+static const struct file_operations sdram_fops = {
 	.read = sdram_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations misc_fops = {
+static const struct file_operations misc_fops = {
 	.read = misc_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
Index: linux-2.6/drivers/zorro/proc.c
===================================================================
--- linux-2.6.orig/drivers/zorro/proc.c
+++ linux-2.6/drivers/zorro/proc.c
@@ -75,7 +75,7 @@ proc_bus_zorro_read(struct file *file, c
 	return nbytes;
 }
 
-static struct file_operations proc_bus_zorro_operations = {
+static const struct file_operations proc_bus_zorro_operations = {
 	.llseek		= proc_bus_zorro_lseek,
 	.read		= proc_bus_zorro_read,
 };
Index: linux-2.6/fs/debugfs/file.c
===================================================================
--- linux-2.6.orig/fs/debugfs/file.c
+++ linux-2.6/fs/debugfs/file.c
@@ -254,7 +254,7 @@ static ssize_t read_file_blob(struct fil
 			blob->size);
 }
 
-static struct file_operations fops_blob = {
+static const struct file_operations fops_blob = {
 	.read =		read_file_blob,
 	.open =		default_open,
 };
Index: linux-2.6/fs/dlm/debug_fs.c
===================================================================
--- linux-2.6.orig/fs/dlm/debug_fs.c
+++ linux-2.6/fs/dlm/debug_fs.c
@@ -287,7 +287,7 @@ static int rsb_open(struct inode *inode,
 	return 0;
 }
 
-static struct file_operations rsb_fops = {
+static const struct file_operations rsb_fops = {
 	.owner   = THIS_MODULE,
 	.open    = rsb_open,
 	.read    = seq_read,
@@ -331,7 +331,7 @@ static ssize_t waiters_read(struct file 
 	return rv;
 }
 
-static struct file_operations waiters_fops = {
+static const struct file_operations waiters_fops = {
 	.owner   = THIS_MODULE,
 	.open    = waiters_open,
 	.read    = waiters_read
Index: linux-2.6/fs/dlm/user.c
===================================================================
--- linux-2.6.orig/fs/dlm/user.c
+++ linux-2.6/fs/dlm/user.c
@@ -25,7 +25,7 @@
 
 static const char *name_prefix="dlm";
 static struct miscdevice ctl_device;
-static struct file_operations device_fops;
+static const struct file_operations device_fops;
 
 #ifdef CONFIG_COMPAT
 
@@ -750,7 +750,7 @@ static int ctl_device_close(struct inode
 	return 0;
 }
 
-static struct file_operations device_fops = {
+static const struct file_operations device_fops = {
 	.open    = device_open,
 	.release = device_close,
 	.read    = device_read,
@@ -759,7 +759,7 @@ static struct file_operations device_fop
 	.owner   = THIS_MODULE,
 };
 
-static struct file_operations ctl_device_fops = {
+static const struct file_operations ctl_device_fops = {
 	.open    = ctl_device_open,
 	.release = ctl_device_close,
 	.write   = device_write,
Index: linux-2.6/fs/gfs2/locking/dlm/plock.c
===================================================================
--- linux-2.6.orig/fs/gfs2/locking/dlm/plock.c
+++ linux-2.6/fs/gfs2/locking/dlm/plock.c
@@ -264,7 +264,7 @@ static unsigned int dev_poll(struct file
 	return 0;
 }
 
-static struct file_operations dev_fops = {
+static const struct file_operations dev_fops = {
 	.read    = dev_read,
 	.write   = dev_write,
 	.poll    = dev_poll,
Index: linux-2.6/fs/nfs/client.c
===================================================================
--- linux-2.6.orig/fs/nfs/client.c
+++ linux-2.6/fs/nfs/client.c
@@ -1173,7 +1173,7 @@ static struct seq_operations nfs_server_
 	.show	= nfs_server_list_show,
 };
 
-static struct file_operations nfs_server_list_fops = {
+static const struct file_operations nfs_server_list_fops = {
 	.open		= nfs_server_list_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -1193,7 +1193,7 @@ static struct seq_operations nfs_volume_
 	.show	= nfs_volume_list_show,
 };
 
-static struct file_operations nfs_volume_list_fops = {
+static const struct file_operations nfs_volume_list_fops = {
 	.open		= nfs_volume_list_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/fs/ocfs2/dlm/dlmfs.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/dlm/dlmfs.c
+++ linux-2.6/fs/ocfs2/dlm/dlmfs.c
@@ -62,7 +62,7 @@
 #include "cluster/masklog.h"
 
 static struct super_operations dlmfs_ops;
-static struct file_operations dlmfs_file_operations;
+static const struct file_operations dlmfs_file_operations;
 static struct inode_operations dlmfs_dir_inode_operations;
 static struct inode_operations dlmfs_root_inode_operations;
 static struct inode_operations dlmfs_file_inode_operations;
@@ -540,7 +540,7 @@ static int dlmfs_fill_super(struct super
 	return 0;
 }
 
-static struct file_operations dlmfs_file_operations = {
+static const struct file_operations dlmfs_file_operations = {
 	.open		= dlmfs_file_open,
 	.release	= dlmfs_file_release,
 	.read		= dlmfs_file_read,
Index: linux-2.6/fs/proc/base.c
===================================================================
--- linux-2.6.orig/fs/proc/base.c
+++ linux-2.6/fs/proc/base.c
@@ -94,7 +94,7 @@ struct pid_entry {
 	char *name;
 	mode_t mode;
 	struct inode_operations *iop;
-	struct file_operations *fop;
+	const struct file_operations *fop;
 	union proc_op op;
 };
 
@@ -422,7 +422,7 @@ static unsigned mounts_poll(struct file 
 	return res;
 }
 
-static struct file_operations proc_mounts_operations = {
+static const struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -460,7 +460,7 @@ static int mountstats_open(struct inode 
 	return ret;
 }
 
-static struct file_operations proc_mountstats_operations = {
+static const struct file_operations proc_mountstats_operations = {
 	.open		= mountstats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -499,7 +499,7 @@ out_no_task:
 	return length;
 }
 
-static struct file_operations proc_info_file_operations = {
+static const struct file_operations proc_info_file_operations = {
 	.read		= proc_info_read,
 };
 
@@ -644,7 +644,7 @@ static loff_t mem_lseek(struct file * fi
 	return file->f_pos;
 }
 
-static struct file_operations proc_mem_operations = {
+static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
@@ -708,7 +708,7 @@ static ssize_t oom_adjust_write(struct f
 	return end - buffer;
 }
 
-static struct file_operations proc_oom_adjust_operations = {
+static const struct file_operations proc_oom_adjust_operations = {
 	.read		= oom_adjust_read,
 	.write		= oom_adjust_write,
 };
@@ -775,7 +775,7 @@ out_free_page:
 	return length;
 }
 
-static struct file_operations proc_loginuid_operations = {
+static const struct file_operations proc_loginuid_operations = {
 	.read		= proc_loginuid_read,
 	.write		= proc_loginuid_write,
 };
@@ -847,7 +847,7 @@ out_no_task:
 	return result;
 }
 
-static struct file_operations proc_seccomp_operations = {
+static const struct file_operations proc_seccomp_operations = {
 	.read		= seccomp_read,
 	.write		= seccomp_write,
 };
@@ -906,7 +906,7 @@ static ssize_t proc_fault_inject_write(s
 	return end - buffer;
 }
 
-static struct file_operations proc_fault_inject_operations = {
+static const struct file_operations proc_fault_inject_operations = {
 	.read		= proc_fault_inject_read,
 	.write		= proc_fault_inject_write,
 };
@@ -1406,7 +1406,7 @@ out_no_task:
 	return retval;
 }
 
-static struct file_operations proc_fd_operations = {
+static const struct file_operations proc_fd_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_readfd,
 };
@@ -1621,7 +1621,7 @@ out_no_task:
 	return length;
 }
 
-static struct file_operations proc_pid_attr_operations = {
+static const struct file_operations proc_pid_attr_operations = {
 	.read		= proc_pid_attr_read,
 	.write		= proc_pid_attr_write,
 };
@@ -1642,7 +1642,7 @@ static int proc_attr_dir_readdir(struct 
 				   attr_dir_stuff,ARRAY_SIZE(attr_dir_stuff));
 }
 
-static struct file_operations proc_attr_dir_operations = {
+static const struct file_operations proc_attr_dir_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_attr_dir_readdir,
 };
@@ -1828,7 +1828,7 @@ static int proc_pid_io_accounting(struct
 /*
  * Thread groups
  */
-static struct file_operations proc_task_operations;
+static const struct file_operations proc_task_operations;
 static struct inode_operations proc_task_inode_operations;
 
 static struct pid_entry tgid_base_stuff[] = {
@@ -1888,7 +1888,7 @@ static int proc_tgid_base_readdir(struct
 				   tgid_base_stuff,ARRAY_SIZE(tgid_base_stuff));
 }
 
-static struct file_operations proc_tgid_base_operations = {
+static const struct file_operations proc_tgid_base_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_tgid_base_readdir,
 };
@@ -2171,7 +2171,7 @@ static struct dentry *proc_tid_base_look
 				  tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
 }
 
-static struct file_operations proc_tid_base_operations = {
+static const struct file_operations proc_tid_base_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_tid_base_readdir,
 };
@@ -2398,7 +2398,7 @@ static struct inode_operations proc_task
 	.setattr	= proc_setattr,
 };
 
-static struct file_operations proc_task_operations = {
+static const struct file_operations proc_task_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_task_readdir,
 };
Index: linux-2.6/fs/proc/generic.c
===================================================================
--- linux-2.6.orig/fs/proc/generic.c
+++ linux-2.6/fs/proc/generic.c
@@ -39,7 +39,7 @@ int proc_match(int len, const char *name
 	return !memcmp(name, de->name, len);
 }
 
-static struct file_operations proc_file_operations = {
+static const struct file_operations proc_file_operations = {
 	.llseek		= proc_file_lseek,
 	.read		= proc_file_read,
 	.write		= proc_file_write,
@@ -497,7 +497,7 @@ out:	unlock_kernel();
  * use the in-memory "struct proc_dir_entry" tree to parse
  * the /proc directory.
  */
-static struct file_operations proc_dir_operations = {
+static const struct file_operations proc_dir_operations = {
 	.read			= generic_read_dir,
 	.readdir		= proc_readdir,
 };
Index: linux-2.6/fs/proc/internal.h
===================================================================
--- linux-2.6.orig/fs/proc/internal.h
+++ linux-2.6/fs/proc/internal.h
@@ -38,13 +38,13 @@ extern int proc_tgid_stat(struct task_st
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
 
-extern struct file_operations proc_maps_operations;
-extern struct file_operations proc_numa_maps_operations;
-extern struct file_operations proc_smaps_operations;
-
-extern struct file_operations proc_maps_operations;
-extern struct file_operations proc_numa_maps_operations;
-extern struct file_operations proc_smaps_operations;
+extern const struct file_operations proc_maps_operations;
+extern const struct file_operations proc_numa_maps_operations;
+extern const struct file_operations proc_smaps_operations;
+
+extern const struct file_operations proc_maps_operations;
+extern const struct file_operations proc_numa_maps_operations;
+extern const struct file_operations proc_smaps_operations;
 
 
 void free_proc_entry(struct proc_dir_entry *de);
Index: linux-2.6/fs/proc/nommu.c
===================================================================
--- linux-2.6.orig/fs/proc/nommu.c
+++ linux-2.6/fs/proc/nommu.c
@@ -128,7 +128,7 @@ static int proc_nommu_vma_list_open(stru
 	return seq_open(file, &proc_nommu_vma_list_seqop);
 }
 
-static struct file_operations proc_nommu_vma_list_operations = {
+static const struct file_operations proc_nommu_vma_list_operations = {
 	.open    = proc_nommu_vma_list_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
Index: linux-2.6/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.orig/fs/proc/proc_misc.c
+++ linux-2.6/fs/proc/proc_misc.c
@@ -228,7 +228,7 @@ static int fragmentation_open(struct ino
 	return seq_open(file, &fragmentation_op);
 }
 
-static struct file_operations fragmentation_file_operations = {
+static const struct file_operations fragmentation_file_operations = {
 	.open		= fragmentation_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -241,7 +241,7 @@ static int zoneinfo_open(struct inode *i
 	return seq_open(file, &zoneinfo_op);
 }
 
-static struct file_operations proc_zoneinfo_file_operations = {
+static const struct file_operations proc_zoneinfo_file_operations = {
 	.open		= zoneinfo_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -266,7 +266,7 @@ static int cpuinfo_open(struct inode *in
 	return seq_open(file, &cpuinfo_op);
 }
 
-static struct file_operations proc_cpuinfo_operations = {
+static const struct file_operations proc_cpuinfo_operations = {
 	.open		= cpuinfo_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -325,7 +325,7 @@ static int devinfo_open(struct inode *in
 	return seq_open(filp, &devinfo_ops);
 }
 
-static struct file_operations proc_devinfo_operations = {
+static const struct file_operations proc_devinfo_operations = {
 	.open		= devinfo_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -337,7 +337,7 @@ static int vmstat_open(struct inode *ino
 {
 	return seq_open(file, &vmstat_op);
 }
-static struct file_operations proc_vmstat_file_operations = {
+static const struct file_operations proc_vmstat_file_operations = {
 	.open		= vmstat_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -368,7 +368,7 @@ static int partitions_open(struct inode 
 {
 	return seq_open(file, &partitions_op);
 }
-static struct file_operations proc_partitions_operations = {
+static const struct file_operations proc_partitions_operations = {
 	.open		= partitions_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -380,7 +380,7 @@ static int diskstats_open(struct inode *
 {
 	return seq_open(file, &diskstats_op);
 }
-static struct file_operations proc_diskstats_operations = {
+static const struct file_operations proc_diskstats_operations = {
 	.open		= diskstats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -394,7 +394,7 @@ static int modules_open(struct inode *in
 {
 	return seq_open(file, &modules_op);
 }
-static struct file_operations proc_modules_operations = {
+static const struct file_operations proc_modules_operations = {
 	.open		= modules_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -409,7 +409,7 @@ static int slabinfo_open(struct inode *i
 {
 	return seq_open(file, &slabinfo_op);
 }
-static struct file_operations proc_slabinfo_operations = {
+static const struct file_operations proc_slabinfo_operations = {
 	.open		= slabinfo_open,
 	.read		= seq_read,
 	.write		= slabinfo_write,
@@ -443,7 +443,7 @@ static int slabstats_release(struct inod
 	return seq_release(inode, file);
 }
 
-static struct file_operations proc_slabstats_operations = {
+static const struct file_operations proc_slabstats_operations = {
 	.open		= slabstats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -556,7 +556,7 @@ static int stat_open(struct inode *inode
 		kfree(buf);
 	return res;
 }
-static struct file_operations proc_stat_operations = {
+static const struct file_operations proc_stat_operations = {
 	.open		= stat_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -598,7 +598,7 @@ static int interrupts_open(struct inode 
 	return seq_open(filp, &int_seq_ops);
 }
 
-static struct file_operations proc_interrupts_operations = {
+static const struct file_operations proc_interrupts_operations = {
 	.open		= interrupts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -655,7 +655,7 @@ static ssize_t write_sysrq_trigger(struc
 	return count;
 }
 
-static struct file_operations proc_sysrq_trigger_operations = {
+static const struct file_operations proc_sysrq_trigger_operations = {
 	.write		= write_sysrq_trigger,
 };
 #endif
Index: linux-2.6/fs/proc/proc_tty.c
===================================================================
--- linux-2.6.orig/fs/proc/proc_tty.c
+++ linux-2.6/fs/proc/proc_tty.c
@@ -138,7 +138,7 @@ static int tty_drivers_open(struct inode
 	return seq_open(file, &tty_drivers_op);
 }
 
-static struct file_operations proc_tty_drivers_operations = {
+static const struct file_operations proc_tty_drivers_operations = {
 	.open		= tty_drivers_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/fs/proc/root.c
===================================================================
--- linux-2.6.orig/fs/proc/root.c
+++ linux-2.6/fs/proc/root.c
@@ -136,7 +136,7 @@ static int proc_root_readdir(struct file
  * <pid> directories. Thus we don't use the generic
  * directory handling functions for that..
  */
-static struct file_operations proc_root_operations = {
+static const struct file_operations proc_root_operations = {
 	.read		 = generic_read_dir,
 	.readdir	 = proc_root_readdir,
 };
Index: linux-2.6/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.orig/fs/proc/task_mmu.c
+++ linux-2.6/fs/proc/task_mmu.c
@@ -434,7 +434,7 @@ static int maps_open(struct inode *inode
 	return do_maps_open(inode, file, &proc_pid_maps_op);
 }
 
-struct file_operations proc_maps_operations = {
+const struct file_operations proc_maps_operations = {
 	.open		= maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -456,7 +456,7 @@ static int numa_maps_open(struct inode *
 	return do_maps_open(inode, file, &proc_pid_numa_maps_op);
 }
 
-struct file_operations proc_numa_maps_operations = {
+const struct file_operations proc_numa_maps_operations = {
 	.open		= numa_maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -469,7 +469,7 @@ static int smaps_open(struct inode *inod
 	return do_maps_open(inode, file, &proc_pid_smaps_op);
 }
 
-struct file_operations proc_smaps_operations = {
+const struct file_operations proc_smaps_operations = {
 	.open		= smaps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/fs/proc/task_nommu.c
===================================================================
--- linux-2.6.orig/fs/proc/task_nommu.c
+++ linux-2.6/fs/proc/task_nommu.c
@@ -220,7 +220,7 @@ static int maps_open(struct inode *inode
 	return ret;
 }
 
-struct file_operations proc_maps_operations = {
+const struct file_operations proc_maps_operations = {
 	.open		= maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,


