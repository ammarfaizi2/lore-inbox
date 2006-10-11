Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWJKNgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWJKNgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWJKNgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:36:21 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:50870 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751306AbWJKNgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:36:18 -0400
Date: Wed, 11 Oct 2006 15:36:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: remove casts from/to (void *).
Message-ID: <20061011133615.GF9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: remove casts from/to (void *).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |    6 +++---
 drivers/s390/cio/css.c        |    2 +-
 drivers/s390/cio/device.c     |   16 ++++++++--------
 drivers/s390/cio/device_fsm.c |   28 ++++++++++++++--------------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-10-11 15:23:39.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-10-11 15:23:39.000000000 +0200
@@ -370,7 +370,7 @@ __s390_process_res_acc(struct subchannel
 	struct res_acc_data *res_data;
 	struct subchannel *sch;
 
-	res_data = (struct res_acc_data *)data;
+	res_data = data;
 	sch = get_subchannel_by_schid(schid);
 	if (!sch)
 		/* Check if a subchannel is newly available. */
@@ -444,7 +444,7 @@ __get_chpid_from_lir(void *data)
 		u32 isinfo[28];
 	} *lir;
 
-	lir = (struct lir*) data;
+	lir = data;
 	if (!(lir->iq&0x80))
 		/* NULL link incident record */
 		return -EINVAL;
@@ -628,7 +628,7 @@ __chp_add(struct subchannel_id schid, vo
 	struct channel_path *chp;
 	struct subchannel *sch;
 
-	chp = (struct channel_path *)data;
+	chp = data;
 	sch = get_subchannel_by_schid(schid);
 	if (!sch)
 		/* Check if the subchannel is now available. */
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-10-11 15:23:39.000000000 +0200
@@ -177,7 +177,7 @@ get_subchannel_by_schid(struct subchanne
 	struct device *dev;
 
 	dev = bus_find_device(&css_bus_type, NULL,
-			      (void *)&schid, check_subchannel);
+			      &schid, check_subchannel);
 
 	return dev ? to_subchannel(dev) : NULL;
 }
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-10-11 15:23:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-10-11 15:23:39.000000000 +0200
@@ -591,7 +591,7 @@ ccw_device_add_changed(void *data)
 
 	struct ccw_device *cdev;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	if (device_add(&cdev->dev)) {
 		put_device(&cdev->dev);
 		return;
@@ -612,7 +612,7 @@ ccw_device_do_unreg_rereg(void *data)
 	struct subchannel *sch;
 	int need_rename;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 	if (cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		/*
@@ -660,7 +660,7 @@ ccw_device_do_unreg_rereg(void *data)
 		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
 			  sch->schid.ssid, sch->schib.pmcw.dev);
 	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_add_changed, (void *)cdev);
+		     ccw_device_add_changed, cdev);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
 }
 
@@ -685,7 +685,7 @@ io_subchannel_register(void *data)
 	int ret;
 	unsigned long flags;
 
-	cdev = (struct ccw_device *) data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 
 	if (klist_node_attached(&cdev->dev.knode_parent)) {
@@ -757,7 +757,7 @@ io_subchannel_recog_done(struct ccw_devi
 			break;
 		sch = to_subchannel(cdev->dev.parent);
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, (void *) cdev);
+			     ccw_device_call_sch_unregister, cdev);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -772,7 +772,7 @@ io_subchannel_recog_done(struct ccw_devi
 		if (!get_device(&cdev->dev))
 			break;
 		PREPARE_WORK(&cdev->private->kick_work,
-			     io_subchannel_register, (void *) cdev);
+			     io_subchannel_register, cdev);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		break;
 	}
@@ -910,7 +910,7 @@ io_subchannel_remove (struct subchannel 
 	 */
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_unregister, (void *) cdev);
+			     ccw_device_unregister, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	return 0;
@@ -1053,7 +1053,7 @@ __ccwdev_check_busid(struct device *dev,
 {
 	char *bus_id;
 
-	bus_id = (char *)id;
+	bus_id = id;
 
 	return (strncmp(bus_id, dev->bus_id, BUS_ID_SIZE) == 0);
 }
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:39.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:39.000000000 +0200
@@ -173,7 +173,7 @@ ccw_device_handle_oper(struct ccw_device
 	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
 	    cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unreg_rereg, (void *)cdev);
+			     ccw_device_do_unreg_rereg, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		return 0;
 	}
@@ -314,13 +314,13 @@ ccw_device_oper_notify(void *data)
 	struct subchannel *sch;
 	int ret;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 	ret = (sch->driver && sch->driver->notify) ?
 		sch->driver->notify(&sch->dev, CIO_OPER) : 0;
 	if (!ret)
 		/* Driver doesn't want device back. */
-		ccw_device_do_unreg_rereg((void *)cdev);
+		ccw_device_do_unreg_rereg(cdev);
 	else {
 		/* Reenable channel measurements, if needed. */
 		cmf_reenable(cdev);
@@ -357,7 +357,7 @@ ccw_device_done(struct ccw_device *cdev,
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify,
-			     (void *)cdev);
+			     cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -513,7 +513,7 @@ ccw_device_nopath_notify(void *data)
 	struct subchannel *sch;
 	int ret;
 
-	cdev = (struct ccw_device *)data;
+	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
 	/* Extra sanity. */
 	if (sch->lpm)
@@ -527,7 +527,7 @@ ccw_device_nopath_notify(void *data)
 			if (get_device(&cdev->dev)) {
 				PREPARE_WORK(&cdev->private->kick_work,
 					     ccw_device_call_sch_unregister,
-					     (void *)cdev);
+					     cdev);
 				queue_work(ccw_device_work,
 					   &cdev->private->kick_work);
 			} else
@@ -582,7 +582,7 @@ ccw_device_verify_done(struct ccw_device
 		break;
 	default:
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
+			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
@@ -713,7 +713,7 @@ ccw_device_offline_notoper(struct ccw_de
 	sch = to_subchannel(cdev->dev.parent);
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, (void *)cdev);
+			     ccw_device_call_sch_unregister, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -744,7 +744,7 @@ ccw_device_online_notoper(struct ccw_dev
 	}
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, (void *)cdev);
+			     ccw_device_call_sch_unregister, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -849,7 +849,7 @@ ccw_device_online_timeout(struct ccw_dev
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, (void *)cdev);
+				     ccw_device_nopath_notify, cdev);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -938,7 +938,7 @@ ccw_device_killing_irq(struct ccw_device
 			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
+			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		/* Start delayed path verification. */
@@ -961,7 +961,7 @@ ccw_device_killing_timeout(struct ccw_de
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, (void *)cdev);
+				     ccw_device_nopath_notify, cdev);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -990,7 +990,7 @@ void device_kill_io(struct subchannel *s
 	if (ret == -ENODEV) {
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, (void *)cdev);
+				     ccw_device_nopath_notify, cdev);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -1002,7 +1002,7 @@ void device_kill_io(struct subchannel *s
 			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
+			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else
 		/* Start delayed path verification. */
