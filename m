Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVEHTNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVEHTNT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVEHTNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:13:18 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:55702 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262815AbVEHTJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:35 -0400
Message-Id: <20050508184345.848102000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:35 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-core-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 06/37] remove unnecessary casts in dvb-core
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary casts in dvb-core (Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/dvb-core/dmxdev.c         |   32 +++++++++++-----------
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c |   38 +++++++++++++-------------
 drivers/media/dvb/dvb-core/dvb_frontend.c   |   34 +++++++++++------------
 drivers/media/dvb/dvb-core/dvb_net.c        |   40 ++++++++++++++--------------
 4 files changed, 72 insertions(+), 72 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dmxdev.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dmxdev.c	2005-05-08 20:24:45.000000000 +0200
@@ -175,8 +175,8 @@ static inline void dvb_dmxdev_dvr_state_
 
 static int dvb_dvr_open(struct inode *inode, struct file *file)
 {
-	struct dvb_device *dvbdev=(struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev=(struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 	struct dmx_frontend *front;
 
 	dprintk ("function : %s\n", __FUNCTION__);
@@ -224,8 +224,8 @@ static int dvb_dvr_open(struct inode *in
 
 static int dvb_dvr_release(struct inode *inode, struct file *file)
 {
-	struct dvb_device *dvbdev=(struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev=(struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 
 	if (down_interruptible (&dmxdev->mutex))
 		return -ERESTARTSYS;
@@ -252,8 +252,8 @@ static int dvb_dvr_release(struct inode 
 static ssize_t dvb_dvr_write(struct file *file, const char __user *buf,
 		size_t count, loff_t *ppos)
 {
-	struct dvb_device *dvbdev=(struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev=(struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 	int ret;
 
 	if (!dmxdev->demux->write)
@@ -270,8 +270,8 @@ static ssize_t dvb_dvr_write(struct file
 static ssize_t dvb_dvr_read(struct file *file, char __user *buf, size_t count,
 		loff_t *ppos)
 {
-	struct dvb_device *dvbdev=(struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev=(struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 	int ret;
 
 	//down(&dmxdev->mutex);
@@ -345,7 +345,7 @@ static int dvb_dmxdev_section_callback(c
 			    const u8 *buffer2, size_t buffer2_len,
 			    struct dmx_section_filter *filter, enum dmx_success success)
 {
-	struct dmxdev_filter *dmxdevfilter=(struct dmxdev_filter *) filter->priv;
+	struct dmxdev_filter *dmxdevfilter = filter->priv;
 	int ret;
 
 	if (dmxdevfilter->buffer.error) {
@@ -381,7 +381,7 @@ static int dvb_dmxdev_ts_callback(const 
 		       const u8 *buffer2, size_t buffer2_len,
 		       struct dmx_ts_feed *feed, enum dmx_success success)
 {
-	struct dmxdev_filter *dmxdevfilter=(struct dmxdev_filter *) feed->priv;
+	struct dmxdev_filter *dmxdevfilter = feed->priv;
 	struct dmxdev_buffer *buffer;
 	int ret;
 
@@ -684,8 +684,8 @@ static int dvb_dmxdev_filter_start(struc
 
 static int dvb_demux_open(struct inode *inode, struct file *file)
 {
-	struct dvb_device *dvbdev=(struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev=(struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 	int i;
 	struct dmxdev_filter *dmxdevfilter;
 
@@ -1013,8 +1013,8 @@ static struct dvb_device dvbdev_demux = 
 static int dvb_dvr_do_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, void *parg)
 {
-	struct dvb_device *dvbdev=(struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev=(struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 
 	int ret=0;
 
@@ -1044,8 +1044,8 @@ static int dvb_dvr_ioctl(struct inode *i
 
 static unsigned int dvb_dvr_poll (struct file *file, poll_table *wait)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dmxdev *dmxdev = (struct dmxdev *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dmxdev *dmxdev = dvbdev->priv;
 	unsigned int mask = 0;
 
 	dprintk ("function : %s\n", __FUNCTION__);
Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-05-08 20:24:45.000000000 +0200
@@ -829,7 +829,7 @@ EXPORT_SYMBOL(dvb_ca_en50221_camready_ir
  */
 void dvb_ca_en50221_camchange_irq(struct dvb_ca_en50221 *pubca, int slot, int change_type)
 {
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) pubca->private;
+	struct dvb_ca_private *ca = pubca->private;
 
 	dprintk("CAMCHANGE IRQ slot:%i change_type:%i\n", slot, change_type);
 
@@ -857,7 +857,7 @@ EXPORT_SYMBOL(dvb_ca_en50221_frda_irq);
  */
 void dvb_ca_en50221_camready_irq(struct dvb_ca_en50221 *pubca, int slot)
 {
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) pubca->private;
+	struct dvb_ca_private *ca = pubca->private;
 
 	dprintk("CAMREADY IRQ slot:%i\n", slot);
 
@@ -876,7 +876,7 @@ void dvb_ca_en50221_camready_irq(struct 
  */
 void dvb_ca_en50221_frda_irq(struct dvb_ca_en50221 *pubca, int slot)
 {
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) pubca->private;
+	struct dvb_ca_private *ca = pubca->private;
 	int flags;
 
 	dprintk("FR/DA IRQ slot:%i\n", slot);
@@ -993,7 +993,7 @@ static void dvb_ca_en50221_thread_update
  */
 static int dvb_ca_en50221_thread(void *data)
 {
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) data;
+	struct dvb_ca_private *ca = data;
 	char name[15];
 	int slot;
 	int flags;
@@ -1202,8 +1202,8 @@ static int dvb_ca_en50221_thread(void *d
 static int dvb_ca_en50221_io_do_ioctl(struct inode *inode, struct file *file,
 				      unsigned int cmd, void *parg)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_ca_private *ca = dvbdev->priv;
 	int err = 0;
 	int slot;
 
@@ -1225,7 +1225,7 @@ static int dvb_ca_en50221_io_do_ioctl(st
 		break;
 
 	case CA_GET_CAP: {
-		struct ca_caps *caps = (struct ca_caps *) parg;
+		struct ca_caps *caps = parg;
 
 		caps->slot_num = ca->slot_count;
 		caps->slot_type = CA_CI_LINK;
@@ -1235,7 +1235,7 @@ static int dvb_ca_en50221_io_do_ioctl(st
 	}
 
 	case CA_GET_SLOT_INFO: {
-		struct ca_slot_info *info = (struct ca_slot_info *) parg;
+		struct ca_slot_info *info = parg;
 
 		if ((info->num > ca->slot_count) || (info->num < 0))
 			return -EINVAL;
@@ -1291,8 +1291,8 @@ static int dvb_ca_en50221_io_ioctl(struc
 static ssize_t dvb_ca_en50221_io_write(struct file *file,
 				       const char __user * buf, size_t count, loff_t * ppos)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_ca_private *ca = dvbdev->priv;
 	u8 slot, connection_id;
 	int status;
 	char fragbuf[HOST_LINK_BUF_SIZE];
@@ -1428,8 +1428,8 @@ static int dvb_ca_en50221_io_read_condit
 static ssize_t dvb_ca_en50221_io_read(struct file *file, char __user * buf,
 				      size_t count, loff_t * ppos)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_ca_private *ca = dvbdev->priv;
 	int status;
 	int result = 0;
 	u8 hdr[2];
@@ -1526,8 +1526,8 @@ static ssize_t dvb_ca_en50221_io_read(st
  */
 static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_ca_private *ca = dvbdev->priv;
 	int err;
 	int i;
 
@@ -1569,8 +1569,8 @@ static int dvb_ca_en50221_io_open(struct
  */
 static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_ca_private *ca = dvbdev->priv;
 	int err = 0;
 
 	dprintk("%s\n", __FUNCTION__);
@@ -1597,8 +1597,8 @@ static int dvb_ca_en50221_io_release(str
  */
 static unsigned int dvb_ca_en50221_io_poll(struct file *file, poll_table * wait)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_ca_private *ca = dvbdev->priv;
 	unsigned int mask = 0;
 	int slot;
 	int result = 0;
@@ -1750,7 +1750,7 @@ EXPORT_SYMBOL(dvb_ca_en50221_release);
  */
 void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 {
-	struct dvb_ca_private *ca = (struct dvb_ca_private *) pubca->private;
+	struct dvb_ca_private *ca = pubca->private;
 	int i;
 
 	dprintk("%s\n", __FUNCTION__);
Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-05-08 20:24:43.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-05-08 20:24:45.000000000 +0200
@@ -117,7 +117,7 @@ struct dvb_frontend_private {
 
 static void dvb_frontend_add_event(struct dvb_frontend *fe, fe_status_t status)
 {
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	struct dvb_fe_events *events = &fepriv->events;
 	struct dvb_frontend_event *e;
 	int wp;
@@ -155,7 +155,7 @@ static void dvb_frontend_add_event(struc
 static int dvb_frontend_get_event(struct dvb_frontend *fe,
 			    struct dvb_frontend_event *event, int flags)
 {
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	struct dvb_fe_events *events = &fepriv->events;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -234,7 +234,7 @@ static int dvb_frontend_autotune(struct 
 {
 	int autoinversion;
 	int ready = 0;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int original_inversion = fepriv->parameters.inversion;
 	u32 original_frequency = fepriv->parameters.frequency;
 
@@ -321,7 +321,7 @@ static int dvb_frontend_autotune(struct 
 
 static int dvb_frontend_is_exiting(struct dvb_frontend *fe)
 {
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	if (fepriv->exit)
 		return 1;
@@ -335,7 +335,7 @@ static int dvb_frontend_is_exiting(struc
 
 static int dvb_frontend_should_wakeup(struct dvb_frontend *fe)
 {
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	if (fepriv->wakeup) {
 		fepriv->wakeup = 0;
@@ -346,7 +346,7 @@ static int dvb_frontend_should_wakeup(st
 
 static void dvb_frontend_wakeup(struct dvb_frontend *fe)
 {
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	fepriv->wakeup = 1;
 	wake_up_interruptible(&fepriv->wait_queue);
@@ -357,8 +357,8 @@ static void dvb_frontend_wakeup(struct d
  */
 static int dvb_frontend_thread(void *data)
 {
-	struct dvb_frontend *fe = (struct dvb_frontend *) data;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend *fe = data;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	unsigned long timeout;
 	char name [15];
 	int quality = 0, delay = 3*HZ;
@@ -520,7 +520,7 @@ static int dvb_frontend_thread(void *dat
 static void dvb_frontend_stop(struct dvb_frontend *fe)
 {
 	unsigned long ret;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -559,7 +559,7 @@ static void dvb_frontend_stop(struct dvb
 static int dvb_frontend_start(struct dvb_frontend *fe)
 {
 	int ret;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -597,7 +597,7 @@ static int dvb_frontend_ioctl(struct ino
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int err = -EOPNOTSUPP;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -615,7 +615,7 @@ static int dvb_frontend_ioctl(struct ino
 
 	switch (cmd) {
 	case FE_GET_INFO: {
-		struct dvb_frontend_info* info = (struct dvb_frontend_info*) parg;
+		struct dvb_frontend_info* info = parg;
 		memcpy(info, &fe->ops->info, sizeof(struct dvb_frontend_info));
 
 		/* Force the CAN_INVERSION_AUTO bit on. If the frontend doesn't
@@ -793,7 +793,7 @@ static unsigned int dvb_frontend_poll(st
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -809,7 +809,7 @@ static int dvb_frontend_open(struct inod
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int ret;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -833,7 +833,7 @@ static int dvb_frontend_release(struct i
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -873,7 +873,7 @@ int dvb_register_frontend(struct dvb_ada
 		up(&frontend_mutex);
 		return -ENOMEM;
 	}
-	fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	fepriv = fe->frontend_priv;
 	memset(fe->frontend_priv, 0, sizeof(struct dvb_frontend_private));
 
 	init_MUTEX (&fepriv->sem);
@@ -897,7 +897,7 @@ EXPORT_SYMBOL(dvb_register_frontend);
 
 int dvb_unregister_frontend(struct dvb_frontend* fe)
 {
-	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	dprintk ("%s\n", __FUNCTION__);
 
 	down (&frontend_mutex);
Index: linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_net.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/dvb-core/dvb_net.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/dvb-core/dvb_net.c	2005-05-08 20:24:45.000000000 +0200
@@ -315,7 +315,7 @@ static inline void reset_ule( struct dvb
  */
 static void dvb_net_ule( struct net_device *dev, const u8 *buf, size_t buf_len )
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv *)dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 	unsigned long skipped = 0L;
 	u8 *ts, *ts_end, *from_where = NULL, ts_remain = 0, how_much = 0, new_ts = 1;
 	struct ethhdr *ethh = NULL;
@@ -709,7 +709,7 @@ static int dvb_net_ts_callback(const u8 
 			       const u8 *buffer2, size_t buffer2_len,
 			       struct dmx_ts_feed *feed, enum dmx_success success)
 {
-	struct net_device *dev = (struct net_device *)feed->priv;
+	struct net_device *dev = feed->priv;
 
 	if (buffer2 != 0)
 		printk(KERN_WARNING "buffer2 not 0: %p.\n", buffer2);
@@ -801,7 +801,7 @@ static int dvb_net_sec_callback(const u8
 		 struct dmx_section_filter *filter,
 		 enum dmx_success success)
 {
-        struct net_device *dev=(struct net_device *) filter->priv;
+        struct net_device *dev = filter->priv;
 
 	/**
 	 * we rely on the DVB API definition where exactly one complete
@@ -826,7 +826,7 @@ static int dvb_net_filter_sec_set(struct
 		   struct dmx_section_filter **secfilter,
 		   u8 *mac, u8 *mac_mask)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 	int ret;
 
 	*secfilter=NULL;
@@ -870,7 +870,7 @@ static int dvb_net_filter_sec_set(struct
 static int dvb_net_feed_start(struct net_device *dev)
 {
 	int ret, i;
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
         struct dmx_demux *demux = priv->demux;
         unsigned char *mac = (unsigned char *) dev->dev_addr;
 
@@ -965,7 +965,7 @@ static int dvb_net_feed_start(struct net
 
 static int dvb_net_feed_stop(struct net_device *dev)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 	int i;
 
 	dprintk("%s\n", __FUNCTION__);
@@ -1016,7 +1016,7 @@ static int dvb_net_feed_stop(struct net_
 
 static int dvb_set_mc_filter (struct net_device *dev, struct dev_mc_list *mc)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 
 	if (priv->multi_num == DVB_NET_MULTICAST_MAX)
 		return -ENOMEM;
@@ -1031,7 +1031,7 @@ static int dvb_set_mc_filter (struct net
 static void wq_set_multicast_list (void *data)
 {
 	struct net_device *dev = data;
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 
 	dvb_net_feed_stop(dev);
 
@@ -1066,7 +1066,7 @@ static void wq_set_multicast_list (void 
 
 static void dvb_net_set_multicast_list (struct net_device *dev)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 	schedule_work(&priv->set_multicast_list_wq);
 }
 
@@ -1084,7 +1084,7 @@ static void wq_restart_net_feed (void *d
 
 static int dvb_net_set_mac (struct net_device *dev, void *p)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 	struct sockaddr *addr=p;
 
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
@@ -1098,7 +1098,7 @@ static int dvb_net_set_mac (struct net_d
 
 static int dvb_net_open(struct net_device *dev)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 
 	priv->in_use++;
 	dvb_net_feed_start(dev);
@@ -1108,7 +1108,7 @@ static int dvb_net_open(struct net_devic
 
 static int dvb_net_stop(struct net_device *dev)
 {
-	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct dvb_net_priv *priv = dev->priv;
 
 	priv->in_use--;
         return dvb_net_feed_stop(dev);
@@ -1228,8 +1228,8 @@ static int dvb_net_remove_if(struct dvb_
 static int dvb_net_do_ioctl(struct inode *inode, struct file *file,
 		  unsigned int cmd, void *parg)
 {
-	struct dvb_device *dvbdev = (struct dvb_device *) file->private_data;
-	struct dvb_net *dvbnet = (struct dvb_net *) dvbdev->priv;
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_net *dvbnet = dvbdev->priv;
 
 	if (((file->f_flags&O_ACCMODE)==O_RDONLY))
 		return -EPERM;
@@ -1237,7 +1237,7 @@ static int dvb_net_do_ioctl(struct inode
 	switch (cmd) {
 	case NET_ADD_IF:
 	{
-		struct dvb_net_if *dvbnetif=(struct dvb_net_if *)parg;
+		struct dvb_net_if *dvbnetif = parg;
 		int result;
 
 		if (!capable(CAP_SYS_ADMIN))
@@ -1258,7 +1258,7 @@ static int dvb_net_do_ioctl(struct inode
 	{
 		struct net_device *netdev;
 		struct dvb_net_priv *priv_data;
-		struct dvb_net_if *dvbnetif=(struct dvb_net_if *)parg;
+		struct dvb_net_if *dvbnetif = parg;
 
 		if (dvbnetif->if_num >= DVB_NET_DEVICES_MAX ||
 		    !dvbnet->state[dvbnetif->if_num])
@@ -1266,7 +1266,7 @@ static int dvb_net_do_ioctl(struct inode
 
 		netdev = dvbnet->device[dvbnetif->if_num];
 
-		priv_data=(struct dvb_net_priv*)netdev->priv;
+		priv_data = netdev->priv;
 		dvbnetif->pid=priv_data->pid;
 		dvbnetif->feedtype=priv_data->feedtype;
 		break;
@@ -1288,7 +1288,7 @@ static int dvb_net_do_ioctl(struct inode
 	/* binary compatiblity cruft */
 	case __NET_ADD_IF_OLD:
 	{
-		struct __dvb_net_if_old *dvbnetif=(struct __dvb_net_if_old *)parg;
+		struct __dvb_net_if_old *dvbnetif = parg;
 		int result;
 
 		if (!capable(CAP_SYS_ADMIN))
@@ -1309,7 +1309,7 @@ static int dvb_net_do_ioctl(struct inode
 	{
 		struct net_device *netdev;
 		struct dvb_net_priv *priv_data;
-		struct __dvb_net_if_old *dvbnetif=(struct __dvb_net_if_old *)parg;
+		struct __dvb_net_if_old *dvbnetif = parg;
 
 		if (dvbnetif->if_num >= DVB_NET_DEVICES_MAX ||
 		    !dvbnet->state[dvbnetif->if_num])
@@ -1317,7 +1317,7 @@ static int dvb_net_do_ioctl(struct inode
 
 		netdev = dvbnet->device[dvbnetif->if_num];
 
-		priv_data=(struct dvb_net_priv*)netdev->priv;
+		priv_data = netdev->priv;
 		dvbnetif->pid=priv_data->pid;
 		break;
 	}

--

