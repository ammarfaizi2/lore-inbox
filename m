Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVLLXsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVLLXsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVLLXq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46243 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932253AbVLLXqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:33 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjmMR009053@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 14/19] MUTEX: First set of include changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the first half of the include files to use the new
mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-include-1-2615rc5.diff
 include/linux/agpgart.h             |    2 +-
 include/linux/audit.h               |    2 +-
 include/linux/backlight.h           |    2 +-
 include/linux/cpu.h                 |    2 +-
 include/linux/cpufreq.h             |    2 +-
 include/linux/devfs_fs_kernel.h     |    2 +-
 include/linux/device.h              |    6 +++---
 include/linux/ext3_fs_i.h           |    2 +-
 include/linux/fs.h                  |   17 +++++++++--------
 include/linux/gameport.h            |    2 +-
 include/linux/generic_serial.h      |    2 +-
 include/linux/hil_mlc.h             |    8 ++++----
 include/linux/hp_sdc.h              |    2 +-
 include/linux/i2c.h                 |    6 +++---
 include/linux/i2o.h                 |    8 ++++----
 include/linux/ide.h                 |   10 +++++-----
 include/linux/if_pppox.h            |    2 +-
 include/linux/input.h               |    2 +-
 include/linux/isdn.h                |    4 ++--
 include/linux/jbd.h                 |    6 +++---
 include/linux/jffs2_fs_i.h          |    4 ++--
 include/linux/jffs2_fs_sb.h         |    6 +++---
 include/linux/kernelcapi.h          |    2 +-
 include/linux/kobj_map.h            |    4 ++--
 include/linux/kthread.h             |    5 +++--
 include/linux/lcd.h                 |    2 +-
 include/linux/libps2.h              |    2 +-
 include/linux/lockd/lockd.h         |    4 ++--
 include/linux/loop.h                |    6 +++---
 include/linux/lp.h                  |    4 ++--
 include/linux/memory.h              |    5 ++---
 include/linux/msdos_fs.h            |    2 +-
 include/linux/mtd/blktrans.h        |    4 ++--
 include/linux/mtd/doc2000.h         |    4 ++--
 include/linux/nbd.h                 |    2 +-
 include/linux/ncp_fs_i.h            |    2 +-
 include/linux/ncp_fs_sb.h           |    4 ++--
 include/linux/netfilter/nfnetlink.h |    2 +-
 include/linux/parport.h             |    4 ++--
 include/linux/quota.h               |    7 ++++---
 include/linux/raid/md.h             |    2 +-
 include/linux/raid/md_k.h           |    2 +-
 include/linux/reiserfs_fs_sb.h      |    6 +++---
 include/linux/rtnetlink.h           |    2 +-
 44 files changed, 89 insertions(+), 87 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/agpgart.h linux-2.6.15-rc5-mutex/include/linux/agpgart.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/agpgart.h	2005-03-02 12:08:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/agpgart.h	2005-12-12 19:30:17.000000000 +0000
@@ -201,7 +201,7 @@ struct agp_file_private {
 };
 
 struct agp_front_data {
-	struct semaphore agp_mutex;
+	struct mutex agp_mutex;
 	struct agp_controller *current_controller;
 	struct agp_controller *controllers;
 	struct agp_file_private *file_priv_list;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/audit.h linux-2.6.15-rc5-mutex/include/linux/audit.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/audit.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/audit.h	2005-12-12 19:39:56.000000000 +0000
@@ -283,7 +283,7 @@ extern void		    audit_send_reply(int pi
 					     int done, int multi,
 					     void *payload, int size);
 extern void		    audit_log_lost(const char *message);
-extern struct semaphore audit_netlink_sem;
+extern struct mutex audit_netlink_sem;
 #else
 #define audit_log(c,g,t,f,...) do { ; } while (0)
 #define audit_log_start(c,g,t) ({ NULL; })
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/backlight.h linux-2.6.15-rc5-mutex/include/linux/backlight.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/backlight.h	2005-03-02 12:08:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/backlight.h	2005-12-12 19:44:11.000000000 +0000
@@ -39,7 +39,7 @@ struct backlight_device {
 	/* This protects the 'props' field. If 'props' is NULL, the driver that
 	   registered this device has been unloaded, and if class_get_devdata()
 	   points to something in the body of that driver, it is also invalid. */
-	struct semaphore sem;
+	struct mutex sem;
 	/* If this is NULL, the backing module is unloaded */
 	struct backlight_properties *props;
 	/* The framebuffer notifier block */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/cpufreq.h linux-2.6.15-rc5-mutex/include/linux/cpufreq.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/cpufreq.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/cpufreq.h	2005-12-12 19:30:49.000000000 +0000
@@ -82,7 +82,7 @@ struct cpufreq_policy {
         unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 
- 	struct semaphore	lock;   /* CPU ->setpolicy or ->target may
+ 	struct mutex		lock;   /* CPU ->setpolicy or ->target may
 					   only be called once a time */
 
 	struct work_struct	update; /* if update_policy() needs to be
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/cpu.h linux-2.6.15-rc5-mutex/include/linux/cpu.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/cpu.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/cpu.h	2005-12-12 22:12:49.000000000 +0000
@@ -23,7 +23,7 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct cpu {
 	int node_id;		/* The node which contains the CPU */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/devfs_fs_kernel.h linux-2.6.15-rc5-mutex/include/linux/devfs_fs_kernel.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/devfs_fs_kernel.h	2004-06-18 13:42:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/devfs_fs_kernel.h	2005-12-12 22:12:49.000000000 +0000
@@ -6,7 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define DEVFS_SUPER_MAGIC                0x1373
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/device.h linux-2.6.15-rc5-mutex/include/linux/device.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/device.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/device.h	2005-12-12 22:12:49.000000000 +0000
@@ -19,7 +19,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/atomic.h>
 
 #define DEVICE_NAME_SIZE	50
@@ -146,7 +146,7 @@ struct class {
 	struct subsystem	subsys;
 	struct list_head	children;
 	struct list_head	interfaces;
-	struct semaphore	sem;	/* locks both the children and interfaces lists */
+	struct mutex		sem;	/* locks both the children and interfaces lists */
 
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
@@ -310,7 +310,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_attribute uevent_attr;
 
-	struct semaphore	sem;	/* semaphore to synchronize calls to
+	struct mutex	sem;		/* semaphore to synchronize calls to
 					 * its driver.
 					 */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/ext3_fs_i.h linux-2.6.15-rc5-mutex/include/linux/ext3_fs_i.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/ext3_fs_i.h	2005-06-22 13:52:32.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/ext3_fs_i.h	2005-12-12 17:34:02.000000000 +0000
@@ -131,7 +131,7 @@ struct ext3_inode_info {
 	 * during recovery.  Hence we must fix the get_block-vs-truncate race
 	 * by other means, so we have truncate_sem.
 	 */
-	struct semaphore truncate_sem;
+	struct mutex truncate_sem;
 	struct inode vfs_inode;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/fs.h linux-2.6.15-rc5-mutex/include/linux/fs.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/fs.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/fs.h	2005-12-12 22:12:49.000000000 +0000
@@ -10,6 +10,7 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/rcuref.h>
+#include <linux/semaphore.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -220,9 +221,9 @@ extern int dir_notify_enable;
 #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/semaphore.h>
 
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
 struct iovec;
@@ -368,8 +369,8 @@ struct block_device {
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
-	struct semaphore	bd_sem;	/* open/close mutex */
-	struct semaphore	bd_mount_sem;	/* mount mutex */
+	struct mutex		bd_sem;	/* open/close mutex */
+	struct mutex		bd_mount_sem;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
@@ -453,7 +454,7 @@ struct inode {
 	unsigned long		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
-	struct semaphore	i_sem;
+	struct mutex		i_sem;
 	struct rw_semaphore	i_alloc_sem;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
@@ -480,7 +481,7 @@ struct inode {
 
 #ifdef CONFIG_INOTIFY
 	struct list_head	inotify_watches; /* watches on this inode */
-	struct semaphore	inotify_sem;	/* protects the watches list */
+	struct mutex		inotify_sem;	/* protects the watches list */
 #endif
 
 	unsigned long		i_state;
@@ -790,7 +791,7 @@ struct super_block {
 	unsigned long		s_magic;
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
-	struct semaphore	s_lock;
+	struct mutex		s_lock;
 	int			s_count;
 	int			s_syncing;
 	int			s_need_sync_fs;
@@ -819,7 +820,7 @@ struct super_block {
 	 * The next field is for VFS *only*. No filesystems have any business
 	 * even looking at it. You had been warned.
 	 */
-	struct semaphore s_vfs_rename_sem;	/* Kludge */
+	struct mutex s_vfs_rename_sem;	/* Kludge */
 
 	/* Granuality of c/m/atime in ns.
 	   Cannot be worse than a second */
@@ -1496,7 +1497,7 @@ extern void destroy_inode(struct inode *
 extern struct inode *new_inode(struct super_block *);
 extern int remove_suid(struct dentry *);
 extern void remove_dquot_ref(struct super_block *, int, struct list_head *);
-extern struct semaphore iprune_sem;
+extern struct mutex iprune_sem;
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 extern void remove_inode_hash(struct inode *);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/gameport.h linux-2.6.15-rc5-mutex/include/linux/gameport.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/gameport.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/gameport.h	2005-12-12 19:31:08.000000000 +0000
@@ -40,7 +40,7 @@ struct gameport {
 	struct gameport *parent, *child;
 
 	struct gameport_driver *drv;
-	struct semaphore drv_sem;	/* protects serio->drv so attributes can pin driver */
+	struct mutex drv_sem;		/* protects serio->drv so attributes can pin driver */
 
 	struct device dev;
 	unsigned int registered;	/* port has been fully registered with driver core */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/generic_serial.h linux-2.6.15-rc5-mutex/include/linux/generic_serial.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/generic_serial.h	2005-06-22 13:52:32.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/generic_serial.h	2005-12-12 19:31:20.000000000 +0000
@@ -34,7 +34,7 @@ struct gs_port {
   int                     xmit_head;
   int                     xmit_tail;
   int                     xmit_cnt;
-  struct semaphore        port_write_sem;
+  struct mutex            port_write_sem;
   int                     flags;
   wait_queue_head_t       open_wait;
   wait_queue_head_t       close_wait;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/hil_mlc.h linux-2.6.15-rc5-mutex/include/linux/hil_mlc.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/hil_mlc.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/hil_mlc.h	2005-12-12 22:12:49.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/hil.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/serio.h>
 #include <linux/list.h>
 
@@ -133,14 +133,14 @@ struct hil_mlc {
 	int			istarted, ostarted;
 
 	hil_mlc_cts		*cts;
-	struct semaphore	csem;   /* Raised when loop idle */
+	struct mutex		csem;   /* Raised when loop idle */
 
 	hil_mlc_out		*out;
-	struct semaphore	osem;   /* Raised when outpacket dispatched */
+	struct mutex		osem;   /* Raised when outpacket dispatched */
 	hil_packet		opacket;
 
 	hil_mlc_in		*in;
-	struct semaphore	isem;   /* Raised when a packet arrives */
+	struct mutex		isem;   /* Raised when a packet arrives */
 	hil_packet		ipacket[16];
 	hil_packet		imatch;
 	int			icount;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/hp_sdc.h linux-2.6.15-rc5-mutex/include/linux/hp_sdc.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/hp_sdc.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/hp_sdc.h	2005-12-12 19:43:52.000000000 +0000
@@ -68,7 +68,7 @@ typedef struct {
 	uint8_t *seq;	/* commands/data for the transaction */
 	union {
 	  hp_sdc_irqhook   *irqhook;	/* Callback, isr or tasklet context */
-	  struct semaphore *semaphore;	/* Semaphore to sleep on. */
+	  struct mutex     *semaphore;	/* Semaphore to sleep on. */
 	} act;
 } hp_sdc_transaction;
 int hp_sdc_enqueue_transaction(hp_sdc_transaction *this);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/i2c.h linux-2.6.15-rc5-mutex/include/linux/i2c.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/i2c.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/i2c.h	2005-12-12 22:12:49.000000000 +0000
@@ -32,7 +32,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* --- For i2c-isa ---------------------------------------------------- */
 
@@ -222,8 +222,8 @@ struct i2c_adapter {
 	int (*client_unregister)(struct i2c_client *);
 
 	/* data fields that are valid for all devices	*/
-	struct semaphore bus_lock;
-	struct semaphore clist_lock;
+	struct mutex bus_lock;
+	struct mutex clist_lock;
 
 	int timeout;
 	int retries;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/i2o.h linux-2.6.15-rc5-mutex/include/linux/i2o.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/i2o.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/i2o.h	2005-12-12 22:12:49.000000000 +0000
@@ -30,9 +30,9 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>	/* work_struct */
+#include <linux/semaphore.h>
 
 #include <asm/io.h>
-#include <asm/semaphore.h>	/* Needed for MUTEX init macros */
 
 /* message queue empty */
 #define I2O_QUEUE_EMPTY		0xffffffff
@@ -69,7 +69,7 @@ struct i2o_device {
 
 	struct device device;
 
-	struct semaphore lock;	/* device lock */
+	struct mutex lock;	/* device lock */
 };
 
 /*
@@ -117,7 +117,7 @@ struct i2o_driver {
 	void (*notify_device_add) (struct i2o_device *);
 	void (*notify_device_remove) (struct i2o_device *);
 
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 /*
@@ -181,7 +181,7 @@ struct i2o_controller {
 	struct i2o_dma hrt;	/* HW Resource Table */
 	i2o_lct *lct;		/* Logical Config Table */
 	struct i2o_dma dlct;	/* Temp LCT */
-	struct semaphore lct_lock;	/* Lock for LCT updates */
+	struct mutex lct_lock;	/* Lock for LCT updates */
 	struct i2o_dma status_block;	/* IOP status block */
 
 	struct i2o_io base;	/* controller messaging unit */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/ide.h linux-2.6.15-rc5-mutex/include/linux/ide.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/ide.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/ide.h	2005-12-12 22:12:49.000000000 +0000
@@ -18,10 +18,10 @@
 #include <linux/bio.h>
 #include <linux/device.h>
 #include <linux/pci.h>
+#include <linux/semaphore.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
 
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
@@ -759,7 +759,7 @@ typedef struct ide_drive_s {
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct device	gendev;
-	struct semaphore gendev_rel_sem;	/* to deal with device release() */
+	struct mutex	gendev_rel_sem;	/* to deal with device release() */
 } ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -915,7 +915,7 @@ typedef struct hwif_s {
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device	gendev;
-	struct semaphore gendev_rel_sem; /* To deal with device release() */
+	struct mutex	gendev_rel_sem; /* To deal with device release() */
 
 	void		*hwif_data;	/* extra hwif data */
 
@@ -1000,7 +1000,7 @@ typedef struct ide_settings_s {
 	struct ide_settings_s	*next;
 } ide_settings_t;
 
-extern struct semaphore ide_setting_sem;
+extern struct mutex ide_setting_sem;
 extern int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
 extern ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
 extern int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
@@ -1458,7 +1458,7 @@ extern const ide_pio_timings_t ide_pio_t
 
 
 extern spinlock_t ide_lock;
-extern struct semaphore ide_cfg_sem;
+extern struct mutex ide_cfg_sem;
 /*
  * Structure locking:
  *
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/if_pppox.h linux-2.6.15-rc5-mutex/include/linux/if_pppox.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/if_pppox.h	2005-06-22 13:52:32.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/if_pppox.h	2005-12-12 22:12:49.000000000 +0000
@@ -24,7 +24,7 @@
 #include <linux/if_ether.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/ppp_channel.h>
 #endif /* __KERNEL__ */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/input.h linux-2.6.15-rc5-mutex/include/linux/input.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/input.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/input.h	2005-12-12 17:51:08.000000000 +0000
@@ -888,7 +888,7 @@ struct input_dev {
 
 	struct input_handle *grab;
 
-	struct semaphore sem;	/* serializes open and close operations */
+	struct mutex sem;	/* serializes open and close operations */
 	unsigned int users;
 
 	struct class_device cdev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/isdn.h linux-2.6.15-rc5-mutex/include/linux/isdn.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/isdn.h	2005-11-01 13:19:20.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/isdn.h	2005-12-12 19:32:14.000000000 +0000
@@ -515,7 +515,7 @@ typedef struct modem_info {
   struct termios	normal_termios;  /* For saving termios structs     */
   struct termios	callout_termios;
   wait_queue_head_t	open_wait, close_wait;
-  struct semaphore      write_sem;
+  struct mutex		write_sem;
   spinlock_t	        readlock;
 } modem_info;
 
@@ -625,7 +625,7 @@ typedef struct isdn_devt {
 	int               v110emu[ISDN_MAX_CHANNELS]; /* V.110 emulator-mode 0=none */
 	atomic_t          v110use[ISDN_MAX_CHANNELS]; /* Usage-Semaphore for stream */
 	isdn_v110_stream  *v110[ISDN_MAX_CHANNELS];   /* V.110 private data         */
-	struct semaphore  sem;                        /* serialize list access*/
+	struct mutex      sem;                        /* serialize list access*/
 	unsigned long     global_features;
 } isdn_dev;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/jbd.h linux-2.6.15-rc5-mutex/include/linux/jbd.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/jbd.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/jbd.h	2005-12-12 22:12:49.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
 #include <linux/bit_spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #endif
 
 #define journal_oom_retry 1
@@ -644,7 +644,7 @@ struct journal_s
 	int			j_barrier_count;
 
 	/* The barrier lock itself */
-	struct semaphore	j_barrier;
+	struct mutex		j_barrier;
 
 	/*
 	 * Transactions: The current running transaction...
@@ -686,7 +686,7 @@ struct journal_s
 	wait_queue_head_t	j_wait_updates;
 
 	/* Semaphore for locking against concurrent checkpoints */
-	struct semaphore 	j_checkpoint_sem;
+	struct mutex		j_checkpoint_sem;
 
 	/*
 	 * Journal head: identifies the first unused block in the journal.
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/jffs2_fs_i.h linux-2.6.15-rc5-mutex/include/linux/jffs2_fs_i.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/jffs2_fs_i.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/jffs2_fs_i.h	2005-12-12 22:12:49.000000000 +0000
@@ -5,7 +5,7 @@
 
 #include <linux/version.h>
 #include <linux/rbtree.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct jffs2_inode_info {
 	/* We need an internal semaphore similar to inode->i_sem.
@@ -14,7 +14,7 @@ struct jffs2_inode_info {
 	   before letting GC proceed. Or we'd have to put ugliness
 	   into the GC code so it didn't attempt to obtain the i_sem
 	   for the inode(s) which are already locked */
-	struct semaphore sem;
+	struct mutex sem;
 
 	/* The highest (datanode) version number used for this ino */
 	uint32_t highest_version;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/jffs2_fs_sb.h linux-2.6.15-rc5-mutex/include/linux/jffs2_fs_sb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/jffs2_fs_sb.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/jffs2_fs_sb.h	2005-12-12 22:12:49.000000000 +0000
@@ -7,7 +7,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/list.h>
@@ -35,7 +35,7 @@ struct jffs2_sb_info {
 	struct completion gc_thread_start; /* GC thread start completion */
 	struct completion gc_thread_exit; /* GC thread exit completion port */
 
-	struct semaphore alloc_sem;	/* Used to protect all the following
+	struct mutex alloc_sem;	/* Used to protect all the following
 					   fields, and also to protect against
 					   out-of-order writing of nodes. And GC. */
 	uint32_t cleanmarker_size;	/* Size of an _inline_ CLEANMARKER
@@ -93,7 +93,7 @@ struct jffs2_sb_info {
 	/* Sem to allow jffs2_garbage_collect_deletion_dirent to
 	   drop the erase_completion_lock while it's holding a pointer
 	   to an obsoleted node. I don't like this. Alternatives welcomed. */
-	struct semaphore erase_free_sem;
+	struct mutex erase_free_sem;
 
 	uint32_t wbuf_pagesize; /* 0 for NOR and other flashes with no wbuf */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/kernelcapi.h linux-2.6.15-rc5-mutex/include/linux/kernelcapi.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/kernelcapi.h	2004-09-16 12:06:22.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/kernelcapi.h	2005-12-12 19:32:42.000000000 +0000
@@ -62,7 +62,7 @@ struct capi20_appl {
 	unsigned long nrecvdatapkt;
 	unsigned long nsentctlpkt;
 	unsigned long nsentdatapkt;
-	struct semaphore recv_sem;
+	struct mutex recv_sem;
 	struct sk_buff_head recv_queue;
 	struct work_struct recv_work;
 	int release_in_progress;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/kobj_map.h linux-2.6.15-rc5-mutex/include/linux/kobj_map.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/kobj_map.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/kobj_map.h	2005-12-12 22:12:49.000000000 +0000
@@ -1,6 +1,6 @@
 #ifdef __KERNEL__
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 typedef struct kobject *kobj_probe_t(dev_t, int *, void *);
 struct kobj_map;
@@ -9,6 +9,6 @@ int kobj_map(struct kobj_map *, dev_t, u
 	     kobj_probe_t *, int (*)(dev_t, void *), void *);
 void kobj_unmap(struct kobj_map *, dev_t, unsigned long);
 struct kobject *kobj_lookup(struct kobj_map *, dev_t, int *);
-struct kobj_map *kobj_map_init(kobj_probe_t *, struct semaphore *);
+struct kobj_map *kobj_map_init(kobj_probe_t *, struct mutex *);
 
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/kthread.h linux-2.6.15-rc5-mutex/include/linux/kthread.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/kthread.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/kthread.h	2005-12-12 22:12:49.000000000 +0000
@@ -3,6 +3,7 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <linux/semaphore.h>
 
 /**
  * kthread_create: create a kthread.
@@ -72,14 +73,14 @@ int kthread_stop(struct task_struct *k);
 /**
  * kthread_stop_sem: stop a thread created by kthread_create().
  * @k: thread created by kthread_create().
- * @s: semaphore that @k waits on while idle.
+ * @s: mutex that @k waits on while idle.
  *
  * Does essentially the same thing as kthread_stop() above, but wakes
  * @k by calling up(@s).
  *
  * Returns the result of threadfn(), or -EINTR if wake_up_process()
  * was never called. */
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s);
+int kthread_stop_sem(struct task_struct *k, struct mutex *s);
 
 /**
  * kthread_should_stop: should this kthread return now?
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/lcd.h linux-2.6.15-rc5-mutex/include/linux/lcd.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/lcd.h	2005-03-02 12:08:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/lcd.h	2005-12-12 19:32:48.000000000 +0000
@@ -38,7 +38,7 @@ struct lcd_device {
 	/* This protects the 'props' field. If 'props' is NULL, the driver that
 	   registered this device has been unloaded, and if class_get_devdata()
 	   points to something in the body of that driver, it is also invalid. */
-	struct semaphore sem;
+	struct mutex sem;
 	/* If this is NULL, the backing module is unloaded */
 	struct lcd_properties *props;
 	/* The framebuffer notifier block */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/libps2.h linux-2.6.15-rc5-mutex/include/linux/libps2.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/libps2.h	2005-08-30 13:56:36.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/libps2.h	2005-12-12 18:02:54.000000000 +0000
@@ -28,7 +28,7 @@ struct ps2dev {
 	struct serio *serio;
 
 	/* Ensures that only one command is executing at a time */
-	struct semaphore cmd_sem;
+	struct mutex cmd_sem;
 
 	/* Used to signal completion from interrupt handler */
 	wait_queue_head_t wait;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/lockd/lockd.h linux-2.6.15-rc5-mutex/include/linux/lockd/lockd.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/lockd/lockd.h	2005-08-30 13:56:36.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/lockd/lockd.h	2005-12-12 17:38:48.000000000 +0000
@@ -53,7 +53,7 @@ struct nlm_host {
 	u32			h_nsmstate;	/* true remote NSM state */
 	u32			h_pidcount;	/* Pseudopids */
 	atomic_t		h_count;	/* reference count */
-	struct semaphore	h_sema;		/* mutex for pmap binding */
+	struct mutex		h_sema;		/* mutex for pmap binding */
 	unsigned long		h_nextrebind;	/* next portmap call */
 	unsigned long		h_expires;	/* eligible for GC */
 	struct list_head	h_lockowners;	/* Lockowners for the client */
@@ -99,7 +99,7 @@ struct nlm_file {
 	struct nlm_block *	f_blocks;	/* blocked locks */
 	unsigned int		f_locks;	/* guesstimate # of locks */
 	unsigned int		f_count;	/* reference count */
-	struct semaphore	f_sema;		/* avoid concurrent access */
+	struct mutex		f_sema;		/* avoid concurrent access */
 	int		       	f_hash;		/* hash of f_handle */
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/loop.h linux-2.6.15-rc5-mutex/include/linux/loop.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/loop.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/loop.h	2005-12-12 17:45:34.000000000 +0000
@@ -58,9 +58,9 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct semaphore	lo_sem;
-	struct semaphore	lo_ctl_mutex;
-	struct semaphore	lo_bh_mutex;
+	struct mutex		lo_sem;
+	struct mutex		lo_ctl_mutex;
+	struct mutex		lo_bh_mutex;
 	int			lo_pending;
 
 	request_queue_t		*lo_queue;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/lp.h linux-2.6.15-rc5-mutex/include/linux/lp.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/lp.h	2005-03-02 12:08:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/lp.h	2005-12-12 22:12:49.000000000 +0000
@@ -99,7 +99,7 @@
 #ifdef __KERNEL__
 
 #include <linux/wait.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* Magic numbers for defining port-device mappings */
 #define LP_PARPORT_UNSPEC -4
@@ -145,7 +145,7 @@ struct lp_struct {
 #endif
 	wait_queue_head_t waitq;
 	unsigned int last_error;
-	struct semaphore port_mutex;
+	struct mutex port_mutex;
 	wait_queue_head_t dataq;
 	long timeout;
 	unsigned int best_mode;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/memory.h linux-2.6.15-rc5-mutex/include/linux/memory.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/memory.h	2005-12-08 16:23:54.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/memory.h	2005-12-12 22:12:49.000000000 +0000
@@ -18,8 +18,7 @@
 #include <linux/sysdev.h>
 #include <linux/node.h>
 #include <linux/compiler.h>
-
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct memory_block {
 	unsigned long phys_index;
@@ -30,7 +29,7 @@ struct memory_block {
 	 * created long after the critical areas during
 	 * initialization.
 	 */
-	struct semaphore state_sem;
+	struct mutex state_sem;
 	int phys_device;		/* to which fru does this belong? */
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/msdos_fs.h linux-2.6.15-rc5-mutex/include/linux/msdos_fs.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/msdos_fs.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/msdos_fs.h	2005-12-12 17:34:19.000000000 +0000
@@ -226,7 +226,7 @@ struct msdos_sb_info {
 	unsigned long max_cluster;   /* maximum cluster number */
 	unsigned long root_cluster;  /* first cluster of the root directory */
 	unsigned long fsinfo_sector; /* sector number of FAT32 fsinfo */
-	struct semaphore fat_lock;
+	struct mutex fat_lock;
 	unsigned int prev_free;      /* previously allocated cluster number */
 	unsigned int free_clusters;  /* -1 if undefined */
 	struct fat_mount_options options;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/mtd/blktrans.h linux-2.6.15-rc5-mutex/include/linux/mtd/blktrans.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/mtd/blktrans.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/mtd/blktrans.h	2005-12-12 22:12:49.000000000 +0000
@@ -10,7 +10,7 @@
 #ifndef __MTD_TRANS_H__
 #define __MTD_TRANS_H__
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct hd_geometry;
 struct mtd_info;
@@ -22,7 +22,7 @@ struct mtd_blktrans_dev {
 	struct mtd_blktrans_ops *tr;
 	struct list_head list;
 	struct mtd_info *mtd;
-	struct semaphore sem;
+	struct mutex sem;
 	int devnum;
 	int blksize;
 	unsigned long size;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/mtd/doc2000.h linux-2.6.15-rc5-mutex/include/linux/mtd/doc2000.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/mtd/doc2000.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/mtd/doc2000.h	2005-12-12 22:12:49.000000000 +0000
@@ -15,7 +15,7 @@
 #define __MTD_DOC2000_H__
 
 #include <linux/mtd/mtd.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define DoC_Sig1 0
 #define DoC_Sig2 1
@@ -187,7 +187,7 @@ struct DiskOnChip {
 	int numchips;
 	struct Nand *chips;
 	struct mtd_info *nextdoc;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 int doc_decode_ecc(unsigned char sector[512], unsigned char ecc1[6]);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/nbd.h linux-2.6.15-rc5-mutex/include/linux/nbd.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/nbd.h	2004-06-18 13:42:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/nbd.h	2005-12-12 19:33:00.000000000 +0000
@@ -49,7 +49,7 @@ struct nbd_device {
 	int magic;
 	spinlock_t queue_lock;
 	struct list_head queue_head;/* Requests are added here...	*/
-	struct semaphore tx_lock;
+	struct mutex tx_lock;
 	struct gendisk *disk;
 	int blksize;
 	u64 bytesize;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/ncp_fs_i.h linux-2.6.15-rc5-mutex/include/linux/ncp_fs_i.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/ncp_fs_i.h	2004-10-19 10:42:17.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/ncp_fs_i.h	2005-12-12 19:33:05.000000000 +0000
@@ -19,7 +19,7 @@ struct ncp_inode_info {
 	__le32	DosDirNum;
 	__u8	volNumber;
 	__le32	nwattr;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	atomic_t	opened;
 	int	access;
 	int	flags;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/ncp_fs_sb.h linux-2.6.15-rc5-mutex/include/linux/ncp_fs_sb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/ncp_fs_sb.h	2004-06-18 13:42:15.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/ncp_fs_sb.h	2005-12-12 19:33:16.000000000 +0000
@@ -51,7 +51,7 @@ struct ncp_server {
 				   receive replies */
 
 	int lock;		/* To prevent mismatch in protocols. */
-	struct semaphore sem;
+	struct mutex sem;
 
 	int current_size;	/* for packet preparation */
 	int has_subfunction;
@@ -96,7 +96,7 @@ struct ncp_server {
 	struct {
 		struct work_struct tq;		/* STREAM/DGRAM: data/error ready */
 		struct ncp_request_reply* creq;	/* STREAM/DGRAM: awaiting reply from this request */
-		struct semaphore creq_sem;	/* DGRAM only: lock accesses to rcv.creq */
+		struct mutex creq_sem;		/* DGRAM only: lock accesses to rcv.creq */
 
 		unsigned int state;		/* STREAM only: receiver state */
 		struct {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/netfilter/nfnetlink.h linux-2.6.15-rc5-mutex/include/linux/netfilter/nfnetlink.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/netfilter/nfnetlink.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/netfilter/nfnetlink.h	2005-12-12 19:41:44.000000000 +0000
@@ -129,7 +129,7 @@ extern void __nfa_fill(struct sk_buff *s
 ({ if (skb_tailroom(skb) < (int)NFA_SPACE(attrlen)) goto nfattr_failure; \
    __nfa_fill(skb, attrtype, attrlen, data); })
 
-extern struct semaphore nfnl_sem;
+extern struct mutex nfnl_sem;
 
 #define nfnl_shlock()		down(&nfnl_sem)
 #define nfnl_shlock_nowait()	down_trylock(&nfnl_sem)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/parport.h linux-2.6.15-rc5-mutex/include/linux/parport.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/parport.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/parport.h	2005-12-12 22:12:49.000000000 +0000
@@ -101,9 +101,9 @@ typedef enum {
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/semaphore.h>
 #include <asm/system.h>
 #include <asm/ptrace.h>
-#include <asm/semaphore.h>
 
 /* Define this later. */
 struct parport;
@@ -254,7 +254,7 @@ enum ieee1284_phase {
 struct ieee1284_info {
 	int mode;
 	volatile enum ieee1284_phase phase;
-	struct semaphore irq;
+	struct mutex irq;
 };
 
 /* A parallel port */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/quota.h linux-2.6.15-rc5-mutex/include/linux/quota.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/quota.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/quota.h	2005-12-12 22:12:49.000000000 +0000
@@ -38,6 +38,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/semaphore.h>
 
 #define __DQUOT_VERSION__	"dquot_6.5.1"
 #define __DQUOT_NUM_VERSION__	6*10000+5*100+1
@@ -215,7 +216,7 @@ struct dquot {
 	struct list_head dq_inuse;	/* List of all quotas */
 	struct list_head dq_free;	/* Free list element */
 	struct list_head dq_dirty;	/* List of dirty dquots */
-	struct semaphore dq_lock;	/* dquot IO lock */
+	struct mutex dq_lock;		/* dquot IO lock */
 	atomic_t dq_count;		/* Use count */
 	wait_queue_head_t dq_wait_unused;	/* Wait queue for dquot to become unused */
 	struct super_block *dq_sb;	/* superblock this applies to */
@@ -285,8 +286,8 @@ struct quota_format_type {
 
 struct quota_info {
 	unsigned int flags;			/* Flags for diskquotas on this device */
-	struct semaphore dqio_sem;		/* lock device while I/O in progress */
-	struct semaphore dqonoff_sem;		/* Serialize quotaon & quotaoff */
+	struct mutex dqio_sem;			/* lock device while I/O in progress */
+	struct mutex dqonoff_sem;		/* Serialize quotaon & quotaoff */
 	struct rw_semaphore dqptr_sem;		/* serialize ops using quota_info struct, pointers from inode to dquots */
 	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/raid/md.h linux-2.6.15-rc5-mutex/include/linux/raid/md.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/raid/md.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/raid/md.h	2005-12-12 22:12:49.000000000 +0000
@@ -19,7 +19,7 @@
 #define _MD_H
 
 #include <linux/blkdev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/major.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/raid/md_k.h linux-2.6.15-rc5-mutex/include/linux/raid/md_k.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/raid/md_k.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/raid/md_k.h	2005-12-12 19:40:30.000000000 +0000
@@ -204,7 +204,7 @@ struct mddev_s
 	unsigned long			recovery;
 
 	int				in_sync;	/* know to not need resync */
-	struct semaphore		reconfig_sem;
+	struct mutex			reconfig_sem;
 	atomic_t			active;
 
 	int				changed;	/* true if we might need to reread partition info */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/reiserfs_fs_sb.h linux-2.6.15-rc5-mutex/include/linux/reiserfs_fs_sb.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/reiserfs_fs_sb.h	2005-08-30 13:56:37.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/reiserfs_fs_sb.h	2005-12-12 19:44:40.000000000 +0000
@@ -152,7 +152,7 @@ struct reiserfs_journal_list {
 	atomic_t j_nonzerolen;
 	atomic_t j_commit_left;
 	atomic_t j_older_commits_done;	/* all commits older than this on disk */
-	struct semaphore j_commit_lock;
+	struct mutex j_commit_lock;
 	unsigned long j_trans_id;
 	time_t j_timestamp;
 	struct reiserfs_list_bitmap *j_list_bitmap;
@@ -194,8 +194,8 @@ struct reiserfs_journal {
 	struct buffer_head *j_header_bh;
 
 	time_t j_trans_start_time;	/* time this transaction started */
-	struct semaphore j_lock;
-	struct semaphore j_flush_sem;
+	struct mutex j_lock;
+	struct mutex j_flush_sem;
 	wait_queue_head_t j_join_wait;	/* wait for current transaction to finish before starting new one */
 	atomic_t j_jlock;	/* lock for j_join_wait */
 	int j_list_bitmap_index;	/* number of next list bitmap to use */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/rtnetlink.h linux-2.6.15-rc5-mutex/include/linux/rtnetlink.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/rtnetlink.h	2005-11-01 13:19:21.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/linux/rtnetlink.h	2005-12-12 17:55:26.000000000 +0000
@@ -1032,7 +1032,7 @@ __rta_reserve(struct sk_buff *skb, int a
 
 extern void rtmsg_ifinfo(int type, struct net_device *dev, unsigned change);
 
-extern struct semaphore rtnl_sem;
+extern struct mutex rtnl_sem;
 
 #define rtnl_shlock()		down(&rtnl_sem)
 #define rtnl_shlock_nowait()	down_trylock(&rtnl_sem)
