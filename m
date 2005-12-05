Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVLEFrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVLEFrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLEFru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:47:50 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:62627 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751215AbVLEFrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:47:49 -0500
Date: Mon, 5 Dec 2005 06:47:47 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051205055256.14897.48586.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
References: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 2/3] s390: Replace driver_data with dev_[gs]et_drvdata
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace (found) dev->driver_data with dev_[gs]et_drvdata().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 block/dasd_devmap.c |    2
 char/raw3270.c      |    6 +-
 char/tape_core.c    |   10 ++--
 char/vmlogrdr.c     |   14 ++---
 cio/device.c        |   14 ++---
 net/claw.c          |   20 ++++----
 net/ctcmain.c       |   12 ++--
 net/lcs.c           |    8 +--
 net/netiucv.c       |   46 +++++++++---------
 net/qeth_main.c     |    2
 net/qeth_proc.c     |    6 +-
 net/qeth_sys.c      |  130 ++++++++++++++++++++++++++--------------------------
 12 files changed, 135 insertions(+), 135 deletions(-)

diff -Narup a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
--- a/drivers/s390/block/dasd_devmap.c	2005-12-02 14:57:55.000000000 +0100
+++ b/drivers/s390/block/dasd_devmap.c	2005-12-02 15:04:32.000000000 +0100
@@ -707,7 +707,7 @@ dasd_discipline_show(struct device *dev,
 
 	spin_lock(&dasd_devmap_lock);
 	dname = "none";
-	devmap = dev->driver_data;
+	devmap = dev_get_drvdata(dev);
 	if (devmap && devmap->device && devmap->device->discipline)
 		dname = devmap->device->discipline->name;
 	spin_unlock(&dasd_devmap_lock);
diff -Narup a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
--- a/drivers/s390/char/tape_core.c	2005-12-02 14:36:11.000000000 +0100
+++ b/drivers/s390/char/tape_core.c	2005-12-02 14:41:38.000000000 +0100
@@ -112,7 +112,7 @@ tape_medium_state_show(struct device *de
 {
 	struct tape_device *tdev;
 
-	tdev = (struct tape_device *) dev->driver_data;
+	tdev = dev_get_drvdata(dev);
 	return scnprintf(buf, PAGE_SIZE, "%i\n", tdev->medium_state);
 }
 
@@ -124,7 +124,7 @@ tape_first_minor_show(struct device *dev
 {
 	struct tape_device *tdev;
 
-	tdev = (struct tape_device *) dev->driver_data;
+	tdev = dev_get_drvdata(dev);
 	return scnprintf(buf, PAGE_SIZE, "%i\n", tdev->first_minor);
 }
 
@@ -136,7 +136,7 @@ tape_state_show(struct device *dev, stru
 {
 	struct tape_device *tdev;
 
-	tdev = (struct tape_device *) dev->driver_data;
+	tdev = dev_get_drvdata(dev);
 	return scnprintf(buf, PAGE_SIZE, "%s\n", (tdev->first_minor < 0) ?
 		"OFFLINE" : tape_state_verbose[tdev->tape_state]);
 }
@@ -150,7 +150,7 @@ tape_operation_show(struct device *dev, 
 	struct tape_device *tdev;
 	ssize_t rc;
 
-	tdev = (struct tape_device *) dev->driver_data;
+	tdev = dev_get_drvdata(dev);
 	if (tdev->first_minor < 0)
 		return scnprintf(buf, PAGE_SIZE, "N/A\n");
 
@@ -176,7 +176,7 @@ tape_blocksize_show(struct device *dev, 
 {
 	struct tape_device *tdev;
 
-	tdev = (struct tape_device *) dev->driver_data;
+	tdev = dev_get_drvdata(dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%i\n", tdev->char_data.block_size);
 }
diff -Narup a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
--- a/drivers/s390/char/raw3270.c	2005-12-02 15:07:48.000000000 +0100
+++ b/drivers/s390/char/raw3270.c	2005-12-02 15:10:37.000000000 +0100
@@ -1142,7 +1142,7 @@ static ssize_t
 raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev->driver_data)->model);
+			((struct raw3270 *) dev_get_drvdata(dev))->model);
 }
 static DEVICE_ATTR(model, 0444, raw3270_model_show, 0);
 
@@ -1150,7 +1150,7 @@ static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev->driver_data)->rows);
+			((struct raw3270 *) dev_get_drvdata(dev))->rows);
 }
 static DEVICE_ATTR(rows, 0444, raw3270_rows_show, 0);
 
@@ -1158,7 +1158,7 @@ static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%i\n",
-			((struct raw3270 *) dev->driver_data)->cols);
+			((struct raw3270 *) dev_get_drvdata(dev))->cols);
 }
 static DEVICE_ATTR(columns, 0444, raw3270_columns_show, 0);
 
diff -Narup a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
--- a/drivers/s390/char/vmlogrdr.c	2005-12-02 14:51:26.000000000 +0100
+++ b/drivers/s390/char/vmlogrdr.c	2005-12-02 15:57:50.000000000 +0100
@@ -549,7 +549,7 @@ vmlogrdr_read (struct file *filp, char *
 
 static ssize_t
 vmlogrdr_autopurge_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t count) {
-	struct vmlogrdr_priv_t *priv = dev->driver_data;
+	struct vmlogrdr_priv_t *priv = dev_get_drvdata(dev);
 	ssize_t ret = count;
 
 	switch (buf[0]) {
@@ -568,7 +568,7 @@ vmlogrdr_autopurge_store(struct device *
 
 static ssize_t
 vmlogrdr_autopurge_show(struct device *dev, struct device_attribute *attr, char *buf) {
-	struct vmlogrdr_priv_t *priv = dev->driver_data;
+	struct vmlogrdr_priv_t *priv = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", priv->autopurge);
 }
 
@@ -582,7 +582,7 @@ vmlogrdr_purge_store(struct device * dev
 
 	char cp_command[80];
 	char cp_response[80];
-	struct vmlogrdr_priv_t *priv = dev->driver_data;
+	struct vmlogrdr_priv_t *priv = dev_get_drvdata(dev);
 
 	if (buf[0] != '1')
 		return -EINVAL;
@@ -621,7 +621,7 @@ static DEVICE_ATTR(purge, 0200, NULL, vm
 static ssize_t
 vmlogrdr_autorecording_store(struct device *dev, struct device_attribute *attr, const char *buf,
 			     size_t count) {
-	struct vmlogrdr_priv_t *priv = dev->driver_data;
+	struct vmlogrdr_priv_t *priv = dev_get_drvdata(dev);
 	ssize_t ret = count;
 
 	switch (buf[0]) {
@@ -640,7 +640,7 @@ vmlogrdr_autorecording_store(struct devi
 
 static ssize_t
 vmlogrdr_autorecording_show(struct device *dev, struct device_attribute *attr, char *buf) {
-	struct vmlogrdr_priv_t *priv = dev->driver_data;
+	struct vmlogrdr_priv_t *priv = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", priv->autorecording);
 }
 
@@ -652,7 +652,7 @@ static DEVICE_ATTR(autorecording, 0644, 
 static ssize_t
 vmlogrdr_recording_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t count) {
 
-	struct vmlogrdr_priv_t *priv = dev->driver_data;
+	struct vmlogrdr_priv_t *priv = dev_get_drvdata(dev);
 	ssize_t ret;
 
 	switch (buf[0]) {
@@ -799,7 +799,7 @@ vmlogrdr_register_device(struct vmlogrdr
 		device_unregister(dev);
 		return ret;
 	}
-	dev->driver_data = priv;
+	dev_set_drvdata(dev, priv);
 	priv->device = dev;
 	return 0;
 }
diff -Narup a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
--- a/drivers/s390/cio/device.c	2005-12-02 14:06:22.000000000 +0100
+++ b/drivers/s390/cio/device.c	2005-12-02 14:10:53.000000000 +0100
@@ -882,12 +882,12 @@ io_subchannel_remove (struct device *dev
 	struct ccw_device *cdev;
 	unsigned long flags;
 
-	if (!dev->driver_data)
+	if (!dev_get_drvdata(dev))
 		return 0;
-	cdev = dev->driver_data;
+	cdev = dev_get_drvdata(dev);
 	/* Set ccw device to not operational and drop reference. */
 	spin_lock_irqsave(cdev->ccwlock, flags);
-	dev->driver_data = NULL;
+	dev_set_drvdata(dev, NULL);
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 	/*
@@ -907,7 +907,7 @@ io_subchannel_notify(struct device *dev,
 {
 	struct ccw_device *cdev;
 
-	cdev = dev->driver_data;
+	cdev = dev_get_drvdata(dev);
 	if (!cdev)
 		return 0;
 	if (!cdev->drv)
@@ -922,7 +922,7 @@ io_subchannel_verify(struct device *dev)
 {
 	struct ccw_device *cdev;
 
-	cdev = dev->driver_data;
+	cdev = dev_get_drvdata(dev);
 	if (cdev)
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
 }
@@ -932,7 +932,7 @@ io_subchannel_ioterm(struct device *dev)
 {
 	struct ccw_device *cdev;
 
-	cdev = dev->driver_data;
+	cdev = dev_get_drvdata(dev);
 	if (!cdev)
 		return;
 	cdev->private->state = DEV_STATE_CLEAR_VERIFY;
@@ -949,7 +949,7 @@ io_subchannel_shutdown(struct device *de
 	int ret;
 
 	sch = to_subchannel(dev);
-	cdev = dev->driver_data;
+	cdev = dev_get_drvdata(dev);
 
 	if (cio_is_console(sch->irq))
 		return;
diff -Narup a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
--- a/drivers/s390/net/netiucv.c	2005-12-02 13:32:18.000000000 +0100
+++ b/drivers/s390/net/netiucv.c	2005-12-02 16:01:04.000000000 +0100
@@ -1358,7 +1358,7 @@ netiucv_change_mtu (struct net_device * 
 static ssize_t
 user_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%s\n", netiucv_printname(priv->conn->userid));
@@ -1367,7 +1367,7 @@ user_show (struct device *dev, struct de
 static ssize_t
 user_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	struct net_device *ndev = priv->conn->netdev;
 	char    *p;
 	char    *tmp;
@@ -1424,7 +1424,7 @@ static DEVICE_ATTR(user, 0644, user_show
 static ssize_t
 buffer_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%d\n", priv->conn->max_buffsize);
@@ -1433,7 +1433,7 @@ buffer_show (struct device *dev, struct 
 static ssize_t
 buffer_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	struct net_device *ndev = priv->conn->netdev;
 	char         *e;
 	int          bs1;
@@ -1488,7 +1488,7 @@ static DEVICE_ATTR(buffer, 0644, buffer_
 static ssize_t
 dev_fsm_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%s\n", fsm_getstate_str(priv->fsm));
@@ -1499,7 +1499,7 @@ static DEVICE_ATTR(device_fsm_state, 044
 static ssize_t
 conn_fsm_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%s\n", fsm_getstate_str(priv->conn->fsm));
@@ -1510,7 +1510,7 @@ static DEVICE_ATTR(connection_fsm_state,
 static ssize_t
 maxmulti_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.maxmulti);
@@ -1519,7 +1519,7 @@ maxmulti_show (struct device *dev, struc
 static ssize_t
 maxmulti_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.maxmulti = 0;
@@ -1531,7 +1531,7 @@ static DEVICE_ATTR(max_tx_buffer_used, 0
 static ssize_t
 maxcq_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.maxcqueue);
@@ -1540,7 +1540,7 @@ maxcq_show (struct device *dev, struct d
 static ssize_t
 maxcq_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.maxcqueue = 0;
@@ -1552,7 +1552,7 @@ static DEVICE_ATTR(max_chained_skbs, 064
 static ssize_t
 sdoio_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.doios_single);
@@ -1561,7 +1561,7 @@ sdoio_show (struct device *dev, struct d
 static ssize_t
 sdoio_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.doios_single = 0;
@@ -1573,7 +1573,7 @@ static DEVICE_ATTR(tx_single_write_ops, 
 static ssize_t
 mdoio_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.doios_multi);
@@ -1582,7 +1582,7 @@ mdoio_show (struct device *dev, struct d
 static ssize_t
 mdoio_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	priv->conn->prof.doios_multi = 0;
@@ -1594,7 +1594,7 @@ static DEVICE_ATTR(tx_multi_write_ops, 0
 static ssize_t
 txlen_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.txlen);
@@ -1603,7 +1603,7 @@ txlen_show (struct device *dev, struct d
 static ssize_t
 txlen_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.txlen = 0;
@@ -1615,7 +1615,7 @@ static DEVICE_ATTR(netto_bytes, 0644, tx
 static ssize_t
 txtime_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_time);
@@ -1624,7 +1624,7 @@ txtime_show (struct device *dev, struct 
 static ssize_t
 txtime_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 	
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.tx_time = 0;
@@ -1636,7 +1636,7 @@ static DEVICE_ATTR(max_tx_io_time, 0644,
 static ssize_t
 txpend_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_pending);
@@ -1645,7 +1645,7 @@ txpend_show (struct device *dev, struct 
 static ssize_t
 txpend_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.tx_pending = 0;
@@ -1657,7 +1657,7 @@ static DEVICE_ATTR(tx_pending, 0644, txp
 static ssize_t
 txmpnd_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_max_pending);
@@ -1666,7 +1666,7 @@ txmpnd_show (struct device *dev, struct 
 static ssize_t
 txmpnd_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev_get_drvdata(dev)
 
 	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.tx_max_pending = 0;
@@ -1762,7 +1762,7 @@ netiucv_register_device(struct net_devic
 	if (ret)
 		goto out_unreg;
 	priv->dev = dev;
-	dev->driver_data = priv;
+	dev_set_drvdata(dev, priv);
 	return 0;
 
 out_unreg:
diff -Narup a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
--- a/drivers/s390/net/claw.c	2005-12-02 13:52:30.000000000 +0100
+++ b/drivers/s390/net/claw.c	2005-12-02 13:55:24.000000000 +0100
@@ -4141,7 +4141,7 @@ claw_hname_show(struct device *dev, stru
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4154,7 +4154,7 @@ claw_hname_write(struct device *dev, str
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4178,7 +4178,7 @@ claw_adname_show(struct device *dev, str
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4191,7 +4191,7 @@ claw_adname_write(struct device *dev, st
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4215,7 +4215,7 @@ claw_apname_show(struct device *dev, str
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4229,7 +4229,7 @@ claw_apname_write(struct device *dev, st
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4263,7 +4263,7 @@ claw_wbuff_show(struct device *dev, stru
 	struct claw_privbk *priv;
 	struct claw_env * p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4277,7 +4277,7 @@ claw_wbuff_write(struct device *dev, str
 	struct claw_env *  p_env;
 	int nnn,max;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4304,7 +4304,7 @@ claw_rbuff_show(struct device *dev, stru
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
@@ -4318,7 +4318,7 @@ claw_rbuff_write(struct device *dev, str
 	struct claw_env *p_env;
 	int nnn,max;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev)
 	if (!priv)
 		return -ENODEV;
 	p_env = priv->p_env;
diff -Narup a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
--- a/drivers/s390/net/qeth_sys.c	2005-12-02 12:31:25.000000000 +0100
+++ b/drivers/s390/net/qeth_sys.c	2005-12-02 13:05:55.000000000 +0100
@@ -32,7 +32,7 @@ const char *VERSION_QETH_SYS_C = "$Revis
 static ssize_t
 qeth_dev_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	if (!card)
 		return -EINVAL;
 
@@ -60,7 +60,7 @@ static DEVICE_ATTR(state, 0444, qeth_dev
 static ssize_t
 qeth_dev_chpid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	if (!card)
 		return -EINVAL;
 
@@ -72,7 +72,7 @@ static DEVICE_ATTR(chpid, 0444, qeth_dev
 static ssize_t
 qeth_dev_if_name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	if (!card)
 		return -EINVAL;
 	return sprintf(buf, "%s\n", QETH_CARD_IFNAME(card));
@@ -83,7 +83,7 @@ static DEVICE_ATTR(if_name, 0444, qeth_d
 static ssize_t
 qeth_dev_card_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	if (!card)
 		return -EINVAL;
 
@@ -95,7 +95,7 @@ static DEVICE_ATTR(card_type, 0444, qeth
 static ssize_t
 qeth_dev_portno_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	if (!card)
 		return -EINVAL;
 
@@ -105,7 +105,7 @@ qeth_dev_portno_show(struct device *dev,
 static ssize_t
 qeth_dev_portno_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	unsigned int portno;
 
@@ -131,7 +131,7 @@ static DEVICE_ATTR(portno, 0644, qeth_de
 static ssize_t
 qeth_dev_portname_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char portname[9] = {0, };
 
 	if (!card)
@@ -148,7 +148,7 @@ qeth_dev_portname_show(struct device *de
 static ssize_t
 qeth_dev_portname_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -179,7 +179,7 @@ static DEVICE_ATTR(portname, 0644, qeth_
 static ssize_t
 qeth_dev_checksum_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -190,7 +190,7 @@ qeth_dev_checksum_show(struct device *de
 static ssize_t
 qeth_dev_checksum_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 
 	if (!card)
@@ -220,7 +220,7 @@ static DEVICE_ATTR(checksumming, 0644, q
 static ssize_t
 qeth_dev_prioqing_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -239,7 +239,7 @@ qeth_dev_prioqing_show(struct device *de
 static ssize_t
 qeth_dev_prioqing_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 
 	if (!card)
@@ -292,7 +292,7 @@ static DEVICE_ATTR(priority_queueing, 06
 static ssize_t
 qeth_dev_bufcnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -303,7 +303,7 @@ qeth_dev_bufcnt_show(struct device *dev,
 static ssize_t
 qeth_dev_bufcnt_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int cnt, old_cnt;
 	int rc;
@@ -362,7 +362,7 @@ qeth_dev_route_show(struct qeth_card *ca
 static ssize_t
 qeth_dev_route4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -412,7 +412,7 @@ qeth_dev_route_store(struct qeth_card *c
 static ssize_t
 qeth_dev_route4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -427,7 +427,7 @@ static DEVICE_ATTR(route4, 0644, qeth_de
 static ssize_t
 qeth_dev_route6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -441,7 +441,7 @@ qeth_dev_route6_show(struct device *dev,
 static ssize_t
 qeth_dev_route6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -463,7 +463,7 @@ static DEVICE_ATTR(route6, 0644, qeth_de
 static ssize_t
 qeth_dev_add_hhlen_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -474,7 +474,7 @@ qeth_dev_add_hhlen_show(struct device *d
 static ssize_t
 qeth_dev_add_hhlen_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -501,7 +501,7 @@ static DEVICE_ATTR(add_hhlen, 0644, qeth
 static ssize_t
 qeth_dev_fake_ll_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -512,7 +512,7 @@ qeth_dev_fake_ll_show(struct device *dev
 static ssize_t
 qeth_dev_fake_ll_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -538,7 +538,7 @@ static DEVICE_ATTR(fake_ll, 0644, qeth_d
 static ssize_t
 qeth_dev_fake_broadcast_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -549,7 +549,7 @@ qeth_dev_fake_broadcast_show(struct devi
 static ssize_t
 qeth_dev_fake_broadcast_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -576,7 +576,7 @@ static DEVICE_ATTR(fake_broadcast, 0644,
 static ssize_t
 qeth_dev_recover_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -598,7 +598,7 @@ static DEVICE_ATTR(recover, 0200, NULL, 
 static ssize_t
 qeth_dev_broadcast_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -615,7 +615,7 @@ qeth_dev_broadcast_mode_show(struct devi
 static ssize_t
 qeth_dev_broadcast_mode_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 
 	if (!card)
@@ -653,7 +653,7 @@ static DEVICE_ATTR(broadcast_mode, 0644,
 static ssize_t
 qeth_dev_canonical_macaddr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -670,7 +670,7 @@ static ssize_t
 qeth_dev_canonical_macaddr_store(struct device *dev, struct device_attribute *attr, const char *buf,
 				  size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -705,7 +705,7 @@ static DEVICE_ATTR(canonical_macaddr, 06
 static ssize_t
 qeth_dev_layer2_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -716,7 +716,7 @@ qeth_dev_layer2_show(struct device *dev,
 static ssize_t
 qeth_dev_layer2_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 	int i;
 
@@ -747,7 +747,7 @@ static DEVICE_ATTR(layer2, 0644, qeth_de
 static ssize_t
 qeth_dev_large_send_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -767,7 +767,7 @@ qeth_dev_large_send_show(struct device *
 static ssize_t
 qeth_dev_large_send_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	enum qeth_large_send_types type;
 	int rc = 0;
 	char *tmp;
@@ -833,7 +833,7 @@ qeth_dev_blkt_store(struct qeth_card *ca
 static ssize_t
 qeth_dev_blkt_total_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	return qeth_dev_blkt_show(buf, card, card->info.blkt.time_total);
 }
@@ -842,7 +842,7 @@ qeth_dev_blkt_total_show(struct device *
 static ssize_t
 qeth_dev_blkt_total_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	return qeth_dev_blkt_store(card, buf, count,
 				   &card->info.blkt.time_total,1000);
@@ -856,7 +856,7 @@ static DEVICE_ATTR(total, 0644, qeth_dev
 static ssize_t
 qeth_dev_blkt_inter_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	return qeth_dev_blkt_show(buf, card, card->info.blkt.inter_packet);
 }
@@ -865,7 +865,7 @@ qeth_dev_blkt_inter_show(struct device *
 static ssize_t
 qeth_dev_blkt_inter_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	return qeth_dev_blkt_store(card, buf, count,
 				   &card->info.blkt.inter_packet,100);
@@ -877,7 +877,7 @@ static DEVICE_ATTR(inter, 0644, qeth_dev
 static ssize_t
 qeth_dev_blkt_inter_jumbo_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	return qeth_dev_blkt_show(buf, card,
 				  card->info.blkt.inter_packet_jumbo);
@@ -887,7 +887,7 @@ qeth_dev_blkt_inter_jumbo_show(struct de
 static ssize_t
 qeth_dev_blkt_inter_jumbo_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	return qeth_dev_blkt_store(card, buf, count,
 				   &card->info.blkt.inter_packet_jumbo,100);
@@ -970,7 +970,7 @@ qeth_check_layer2(struct qeth_card *card
 static ssize_t
 qeth_dev_ipato_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -983,7 +983,7 @@ qeth_dev_ipato_enable_show(struct device
 static ssize_t
 qeth_dev_ipato_enable_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 
 	if (!card)
@@ -1018,7 +1018,7 @@ static QETH_DEVICE_ATTR(ipato_enable, en
 static ssize_t
 qeth_dev_ipato_invert4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1032,7 +1032,7 @@ qeth_dev_ipato_invert4_show(struct devic
 static ssize_t
 qeth_dev_ipato_invert4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 
 	if (!card)
@@ -1098,7 +1098,7 @@ qeth_dev_ipato_add_show(char *buf, struc
 static ssize_t
 qeth_dev_ipato_add4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1167,7 +1167,7 @@ qeth_dev_ipato_add_store(const char *buf
 static ssize_t
 qeth_dev_ipato_add4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1200,7 +1200,7 @@ qeth_dev_ipato_del_store(const char *buf
 static ssize_t
 qeth_dev_ipato_del4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1215,7 +1215,7 @@ static QETH_DEVICE_ATTR(ipato_del4, del4
 static ssize_t
 qeth_dev_ipato_invert6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1229,7 +1229,7 @@ qeth_dev_ipato_invert6_show(struct devic
 static ssize_t
 qeth_dev_ipato_invert6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 	char *tmp;
 
 	if (!card)
@@ -1261,7 +1261,7 @@ static QETH_DEVICE_ATTR(ipato_invert6, i
 static ssize_t
 qeth_dev_ipato_add6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1272,7 +1272,7 @@ qeth_dev_ipato_add6_show(struct device *
 static ssize_t
 qeth_dev_ipato_add6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1287,7 +1287,7 @@ static QETH_DEVICE_ATTR(ipato_add6, add6
 static ssize_t
 qeth_dev_ipato_del6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1355,7 +1355,7 @@ qeth_dev_vipa_add_show(char *buf, struct
 static ssize_t
 qeth_dev_vipa_add4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1395,7 +1395,7 @@ qeth_dev_vipa_add_store(const char *buf,
 static ssize_t
 qeth_dev_vipa_add4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1427,7 +1427,7 @@ qeth_dev_vipa_del_store(const char *buf,
 static ssize_t
 qeth_dev_vipa_del4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1442,7 +1442,7 @@ static QETH_DEVICE_ATTR(vipa_del4, del4,
 static ssize_t
 qeth_dev_vipa_add6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1453,7 +1453,7 @@ qeth_dev_vipa_add6_show(struct device *d
 static ssize_t
 qeth_dev_vipa_add6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1468,7 +1468,7 @@ static QETH_DEVICE_ATTR(vipa_add6, add6,
 static ssize_t
 qeth_dev_vipa_del6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1536,7 +1536,7 @@ qeth_dev_rxip_add_show(char *buf, struct
 static ssize_t
 qeth_dev_rxip_add4_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1576,7 +1576,7 @@ qeth_dev_rxip_add_store(const char *buf,
 static ssize_t
 qeth_dev_rxip_add4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1608,7 +1608,7 @@ qeth_dev_rxip_del_store(const char *buf,
 static ssize_t
 qeth_dev_rxip_del4_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1623,7 +1623,7 @@ static QETH_DEVICE_ATTR(rxip_del4, del4,
 static ssize_t
 qeth_dev_rxip_add6_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1634,7 +1634,7 @@ qeth_dev_rxip_add6_show(struct device *d
 static ssize_t
 qeth_dev_rxip_add6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1649,7 +1649,7 @@ static QETH_DEVICE_ATTR(rxip_add6, add6,
 static ssize_t
 qeth_dev_rxip_del6_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (!card)
 		return -EINVAL;
@@ -1680,7 +1680,7 @@ int
 qeth_create_device_attributes(struct device *dev)
 {
 	int ret;
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		return sysfs_create_group(&dev->kobj,
@@ -1711,7 +1711,7 @@ qeth_create_device_attributes(struct dev
 void
 qeth_remove_device_attributes(struct device *dev)
 {
-	struct qeth_card *card = dev->driver_data;
+	struct qeth_card *card = dev_get_drvdata(dev);
 
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		return sysfs_remove_group(&dev->kobj,
diff -Narup a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
--- a/drivers/s390/net/qeth_proc.c	2005-12-02 15:31:13.000000000 +0100
+++ b/drivers/s390/net/qeth_proc.c	2005-12-02 15:30:09.000000000 +0100
@@ -135,7 +135,7 @@ qeth_procfile_seq_show(struct seq_file *
 			      "---- ----- -----\n");
 	} else {
 		device = (struct device *) it;
-		card = device->driver_data;
+		card = dev_get_drvdata(device);
 		seq_printf(s, "%s/%s/%s x%02X   %-10s %-14s %-4i ",
 				CARD_RDEV_ID(card),
 				CARD_WDEV_ID(card),
@@ -230,7 +230,7 @@ qeth_perf_procfile_seq_show(struct seq_f
 	struct qeth_card *card;
 
 	device = (struct device *) it;
-	card = device->driver_data;
+	card = dev_get_drvdata(device);
 	seq_printf(s, "For card with devnos %s/%s/%s (%s):\n",
 			CARD_RDEV_ID(card),
 			CARD_WDEV_ID(card),
@@ -385,7 +385,7 @@ qeth_ipato_procfile_seq_show(struct seq_
 	 * else output setting for respective card
 	 */
 	device = (struct device *) it;
-	card = device->driver_data;
+	card = dev_get_drvdata(device);
 
 	return 0;
 }
diff -Narup a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c	2005-12-02 13:58:41.000000000 +0100
+++ b/drivers/s390/net/lcs.c	2005-12-02 14:04:27.000000000 +0100
@@ -1987,7 +1987,7 @@ lcs_portno_show (struct device *dev, str
 {
         struct lcs_card *card;
 
-	card = (struct lcs_card *)dev->driver_data;
+	card = dev_get_drvdata(dev);
 
         if (!card)
                 return 0;
@@ -2004,7 +2004,7 @@ lcs_portno_store (struct device *dev, st
         struct lcs_card *card;
         int value;
 
-	card = (struct lcs_card *)dev->driver_data;
+	card = dev_get_drvdata(dev);
 
         if (!card)
                 return 0;
@@ -2038,7 +2038,7 @@ lcs_timeout_show(struct device *dev, str
 {
 	struct lcs_card *card;
 
-	card = (struct lcs_card *)dev->driver_data;
+	card = dev_get_drvdata(dev);
 
 	return card ? sprintf(buf, "%u\n", card->lancmd_timeout) : 0;
 }
@@ -2049,7 +2049,7 @@ lcs_timeout_store (struct device *dev, s
         struct lcs_card *card;
         int value;
 
-	card = (struct lcs_card *)dev->driver_data;
+	card = dev_get_drvdata(dev);
 
         if (!card)
                 return 0;
diff -Narup a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
--- a/drivers/s390/net/qeth_main.c	2005-12-02 14:15:04.000000000 +0100
+++ b/drivers/s390/net/qeth_main.c	2005-12-02 14:13:24.000000000 +0100
@@ -8497,7 +8497,7 @@ __qeth_reboot_event_card(struct device *
 {
 	struct qeth_card *card;
 
-	card = (struct qeth_card *) dev->driver_data;
+	card = dev_get_drvdata(dev);
 	qeth_clear_ip_list(card, 0, 0);
 	qeth_qdio_clear_card(card, 0);
 	return 0;
diff -Narup a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
--- a/drivers/s390/net/ctcmain.c	2005-12-02 13:15:41.000000000 +0100
+++ b/drivers/s390/net/ctcmain.c	2005-12-02 13:29:46.000000000 +0100
@@ -2478,7 +2478,7 @@ buffer_show(struct device *dev, struct d
 {
 	struct ctc_priv *priv;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev);
 	if (!priv)
 		return -ENODEV;
 	return sprintf(buf, "%d\n",
@@ -2495,7 +2495,7 @@ buffer_write(struct device *dev, struct 
 
 	DBF_TEXT(trace, 3, __FUNCTION__);
 	DBF_TEXT(trace, 3, buf);
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev);
 	if (!priv) {
 		DBF_TEXT(trace, 3, "bfnopriv");
 		return -ENODEV;
@@ -2596,7 +2596,7 @@ ctc_print_statistics(struct ctc_priv *pr
 static ssize_t
 stats_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct ctc_priv *priv = dev->driver_data;
+	struct ctc_priv *priv = dev_get_drvdata(dev);
 	if (!priv)
 		return -ENODEV;
 	ctc_print_statistics(priv);
@@ -2606,7 +2606,7 @@ stats_show(struct device *dev, struct de
 static ssize_t
 stats_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct ctc_priv *priv = dev->driver_data;
+	struct ctc_priv *priv = dev_get_drvdata(dev);
 	if (!priv)
 		return -ENODEV;
 	/* Reset statistics */
@@ -2662,7 +2662,7 @@ ctc_proto_show(struct device *dev, struc
 {
 	struct ctc_priv *priv;
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev);
 	if (!priv)
 		return -ENODEV;
 
@@ -2678,7 +2678,7 @@ ctc_proto_store(struct device *dev, stru
 	DBF_TEXT(trace, 3, __FUNCTION__);
 	pr_debug("%s() called\n", __FUNCTION__);
 
-	priv = dev->driver_data;
+	priv = dev_get_drvdata(dev);
 	if (!priv)
 		return -ENODEV;
 	sscanf(buf, "%u", &value);
