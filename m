Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbVKDJVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVKDJVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 04:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbVKDJVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 04:21:36 -0500
Received: from [85.8.13.51] ([85.8.13.51]:22678 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932697AbVKDJVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 04:21:36 -0500
Message-ID: <436B2819.4090909@drzeus.cx>
Date: Fri, 04 Nov 2005 10:21:29 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>
Subject: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Content-Type: multipart/mixed;
 boundary="------------020405020003030501090807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020405020003030501090807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Perhaps Mr Morton can have a look? This patch is probably -mm material 
anyhow.

Rgds
Pierre


--------------020405020003030501090807
Content-Type: message/rfc822;
 name="[PATCH] [PNP][RFC] Suspend support for PNP bus."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] [PNP][RFC] Suspend support for PNP bus."

X-Virus-Scanned: by clamdfilter 1.1
X-Virus-Status: No
Delivered-To: drzeus-list@drzeus.cx
Return-Path: <linux-kernel-owner+drzeus-list=40drzeus.cx-S965176AbVJ1Hiz@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [::ffff:209.132.176.167])
  by mail.drzeus.cx with esmtp; Fri, 28 Oct 2005 09:39:17 +0200
  id 00AACE63.4361D5A5.00005AD9
Received-SPF: none (Address does not pass the Sender Policy Framework)
  SPF=HELO;
  sender=vger.kernel.org;
  remoteip=::ffff:209.132.176.167;
  remotehost=vger.kernel.org;
  helo=vger.kernel.org;
  receiver=mail.drzeus.cx;
Received-SPF: none (Address does not pass the Sender Policy Framework)
  SPF=MAILFROM;
  sender=linux-kernel-owner+drzeus-list=40drzeus.cx-S965176AbVJ1Hiz@vger.kernel.org;
  remoteip=::ffff:209.132.176.167;
  remotehost=vger.kernel.org;
  helo=vger.kernel.org;
  receiver=mail.drzeus.cx;
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVJ1Hiz (ORCPT <rfc822;drzeus-list@drzeus.cx>);
	Fri, 28 Oct 2005 03:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVJ1Hiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:38:55 -0400
Received: from [85.8.13.51] ([85.8.13.51]:54162 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965176AbVJ1Hiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:38:54 -0400
Received: from poseidon.drzeus.cx (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: LOGIN drzeus)
  by smtp.drzeus.cx with esmtp; Fri, 28 Oct 2005 09:38:53 +0200
  id 0006271B.4361D58D.00000933
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [PNP][RFC] Suspend support for PNP bus.
Date: Fri, 28 Oct 2005 09:39:01 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051028073900.4148.83481.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Received-SPF: none (Address does not pass the Sender Policy Framework)
  SPF=FROM;
  sender=drzeus@drzeus.cx;
  remoteip=::ffff:209.132.176.167;
  remotehost=vger.kernel.org;
  helo=vger.kernel.org;
  receiver=mail.drzeus.cx;
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on hades.drzeus.cx
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 
	autolearn=unavailable version=3.0.4

Add support for suspending devices connected to the PNP bus. New
callbacks are added for the drivers and the PNP hardware layer is
told to disable the device during the suspend.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/pnp/driver.c  |   51 +++++++++++++++++++++++++++++++-
 drivers/pnp/manager.c |   78 +++++++++++++++++++++++++++++++++++++------------
 include/linux/pnp.h   |   10 +++++-
 3 files changed, 116 insertions(+), 23 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -146,10 +146,57 @@ static int pnp_bus_match(struct device *
 	return 1;
 }
 
+static int pnp_bus_suspend(struct device *dev, pm_message_t state)
+{
+	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver * drv = pnp_dev->driver;
+	int error;
+
+	if (!drv)
+		return 0;
+
+	if (drv->suspend) {
+		error = drv->suspend(pnp_dev, state);
+		if (error)
+			return error;
+	}
+
+	if (!(drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) &&
+	    pnp_can_disable(pnp_dev)) {
+	    	error = pnp_stop_dev(pnp_dev);
+	    	if (error)
+	    		return error;
+	}
+
+	return 0;
+}
+
+static int pnp_bus_resume(struct device *dev)
+{
+	struct pnp_dev * pnp_dev = to_pnp_dev(dev);
+	struct pnp_driver * drv = pnp_dev->driver;
+	int error;
+
+	if (!drv)
+		return 0;
+
+	if (!(drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
+		error = pnp_start_dev(pnp_dev);
+		if (error)
+			return error;
+	}
+
+	if (drv->resume)
+		return drv->resume(pnp_dev);
+
+	return 0;
+}
 
 struct bus_type pnp_bus_type = {
-	.name	= "pnp",
-	.match	= pnp_bus_match,
+	.name		= "pnp",
+	.match		= pnp_bus_match,
+	.suspend	= pnp_bus_suspend,
+	.resume		= pnp_bus_resume,
 };
 
 
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -468,6 +468,53 @@ int pnp_auto_config_dev(struct pnp_dev *
 }
 
 /**
+ * pnp_start_dev - low-level start of the PnP device
+ * @dev: pointer to the desired device
+ *
+ * assumes that resources have alread been allocated
+ */
+
+int pnp_start_dev(struct pnp_dev *dev)
+{
+	if (!pnp_can_write(dev)) {
+		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
+		return -EINVAL;
+	}
+
+	if (dev->protocol->set(dev, &dev->res)<0) {
+		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
+		return -EIO;
+	}
+
+	pnp_info("Device %s activated.", dev->dev.bus_id);
+
+	return 0;
+}
+
+/**
+ * pnp_stop_dev - low-level disable of the PnP device
+ * @dev: pointer to the desired device
+ *
+ * does not free resources
+ */
+
+int pnp_stop_dev(struct pnp_dev *dev)
+{
+	if (!pnp_can_disable(dev)) {
+		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
+		return -EINVAL;
+	}
+	if (dev->protocol->disable(dev)<0) {
+		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
+		return -EIO;
+	}
+
+	pnp_info("Device %s disabled.", dev->dev.bus_id);
+
+	return 0;
+}
+
+/**
  * pnp_activate_dev - activates a PnP device for use
  * @dev: pointer to the desired device
  *
@@ -475,6 +522,8 @@ int pnp_auto_config_dev(struct pnp_dev *
  */
 int pnp_activate_dev(struct pnp_dev *dev)
 {
+	int error;
+
 	if (!dev)
 		return -EINVAL;
 	if (dev->active) {
@@ -485,18 +534,11 @@ int pnp_activate_dev(struct pnp_dev *dev
 	if (pnp_auto_config_dev(dev))
 		return -EBUSY;
 
-	if (!pnp_can_write(dev)) {
-		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
-		return -EINVAL;
-	}
-
-	if (dev->protocol->set(dev, &dev->res)<0) {
-		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
-		return -EIO;
-	}
+	error = pnp_start_dev(dev);
+	if (error)
+		return error;
 
 	dev->active = 1;
-	pnp_info("Device %s activated.", dev->dev.bus_id);
 
 	return 1;
 }
@@ -509,23 +551,19 @@ int pnp_activate_dev(struct pnp_dev *dev
  */
 int pnp_disable_dev(struct pnp_dev *dev)
 {
+	int error;
+
         if (!dev)
                 return -EINVAL;
 	if (!dev->active) {
 		return 0; /* the device is already disabled */
 	}
 
-	if (!pnp_can_disable(dev)) {
-		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
-		return -EINVAL;
-	}
-	if (dev->protocol->disable(dev)<0) {
-		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
-		return -EIO;
-	}
+	error = pnp_stop_dev(dev);
+	if (error)
+		return error;
 
 	dev->active = 0;
-	pnp_info("Device %s disabled.", dev->dev.bus_id);
 
 	/* release the resources so that other devices can use them */
 	down(&pnp_res_mutex);
@@ -554,6 +592,8 @@ void pnp_resource_change(struct resource
 
 EXPORT_SYMBOL(pnp_manual_config_dev);
 EXPORT_SYMBOL(pnp_auto_config_dev);
+EXPORT_SYMBOL(pnp_start_dev);
+EXPORT_SYMBOL(pnp_stop_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_resource_change);
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -292,8 +292,10 @@ struct pnp_driver {
 	char * name;
 	const struct pnp_device_id *id_table;
 	unsigned int flags;
-	int  (*probe)  (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
-	void (*remove) (struct pnp_dev *dev);
+	int  (*probe)   (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
+	void (*remove)  (struct pnp_dev *dev);
+	int  (*suspend) (struct pnp_dev *dev, pm_message_t state);
+	int  (*resume)  (struct pnp_dev *dev);
 	struct device_driver driver;
 };
 
@@ -381,6 +383,8 @@ void pnp_init_resource_table(struct pnp_
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_validate_config(struct pnp_dev *dev);
+int pnp_start_dev(struct pnp_dev *dev);
+int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
@@ -425,6 +429,8 @@ static inline void pnp_init_resource_tab
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
+static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------020405020003030501090807--
