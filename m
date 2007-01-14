Return-Path: <linux-kernel-owner+w=401wt.eu-S1750948AbXANBBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXANBBt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbXANBBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:01:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52765 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbXANBB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:01:27 -0500
Subject: [patch 05/12] mark struct file_operations const 5
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:54:56 -0800
Message-Id: <1168736096.3123.327.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 05/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/drivers/message/i2o/i2o_config.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_config.c
+++ linux-2.6/drivers/message/i2o/i2o_config.c
@@ -1111,7 +1111,7 @@ static int cfg_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations config_fops = {
+static const struct file_operations config_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.ioctl = i2o_cfg_ioctl,
Index: linux-2.6/drivers/message/i2o/i2o_proc.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_proc.c
+++ linux-2.6/drivers/message/i2o/i2o_proc.c
@@ -1703,133 +1703,133 @@ static int i2o_seq_open_dev_name(struct 
 	return single_open(file, i2o_seq_show_dev_name, PDE(inode)->data);
 };
 
-static struct file_operations i2o_seq_fops_lct = {
+static const struct file_operations i2o_seq_fops_lct = {
 	.open = i2o_seq_open_lct,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_hrt = {
+static const struct file_operations i2o_seq_fops_hrt = {
 	.open = i2o_seq_open_hrt,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_status = {
+static const struct file_operations i2o_seq_fops_status = {
 	.open = i2o_seq_open_status,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_hw = {
+static const struct file_operations i2o_seq_fops_hw = {
 	.open = i2o_seq_open_hw,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_ddm_table = {
+static const struct file_operations i2o_seq_fops_ddm_table = {
 	.open = i2o_seq_open_ddm_table,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_driver_store = {
+static const struct file_operations i2o_seq_fops_driver_store = {
 	.open = i2o_seq_open_driver_store,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_drivers_stored = {
+static const struct file_operations i2o_seq_fops_drivers_stored = {
 	.open = i2o_seq_open_drivers_stored,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_groups = {
+static const struct file_operations i2o_seq_fops_groups = {
 	.open = i2o_seq_open_groups,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_phys_device = {
+static const struct file_operations i2o_seq_fops_phys_device = {
 	.open = i2o_seq_open_phys_device,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_claimed = {
+static const struct file_operations i2o_seq_fops_claimed = {
 	.open = i2o_seq_open_claimed,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_users = {
+static const struct file_operations i2o_seq_fops_users = {
 	.open = i2o_seq_open_users,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_priv_msgs = {
+static const struct file_operations i2o_seq_fops_priv_msgs = {
 	.open = i2o_seq_open_priv_msgs,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_authorized_users = {
+static const struct file_operations i2o_seq_fops_authorized_users = {
 	.open = i2o_seq_open_authorized_users,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_dev_name = {
+static const struct file_operations i2o_seq_fops_dev_name = {
 	.open = i2o_seq_open_dev_name,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_dev_identity = {
+static const struct file_operations i2o_seq_fops_dev_identity = {
 	.open = i2o_seq_open_dev_identity,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_ddm_identity = {
+static const struct file_operations i2o_seq_fops_ddm_identity = {
 	.open = i2o_seq_open_ddm_identity,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_uinfo = {
+static const struct file_operations i2o_seq_fops_uinfo = {
 	.open = i2o_seq_open_uinfo,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_sgl_limits = {
+static const struct file_operations i2o_seq_fops_sgl_limits = {
 	.open = i2o_seq_open_sgl_limits,
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
-static struct file_operations i2o_seq_fops_sensors = {
+static const struct file_operations i2o_seq_fops_sensors = {
 	.open = i2o_seq_open_sensors,
 	.read = seq_read,
 	.llseek = seq_lseek,
Index: linux-2.6/drivers/misc/hdpuftrs/hdpu_cpustate.c
===================================================================
--- linux-2.6.orig/drivers/misc/hdpuftrs/hdpu_cpustate.c
+++ linux-2.6/drivers/misc/hdpuftrs/hdpu_cpustate.c
@@ -169,7 +169,7 @@ static struct platform_driver hdpu_cpust
 /*
  *	The various file operations we support.
  */
-static struct file_operations cpustate_fops = {
+static const struct file_operations cpustate_fops = {
       owner:THIS_MODULE,
       open:cpustate_open,
       release:cpustate_release,
Index: linux-2.6/drivers/misc/ibmasm/ibmasmfs.c
===================================================================
--- linux-2.6.orig/drivers/misc/ibmasm/ibmasmfs.c
+++ linux-2.6/drivers/misc/ibmasm/ibmasmfs.c
@@ -156,7 +156,7 @@ static struct inode *ibmasmfs_make_inode
 static struct dentry *ibmasmfs_create_file (struct super_block *sb,
 			struct dentry *parent,
 		       	const char *name,
-			struct file_operations *fops,
+			const struct file_operations *fops,
 			void *data,
 			int mode)
 {
@@ -581,28 +581,28 @@ static ssize_t remote_settings_file_writ
 	return count;
 }
 
-static struct file_operations command_fops = {
+static const struct file_operations command_fops = {
 	.open =		command_file_open,
 	.release =	command_file_close,
 	.read =		command_file_read,
 	.write =	command_file_write,
 };
 
-static struct file_operations event_fops = {
+static const struct file_operations event_fops = {
 	.open =		event_file_open,
 	.release =	event_file_close,
 	.read =		event_file_read,
 	.write =	event_file_write,
 };
 
-static struct file_operations r_heartbeat_fops = {
+static const struct file_operations r_heartbeat_fops = {
 	.open =		r_heartbeat_file_open,
 	.release =	r_heartbeat_file_close,
 	.read =		r_heartbeat_file_read,
 	.write =	r_heartbeat_file_write,
 };
 
-static struct file_operations remote_settings_fops = {
+static const struct file_operations remote_settings_fops = {
 	.open =		remote_settings_file_open,
 	.release =	remote_settings_file_close,
 	.read =		remote_settings_file_read,
Index: linux-2.6/drivers/mtd/mtdchar.c
===================================================================
--- linux-2.6.orig/drivers/mtd/mtdchar.c
+++ linux-2.6/drivers/mtd/mtdchar.c
@@ -760,7 +760,7 @@ static int mtd_ioctl(struct inode *inode
 	return ret;
 } /* memory_ioctl */
 
-static struct file_operations mtd_fops = {
+static const struct file_operations mtd_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= mtd_lseek,
 	.read		= mtd_read,
Index: linux-2.6/drivers/net/bonding/bond_main.c
===================================================================
--- linux-2.6.orig/drivers/net/bonding/bond_main.c
+++ linux-2.6/drivers/net/bonding/bond_main.c
@@ -3122,7 +3122,7 @@ static int bond_info_open(struct inode *
 	return res;
 }
 
-static struct file_operations bond_info_fops = {
+static const struct file_operations bond_info_fops = {
 	.owner   = THIS_MODULE,
 	.open    = bond_info_open,
 	.read    = seq_read,
Index: linux-2.6/drivers/net/hamradio/bpqether.c
===================================================================
--- linux-2.6.orig/drivers/net/hamradio/bpqether.c
+++ linux-2.6/drivers/net/hamradio/bpqether.c
@@ -459,7 +459,7 @@ static int bpq_info_open(struct inode *i
 	return seq_open(file, &bpq_seqops);
 }
 
-static struct file_operations bpq_info_fops = {
+static const struct file_operations bpq_info_fops = {
 	.owner = THIS_MODULE,
 	.open = bpq_info_open,
 	.read = seq_read,
Index: linux-2.6/drivers/net/hamradio/scc.c
===================================================================
--- linux-2.6.orig/drivers/net/hamradio/scc.c
+++ linux-2.6/drivers/net/hamradio/scc.c
@@ -2083,7 +2083,7 @@ static int scc_net_seq_open(struct inode
 	return seq_open(file, &scc_net_seq_ops);
 }
 
-static struct file_operations scc_net_seq_fops = {
+static const struct file_operations scc_net_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = scc_net_seq_open,
 	.read	 = seq_read,
Index: linux-2.6/drivers/net/hamradio/yam.c
===================================================================
--- linux-2.6.orig/drivers/net/hamradio/yam.c
+++ linux-2.6/drivers/net/hamradio/yam.c
@@ -804,7 +804,7 @@ static int yam_info_open(struct inode *i
 	return seq_open(file, &yam_seqops);
 }
 
-static struct file_operations yam_info_fops = {
+static const struct file_operations yam_info_fops = {
 	.owner = THIS_MODULE,
 	.open = yam_info_open,
 	.read = seq_read,
Index: linux-2.6/drivers/net/ibmveth.c
===================================================================
--- linux-2.6.orig/drivers/net/ibmveth.c
+++ linux-2.6/drivers/net/ibmveth.c
@@ -1156,7 +1156,7 @@ static int ibmveth_proc_open(struct inod
 	return rc;
 }
 
-static struct file_operations ibmveth_proc_fops = {
+static const struct file_operations ibmveth_proc_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = ibmveth_proc_open,
 	.read    = seq_read,
Index: linux-2.6/drivers/net/irda/vlsi_ir.c
===================================================================
--- linux-2.6.orig/drivers/net/irda/vlsi_ir.c
+++ linux-2.6/drivers/net/irda/vlsi_ir.c
@@ -385,7 +385,7 @@ static int vlsi_seq_open(struct inode *i
 	return single_open(file, vlsi_seq_show, PDE(inode)->data);
 }
 
-static struct file_operations vlsi_proc_fops = {
+static const struct file_operations vlsi_proc_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = vlsi_seq_open,
 	.read    = seq_read,
Index: linux-2.6/drivers/net/ppp_generic.c
===================================================================
--- linux-2.6.orig/drivers/net/ppp_generic.c
+++ linux-2.6/drivers/net/ppp_generic.c
@@ -834,7 +834,7 @@ static int ppp_unattached_ioctl(struct p
 	return err;
 }
 
-static struct file_operations ppp_device_fops = {
+static const struct file_operations ppp_device_fops = {
 	.owner		= THIS_MODULE,
 	.read		= ppp_read,
 	.write		= ppp_write,
Index: linux-2.6/drivers/net/pppoe.c
===================================================================
--- linux-2.6.orig/drivers/net/pppoe.c
+++ linux-2.6/drivers/net/pppoe.c
@@ -1043,7 +1043,7 @@ static int pppoe_seq_open(struct inode *
 	return seq_open(file, &pppoe_seq_ops);
 }
 
-static struct file_operations pppoe_seq_fops = {
+static const struct file_operations pppoe_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= pppoe_seq_open,
 	.read		= seq_read,
Index: linux-2.6/drivers/net/tun.c
===================================================================
--- linux-2.6.orig/drivers/net/tun.c
+++ linux-2.6/drivers/net/tun.c
@@ -744,7 +744,7 @@ static int tun_chr_close(struct inode *i
 	return 0;
 }
 
-static struct file_operations tun_fops = {
+static const struct file_operations tun_fops = {
 	.owner	= THIS_MODULE,
 	.llseek = no_llseek,
 	.read  = do_sync_read,
Index: linux-2.6/drivers/net/wan/cosa.c
===================================================================
--- linux-2.6.orig/drivers/net/wan/cosa.c
+++ linux-2.6/drivers/net/wan/cosa.c
@@ -311,7 +311,7 @@ static int cosa_chardev_ioctl(struct ino
 static int cosa_fasync(struct inode *inode, struct file *file, int on);
 #endif
 
-static struct file_operations cosa_fops = {
+static const struct file_operations cosa_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= cosa_read,
Index: linux-2.6/drivers/net/wireless/airo.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/airo.c
+++ linux-2.6/drivers/net/wireless/airo.c
@@ -4430,53 +4430,53 @@ static int proc_BSSList_open( struct ino
 static int proc_config_open( struct inode *inode, struct file *file );
 static int proc_wepkey_open( struct inode *inode, struct file *file );
 
-static struct file_operations proc_statsdelta_ops = {
+static const struct file_operations proc_statsdelta_ops = {
 	.read		= proc_read,
 	.open		= proc_statsdelta_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_stats_ops = {
+static const struct file_operations proc_stats_ops = {
 	.read		= proc_read,
 	.open		= proc_stats_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_status_ops = {
+static const struct file_operations proc_status_ops = {
 	.read		= proc_read,
 	.open		= proc_status_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_SSID_ops = {
+static const struct file_operations proc_SSID_ops = {
 	.read		= proc_read,
 	.write		= proc_write,
 	.open		= proc_SSID_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_BSSList_ops = {
+static const struct file_operations proc_BSSList_ops = {
 	.read		= proc_read,
 	.write		= proc_write,
 	.open		= proc_BSSList_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_APList_ops = {
+static const struct file_operations proc_APList_ops = {
 	.read		= proc_read,
 	.write		= proc_write,
 	.open		= proc_APList_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_config_ops = {
+static const struct file_operations proc_config_ops = {
 	.read		= proc_read,
 	.write		= proc_write,
 	.open		= proc_config_open,
 	.release	= proc_close
 };
 
-static struct file_operations proc_wepkey_ops = {
+static const struct file_operations proc_wepkey_ops = {
 	.read		= proc_read,
 	.write		= proc_write,
 	.open		= proc_wepkey_open,
Index: linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
@@ -355,37 +355,37 @@ out_up:
 #undef fappend
 
 
-static struct file_operations devinfo_fops = {
+static const struct file_operations devinfo_fops = {
 	.read = devinfo_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations spromdump_fops = {
+static const struct file_operations spromdump_fops = {
 	.read = spromdump_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations drvinfo_fops = {
+static const struct file_operations drvinfo_fops = {
 	.read = drvinfo_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations tsf_fops = {
+static const struct file_operations tsf_fops = {
 	.read = tsf_read_file,
 	.write = tsf_write_file,
 	.open = open_file_generic,
 };
 
-static struct file_operations txstat_fops = {
+static const struct file_operations txstat_fops = {
 	.read = txstat_read_file,
 	.write = write_file_dummy,
 	.open = open_file_generic,
 };
 
-static struct file_operations restart_fops = {
+static const struct file_operations restart_fops = {
 	.write = restart_write_file,
 	.open = open_file_generic,
 };
Index: linux-2.6/drivers/net/wireless/strip.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/strip.c
+++ linux-2.6/drivers/net/wireless/strip.c
@@ -1160,7 +1160,7 @@ static int strip_seq_open(struct inode *
 	return seq_open(file, &strip_seq_ops);
 }
 
-static struct file_operations strip_seq_fops = {
+static const struct file_operations strip_seq_fops = {
 	.owner	 = THIS_MODULE,
 	.open    = strip_seq_open,
 	.read    = seq_read,
Index: linux-2.6/drivers/oprofile/event_buffer.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/event_buffer.c
+++ linux-2.6/drivers/oprofile/event_buffer.c
@@ -181,7 +181,7 @@ out:
 	return retval;
 }
  
-struct file_operations event_buffer_fops = {
+const struct file_operations event_buffer_fops = {
 	.open		= event_buffer_open,
 	.release	= event_buffer_release,
 	.read		= event_buffer_read,
Index: linux-2.6/drivers/oprofile/event_buffer.h
===================================================================
--- linux-2.6.orig/drivers/oprofile/event_buffer.h
+++ linux-2.6/drivers/oprofile/event_buffer.h
@@ -41,7 +41,7 @@ void wake_up_buffer_waiter(void);
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
  
-extern struct file_operations event_buffer_fops;
+extern const struct file_operations event_buffer_fops;
  
 /* mutex between sync_cpu_buffers() and the
  * file reading code.
Index: linux-2.6/drivers/oprofile/oprofile_files.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/oprofile_files.c
+++ linux-2.6/drivers/oprofile/oprofile_files.c
@@ -44,7 +44,7 @@ static ssize_t depth_write(struct file *
 }
 
 
-static struct file_operations depth_fops = {
+static const struct file_operations depth_fops = {
 	.read		= depth_read,
 	.write		= depth_write
 };
@@ -56,7 +56,7 @@ static ssize_t pointer_size_read(struct 
 }
 
 
-static struct file_operations pointer_size_fops = {
+static const struct file_operations pointer_size_fops = {
 	.read		= pointer_size_read,
 };
 
@@ -67,7 +67,7 @@ static ssize_t cpu_type_read(struct file
 }
  
  
-static struct file_operations cpu_type_fops = {
+static const struct file_operations cpu_type_fops = {
 	.read		= cpu_type_read,
 };
  
@@ -101,7 +101,7 @@ static ssize_t enable_write(struct file 
 }
 
  
-static struct file_operations enable_fops = {
+static const struct file_operations enable_fops = {
 	.read		= enable_read,
 	.write		= enable_write,
 };
@@ -114,7 +114,7 @@ static ssize_t dump_write(struct file * 
 }
 
 
-static struct file_operations dump_fops = {
+static const struct file_operations dump_fops = {
 	.write		= dump_write,
 };
  
Index: linux-2.6/drivers/oprofile/oprofilefs.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/oprofilefs.c
+++ linux-2.6/drivers/oprofile/oprofilefs.c
@@ -115,14 +115,14 @@ static int default_open(struct inode * i
 }
 
 
-static struct file_operations ulong_fops = {
+static const struct file_operations ulong_fops = {
 	.read		= ulong_read_file,
 	.write		= ulong_write_file,
 	.open		= default_open,
 };
 
 
-static struct file_operations ulong_ro_fops = {
+static const struct file_operations ulong_ro_fops = {
 	.read		= ulong_read_file,
 	.open		= default_open,
 };
@@ -182,7 +182,7 @@ static ssize_t atomic_read_file(struct f
 }
  
 
-static struct file_operations atomic_ro_fops = {
+static const struct file_operations atomic_ro_fops = {
 	.read		= atomic_read_file,
 	.open		= default_open,
 };
Index: linux-2.6/drivers/parisc/ccio-dma.c
===================================================================
--- linux-2.6.orig/drivers/parisc/ccio-dma.c
+++ linux-2.6/drivers/parisc/ccio-dma.c
@@ -1091,7 +1091,7 @@ static int ccio_proc_info_open(struct in
 	return single_open(file, &ccio_proc_info, NULL);
 }
 
-static struct file_operations ccio_proc_info_fops = {
+static const struct file_operations ccio_proc_info_fops = {
 	.owner = THIS_MODULE,
 	.open = ccio_proc_info_open,
 	.read = seq_read,
@@ -1127,7 +1127,7 @@ static int ccio_proc_bitmap_open(struct 
 	return single_open(file, &ccio_proc_bitmap_info, NULL);
 }
 
-static struct file_operations ccio_proc_bitmap_fops = {
+static const struct file_operations ccio_proc_bitmap_fops = {
 	.owner = THIS_MODULE,
 	.open = ccio_proc_bitmap_open,
 	.read = seq_read,
Index: linux-2.6/drivers/parisc/eisa_eeprom.c
===================================================================
--- linux-2.6.orig/drivers/parisc/eisa_eeprom.c
+++ linux-2.6/drivers/parisc/eisa_eeprom.c
@@ -97,7 +97,7 @@ static int eisa_eeprom_release(struct in
 /*
  *	The various file operations we support.
  */
-static struct file_operations eisa_eeprom_fops = {
+static const struct file_operations eisa_eeprom_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	eisa_eeprom_llseek,
 	.read =		eisa_eeprom_read,
Index: linux-2.6/drivers/parisc/sba_iommu.c
===================================================================
--- linux-2.6.orig/drivers/parisc/sba_iommu.c
+++ linux-2.6/drivers/parisc/sba_iommu.c
@@ -1799,7 +1799,7 @@ sba_proc_open(struct inode *i, struct fi
 	return single_open(f, &sba_proc_info, NULL);
 }
 
-static struct file_operations sba_proc_fops = {
+static const struct file_operations sba_proc_fops = {
 	.owner = THIS_MODULE,
 	.open = sba_proc_open,
 	.read = seq_read,
@@ -1831,7 +1831,7 @@ sba_proc_bitmap_open(struct inode *i, st
 	return single_open(f, &sba_proc_bitmap_info, NULL);
 }
 
-static struct file_operations sba_proc_bitmap_fops = {
+static const struct file_operations sba_proc_bitmap_fops = {
 	.owner = THIS_MODULE,
 	.open = sba_proc_bitmap_open,
 	.read = seq_read,
Index: linux-2.6/drivers/pci/hotplug/cpqphp_sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/cpqphp_sysfs.c
+++ linux-2.6/drivers/pci/hotplug/cpqphp_sysfs.c
@@ -202,7 +202,7 @@ static int release(struct inode *inode, 
 	return 0;
 }
 
-static struct file_operations debug_ops = {
+static const struct file_operations debug_ops = {
 	.owner = THIS_MODULE,
 	.open = open,
 	.llseek = lseek,
Index: linux-2.6/drivers/pci/proc.c
===================================================================
--- linux-2.6.orig/drivers/pci/proc.c
+++ linux-2.6/drivers/pci/proc.c
@@ -287,7 +287,7 @@ static int proc_bus_pci_release(struct i
 }
 #endif /* HAVE_PCI_MMAP */
 
-static struct file_operations proc_bus_pci_operations = {
+static const struct file_operations proc_bus_pci_operations = {
 	.llseek		= proc_bus_pci_lseek,
 	.read		= proc_bus_pci_read,
 	.write		= proc_bus_pci_write,
@@ -456,7 +456,7 @@ static int proc_bus_pci_dev_open(struct 
 {
 	return seq_open(file, &proc_bus_pci_devices_op);
 }
-static struct file_operations proc_bus_pci_dev_operations = {
+static const struct file_operations proc_bus_pci_dev_operations = {
 	.open		= proc_bus_pci_dev_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/pcmcia/pcmcia_ioctl.c
===================================================================
--- linux-2.6.orig/drivers/pcmcia/pcmcia_ioctl.c
+++ linux-2.6/drivers/pcmcia/pcmcia_ioctl.c
@@ -766,7 +766,7 @@ free_out:
 
 /*====================================================================*/
 
-static struct file_operations ds_fops = {
+static const struct file_operations ds_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ds_open,
 	.release	= ds_release,
Index: linux-2.6/drivers/pnp/isapnp/proc.c
===================================================================
--- linux-2.6.orig/drivers/pnp/isapnp/proc.c
+++ linux-2.6/drivers/pnp/isapnp/proc.c
@@ -85,7 +85,7 @@ static ssize_t isapnp_proc_bus_read(stru
 	return nbytes;
 }
 
-static struct file_operations isapnp_proc_bus_file_operations =
+static const struct file_operations isapnp_proc_bus_file_operations =
 {
 	.llseek		= isapnp_proc_bus_lseek,
 	.read		= isapnp_proc_bus_read,
Index: linux-2.6/drivers/rtc/rtc-dev.c
===================================================================
--- linux-2.6.orig/drivers/rtc/rtc-dev.c
+++ linux-2.6/drivers/rtc/rtc-dev.c
@@ -384,7 +384,7 @@ static int rtc_dev_fasync(int fd, struct
 	return fasync_helper(fd, file, on, &rtc->async_queue);
 }
 
-static struct file_operations rtc_dev_fops = {
+static const struct file_operations rtc_dev_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= rtc_dev_read,
Index: linux-2.6/drivers/rtc/rtc-proc.c
===================================================================
--- linux-2.6.orig/drivers/rtc/rtc-proc.c
+++ linux-2.6/drivers/rtc/rtc-proc.c
@@ -96,7 +96,7 @@ static int rtc_proc_release(struct inode
 	return res;
 }
 
-static struct file_operations rtc_proc_fops = {
+static const struct file_operations rtc_proc_fops = {
 	.open		= rtc_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/s390/block/dasd_eer.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_eer.c
+++ linux-2.6/drivers/s390/block/dasd_eer.c
@@ -650,7 +650,7 @@ static unsigned int dasd_eer_poll(struct
 	return mask;
 }
 
-static struct file_operations dasd_eer_fops = {
+static const struct file_operations dasd_eer_fops = {
 	.open		= &dasd_eer_open,
 	.release	= &dasd_eer_close,
 	.read		= &dasd_eer_read,
Index: linux-2.6/drivers/s390/block/dasd_proc.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_proc.c
+++ linux-2.6/drivers/s390/block/dasd_proc.c
@@ -147,7 +147,7 @@ static int dasd_devices_open(struct inod
 	return seq_open(file, &dasd_devices_seq_ops);
 }
 
-static struct file_operations dasd_devices_file_ops = {
+static const struct file_operations dasd_devices_file_ops = {
 	.open		= dasd_devices_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
Index: linux-2.6/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/fs3270.c
+++ linux-2.6/drivers/s390/char/fs3270.c
@@ -493,7 +493,7 @@ fs3270_close(struct inode *inode, struct
 	return 0;
 }
 
-static struct file_operations fs3270_fops = {
+static const struct file_operations fs3270_fops = {
 	.owner		 = THIS_MODULE,		/* owner */
 	.read		 = fs3270_read,		/* read */
 	.write		 = fs3270_write,	/* write */
Index: linux-2.6/drivers/s390/char/monreader.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/monreader.c
+++ linux-2.6/drivers/s390/char/monreader.c
@@ -576,7 +576,7 @@ mon_poll(struct file *filp, struct poll_
 	return 0;
 }
 
-static struct file_operations mon_fops = {
+static const struct file_operations mon_fops = {
 	.owner   = THIS_MODULE,
 	.open    = &mon_open,
 	.release = &mon_close,
Index: linux-2.6/drivers/s390/char/monwriter.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/monwriter.c
+++ linux-2.6/drivers/s390/char/monwriter.c
@@ -255,7 +255,7 @@ out_error:
 	return rc;
 }
 
-static struct file_operations monwrite_fops = {
+static const struct file_operations monwrite_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = &monwrite_open,
 	.release = &monwrite_close,
Index: linux-2.6/drivers/s390/char/tape_char.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_char.c
+++ linux-2.6/drivers/s390/char/tape_char.c
@@ -39,7 +39,7 @@ static int tapechar_ioctl(struct inode *
 static long tapechar_compat_ioctl(struct file *, unsigned int,
 			  unsigned long);
 
-static struct file_operations tape_fops =
+static const struct file_operations tape_fops =
 {
 	.owner = THIS_MODULE,
 	.read = tapechar_read,
Index: linux-2.6/drivers/s390/char/tape_proc.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_proc.c
+++ linux-2.6/drivers/s390/char/tape_proc.c
@@ -109,7 +109,7 @@ static int tape_proc_open(struct inode *
 	return seq_open(file, &tape_proc_seq);
 }
 
-static struct file_operations tape_proc_ops =
+static const struct file_operations tape_proc_ops =
 {
 	.open		= tape_proc_open,
 	.read		= seq_read,
Index: linux-2.6/drivers/s390/char/vmcp.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/vmcp.c
+++ linux-2.6/drivers/s390/char/vmcp.c
@@ -173,7 +173,7 @@ static long vmcp_ioctl(struct file *file
 	}
 }
 
-static struct file_operations vmcp_fops = {
+static const struct file_operations vmcp_fops = {
 	.owner		= THIS_MODULE,
 	.open		= &vmcp_open,
 	.release	= &vmcp_release,
Index: linux-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ linux-2.6/drivers/s390/char/vmlogrdr.c
@@ -89,7 +89,7 @@ static int vmlogrdr_release(struct inode
 static ssize_t vmlogrdr_read (struct file *filp, char __user *data,
 			      size_t count, loff_t * ppos);
 
-static struct file_operations vmlogrdr_fops = {
+static const struct file_operations vmlogrdr_fops = {
 	.owner   = THIS_MODULE,
 	.open    = vmlogrdr_open,
 	.release = vmlogrdr_release,
Index: linux-2.6/drivers/s390/char/vmwatchdog.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/vmwatchdog.c
+++ linux-2.6/drivers/s390/char/vmwatchdog.c
@@ -228,7 +228,7 @@ static ssize_t vmwdt_write(struct file *
 	return count;
 }
 
-static struct file_operations vmwdt_fops = {
+static const struct file_operations vmwdt_fops = {
 	.open    = &vmwdt_open,
 	.release = &vmwdt_close,
 	.ioctl   = &vmwdt_ioctl,
Index: linux-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/blacklist.c
+++ linux-2.6/drivers/s390/cio/blacklist.c
@@ -364,7 +364,7 @@ cio_ignore_proc_open(struct inode *inode
 	return seq_open(file, &cio_ignore_proc_seq_ops);
 }
 
-static struct file_operations cio_ignore_proc_fops = {
+static const struct file_operations cio_ignore_proc_fops = {
 	.open    = cio_ignore_proc_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
Index: linux-2.6/drivers/s390/crypto/zcrypt_api.c
===================================================================
--- linux-2.6.orig/drivers/s390/crypto/zcrypt_api.c
+++ linux-2.6/drivers/s390/crypto/zcrypt_api.c
@@ -807,7 +807,7 @@ long zcrypt_compat_ioctl(struct file *fi
 /**
  * Misc device file operations.
  */
-static struct file_operations zcrypt_fops = {
+static const struct file_operations zcrypt_fops = {
 	.owner		= THIS_MODULE,
 	.read		= zcrypt_read,
 	.write		= zcrypt_write,
Index: linux-2.6/drivers/s390/net/qeth_proc.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_proc.c
+++ linux-2.6/drivers/s390/net/qeth_proc.c
@@ -161,7 +161,7 @@ qeth_procfile_open(struct inode *inode, 
 	return seq_open(file, &qeth_procfile_seq_ops);
 }
 
-static struct file_operations qeth_procfile_fops = {
+static const struct file_operations qeth_procfile_fops = {
 	.owner   = THIS_MODULE,
 	.open    = qeth_procfile_open,
 	.read    = seq_read,
@@ -273,7 +273,7 @@ qeth_perf_procfile_open(struct inode *in
 	return seq_open(file, &qeth_perf_procfile_seq_ops);
 }
 
-static struct file_operations qeth_perf_procfile_fops = {
+static const struct file_operations qeth_perf_procfile_fops = {
 	.owner   = THIS_MODULE,
 	.open    = qeth_perf_procfile_open,
 	.read    = seq_read,
Index: linux-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- linux-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ linux-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -61,7 +61,7 @@ static long zfcp_cfdc_dev_ioctl(struct f
 	_IOWR(ZFCP_CFDC_IOC_MAGIC, 0, struct zfcp_cfdc_sense_data)
 
 
-static struct file_operations zfcp_cfdc_fops = {
+static const struct file_operations zfcp_cfdc_fops = {
 	.unlocked_ioctl = zfcp_cfdc_dev_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = zfcp_cfdc_dev_ioctl


