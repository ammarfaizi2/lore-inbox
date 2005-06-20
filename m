Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVFUApC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFUApC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFUAoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:44:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:44260 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261763AbVFTW7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:54 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver Core: drivers/char/raw3270.c - drivers/net/netiucv.c: update device attribute callbacks
In-Reply-To: <11193083681837@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083682161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: drivers/char/raw3270.c - drivers/net/netiucv.c: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3fd3c0a5f53a0f9d8987b90acbd84f7dd8ef606e
tree 46a9050abe4c11375a78b51f07e524682722bf70
parent e404e274f62665f3333d6a539d0d3701f678a598
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:43:27 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:34 -0700

 drivers/s390/char/raw3270.c   |    6 +++---
 drivers/s390/char/tape_core.c |   10 +++++----
 drivers/s390/char/vmlogrdr.c  |   12 ++++++-----
 drivers/s390/cio/ccwgroup.c   |    6 +++---
 drivers/s390/cio/chsc.c       |    6 +++---
 drivers/s390/cio/cmf.c        |   12 ++++++-----
 drivers/s390/cio/device.c     |   14 +++++++------
 drivers/s390/net/claw.c       |   40 +++++++++++++++++++------------------
 drivers/s390/net/ctcmain.c    |   18 ++++++++---------
 drivers/s390/net/lcs.c        |   10 +++++----
 drivers/s390/net/netiucv.c    |   44 +++++++++++++++++++++--------------------
 11 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1084,7 +1084,7 @@ raw3270_probe (struct ccw_device *cdev)
  * Additional attributes for a 3270 device
  */
 static ssize_t
-raw3270_model_show(struct device *dev, char *buf)
+raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->model);
@@ -1092,7 +1092,7 @@ raw3270_model_show(struct device *dev, c
 static DEVICE_ATTR(model, 0444, raw3270_model_show, 0);
 
 static ssize_t
-raw3270_rows_show(struct device *dev, char *buf)
+raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->rows);
@@ -1100,7 +1100,7 @@ raw3270_rows_show(struct device *dev, ch
 static DEVICE_ATTR(rows, 0444, raw3270_rows_show, 0);
 
 static ssize_t
-raw3270_columns_show(struct device *dev, char *buf)
+raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev->driver_data)->cols);
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -107,7 +107,7 @@ busid_to_int(char *bus_id)
  *        replaced by a link to the cdev tree.
  */
 static ssize_t
-tape_medium_state_show(struct device *dev, char *buf)
+tape_medium_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tape_device *tdev;
 
@@ -119,7 +119,7 @@ static
 DEVICE_ATTR(medium_state, 0444, tape_medium_state_show, NULL);
 
 static ssize_t
-tape_first_minor_show(struct device *dev, char *buf)
+tape_first_minor_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tape_device *tdev;
 
@@ -131,7 +131,7 @@ static
 DEVICE_ATTR(first_minor, 0444, tape_first_minor_show, NULL);
 
 static ssize_t
-tape_state_show(struct device *dev, char *buf)
+tape_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tape_device *tdev;
 
@@ -144,7 +144,7 @@ static
 DEVICE_ATTR(state, 0444, tape_state_show, NULL);
 
 static ssize_t
-tape_operation_show(struct device *dev, char *buf)
+tape_operation_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tape_device *tdev;
 	ssize_t rc;
@@ -171,7 +171,7 @@ static
 DEVICE_ATTR(operation, 0444, tape_operation_show, NULL);
 
 static ssize_t
-tape_blocksize_show(struct device *dev, char *buf)
+tape_blocksize_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tape_device *tdev;
 
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -548,7 +548,7 @@ vmlogrdr_read (struct file *filp, char *
 }
 
 static ssize_t
-vmlogrdr_autopurge_store(struct device * dev, const char * buf, size_t count) {
+vmlogrdr_autopurge_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t count) {
 	struct vmlogrdr_priv_t *priv = dev->driver_data;
 	ssize_t ret = count;
 
@@ -567,7 +567,7 @@ vmlogrdr_autopurge_store(struct device *
 
 
 static ssize_t
-vmlogrdr_autopurge_show(struct device *dev, char *buf) {
+vmlogrdr_autopurge_show(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct vmlogrdr_priv_t *priv = dev->driver_data;
 	return sprintf(buf, "%u\n", priv->autopurge);
 }
@@ -578,7 +578,7 @@ static DEVICE_ATTR(autopurge, 0644, vmlo
 
 
 static ssize_t
-vmlogrdr_purge_store(struct device * dev, const char * buf, size_t count) {
+vmlogrdr_purge_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t count) {
 
 	char cp_command[80];
 	char cp_response[80];
@@ -619,7 +619,7 @@ static DEVICE_ATTR(purge, 0200, NULL, vm
 
 
 static ssize_t
-vmlogrdr_autorecording_store(struct device *dev, const char *buf,
+vmlogrdr_autorecording_store(struct device *dev, struct device_attribute *attr, const char *buf,
 			     size_t count) {
 	struct vmlogrdr_priv_t *priv = dev->driver_data;
 	ssize_t ret = count;
@@ -639,7 +639,7 @@ vmlogrdr_autorecording_store(struct devi
 
 
 static ssize_t
-vmlogrdr_autorecording_show(struct device *dev, char *buf) {
+vmlogrdr_autorecording_show(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct vmlogrdr_priv_t *priv = dev->driver_data;
 	return sprintf(buf, "%u\n", priv->autorecording);
 }
@@ -650,7 +650,7 @@ static DEVICE_ATTR(autorecording, 0644, 
 
 
 static ssize_t
-vmlogrdr_recording_store(struct device * dev, const char * buf, size_t count) {
+vmlogrdr_recording_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t count) {
 
 	struct vmlogrdr_priv_t *priv = dev->driver_data;
 	ssize_t ret;
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -77,7 +77,7 @@ __ccwgroup_remove_symlinks(struct ccwgro
  * longer needed or accidentially created. Saves memory :)
  */
 static ssize_t
-ccwgroup_ungroup_store(struct device *dev, const char *buf, size_t count)
+ccwgroup_ungroup_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ccwgroup_device *gdev;
 
@@ -310,7 +310,7 @@ ccwgroup_set_offline(struct ccwgroup_dev
 }
 
 static ssize_t
-ccwgroup_online_store (struct device *dev, const char *buf, size_t count)
+ccwgroup_online_store (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ccwgroup_device *gdev;
 	struct ccwgroup_driver *gdrv;
@@ -338,7 +338,7 @@ ccwgroup_online_store (struct device *de
 }
 
 static ssize_t
-ccwgroup_online_show (struct device *dev, char *buf)
+ccwgroup_online_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int online;
 
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -852,7 +852,7 @@ out:
  * Files for the channel path entries.
  */
 static ssize_t
-chp_status_show(struct device *dev, char *buf)
+chp_status_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct channel_path *chp = container_of(dev, struct channel_path, dev);
 
@@ -863,7 +863,7 @@ chp_status_show(struct device *dev, char
 }
 
 static ssize_t
-chp_status_write(struct device *dev, const char *buf, size_t count)
+chp_status_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct channel_path *cp = container_of(dev, struct channel_path, dev);
 	char cmd[10];
@@ -888,7 +888,7 @@ chp_status_write(struct device *dev, con
 static DEVICE_ATTR(status, 0644, chp_status_show, chp_status_write);
 
 static ssize_t
-chp_type_show(struct device *dev, char *buf)
+chp_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct channel_path *chp = container_of(dev, struct channel_path, dev);
 
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -796,7 +796,7 @@ cmb_show_attr(struct device *dev, char *
 }
 
 static ssize_t
-cmb_show_avg_sample_interval(struct device *dev, char *buf)
+cmb_show_avg_sample_interval(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccw_device *cdev;
 	long interval;
@@ -813,7 +813,7 @@ cmb_show_avg_sample_interval(struct devi
 }
 
 static ssize_t
-cmb_show_avg_utilization(struct device *dev, char *buf)
+cmb_show_avg_utilization(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct cmbdata data;
 	u64 utilization;
@@ -842,12 +842,12 @@ cmb_show_avg_utilization(struct device *
 }
 
 #define cmf_attr(name) \
-static ssize_t show_ ## name (struct device * dev, char * buf) \
+static ssize_t show_ ## name (struct device * dev, struct device_attribute *attr, char * buf) \
 { return cmb_show_attr((dev), buf, cmb_ ## name); } \
 static DEVICE_ATTR(name, 0444, show_ ## name, NULL);
 
 #define cmf_attr_avg(name) \
-static ssize_t show_avg_ ## name (struct device * dev, char * buf) \
+static ssize_t show_avg_ ## name (struct device * dev, struct device_attribute *attr, char * buf) \
 { return cmb_show_attr((dev), buf, cmb_ ## name); } \
 static DEVICE_ATTR(avg_ ## name, 0444, show_avg_ ## name, NULL);
 
@@ -902,12 +902,12 @@ static struct attribute_group cmf_attr_g
 	.attrs = cmf_attributes_ext,
 };
 
-static ssize_t cmb_enable_show(struct device *dev, char *buf)
+static ssize_t cmb_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", to_ccwdev(dev)->private->cmb ? 1 : 0);
 }
 
-static ssize_t cmb_enable_store(struct device *dev, const char *buf, size_t c)
+static ssize_t cmb_enable_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t c)
 {
 	struct ccw_device *cdev;
 	int ret;
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -204,7 +204,7 @@ module_exit(cleanup_ccw_bus_type);
  * TODO: Split chpids and pimpampom up? Where is "in use" in the tree?
  */
 static ssize_t
-chpids_show (struct device * dev, char * buf)
+chpids_show (struct device * dev, struct device_attribute *attr, char * buf)
 {
 	struct subchannel *sch = to_subchannel(dev);
 	struct ssd_info *ssd = &sch->ssd_info;
@@ -219,7 +219,7 @@ chpids_show (struct device * dev, char *
 }
 
 static ssize_t
-pimpampom_show (struct device * dev, char * buf)
+pimpampom_show (struct device * dev, struct device_attribute *attr, char * buf)
 {
 	struct subchannel *sch = to_subchannel(dev);
 	struct pmcw *pmcw = &sch->schib.pmcw;
@@ -229,7 +229,7 @@ pimpampom_show (struct device * dev, cha
 }
 
 static ssize_t
-devtype_show (struct device *dev, char *buf)
+devtype_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct ccw_device_id *id = &(cdev->id);
@@ -242,7 +242,7 @@ devtype_show (struct device *dev, char *
 }
 
 static ssize_t
-cutype_show (struct device *dev, char *buf)
+cutype_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct ccw_device_id *id = &(cdev->id);
@@ -252,7 +252,7 @@ cutype_show (struct device *dev, char *b
 }
 
 static ssize_t
-online_show (struct device *dev, char *buf)
+online_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 
@@ -350,7 +350,7 @@ ccw_device_set_online(struct ccw_device 
 }
 
 static ssize_t
-online_store (struct device *dev, const char *buf, size_t count)
+online_store (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	int i, force, ret;
@@ -422,7 +422,7 @@ online_store (struct device *dev, const 
 }
 
 static ssize_t
-available_show (struct device *dev, char *buf)
+available_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct subchannel *sch;
diff --git a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -241,20 +241,20 @@ static struct sk_buff *claw_pack_skb(str
 static void dumpit (char *buf, int len);
 #endif
 /* sysfs Functions */
-static ssize_t claw_hname_show(struct device *dev, char *buf);
-static ssize_t claw_hname_write(struct device *dev,
+static ssize_t claw_hname_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t claw_hname_write(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count);
-static ssize_t claw_adname_show(struct device *dev, char *buf);
-static ssize_t claw_adname_write(struct device *dev,
+static ssize_t claw_adname_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t claw_adname_write(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count);
-static ssize_t claw_apname_show(struct device *dev, char *buf);
-static ssize_t claw_apname_write(struct device *dev,
+static ssize_t claw_apname_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t claw_apname_write(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count);
-static ssize_t claw_wbuff_show(struct device *dev, char *buf);
-static ssize_t claw_wbuff_write(struct device *dev,
+static ssize_t claw_wbuff_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t claw_wbuff_write(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count);
-static ssize_t claw_rbuff_show(struct device *dev, char *buf);
-static ssize_t claw_rbuff_write(struct device *dev,
+static ssize_t claw_rbuff_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t claw_rbuff_write(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count);
 static int claw_add_files(struct device *dev);
 static void claw_remove_files(struct device *dev);
@@ -4149,7 +4149,7 @@ claw_remove_device(struct ccwgroup_devic
  * sysfs attributes
  */
 static ssize_t
-claw_hname_show(struct device *dev, char *buf)
+claw_hname_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4162,7 +4162,7 @@ claw_hname_show(struct device *dev, char
 }
 
 static ssize_t
-claw_hname_write(struct device *dev, const char *buf, size_t count)
+claw_hname_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4186,7 +4186,7 @@ claw_hname_write(struct device *dev, con
 static DEVICE_ATTR(host_name, 0644, claw_hname_show, claw_hname_write);
 
 static ssize_t
-claw_adname_show(struct device *dev, char *buf)
+claw_adname_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4199,7 +4199,7 @@ claw_adname_show(struct device *dev, cha
 }
 
 static ssize_t
-claw_adname_write(struct device *dev, const char *buf, size_t count)
+claw_adname_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4223,7 +4223,7 @@ claw_adname_write(struct device *dev, co
 static DEVICE_ATTR(adapter_name, 0644, claw_adname_show, claw_adname_write);
 
 static ssize_t
-claw_apname_show(struct device *dev, char *buf)
+claw_apname_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4237,7 +4237,7 @@ claw_apname_show(struct device *dev, cha
 }
 
 static ssize_t
-claw_apname_write(struct device *dev, const char *buf, size_t count)
+claw_apname_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4271,7 +4271,7 @@ claw_apname_write(struct device *dev, co
 static DEVICE_ATTR(api_type, 0644, claw_apname_show, claw_apname_write);
 
 static ssize_t
-claw_wbuff_show(struct device *dev, char *buf)
+claw_wbuff_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct claw_privbk *priv;
 	struct claw_env * p_env;
@@ -4284,7 +4284,7 @@ claw_wbuff_show(struct device *dev, char
 }
 
 static ssize_t
-claw_wbuff_write(struct device *dev, const char *buf, size_t count)
+claw_wbuff_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4312,7 +4312,7 @@ claw_wbuff_write(struct device *dev, con
 static DEVICE_ATTR(write_buffer, 0644, claw_wbuff_show, claw_wbuff_write);
 
 static ssize_t
-claw_rbuff_show(struct device *dev, char *buf)
+claw_rbuff_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct claw_privbk *priv;
 	struct claw_env *  p_env;
@@ -4325,7 +4325,7 @@ claw_rbuff_show(struct device *dev, char
 }
 
 static ssize_t
-claw_rbuff_write(struct device *dev, const char *buf, size_t count)
+claw_rbuff_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct claw_privbk *priv;
 	struct claw_env *p_env;
diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
--- a/drivers/s390/net/ctcmain.c
+++ b/drivers/s390/net/ctcmain.c
@@ -2469,7 +2469,7 @@ ctc_stats(struct net_device * dev)
  */
 
 static ssize_t
-buffer_show(struct device *dev, char *buf)
+buffer_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ctc_priv *priv;
 
@@ -2481,7 +2481,7 @@ buffer_show(struct device *dev, char *bu
 }
 
 static ssize_t
-buffer_write(struct device *dev, const char *buf, size_t count)
+buffer_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ctc_priv *priv;
 	struct net_device *ndev;
@@ -2530,13 +2530,13 @@ einval:
 }
 
 static ssize_t
-loglevel_show(struct device *dev, char *buf)
+loglevel_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", loglevel);
 }
 
 static ssize_t
-loglevel_write(struct device *dev, const char *buf, size_t count)
+loglevel_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int ll1;
 
@@ -2589,7 +2589,7 @@ ctc_print_statistics(struct ctc_priv *pr
 }
 
 static ssize_t
-stats_show(struct device *dev, char *buf)
+stats_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ctc_priv *priv = dev->driver_data;
 	if (!priv)
@@ -2599,7 +2599,7 @@ stats_show(struct device *dev, char *buf
 }
 
 static ssize_t
-stats_write(struct device *dev, const char *buf, size_t count)
+stats_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ctc_priv *priv = dev->driver_data;
 	if (!priv)
@@ -2654,7 +2654,7 @@ ctc_free_netdevice(struct net_device * d
 }
 
 static ssize_t
-ctc_proto_show(struct device *dev, char *buf)
+ctc_proto_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ctc_priv *priv;
 
@@ -2666,7 +2666,7 @@ ctc_proto_show(struct device *dev, char 
 }
 
 static ssize_t
-ctc_proto_store(struct device *dev, const char *buf, size_t count)
+ctc_proto_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ctc_priv *priv;
 	int value;
@@ -2687,7 +2687,7 @@ ctc_proto_store(struct device *dev, cons
 
 
 static ssize_t
-ctc_type_show(struct device *dev, char *buf)
+ctc_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccwgroup_device *cgdev;
 
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1984,7 +1984,7 @@ lcs_open_device(struct net_device *dev)
  * show function for portno called by cat or similar things
  */
 static ssize_t
-lcs_portno_show (struct device *dev, char *buf)
+lcs_portno_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
         struct lcs_card *card;
 
@@ -2000,7 +2000,7 @@ lcs_portno_show (struct device *dev, cha
  * store the value which is piped to file portno
  */
 static ssize_t
-lcs_portno_store (struct device *dev, const char *buf, size_t count)
+lcs_portno_store (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
         struct lcs_card *card;
         int value;
@@ -2021,7 +2021,7 @@ lcs_portno_store (struct device *dev, co
 static DEVICE_ATTR(portno, 0644, lcs_portno_show, lcs_portno_store);
 
 static ssize_t
-lcs_type_show(struct device *dev, char *buf)
+lcs_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccwgroup_device *cgdev;
 
@@ -2035,7 +2035,7 @@ lcs_type_show(struct device *dev, char *
 static DEVICE_ATTR(type, 0444, lcs_type_show, NULL);
 
 static ssize_t
-lcs_timeout_show(struct device *dev, char *buf)
+lcs_timeout_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lcs_card *card;
 
@@ -2045,7 +2045,7 @@ lcs_timeout_show(struct device *dev, cha
 }
 
 static ssize_t
-lcs_timeout_store (struct device *dev, const char *buf, size_t count)
+lcs_timeout_store (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
         struct lcs_card *card;
         int value;
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -1356,7 +1356,7 @@ netiucv_change_mtu (struct net_device * 
  *****************************************************************************/
 
 static ssize_t
-user_show (struct device *dev, char *buf)
+user_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1365,7 +1365,7 @@ user_show (struct device *dev, char *buf
 }
 
 static ssize_t
-user_write (struct device *dev, const char *buf, size_t count)
+user_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	struct net_device *ndev = priv->conn->netdev;
@@ -1422,7 +1422,7 @@ user_write (struct device *dev, const ch
 static DEVICE_ATTR(user, 0644, user_show, user_write);
 
 static ssize_t
-buffer_show (struct device *dev, char *buf)
+buffer_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1431,7 +1431,7 @@ buffer_show (struct device *dev, char *b
 }
 
 static ssize_t
-buffer_write (struct device *dev, const char *buf, size_t count)
+buffer_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	struct net_device *ndev = priv->conn->netdev;
@@ -1486,7 +1486,7 @@ buffer_write (struct device *dev, const 
 static DEVICE_ATTR(buffer, 0644, buffer_show, buffer_write);
 
 static ssize_t
-dev_fsm_show (struct device *dev, char *buf)
+dev_fsm_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1497,7 +1497,7 @@ dev_fsm_show (struct device *dev, char *
 static DEVICE_ATTR(device_fsm_state, 0444, dev_fsm_show, NULL);
 
 static ssize_t
-conn_fsm_show (struct device *dev, char *buf)
+conn_fsm_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1508,7 +1508,7 @@ conn_fsm_show (struct device *dev, char 
 static DEVICE_ATTR(connection_fsm_state, 0444, conn_fsm_show, NULL);
 
 static ssize_t
-maxmulti_show (struct device *dev, char *buf)
+maxmulti_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1517,7 +1517,7 @@ maxmulti_show (struct device *dev, char 
 }
 
 static ssize_t
-maxmulti_write (struct device *dev, const char *buf, size_t count)
+maxmulti_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1529,7 +1529,7 @@ maxmulti_write (struct device *dev, cons
 static DEVICE_ATTR(max_tx_buffer_used, 0644, maxmulti_show, maxmulti_write);
 
 static ssize_t
-maxcq_show (struct device *dev, char *buf)
+maxcq_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1538,7 +1538,7 @@ maxcq_show (struct device *dev, char *bu
 }
 
 static ssize_t
-maxcq_write (struct device *dev, const char *buf, size_t count)
+maxcq_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1550,7 +1550,7 @@ maxcq_write (struct device *dev, const c
 static DEVICE_ATTR(max_chained_skbs, 0644, maxcq_show, maxcq_write);
 
 static ssize_t
-sdoio_show (struct device *dev, char *buf)
+sdoio_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1559,7 +1559,7 @@ sdoio_show (struct device *dev, char *bu
 }
 
 static ssize_t
-sdoio_write (struct device *dev, const char *buf, size_t count)
+sdoio_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1571,7 +1571,7 @@ sdoio_write (struct device *dev, const c
 static DEVICE_ATTR(tx_single_write_ops, 0644, sdoio_show, sdoio_write);
 
 static ssize_t
-mdoio_show (struct device *dev, char *buf)
+mdoio_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1580,7 +1580,7 @@ mdoio_show (struct device *dev, char *bu
 }
 
 static ssize_t
-mdoio_write (struct device *dev, const char *buf, size_t count)
+mdoio_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1592,7 +1592,7 @@ mdoio_write (struct device *dev, const c
 static DEVICE_ATTR(tx_multi_write_ops, 0644, mdoio_show, mdoio_write);
 
 static ssize_t
-txlen_show (struct device *dev, char *buf)
+txlen_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1601,7 +1601,7 @@ txlen_show (struct device *dev, char *bu
 }
 
 static ssize_t
-txlen_write (struct device *dev, const char *buf, size_t count)
+txlen_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1613,7 +1613,7 @@ txlen_write (struct device *dev, const c
 static DEVICE_ATTR(netto_bytes, 0644, txlen_show, txlen_write);
 
 static ssize_t
-txtime_show (struct device *dev, char *buf)
+txtime_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1622,7 +1622,7 @@ txtime_show (struct device *dev, char *b
 }
 
 static ssize_t
-txtime_write (struct device *dev, const char *buf, size_t count)
+txtime_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
@@ -1634,7 +1634,7 @@ txtime_write (struct device *dev, const 
 static DEVICE_ATTR(max_tx_io_time, 0644, txtime_show, txtime_write);
 
 static ssize_t
-txpend_show (struct device *dev, char *buf)
+txpend_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1643,7 +1643,7 @@ txpend_show (struct device *dev, char *b
 }
 
 static ssize_t
-txpend_write (struct device *dev, const char *buf, size_t count)
+txpend_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1655,7 +1655,7 @@ txpend_write (struct device *dev, const 
 static DEVICE_ATTR(tx_pending, 0644, txpend_show, txpend_write);
 
 static ssize_t
-txmpnd_show (struct device *dev, char *buf)
+txmpnd_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
@@ -1664,7 +1664,7 @@ txmpnd_show (struct device *dev, char *b
 }
 
 static ssize_t
-txmpnd_write (struct device *dev, const char *buf, size_t count)
+txmpnd_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
 

