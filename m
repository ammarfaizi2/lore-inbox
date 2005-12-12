Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVLLXvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVLLXvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVLLXqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932263AbVLLXqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:36 -0500
Date: Mon, 12 Dec 2005 23:45:47 GMT
Message-Id: <200512122345.jBCNjlvB009041@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 8/19] MUTEX: Drivers I-K changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/i* thru drivers/k* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-ItoK-2615rc5.diff
 drivers/i2c/busses/i2c-ali1535.c            |    2 +-
 drivers/i2c/busses/i2c-amd756-s4882.c       |    2 +-
 drivers/i2c/busses/scx200_acb.c             |    2 +-
 drivers/i2c/chips/eeprom.c                  |    2 +-
 drivers/i2c/chips/max6875.c                 |    4 ++--
 drivers/i2c/chips/pcf8591.c                 |    2 +-
 drivers/i2c/chips/tps65010.c                |    2 +-
 drivers/ide/ide.c                           |    4 ++--
 drivers/ieee1394/dv1394-private.h           |    2 +-
 drivers/ieee1394/eth1394.c                  |    2 +-
 drivers/ieee1394/hosts.h                    |    2 +-
 drivers/ieee1394/ieee1394_core.c            |    2 +-
 drivers/ieee1394/ieee1394_core.h            |    2 +-
 drivers/ieee1394/ieee1394_types.h           |    2 +-
 drivers/ieee1394/nodemgr.c                  |   10 +++++-----
 drivers/ieee1394/raw1394.c                  |    8 ++++----
 drivers/infiniband/core/device.c            |    2 +-
 drivers/infiniband/core/ucm.c               |    2 +-
 drivers/infiniband/core/user_mad.c          |    4 ++--
 drivers/infiniband/core/uverbs.h            |    4 ++--
 drivers/infiniband/hw/mthca/mthca_cmd.c     |   10 +++++-----
 drivers/infiniband/hw/mthca/mthca_dev.h     |   10 +++++-----
 drivers/infiniband/hw/mthca/mthca_memfree.c |    2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.h |    6 +++---
 drivers/infiniband/ulp/ipoib/ipoib.h        |    6 +++---
 drivers/infiniband/ulp/srp/ib_srp.h         |    4 ++--
 drivers/input/joystick/db9.c                |    2 +-
 drivers/input/joystick/gamecon.c            |    2 +-
 drivers/input/joystick/iforce/iforce.h      |    4 ++--
 drivers/input/joystick/turbografx.c         |    2 +-
 drivers/input/keyboard/atkbd.c              |    2 +-
 drivers/input/keyboard/hil_kbd.c            |    2 +-
 drivers/input/misc/hp_sdc_rtc.c             |    4 ++--
 drivers/input/mouse/hil_ptr.c               |    2 +-
 drivers/input/serio/hp_sdc.c                |    4 ++--
 drivers/input/serio/hp_sdc_mlc.c            |    2 +-
 drivers/isdn/capi/capi.c                    |    2 +-
 37 files changed, 64 insertions(+), 64 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/busses/i2c-ali1535.c linux-2.6.15-rc5-mutex/drivers/i2c/busses/i2c-ali1535.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/busses/i2c-ali1535.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/busses/i2c-ali1535.c	2005-12-12 22:08:48.000000000 +0000
@@ -63,7 +63,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 
 /* ALI1535 SMBus address offsets */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/busses/i2c-amd756-s4882.c linux-2.6.15-rc5-mutex/drivers/i2c/busses/i2c-amd756-s4882.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/busses/i2c-amd756-s4882.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/busses/i2c-amd756-s4882.c	2005-12-12 21:31:04.000000000 +0000
@@ -45,7 +45,7 @@ static struct i2c_adapter *s4882_adapter
 static struct i2c_algorithm *s4882_algo;
 
 /* Wrapper access functions for multiplexed SMBus */
-static struct semaphore amd756_lock;
+static struct mutex amd756_lock;
 
 static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
 			       unsigned short flags, char read_write,
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/busses/scx200_acb.c linux-2.6.15-rc5-mutex/drivers/i2c/busses/scx200_acb.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/busses/scx200_acb.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/busses/scx200_acb.c	2005-12-12 21:31:22.000000000 +0000
@@ -84,7 +84,7 @@ struct scx200_acb_iface
 	struct scx200_acb_iface *next;
 	struct i2c_adapter adapter;
 	unsigned base;
-	struct semaphore sem;
+	struct mutex sem;
 
 	/* State machine data */
 	enum scx200_acb_state state;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/eeprom.c linux-2.6.15-rc5-mutex/drivers/i2c/chips/eeprom.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/eeprom.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/chips/eeprom.c	2005-12-12 21:31:31.000000000 +0000
@@ -54,7 +54,7 @@ enum eeprom_nature {
 /* Each client has this additional data */
 struct eeprom_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	u8 valid;			/* bitfield, bit!=0 if slice is valid */
 	unsigned long last_updated[8];	/* In jiffies, 8 slices */
 	u8 data[EEPROM_SIZE];		/* Register values */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/max6875.c linux-2.6.15-rc5-mutex/drivers/i2c/chips/max6875.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/max6875.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/chips/max6875.c	2005-12-12 22:08:48.000000000 +0000
@@ -31,7 +31,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* Do not scan - the MAX6875 access method will write to some EEPROM chips */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
@@ -54,7 +54,7 @@ I2C_CLIENT_INSMOD_1(max6875);
 /* Each client has this additional data */
 struct max6875_data {
 	struct i2c_client	client;
-	struct semaphore	update_lock;
+	struct mutex		update_lock;
 
 	u32			valid;
 	u8			data[USER_EEPROM_SIZE];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/pcf8591.c linux-2.6.15-rc5-mutex/drivers/i2c/chips/pcf8591.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/pcf8591.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/chips/pcf8591.c	2005-12-12 21:31:48.000000000 +0000
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(input_mode,
 
 struct pcf8591_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
+	struct mutex  update_lock;
 
 	u8 control;
 	u8 aout;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/tps65010.c linux-2.6.15-rc5-mutex/drivers/i2c/chips/tps65010.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/i2c/chips/tps65010.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/i2c/chips/tps65010.c	2005-12-12 21:31:36.000000000 +0000
@@ -81,7 +81,7 @@ enum tps_model {
 
 struct tps65010 {
 	struct i2c_client	client;
-	struct semaphore	lock;
+	struct mutex		lock;
 	int			irq;
 	struct work_struct	work;
 	struct dentry		*file;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ide/ide.c linux-2.6.15-rc5-mutex/drivers/ide/ide.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ide/ide.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ide/ide.c	2005-12-12 17:55:02.000000000 +0000
@@ -222,7 +222,7 @@ static void init_hwif_data(ide_hwif_t *h
 	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
 	hwif->swdma_mask = 0x80;	/* disable all swdma */
 
-	sema_init(&hwif->gendev_rel_sem, 0);
+	init_MUTEX_LOCKED(&hwif->gendev_rel_sem);
 
 	default_hwif_iops(hwif);
 	default_hwif_transport(hwif);
@@ -245,7 +245,7 @@ static void init_hwif_data(ide_hwif_t *h
 		drive->is_flash			= 0;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
-		sema_init(&drive->gendev_rel_sem, 0);
+		init_MUTEX_LOCKED(&drive->gendev_rel_sem);
 	}
 }
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/dv1394-private.h linux-2.6.15-rc5-mutex/drivers/ieee1394/dv1394-private.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/dv1394-private.h	2004-06-18 13:41:59.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/dv1394-private.h	2005-12-12 21:38:13.000000000 +0000
@@ -470,7 +470,7 @@ struct video_card {
 
 	  NOTE: if you need both spinlock and sem, take sem first to avoid deadlock!
 	 */
-	struct semaphore sem;
+	struct mutex sem;
 
 	/* people waiting for buffer space, please form a line here... */
 	wait_queue_head_t waitq;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/eth1394.c linux-2.6.15-rc5-mutex/drivers/ieee1394/eth1394.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/eth1394.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/eth1394.c	2005-12-12 22:08:48.000000000 +0000
@@ -64,7 +64,7 @@
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
 #include <asm/delay.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <net/arp.h>
 
 #include "csr1212.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/hosts.h linux-2.6.15-rc5-mutex/drivers/ieee1394/hosts.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/hosts.h	2005-11-01 13:19:07.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/hosts.h	2005-12-12 22:08:48.000000000 +0000
@@ -7,7 +7,7 @@
 #include <linux/timer.h>
 #include <linux/skbuff.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "ieee1394_types.h"
 #include "csr.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/ieee1394_core.c linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/ieee1394_core.c	2005-11-01 13:19:07.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_core.c	2005-12-12 22:08:48.000000000 +0000
@@ -35,7 +35,7 @@
 #include <linux/suspend.h>
 
 #include <asm/byteorder.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "ieee1394_types.h"
 #include "ieee1394.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/ieee1394_core.h linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_core.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/ieee1394_core.h	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_core.h	2005-12-12 22:08:48.000000000 +0000
@@ -5,7 +5,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include "hosts.h"
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/ieee1394_types.h linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_types.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/ieee1394_types.h	2004-06-18 13:41:59.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/ieee1394_types.h	2005-12-12 22:08:48.000000000 +0000
@@ -9,7 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/byteorder.h>
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/nodemgr.c linux-2.6.15-rc5-mutex/drivers/ieee1394/nodemgr.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/nodemgr.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/nodemgr.c	2005-12-12 20:21:37.000000000 +0000
@@ -1520,8 +1520,8 @@ static int nodemgr_host_thread(void *__h
 		unsigned int generation = 0;
 		int i;
 
-		if (down_interruptible(&hi->reset_sem) ||
-		    down_interruptible(&nodemgr_serialize)) {
+		if (down_sem_interruptible(&hi->reset_sem) ||
+		    down_sem_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
 			printk("NodeMgr: received unexpected signal?!\n" );
@@ -1551,7 +1551,7 @@ static int nodemgr_host_thread(void *__h
 
 			/* If we get a reset before we are done waiting, then
 			 * start the the waiting over again */
-			while (!down_trylock(&hi->reset_sem))
+			while (!down_sem_trylock(&hi->reset_sem))
 				i = 0;
 
 			/* Check the kill_me again */
@@ -1678,7 +1678,7 @@ static void nodemgr_host_reset(struct hp
 
 	if (hi != NULL) {
 		HPSB_VERBOSE("NodeMgr: Processing host reset for %s", hi->daemon_name);
-		up(&hi->reset_sem);
+		up_sem(&hi->reset_sem);
 	} else
 		HPSB_ERR ("NodeMgr: could not process reset of unused host");
 
@@ -1693,7 +1693,7 @@ static void nodemgr_remove_host(struct h
 		if (hi->pid >= 0) {
 			hi->kill_me = 1;
 			mb();
-			up(&hi->reset_sem);
+			up_sem(&hi->reset_sem);
 			wait_for_completion(&hi->exited);
 			nodemgr_remove_host_dev(&host->device);
 		}
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/raw1394.c linux-2.6.15-rc5-mutex/drivers/ieee1394/raw1394.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/ieee1394/raw1394.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/ieee1394/raw1394.c	2005-12-12 20:21:05.000000000 +0000
@@ -138,7 +138,7 @@ static void __queue_complete_req(struct 
 	list_del(&req->list);
 	list_add_tail(&req->list, &fi->req_complete);
 
-	up(&fi->complete_sem);
+	up_sem(&fi->complete_sem);
 	wake_up_interruptible(&fi->poll_wait_complete);
 }
 
@@ -427,11 +427,11 @@ static ssize_t raw1394_read(struct file 
 	}
 
 	if (file->f_flags & O_NONBLOCK) {
-		if (down_trylock(&fi->complete_sem)) {
+		if (down_sem_trylock(&fi->complete_sem)) {
 			return -EAGAIN;
 		}
 	} else {
-		if (down_interruptible(&fi->complete_sem)) {
+		if (down_sem_interruptible(&fi->complete_sem)) {
 			return -ERESTARTSYS;
 		}
 	}
@@ -2809,7 +2809,7 @@ static int raw1394_release(struct inode 
 		spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 		if (!done)
-			down_interruptible(&fi->complete_sem);
+			down_sem_interruptible(&fi->complete_sem);
 	}
 
 	/* Remove any sub-trees left by user space programs */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/device.c linux-2.6.15-rc5-mutex/drivers/infiniband/core/device.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/device.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/device.c	2005-12-12 22:12:49.000000000 +0000
@@ -39,7 +39,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "core_priv.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/ucm.c linux-2.6.15-rc5-mutex/drivers/infiniband/core/ucm.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/ucm.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/ucm.c	2005-12-12 21:14:22.000000000 +0000
@@ -60,7 +60,7 @@ struct ib_ucm_device {
 };
 
 struct ib_ucm_file {
-	struct semaphore mutex;
+	struct mutex mutex;
 	struct file *filp;
 	struct ib_ucm_device *device;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/user_mad.c linux-2.6.15-rc5-mutex/drivers/infiniband/core/user_mad.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/user_mad.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/user_mad.c	2005-12-12 22:12:49.000000000 +0000
@@ -47,7 +47,7 @@
 #include <linux/kref.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_user_mad.h>
@@ -92,7 +92,7 @@ struct ib_umad_port {
 
 	struct cdev           *sm_dev;
 	struct class_device   *sm_class_dev;
-	struct semaphore       sm_sem;
+	struct mutex           sm_sem;
 
 	struct rw_semaphore    mutex;
 	struct list_head       file_list;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/uverbs.h linux-2.6.15-rc5-mutex/drivers/infiniband/core/uverbs.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/core/uverbs.h	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/core/uverbs.h	2005-12-12 21:14:18.000000000 +0000
@@ -88,7 +88,7 @@ struct ib_uverbs_event_file {
 
 struct ib_uverbs_file {
 	struct kref				ref;
-	struct semaphore			mutex;
+	struct mutex				mutex;
 	struct ib_uverbs_device		       *device;
 	struct ib_ucontext		       *ucontext;
 	struct ib_event_handler			event_handler;
@@ -131,7 +131,7 @@ struct ib_ucq_object {
 	u32			async_events_reported;
 };
 
-extern struct semaphore ib_uverbs_idr_mutex;
+extern struct mutex ib_uverbs_idr_mutex;
 extern struct idr ib_uverbs_pd_idr;
 extern struct idr ib_uverbs_mr_idr;
 extern struct idr ib_uverbs_mw_idr;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_cmd.c linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_cmd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-12-12 20:33:35.000000000 +0000
@@ -333,7 +333,7 @@ static int mthca_cmd_wait(struct mthca_d
 	int err = 0;
 	struct mthca_cmd_context *context;
 
-	if (down_interruptible(&dev->cmd.event_sem))
+	if (down_sem_interruptible(&dev->cmd.event_sem))
 		return -EINTR;
 
 	spin_lock(&dev->cmd.context_lock);
@@ -375,7 +375,7 @@ out:
 	dev->cmd.free_head = context - dev->cmd.context;
 	spin_unlock(&dev->cmd.context_lock);
 
-	up(&dev->cmd.event_sem);
+	up_sem(&dev->cmd.event_sem);
 	return err;
 }
 
@@ -438,8 +438,8 @@ static int mthca_cmd_imm(struct mthca_de
 
 int mthca_cmd_init(struct mthca_dev *dev)
 {
-	sema_init(&dev->cmd.hcr_sem, 1);
-	sema_init(&dev->cmd.poll_sem, 1);
+	init_MUTEX(&dev->cmd.hcr_sem);
+	init_MUTEX(&dev->cmd.poll_sem);
 	dev->cmd.use_events = 0;
 
 	dev->hcr = ioremap(pci_resource_start(dev->pdev, 0) + MTHCA_HCR_BASE,
@@ -517,7 +517,7 @@ void mthca_cmd_use_polling(struct mthca_
 	dev->cmd.use_events = 0;
 
 	for (i = 0; i < dev->cmd.max_cmds; ++i)
-		down(&dev->cmd.event_sem);
+		down_sem(&dev->cmd.event_sem);
 
 	kfree(dev->cmd.context);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_dev.h linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_dev.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_dev.h	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_dev.h	2005-12-12 22:06:13.000000000 +0000
@@ -43,7 +43,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "mthca_provider.h"
 #include "mthca_doorbell.h"
@@ -110,8 +110,8 @@ enum {
 struct mthca_cmd {
 	struct pci_pool          *pool;
 	int                       use_events;
-	struct semaphore          hcr_sem;
-	struct semaphore 	  poll_sem;
+	struct mutex              hcr_sem;
+	struct mutex              poll_sem;
 	struct semaphore 	  event_sem;
 	int              	  max_cmds;
 	spinlock_t                context_lock;
@@ -255,7 +255,7 @@ struct mthca_av_table {
 };
 
 struct mthca_mcg_table {
-	struct semaphore   	sem;
+	struct mutex		sem;
 	struct mthca_alloc 	alloc;
 	struct mthca_icm_table *table;
 };
@@ -300,7 +300,7 @@ struct mthca_dev {
 	u64              ddr_end;
 
 	MTHCA_DECLARE_DOORBELL_LOCK(doorbell_lock)
-	struct semaphore cap_mask_mutex;
+	struct mutex cap_mask_mutex;
 
 	void __iomem    *hcr;
 	void __iomem    *kar;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_memfree.c linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_memfree.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-12-12 21:14:34.000000000 +0000
@@ -50,7 +50,7 @@ enum {
 };
 
 struct mthca_user_db_table {
-	struct semaphore mutex;
+	struct mutex mutex;
 	struct {
 		u64                uvirt;
 		struct scatterlist mem;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_memfree.h linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_memfree.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-12-12 22:06:17.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define MTHCA_ICM_CHUNK_LEN \
 	((256 - sizeof (struct list_head) - 2 * sizeof (int)) /		\
@@ -64,7 +64,7 @@ struct mthca_icm_table {
 	int               num_obj;
 	int               obj_size;
 	int               lowmem;
-	struct semaphore  mutex;
+	struct mutex      mutex;
 	struct mthca_icm *icm[0];
 };
 
@@ -147,7 +147,7 @@ struct mthca_db_table {
 	int 	       	      max_group1;
 	int 	       	      min_group2;
 	struct mthca_db_page *page;
-	struct semaphore      mutex;
+	struct mutex          mutex;
 };
 
 enum mthca_db_type {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/ulp/ipoib/ipoib.h linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/ipoib/ipoib.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/ulp/ipoib/ipoib.h	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/ipoib/ipoib.h	2005-12-12 22:12:49.000000000 +0000
@@ -49,7 +49,7 @@
 #include <net/neighbour.h>
 
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
@@ -123,8 +123,8 @@ struct ipoib_dev_priv {
 
 	unsigned long flags;
 
-	struct semaphore mcast_mutex;
-	struct semaphore vlan_mutex;
+	struct mutex mcast_mutex;
+	struct mutex vlan_mutex;
 
 	struct rb_root  path_tree;
 	struct list_head path_list;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/ulp/srp/ib_srp.h linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/srp/ib_srp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/infiniband/ulp/srp/ib_srp.h	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/infiniband/ulp/srp/ib_srp.h	2005-12-12 22:12:49.000000000 +0000
@@ -38,7 +38,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -85,7 +85,7 @@ struct srp_host {
 	struct ib_mr	       *mr;
 	struct class_device	class_dev;
 	struct list_head	target_list;
-	struct semaphore        target_mutex;
+	struct mutex            target_mutex;
 	struct completion	released;
 	struct list_head	list;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/db9.c linux-2.6.15-rc5-mutex/drivers/input/joystick/db9.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/db9.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/joystick/db9.c	2005-12-12 20:56:11.000000000 +0000
@@ -111,7 +111,7 @@ struct db9 {
 	struct pardevice *pd;
 	int mode;
 	int used;
-	struct semaphore sem;
+	struct mutex sem;
 	char phys[DB9_MAX_DEVICES][32];
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/gamecon.c linux-2.6.15-rc5-mutex/drivers/input/joystick/gamecon.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/gamecon.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/joystick/gamecon.c	2005-12-12 20:56:07.000000000 +0000
@@ -83,7 +83,7 @@ struct gc {
 	struct timer_list timer;
 	unsigned char pads[GC_MAX + 1];
 	int used;
-	struct semaphore sem;
+	struct mutex sem;
 	char phys[GC_MAX_DEVICES][32];
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/iforce/iforce.h linux-2.6.15-rc5-mutex/drivers/input/joystick/iforce/iforce.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/iforce/iforce.h	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/joystick/iforce/iforce.h	2005-12-12 22:12:50.000000000 +0000
@@ -37,7 +37,7 @@
 #include <linux/serio.h>
 #include <linux/config.h>
 #include <linux/circ_buf.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /* This module provides arbitrary resource management routines.
  * I use it to manage the device's memory.
@@ -146,7 +146,7 @@ struct iforce {
 	wait_queue_head_t wait;
 	struct resource device_memory;
 	struct iforce_core_effect core_effects[FF_EFFECTS_MAX];
-	struct semaphore mem_mutex;
+	struct mutex mem_mutex;
 };
 
 /* Get hi and low bytes of a 16-bits int */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/turbografx.c linux-2.6.15-rc5-mutex/drivers/input/joystick/turbografx.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/joystick/turbografx.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/joystick/turbografx.c	2005-12-12 20:56:17.000000000 +0000
@@ -86,7 +86,7 @@ static struct tgfx {
 	char phys[TGFX_MAX_DEVICES][32];
 	int sticks;
 	int used;
-	struct semaphore sem;
+	struct mutex sem;
 } *tgfx_base[TGFX_MAX_PORTS];
 
 /*
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/keyboard/atkbd.c linux-2.6.15-rc5-mutex/drivers/input/keyboard/atkbd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/keyboard/atkbd.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/keyboard/atkbd.c	2005-12-12 17:52:17.000000000 +0000
@@ -216,7 +216,7 @@ struct atkbd {
 	unsigned long time;
 
 	struct work_struct event_work;
-	struct semaphore event_sem;
+	struct mutex event_sem;
 	unsigned long event_mask;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/keyboard/hil_kbd.c linux-2.6.15-rc5-mutex/drivers/input/keyboard/hil_kbd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/keyboard/hil_kbd.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/keyboard/hil_kbd.c	2005-12-12 20:55:05.000000000 +0000
@@ -80,7 +80,7 @@ struct hil_kbd {
 	char	rnm[HIL_KBD_MAX_LENGTH + 1];	/* RNM record + NULL term. */
 
 	/* Something to sleep around with. */
-	struct semaphore sem;
+	struct mutex sem;
 };
 
 /* Process a complete packet after transfer from the HIL */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/misc/hp_sdc_rtc.c linux-2.6.15-rc5-mutex/drivers/input/misc/hp_sdc_rtc.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/misc/hp_sdc_rtc.c	2005-06-22 13:51:49.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/input/misc/hp_sdc_rtc.c	2005-12-12 20:55:41.000000000 +0000
@@ -52,7 +52,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 static unsigned long epoch = 2000;
 
-static struct semaphore i8042tregs;
+static struct mutex i8042tregs;
 
 static hp_sdc_irqhook hp_sdc_rtc_isr;
 
@@ -85,7 +85,7 @@ static void hp_sdc_rtc_isr (int irq, voi
 
 static int hp_sdc_rtc_do_read_bbrtc (struct rtc_time *rtctm)
 {
-	struct semaphore tsem;
+	struct mutex tsem;
 	hp_sdc_transaction t;
 	uint8_t tseq[91];
 	int i;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/mouse/hil_ptr.c linux-2.6.15-rc5-mutex/drivers/input/mouse/hil_ptr.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/mouse/hil_ptr.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/mouse/hil_ptr.c	2005-12-12 20:56:27.000000000 +0000
@@ -73,7 +73,7 @@ struct hil_ptr {
 	unsigned int btnmap[7];
 
 	/* Something to sleep around with. */
-	struct semaphore sem;
+	struct mutex sem;
 };
 
 /* Process a complete packet after transfer from the HIL */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/serio/hp_sdc.c linux-2.6.15-rc5-mutex/drivers/input/serio/hp_sdc.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/serio/hp_sdc.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/serio/hp_sdc.c	2005-12-12 20:56:45.000000000 +0000
@@ -777,7 +777,7 @@ static int __init hp_sdc_init(void)
 	char *errstr;
 	hp_sdc_transaction t_sync;
 	uint8_t ts_sync[6];
-	struct semaphore s_sync;
+	struct mutex s_sync;
 
   	rwlock_init(&hp_sdc.lock);
   	rwlock_init(&hp_sdc.ibf_lock);
@@ -919,7 +919,7 @@ static int __init hp_sdc_register(void)
 {
 	hp_sdc_transaction tq_init;
 	uint8_t tq_init_seq[5];
-	struct semaphore tq_init_sem;
+	struct mutex tq_init_sem;
 #if defined(__mc68000__)
 	mm_segment_t fs;
 	unsigned char i;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/input/serio/hp_sdc_mlc.c linux-2.6.15-rc5-mutex/drivers/input/serio/hp_sdc_mlc.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/input/serio/hp_sdc_mlc.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/input/serio/hp_sdc_mlc.c	2005-12-12 22:12:50.000000000 +0000
@@ -40,7 +40,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define PREFIX "HP SDC MLC: "
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/isdn/capi/capi.c linux-2.6.15-rc5-mutex/drivers/isdn/capi/capi.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/isdn/capi/capi.c	2005-12-08 16:23:40.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/isdn/capi/capi.c	2005-12-12 21:19:35.000000000 +0000
@@ -138,7 +138,7 @@ struct capidev {
 
 	struct capincci *nccis;
 
-	struct semaphore ncci_list_sem;
+	struct mutex ncci_list_sem;
 };
 
 /* -------- global variables ---------------------------------------- */
