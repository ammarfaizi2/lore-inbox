Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbWBHUCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbWBHUCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWBHUCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:02:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38353 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030514AbWBHUCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:02:05 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drivers/s390 misc sparse annotations
Cc: schwidefsky@de.ibm.com
Message-Id: <E1F6vVr-0008C4-LY@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:02:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1133682045 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/s390/block/dasd_devmap.c  |    8 ++++----
 drivers/s390/block/dasd_eckd.c    |   20 ++++++++++---------
 drivers/s390/block/dasd_fba.c     |    4 ++--
 drivers/s390/block/dasd_genhd.c   |    6 +++---
 drivers/s390/char/con3215.c       |    2 +-
 drivers/s390/char/ctrlchar.c      |    2 +-
 drivers/s390/char/defkeymap.c     |    6 +++---
 drivers/s390/char/fs3270.c        |   12 ++++++------
 drivers/s390/char/keyboard.c      |    6 +++---
 drivers/s390/char/raw3270.c       |   32 ++++++++++++++++---------------
 drivers/s390/char/raw3270.h       |    2 +-
 drivers/s390/char/tape_34xx.c     |    4 ++--
 drivers/s390/char/tty3270.c       |   24 ++++++++++++-----------
 drivers/s390/char/vmlogrdr.c      |    4 ++--
 drivers/s390/char/vmwatchdog.c    |    2 +-
 drivers/s390/cio/ccwgroup.c       |    2 +-
 drivers/s390/cio/cio.c            |    2 +-
 drivers/s390/cio/cmf.c            |    8 ++++----
 drivers/s390/cio/device.c         |    8 ++++----
 drivers/s390/cio/qdio.c           |    2 +-
 drivers/s390/crypto/z90hardware.c |    2 +-
 drivers/s390/crypto/z90main.c     |   20 ++++++++++---------
 drivers/s390/net/ctctty.c         |    6 +++---
 drivers/s390/net/iucv.c           |    2 +-
 drivers/s390/net/qeth_main.c      |   16 ++++++++--------
 drivers/s390/net/qeth_sys.c       |    4 ++--
 drivers/s390/net/smsgiucv.c       |   14 +++++++-------
 drivers/s390/scsi/zfcp_erp.c      |    2 +-
 drivers/s390/scsi/zfcp_fsf.c      |    2 +-
 drivers/s390/scsi/zfcp_scsi.c     |   38 +++++++++++++++++++------------------
 30 files changed, 131 insertions(+), 131 deletions(-)

44f302464077fba52c37b14bb282b58aaae2c2c5
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 1629b27..8e0c6e2 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -368,7 +368,7 @@ dasd_add_busid(char *bus_id, int feature
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 	spin_lock(&dasd_devmap_lock);
-	devmap = 0;
+	devmap = NULL;
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list)
 		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
@@ -380,10 +380,10 @@ dasd_add_busid(char *bus_id, int feature
 		new->devindex = dasd_max_devindex++;
 		strncpy(new->bus_id, bus_id, BUS_ID_SIZE);
 		new->features = features;
-		new->device = 0;
+		new->device = NULL;
 		list_add(&new->list, &dasd_hashlists[hash]);
 		devmap = new;
-		new = 0;
+		new = NULL;
 	}
 	spin_unlock(&dasd_devmap_lock);
 	kfree(new);
@@ -454,7 +454,7 @@ dasd_device_from_devindex(int devindex)
 	int i;
 
 	spin_lock(&dasd_devmap_lock);
-	devmap = 0;
+	devmap = NULL;
 	for (i = 0; (i < 256) && !devmap; i++)
 		list_for_each_entry(tmp, &dasd_hashlists[i], list)
 			if (tmp->devindex == devindex) {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 822e2a2..b2ebef6 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -65,16 +65,16 @@ struct dasd_eckd_private {
 /* The ccw bus type uses this table to find devices that it sends to
  * dasd_eckd_probe */
 static struct ccw_device_id dasd_eckd_ids[] = {
-	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3390, 0), driver_info: 0x1},
-	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3390, 0), driver_info: 0x2},
-	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3390, 0), driver_info: 0x3},
-	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3380, 0), driver_info: 0x4},
-	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3380, 0), driver_info: 0x5},
-	{ CCW_DEVICE_DEVTYPE (0x9343, 0, 0x9345, 0), driver_info: 0x6},
-	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3390, 0), driver_info: 0x7},
-	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3380, 0), driver_info: 0x8},
-	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3390, 0), driver_info: 0x9},
-	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3380, 0), driver_info: 0xa},
+	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3390, 0), .driver_info = 0x1},
+	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3390, 0), .driver_info = 0x2},
+	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3390, 0), .driver_info = 0x3},
+	{ CCW_DEVICE_DEVTYPE (0x3990, 0, 0x3380, 0), .driver_info = 0x4},
+	{ CCW_DEVICE_DEVTYPE (0x2105, 0, 0x3380, 0), .driver_info = 0x5},
+	{ CCW_DEVICE_DEVTYPE (0x9343, 0, 0x9345, 0), .driver_info = 0x6},
+	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3390, 0), .driver_info = 0x7},
+	{ CCW_DEVICE_DEVTYPE (0x2107, 0, 0x3380, 0), .driver_info = 0x8},
+	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3390, 0), .driver_info = 0x9},
+	{ CCW_DEVICE_DEVTYPE (0x1750, 0, 0x3380, 0), .driver_info = 0xa},
 	{ /* end of list */ },
 };
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 9114569..3d5eaad 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -45,8 +45,8 @@ struct dasd_fba_private {
 };
 
 static struct ccw_device_id dasd_fba_ids[] = {
-	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), driver_info: 0x1},
-	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), driver_info: 0x2},
+	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), .driver_info = 0x1},
+	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), .driver_info = 0x2},
 	{ /* end of list */ },
 };
 
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 65dc844..e8f9140 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -87,9 +87,9 @@ void
 dasd_gendisk_free(struct dasd_device *device)
 {
 	del_gendisk(device->gdp);
-	device->gdp->queue = 0;
+	device->gdp->queue = NULL;
 	put_disk(device->gdp);
-	device->gdp = 0;
+	device->gdp = NULL;
 }
 
 /*
@@ -141,7 +141,7 @@ dasd_destroy_partitions(struct dasd_devi
 	 * device->bdev to lower the offline open_count limit again.
 	 */
 	bdev = device->bdev;
-	device->bdev = 0;
+	device->bdev = NULL;
 
 	/*
 	 * See fs/partition/check.c:delete_partition
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 606f6ad..5f9bf4b 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -694,7 +694,7 @@ raw3215_probe (struct ccw_device *cdev)
 				       GFP_KERNEL|GFP_DMA);
 	if (raw->buffer == NULL) {
 		spin_lock(&raw3215_device_lock);
-		raw3215[line] = 0;
+		raw3215[line] = NULL;
 		spin_unlock(&raw3215_device_lock);
 		kfree(raw);
 		return -ENOMEM;
diff --git a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
index be46324..3b77f9a 100644
--- a/drivers/s390/char/ctrlchar.c
+++ b/drivers/s390/char/ctrlchar.c
@@ -24,7 +24,7 @@ ctrlchar_handle_sysrq(void *tty)
 	handle_sysrq(ctrlchar_sysrq_key, NULL, (struct tty_struct *) tty);
 }
 
-static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, 0);
+static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
 #endif
 
 
diff --git a/drivers/s390/char/defkeymap.c b/drivers/s390/char/defkeymap.c
index ca15adb..9186299 100644
--- a/drivers/s390/char/defkeymap.c
+++ b/drivers/s390/char/defkeymap.c
@@ -83,8 +83,8 @@ static u_short shift_ctrl_map[NR_KEYS] =
 };
 
 ushort *key_maps[MAX_NR_KEYMAPS] = {
-	plain_map, shift_map, 0, 0,
-	ctrl_map, shift_ctrl_map,	0
+	plain_map, shift_map, NULL, NULL,
+	ctrl_map, shift_ctrl_map,	NULL
 };
 
 unsigned int keymap_count = 4;
@@ -145,7 +145,7 @@ char *func_table[MAX_NR_FUNC] = {
 	func_buf + 97,
 	func_buf + 103,
 	func_buf + 109,
-	0,
+	NULL,
 };
 
 struct kbdiacr accent_table[MAX_DIACR] = {
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 5f6fa4c..250add8 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -237,7 +237,7 @@ fs3270_irq(struct fs3270 *fp, struct raw
  * Process reads from fullscreen 3270.
  */
 static ssize_t
-fs3270_read(struct file *filp, char *data, size_t count, loff_t *off)
+fs3270_read(struct file *filp, char __user *data, size_t count, loff_t *off)
 {
 	struct fs3270 *fp;
 	struct raw3270_request *rq;
@@ -282,7 +282,7 @@ fs3270_read(struct file *filp, char *dat
  * Process writes to fullscreen 3270.
  */
 static ssize_t
-fs3270_write(struct file *filp, const char *data, size_t count, loff_t *off)
+fs3270_write(struct file *filp, const char __user *data, size_t count, loff_t *off)
 {
 	struct fs3270 *fp;
 	struct raw3270_request *rq;
@@ -339,10 +339,10 @@ fs3270_ioctl(struct file *filp, unsigned
 		fp->write_command = arg;
 		break;
 	case TUBGETI:
-		rc = put_user(fp->read_command, (char *) arg);
+		rc = put_user(fp->read_command, (char __user *) arg);
 		break;
 	case TUBGETO:
-		rc = put_user(fp->write_command,(char *) arg);
+		rc = put_user(fp->write_command,(char __user *) arg);
 		break;
 	case TUBGETMOD:
 		iocb.model = fp->view.model;
@@ -351,7 +351,7 @@ fs3270_ioctl(struct file *filp, unsigned
 		iocb.pf_cnt = 24;
 		iocb.re_cnt = 20;
 		iocb.map = 0;
-		if (copy_to_user((char *) arg, &iocb,
+		if (copy_to_user((char __user *) arg, &iocb,
 				 sizeof(struct raw3270_iocb)))
 			rc = -EFAULT;
 		break;
@@ -481,7 +481,7 @@ fs3270_close(struct inode *inode, struct
 	struct fs3270 *fp;
 
 	fp = filp->private_data;
-	filp->private_data = 0;
+	filp->private_data = NULL;
 	if (fp) {
 		fp->fs_pid = 0;
 		raw3270_reset(&fp->view);
diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index a317a12..6674825 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -108,7 +108,7 @@ out_maps:
 out_kbd:
 	kfree(kbd);
 out:
-	return 0;
+	return NULL;
 }
 
 void
@@ -309,7 +309,7 @@ kbd_keycode(struct kbd_data *kbd, unsign
 		if (kbd->sysrq) {
 			if (kbd->sysrq == K(KT_LATIN, '-')) {
 				kbd->sysrq = 0;
-				handle_sysrq(value, 0, kbd->tty);
+				handle_sysrq(value, NULL, kbd->tty);
 				return;
 			}
 			if (value == '-') {
@@ -368,7 +368,7 @@ do_kdsk_ioctl(struct kbd_data *kbd, stru
 			/* disallocate map */
 			key_map = kbd->key_maps[tmp.kb_table];
 			if (key_map) {
-			    kbd->key_maps[tmp.kb_table] = 0;
+			    kbd->key_maps[tmp.kb_table] = NULL;
 			    kfree(key_map);
 			}
 			break;
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 1026f2b..5d76876 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -719,8 +719,8 @@ raw3270_size_device(struct raw3270 *rp)
 		rc = __raw3270_size_device_vm(rp);
 	else
 		rc = __raw3270_size_device(rp);
-	raw3270_init_view.dev = 0;
-	rp->view = 0;
+	raw3270_init_view.dev = NULL;
+	rp->view = NULL;
 	up(&raw3270_init_sem);
 	if (rc == 0) {	/* Found something. */
 		/* Try to find a model. */
@@ -761,8 +761,8 @@ raw3270_reset_device(struct raw3270 *rp)
 	rp->view = &raw3270_init_view;
 	raw3270_init_view.dev = rp;
 	rc = raw3270_start_init(rp, &raw3270_init_view, &raw3270_init_request);
-	raw3270_init_view.dev = 0;
-	rp->view = 0;
+	raw3270_init_view.dev = NULL;
+	rp->view = NULL;
 	up(&raw3270_init_sem);
 	return rc;
 }
@@ -934,7 +934,7 @@ raw3270_activate_view(struct raw3270_vie
 	else if (!test_bit(RAW3270_FLAGS_READY, &rp->flags))
 		rc = -ENODEV;
 	else {
-		oldview = 0;
+		oldview = NULL;
 		if (rp->view) {
 			oldview = rp->view;
 			oldview->fn->deactivate(oldview);
@@ -951,7 +951,7 @@ raw3270_activate_view(struct raw3270_vie
 						rp->view = nv;
 						if (nv->fn->activate(nv) == 0)
 							break;
-						rp->view = 0;
+						rp->view = NULL;
 					}
 			}
 		}
@@ -975,7 +975,7 @@ raw3270_deactivate_view(struct raw3270_v
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 	if (rp->view == view) {
 		view->fn->deactivate(view);
-		rp->view = 0;
+		rp->view = NULL;
 		/* Move deactivated view to end of list. */
 		list_del_init(&view->list);
 		list_add_tail(&view->list, &rp->view_list);
@@ -985,7 +985,7 @@ raw3270_deactivate_view(struct raw3270_v
 				rp->view = view;
 				if (view->fn->activate(view) == 0)
 					break;
-				rp->view = 0;
+				rp->view = NULL;
 			}
 		}
 	}
@@ -1076,7 +1076,7 @@ raw3270_del_view(struct raw3270_view *vi
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 	if (rp->view == view) {
 		view->fn->deactivate(view);
-		rp->view = 0;
+		rp->view = NULL;
 	}
 	list_del_init(&view->list);
 	if (!rp->view && test_bit(RAW3270_FLAGS_READY, &rp->flags)) {
@@ -1117,9 +1117,9 @@ raw3270_delete_device(struct raw3270 *rp
 
 	/* Disconnect from ccw_device. */
 	cdev = rp->cdev;
-	rp->cdev = 0;
-	cdev->dev.driver_data = 0;
-	cdev->handler = 0;
+	rp->cdev = NULL;
+	cdev->dev.driver_data = NULL;
+	cdev->handler = NULL;
 
 	/* Put ccw_device structure. */
 	put_device(&cdev->dev);
@@ -1144,7 +1144,7 @@ raw3270_model_show(struct device *dev, s
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->model);
 }
-static DEVICE_ATTR(model, 0444, raw3270_model_show, 0);
+static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
 
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1152,7 +1152,7 @@ raw3270_rows_show(struct device *dev, st
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->rows);
 }
-static DEVICE_ATTR(rows, 0444, raw3270_rows_show, 0);
+static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
 
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1160,7 +1160,7 @@ raw3270_columns_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->cols);
 }
-static DEVICE_ATTR(columns, 0444, raw3270_columns_show, 0);
+static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
 
 static struct attribute * raw3270_attrs[] = {
 	&dev_attr_model.attr,
@@ -1296,7 +1296,7 @@ raw3270_remove (struct ccw_device *cdev)
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	if (rp->view) {
 		rp->view->fn->deactivate(rp->view);
-		rp->view = 0;
+		rp->view = NULL;
 	}
 	while (!list_empty(&rp->view_list)) {
 		v = list_entry(rp->view_list.next, struct raw3270_view, list);
diff --git a/drivers/s390/char/raw3270.h b/drivers/s390/char/raw3270.h
index b635bf8..90beaa8 100644
--- a/drivers/s390/char/raw3270.h
+++ b/drivers/s390/char/raw3270.h
@@ -231,7 +231,7 @@ alloc_string(struct list_head *free_list
 		INIT_LIST_HEAD(&cs->update);
 		return cs;
 	}
-	return 0;
+	return NULL;
 }
 
 static inline unsigned long
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 682039c..d1d3058 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -1316,8 +1316,8 @@ static struct tape_discipline tape_disci
 };
 
 static struct ccw_device_id tape_34xx_ids[] = {
-	{ CCW_DEVICE_DEVTYPE(0x3480, 0, 0x3480, 0), driver_info: tape_3480},
-	{ CCW_DEVICE_DEVTYPE(0x3490, 0, 0x3490, 0), driver_info: tape_3490},
+	{ CCW_DEVICE_DEVTYPE(0x3480, 0, 0x3480, 0), .driver_info = tape_3480},
+	{ CCW_DEVICE_DEVTYPE(0x3490, 0, 0x3490, 0), .driver_info = tape_3490},
 	{ /* end of list */ }
 };
 
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 4b90693..30f016d 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -438,7 +438,7 @@ tty3270_rcl_add(struct tty3270 *tp, char
 {
 	struct string *s;
 
-	tp->rcl_walk = 0;
+	tp->rcl_walk = NULL;
 	if (len <= 0)
 		return;
 	if (tp->rcl_nr >= tp->rcl_max) {
@@ -467,12 +467,12 @@ tty3270_rcl_backward(struct kbd_data *kb
 		else if (!list_empty(&tp->rcl_lines))
 			tp->rcl_walk = tp->rcl_lines.prev;
 		s = tp->rcl_walk ? 
-			list_entry(tp->rcl_walk, struct string, list) : 0;
+			list_entry(tp->rcl_walk, struct string, list) : NULL;
 		if (tp->rcl_walk) {
 			s = list_entry(tp->rcl_walk, struct string, list);
 			tty3270_update_prompt(tp, s->string, s->len);
 		} else
-			tty3270_update_prompt(tp, 0, 0);
+			tty3270_update_prompt(tp, NULL, 0);
 		tty3270_set_timer(tp, 1);
 	}
 	spin_unlock_bh(&tp->view.lock);
@@ -554,7 +554,7 @@ tty3270_read_tasklet(struct raw3270_requ
 	 * has to be emitted to the tty and for 0x6d the screen
 	 * needs to be redrawn.
 	 */
-	input = 0;
+	input = NULL;
 	len = 0;
 	if (tp->input->string[0] == 0x7d) {
 		/* Enter: write input to tty. */
@@ -568,7 +568,7 @@ tty3270_read_tasklet(struct raw3270_requ
 			tty3270_update_status(tp);
 		}
 		/* Clear input area. */
-		tty3270_update_prompt(tp, 0, 0);
+		tty3270_update_prompt(tp, NULL, 0);
 		tty3270_set_timer(tp, 1);
 	} else if (tp->input->string[0] == 0x6d) {
 		/* Display has been cleared. Redraw. */
@@ -812,8 +812,8 @@ tty3270_release(struct raw3270_view *vie
 	tp = (struct tty3270 *) view;
 	tty = tp->tty;
 	if (tty) {
-		tty->driver_data = 0;
-		tp->tty = tp->kbd->tty = 0;
+		tty->driver_data = NULL;
+		tp->tty = tp->kbd->tty = NULL;
 		tty_hangup(tty);
 		raw3270_put_view(&tp->view);
 	}
@@ -952,8 +952,8 @@ tty3270_close(struct tty_struct *tty, st
 		return;
 	tp = (struct tty3270 *) tty->driver_data;
 	if (tp) {
-		tty->driver_data = 0;
-		tp->tty = tp->kbd->tty = 0;
+		tty->driver_data = NULL;
+		tp->tty = tp->kbd->tty = NULL;
 		raw3270_put_view(&tp->view);
 	}
 }
@@ -1677,7 +1677,7 @@ tty3270_set_termios(struct tty_struct *t
 		new = L_ECHO(tty) ? TF_INPUT: TF_INPUTN;
 		if (new != tp->inattr) {
 			tp->inattr = new;
-			tty3270_update_prompt(tp, 0, 0);
+			tty3270_update_prompt(tp, NULL, 0);
 			tty3270_set_timer(tp, 1);
 		}
 	}
@@ -1763,7 +1763,7 @@ void
 tty3270_notifier(int index, int active)
 {
 	if (active)
-		tty_register_device(tty3270_driver, index, 0);
+		tty_register_device(tty3270_driver, index, NULL);
 	else
 		tty_unregister_device(tty3270_driver, index);
 }
@@ -1823,7 +1823,7 @@ tty3270_exit(void)
 
 	raw3270_unregister_notifier(tty3270_notifier);
 	driver = tty3270_driver;
-	tty3270_driver = 0;
+	tty3270_driver = NULL;
 	tty_unregister_driver(driver);
 	tty3270_del_views();
 }
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index b2d75de..4d8a185 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -86,7 +86,7 @@ struct vmlogrdr_priv_t {
  */
 static int vmlogrdr_open(struct inode *, struct file *);
 static int vmlogrdr_release(struct inode *, struct file *);
-static ssize_t vmlogrdr_read (struct file *filp, char *data, size_t count,
+static ssize_t vmlogrdr_read (struct file *filp, char __user *data, size_t count,
 			       loff_t * ppos);
 
 static struct file_operations vmlogrdr_fops = {
@@ -515,7 +515,7 @@ vmlogrdr_receive_data(struct vmlogrdr_pr
 
 
 static ssize_t
-vmlogrdr_read (struct file *filp, char *data, size_t count, loff_t * ppos)
+vmlogrdr_read (struct file *filp, char __user *data, size_t count, loff_t * ppos)
 {
 	int rc;
 	struct vmlogrdr_priv_t * priv = filp->private_data;
diff --git a/drivers/s390/char/vmwatchdog.c b/drivers/s390/char/vmwatchdog.c
index 5acc0ac..807320a 100644
--- a/drivers/s390/char/vmwatchdog.c
+++ b/drivers/s390/char/vmwatchdog.c
@@ -193,7 +193,7 @@ static int vmwdt_ioctl(struct inode *i, 
 		return 0;
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, (int *)arg);
+		return put_user(0, (int __user *)arg);
 	case WDIOC_GETTEMP:
 		return -EINVAL;
 	case WDIOC_SETOPTIONS:
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 8013c8e..f15df6b 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -320,7 +320,7 @@ ccwgroup_online_store (struct device *de
 	if (!try_module_get(gdrv->owner))
 		return -EINVAL;
 
-	value = simple_strtoul(buf, 0, 0);
+	value = simple_strtoul(buf, NULL, 0);
 	ret = count;
 	if (value == 1)
 		ccwgroup_set_online(gdev);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index cbb86fa..f4d169e 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -798,7 +798,7 @@ struct subchannel *
 cio_get_console_subchannel(void)
 {
 	if (!console_subchannel_in_use)
-		return 0;
+		return NULL;
 	return &console_subchannel;
 }
 
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 07ef3f6..c3c847b 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -258,7 +258,7 @@ static int set_schib_wait(struct ccw_dev
 		spin_lock_irq(cdev->ccwlock);
 		if (s.ret == 1) {
 			s.ret = -ERESTARTSYS;
-			cdev->private->cmb_wait = 0;
+			cdev->private->cmb_wait = NULL;
 			if (cdev->private->state == DEV_STATE_CMFCHANGE)
 				cdev->private->state = DEV_STATE_ONLINE;
 		}
@@ -276,7 +276,7 @@ void retry_set_schib(struct ccw_device *
 	struct set_schib_struct *s;
 
 	s = cdev->private->cmb_wait;
-	cdev->private->cmb_wait = 0;
+	cdev->private->cmb_wait = NULL;
 	if (!s) {
 		WARN_ON(1);
 		return;
@@ -876,7 +876,7 @@ static struct attribute *cmf_attributes[
 	&dev_attr_avg_device_disconnect_time.attr,
 	&dev_attr_avg_control_unit_queuing_time.attr,
 	&dev_attr_avg_device_active_only_time.attr,
-	0,
+	NULL,
 };
 
 static struct attribute_group cmf_attr_group = {
@@ -896,7 +896,7 @@ static struct attribute *cmf_attributes_
 	&dev_attr_avg_device_active_only_time.attr,
 	&dev_attr_avg_device_busy_time.attr,
 	&dev_attr_avg_initial_command_response_time.attr,
-	0,
+	NULL,
 };
 
 static struct attribute_group cmf_attr_group_ext = {
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 062fb10..2d08cf8 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -101,7 +101,7 @@ ccw_uevent (struct device *dev, char **e
 	if ((buffer_size - length <= 0) || (i >= num_envp))
 		return -ENOMEM;
 
-	envp[i] = 0;
+	envp[i] = NULL;
 
 	return 0;
 }
@@ -1060,7 +1060,7 @@ get_ccwdev_by_busid(struct ccw_driver *c
 				 __ccwdev_check_busid);
 	put_driver(drv);
 
-	return dev ? to_ccwdev(dev) : 0;
+	return dev ? to_ccwdev(dev) : NULL;
 }
 
 /************************** device driver handling ************************/
@@ -1085,7 +1085,7 @@ ccw_device_probe (struct device *dev)
 	ret = cdrv->probe ? cdrv->probe(cdev) : -ENODEV;
 
 	if (ret) {
-		cdev->drv = 0;
+		cdev->drv = NULL;
 		return ret;
 	}
 
@@ -1116,7 +1116,7 @@ ccw_device_remove (struct device *dev)
 				 ret, cdev->dev.bus_id);
 	}
 	ccw_device_set_timeout(cdev, 0);
-	cdev->drv = 0;
+	cdev->drv = NULL;
 	return 0;
 }
 
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 45ce032..af4b2b9 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -2728,7 +2728,7 @@ qdio_free(struct ccw_device *cdev)
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
-	cdev->private->qdio_data = 0;
+	cdev->private->qdio_data = NULL;
 
 	up(&irq_ptr->setting_up_sema);
 
diff --git a/drivers/s390/crypto/z90hardware.c b/drivers/s390/crypto/z90hardware.c
index 4141919..68a30cd 100644
--- a/drivers/s390/crypto/z90hardware.c
+++ b/drivers/s390/crypto/z90hardware.c
@@ -2374,7 +2374,7 @@ convert_response(unsigned char *response
 	struct CPRB *cprb_p;
 	struct CPRBX *cprbx_p;
 
-	src_p = 0;
+	src_p = NULL;
 	reply_code = 0;
 	service_rc = 0;
 	service_rs = 0;
diff --git a/drivers/s390/crypto/z90main.c b/drivers/s390/crypto/z90main.c
index 7d6f190..47b814e 100644
--- a/drivers/s390/crypto/z90main.c
+++ b/drivers/s390/crypto/z90main.c
@@ -613,10 +613,10 @@ z90crypt_init_module(void)
 	add_timer(&cleanup_timer);
 
 	/* Set up the proc file system */
-	entry = create_proc_entry("driver/z90crypt", 0644, 0);
+	entry = create_proc_entry("driver/z90crypt", 0644, NULL);
 	if (entry) {
 		entry->nlink = 1;
-		entry->data = 0;
+		entry->data = NULL;
 		entry->read_proc = z90crypt_status;
 		entry->write_proc = z90crypt_status_write;
 	}
@@ -660,7 +660,7 @@ z90crypt_cleanup_module(void)
 
 	PDEBUG("PID %d\n", PID());
 
-	remove_proc_entry("driver/z90crypt", 0);
+	remove_proc_entry("driver/z90crypt", NULL);
 
 	if ((nresult = misc_deregister(&z90crypt_misc_device)))
 		PRINTK("misc_deregister failed with %d.\n", nresult);
@@ -1913,7 +1913,7 @@ z90crypt_unlocked_ioctl(struct file *fil
 		}
 
 		tempstat = get_status_PCIXCCcount();
-		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) != 0)
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) != 0)
 			ret = -EFAULT;
 		break;
 
@@ -2222,7 +2222,7 @@ receive_from_crypto_device(int index, un
 	if (z90crypt.terminating)
 		return REC_FATAL_ERROR;
 
-	caller_p = 0;
+	caller_p = NULL;
 	dev_ptr = z90crypt.device_p[index];
 	rv = 0;
 	do {
@@ -2286,7 +2286,7 @@ receive_from_crypto_device(int index, un
 					break;
 				}
 			}
-			caller_p = 0;
+			caller_p = NULL;
 		}
 		if (!caller_p) {
 			PRINTKW("Unable to locate PSMID %02X%02X%02X%02X%02X"
@@ -2406,7 +2406,7 @@ helper_handle_work_element(int index, un
 	struct work_element *pq_p;
 	struct list_head *lptr, *tptr;
 
-	pq_p = 0;
+	pq_p = NULL;
 	list_for_each_safe(lptr, tptr, &pending_list) {
 		pq_p = list_entry(lptr, struct work_element, liste);
 		if (!memcmp(pq_p->caller_id, psmid, sizeof(pq_p->caller_id))) {
@@ -2415,7 +2415,7 @@ helper_handle_work_element(int index, un
 			pq_p->audit[1] |= FP_NOTPENDING;
 			break;
 		}
-		pq_p = 0;
+		pq_p = NULL;
 	}
 
 	if (!pq_p) {
@@ -2519,7 +2519,7 @@ z90crypt_reader_task(unsigned long ptr)
 	 * exiting the loop. If (pendingq_count+requestq_count) == 0 after the
 	 * loop, there is no work remaining on the queues.
 	 */
-	resp_addr = 0;
+	resp_addr = NULL;
 	workavail = 2;
 	buff_len = 0;
 	while (workavail) {
@@ -3085,7 +3085,7 @@ destroy_crypto_device(int index)
 		disabledFlag = 0;
 		t = -1;
 	}
-	z90crypt.device_p[index] = 0;
+	z90crypt.device_p[index] = NULL;
 
 	/* if the type is valid, remove the device from the type_mask */
 	if ((t != -1) && z90crypt.hdware_info->type_mask[t].st_mask[index]) {
diff --git a/drivers/s390/net/ctctty.c b/drivers/s390/net/ctctty.c
index 5cdcdbf..98f2669 100644
--- a/drivers/s390/net/ctctty.c
+++ b/drivers/s390/net/ctctty.c
@@ -1037,7 +1037,7 @@ ctc_tty_close(struct tty_struct *tty, st
 		info->lsr |= UART_LSR_TEMT;
 	}
 	tty_ldisc_flush(tty);
-	info->tty = 0;
+	info->tty = NULL;
 	tty->closing = 0;
 	if (info->blocked_open) {
 		msleep_interruptible(500);
@@ -1066,7 +1066,7 @@ ctc_tty_hangup(struct tty_struct *tty)
 	info->count = 0;
 	info->flags &= ~CTC_ASYNC_NORMAL_ACTIVE;
 	spin_lock_irqsave(&ctc_tty_lock, saveflags);
-	info->tty = 0;
+	info->tty = NULL;
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
 	wake_up_interruptible(&info->open_wait);
 }
@@ -1160,7 +1160,7 @@ ctc_tty_init(void)
 				(unsigned long) info);
 		info->magic = CTC_ASYNC_MAGIC;
 		info->line = i;
-		info->tty = 0;
+		info->tty = NULL;
 		info->count = 0;
 		info->blocked_open = 0;
 		init_waitqueue_head(&info->open_wait);
diff --git a/drivers/s390/net/iucv.c b/drivers/s390/net/iucv.c
index 760e77e..1be89b9 100644
--- a/drivers/s390/net/iucv.c
+++ b/drivers/s390/net/iucv.c
@@ -695,7 +695,7 @@ iucv_retrieve_buffer (void)
 	iucv_debug(1, "entering");
 	if (iucv_cpuid != -1) {
 		smp_call_function_on(iucv_retrieve_buffer_cpuid,
-				     0, 0, 1, iucv_cpuid);
+				     NULL, 0, 1, iucv_cpuid);
 		/* Release the cpu reserved by iucv_declare_buffer. */
 		smp_put_cpu(iucv_cpuid);
 		iucv_cpuid = -1;
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 410abea..3ba3e13 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -4823,7 +4823,7 @@ static struct qeth_cmd_buffer *
 qeth_get_setassparms_cmd(struct qeth_card *, enum qeth_ipa_funcs,
 			 __u16, __u16, enum qeth_prot_versions);
 static int
-qeth_arp_query(struct qeth_card *card, char *udata)
+qeth_arp_query(struct qeth_card *card, char __user *udata)
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_arp_query_info qinfo = {0, };
@@ -4957,7 +4957,7 @@ qeth_get_adapter_cmd(struct qeth_card *c
  * function to send SNMP commands to OSA-E card
  */
 static int
-qeth_snmp_command(struct qeth_card *card, char *udata)
+qeth_snmp_command(struct qeth_card *card, char __user *udata)
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
@@ -7955,9 +7955,9 @@ qeth_set_online(struct ccwgroup_device *
 }
 
 static struct ccw_device_id qeth_ids[] = {
-	{CCW_DEVICE(0x1731, 0x01), driver_info:QETH_CARD_TYPE_OSAE},
-	{CCW_DEVICE(0x1731, 0x05), driver_info:QETH_CARD_TYPE_IQD},
-	{CCW_DEVICE(0x1731, 0x06), driver_info:QETH_CARD_TYPE_OSN},
+	{CCW_DEVICE(0x1731, 0x01), .driver_info = QETH_CARD_TYPE_OSAE},
+	{CCW_DEVICE(0x1731, 0x05), .driver_info = QETH_CARD_TYPE_IQD},
+	{CCW_DEVICE(0x1731, 0x06), .driver_info = QETH_CARD_TYPE_OSN},
 	{},
 };
 MODULE_DEVICE_TABLE(ccw, qeth_ids);
@@ -8427,7 +8427,7 @@ out:
 
 static struct notifier_block qeth_ip_notifier = {
 	qeth_ip_event,
-	0
+	NULL
 };
 
 #ifdef CONFIG_QETH_IPV6
@@ -8480,7 +8480,7 @@ out:
 
 static struct notifier_block qeth_ip6_notifier = {
 	qeth_ip6_event,
-	0
+	NULL
 };
 #endif
 
@@ -8507,7 +8507,7 @@ qeth_reboot_event(struct notifier_block 
 
 static struct notifier_block qeth_reboot_notifier = {
 	qeth_reboot_event,
-	0
+	NULL
 };
 
 static int
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
index c1831f5..e821599 100644
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
@@ -1756,7 +1756,7 @@ qeth_driver_group_store(struct device_dr
 }
 
 
-static DRIVER_ATTR(group, 0200, 0, qeth_driver_group_store);
+static DRIVER_ATTR(group, 0200, NULL, qeth_driver_group_store);
 
 static ssize_t
 qeth_driver_notifier_register_store(struct device_driver *ddrv, const char *buf,
@@ -1784,7 +1784,7 @@ qeth_driver_notifier_register_store(stru
 	return count;
 }
 
-static DRIVER_ATTR(notifier_register, 0200, 0,
+static DRIVER_ATTR(notifier_register, 0200, NULL,
 		   qeth_driver_notifier_register_store);
 
 int
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index d6469ba..5d95e9c 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -66,7 +66,7 @@ smsg_message_pending(iucv_MessagePending
 		return;
 	}
 	rc = iucv_receive(eib->ippathid, eib->ipmsgid, eib->iptrgcls,
-			  msg, len, 0, 0, 0);
+			  msg, len, NULL, NULL, NULL);
 	if (rc == 0) {
 		msg[len] = 0;
 		EBCASC(msg, len);
@@ -122,7 +122,7 @@ smsg_unregister_callback(char *prefix, v
 	struct smsg_callback *cb, *tmp;
 
 	spin_lock(&smsg_list_lock);
-	cb = 0;
+	cb = NULL;
 	list_for_each_entry(tmp, &smsg_list, list)
 		if (tmp->callback == callback &&
 		    strcmp(tmp->prefix, prefix) == 0) {
@@ -139,7 +139,7 @@ smsg_exit(void)
 {
 	if (smsg_handle > 0) {
 		cpcmd("SET SMSG OFF", NULL, 0, NULL);
-		iucv_sever(smsg_pathid, 0);
+		iucv_sever(smsg_pathid, NULL);
 		iucv_unregister_program(smsg_handle);
 		driver_unregister(&smsg_driver);
 	}
@@ -162,19 +162,19 @@ smsg_init(void)
 		return rc;
 	}
 	smsg_handle = iucv_register_program("SMSGIUCV        ", "*MSG    ",
-					    pgmmask, &smsg_ops, 0);
+					    pgmmask, &smsg_ops, NULL);
 	if (!smsg_handle) {
 		printk(KERN_ERR "SMSGIUCV: failed to register to iucv");
 		driver_unregister(&smsg_driver);
 		return -EIO;	/* better errno ? */
 	}
-	rc = iucv_connect (&smsg_pathid, 1, 0, "*MSG    ", 0, 0, 0, 0,
-			   smsg_handle, 0);
+	rc = iucv_connect (&smsg_pathid, 1, NULL, "*MSG    ", NULL, 0, NULL,
+			   NULL, smsg_handle, NULL);
 	if (rc) {
 		printk(KERN_ERR "SMSGIUCV: failed to connect to *MSG");
 		iucv_unregister_program(smsg_handle);
 		driver_unregister(&smsg_driver);
-		smsg_handle = 0;
+		smsg_handle = NULL;
 		return -EIO;
 	}
 	cpcmd("SET SMSG IUCV", NULL, 0, NULL);
diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index da947e6..f30bc64 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -2124,7 +2124,7 @@ zfcp_erp_adapter_strategy_open_qdio(stru
 		sbale = &(adapter->response_queue.buffer[i]->element[0]);
 		sbale->length = 0;
 		sbale->flags = SBAL_FLAGS_LAST_ENTRY;
-		sbale->addr = 0;
+		sbale->addr = NULL;
 	}
 
 	ZFCP_LOG_TRACE("calling do_QDIO on adapter %s (flags=0x%x, "
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 9f0cb3d..26b4f8e 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2241,7 +2241,7 @@ zfcp_fsf_exchange_port_data(struct zfcp_
 	/* setup new FSF request */
 	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_EXCHANGE_PORT_DATA,
 				     erp_action ? ZFCP_REQ_AUTO_CLEANUP : 0,
-				     0, &lock_flags, &fsf_req);
+				     NULL, &lock_flags, &fsf_req);
 	if (retval < 0) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
                               "exchange port data request for"
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index e080375..c73bc9f 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -54,30 +54,30 @@ struct scsi_transport_template *zfcp_tra
 
 struct zfcp_data zfcp_data = {
 	.scsi_host_template = {
-	      name:	               ZFCP_NAME,
-	      proc_name:               "zfcp",
-	      proc_info:               NULL,
-	      detect:	               NULL,
-	      slave_alloc:             zfcp_scsi_slave_alloc,
-	      slave_configure:         zfcp_scsi_slave_configure,
-	      slave_destroy:           zfcp_scsi_slave_destroy,
-	      queuecommand:            zfcp_scsi_queuecommand,
-	      eh_abort_handler:        zfcp_scsi_eh_abort_handler,
-	      eh_device_reset_handler: zfcp_scsi_eh_device_reset_handler,
-	      eh_bus_reset_handler:    zfcp_scsi_eh_bus_reset_handler,
-	      eh_host_reset_handler:   zfcp_scsi_eh_host_reset_handler,
+	      .name =	               ZFCP_NAME,
+	      .proc_name =             "zfcp",
+	      .proc_info =             NULL,
+	      .detect =	               NULL,
+	      .slave_alloc =           zfcp_scsi_slave_alloc,
+	      .slave_configure =       zfcp_scsi_slave_configure,
+	      .slave_destroy =         zfcp_scsi_slave_destroy,
+	      .queuecommand =          zfcp_scsi_queuecommand,
+	      .eh_abort_handler =      zfcp_scsi_eh_abort_handler,
+	      .eh_device_reset_handler = zfcp_scsi_eh_device_reset_handler,
+	      .eh_bus_reset_handler =  zfcp_scsi_eh_bus_reset_handler,
+	      .eh_host_reset_handler = zfcp_scsi_eh_host_reset_handler,
 			               /* FIXME(openfcp): Tune */
-	      can_queue:               4096,
-	      this_id:	               0,
+	      .can_queue =             4096,
+	      .this_id =               0,
 	      /*
 	       * FIXME:
 	       * one less? can zfcp_create_sbale cope with it?
 	       */
-	      sg_tablesize:            ZFCP_MAX_SBALES_PER_REQ,
-	      cmd_per_lun:             1,
-	      unchecked_isa_dma:       0,
-	      use_clustering:          1,
-	      sdev_attrs:              zfcp_sysfs_sdev_attrs,
+	      .sg_tablesize =          ZFCP_MAX_SBALES_PER_REQ,
+	      .cmd_per_lun =           1,
+	      .unchecked_isa_dma =     0,
+	      .use_clustering =        1,
+	      .sdev_attrs =            zfcp_sysfs_sdev_attrs,
 	},
 	.driver_version = ZFCP_VERSION,
 	/* rest initialised with zeros */
-- 
0.99.9.GIT

