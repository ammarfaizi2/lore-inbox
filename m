Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVIHWX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVIHWX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVIHWXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:23:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:37054 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965048AbVIHWWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:55 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Added inline functions on top of container_of().
In-Reply-To: <11262181614069@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:41 -0700
Message-Id: <11262181613474@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Added inline functions on top of container_of().

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit db2d0008de519c5db6baec45f7831e08790301cf
tree f100b05ab42f54740b967a24ba07d79518337f8e
parent 5e8eb8501212eb92826ccf191f9ca8c186f531c3
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:49 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/w1.c       |   22 ++++++++++------------
 drivers/w1/w1.h       |   15 +++++++++++++++
 drivers/w1/w1_smem.c  |    6 ++----
 drivers/w1/w1_therm.c |    6 ++----
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -89,15 +89,13 @@ static int w1_master_remove(struct devic
 
 static void w1_master_release(struct device *dev)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-
+	struct w1_master *md = dev_to_w1_master(dev);
 	complete(&md->dev_released);
 }
 
 static void w1_slave_release(struct device *dev)
 {
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
+	struct w1_slave *sl = dev_to_w1_slave(dev);
 	complete(&sl->dev_released);
 }
 
@@ -162,7 +160,7 @@ struct device w1_slave_device = {
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
 	if (down_interruptible (&md->mutex))
@@ -179,7 +177,7 @@ static ssize_t w1_master_attribute_store
 						struct device_attribute *attr,
 						const char * buf, size_t count)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 
 	if (down_interruptible (&md->mutex))
 		return -EBUSY;
@@ -195,7 +193,7 @@ static ssize_t w1_master_attribute_show_
 					       struct device_attribute *attr,
 					       char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
 	if (down_interruptible (&md->mutex))
@@ -210,7 +208,7 @@ static ssize_t w1_master_attribute_show_
 
 static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
 	if (down_interruptible(&md->mutex))
@@ -231,7 +229,7 @@ static ssize_t w1_master_attribute_show_
 
 static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
 	if (down_interruptible(&md->mutex))
@@ -245,7 +243,7 @@ static ssize_t w1_master_attribute_show_
 
 static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
 	if (down_interruptible(&md->mutex))
@@ -259,7 +257,7 @@ static ssize_t w1_master_attribute_show_
 
 static ssize_t w1_master_attribute_show_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
 	if (down_interruptible(&md->mutex))
@@ -273,7 +271,7 @@ static ssize_t w1_master_attribute_show_
 
 static ssize_t w1_master_attribute_show_slaves(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_master *md = dev_to_w1_master(dev);
 	int c = PAGE_SIZE;
 
 	if (down_interruptible(&md->mutex))
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -191,6 +191,21 @@ struct w1_master
 int w1_create_master_attributes(struct w1_master *);
 void w1_search(struct w1_master *dev, w1_slave_found_callback cb);
 
+static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
+{
+	return container_of(dev, struct w1_slave, dev);
+}
+
+static inline struct w1_slave* kobj_to_w1_slave(struct kobject *kobj)
+{
+	return dev_to_w1_slave(container_of(kobj, struct device, kobj));
+}
+
+static inline struct w1_master* dev_to_w1_master(struct device *dev)
+{
+	return container_of(dev, struct w1_master, dev);
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
diff --git a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c
+++ b/drivers/w1/w1_smem.c
@@ -46,15 +46,13 @@ static struct w1_family_ops w1_smem_fops
 
 static ssize_t w1_smem_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
+	struct w1_slave *sl = dev_to_w1_slave(dev);
 	return sprintf(buf, "%s\n", sl->name);
 }
 
 static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
-	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-					   struct w1_slave, dev);
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int i;
 
 	atomic_inc(&sl->refcnt);
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -92,8 +92,7 @@ static struct w1_therm_family_converter 
 
 static ssize_t w1_therm_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
+	struct w1_slave *sl = dev_to_w1_slave(dev);
 	return sprintf(buf, "%s\n", sl->name);
 }
 
@@ -148,8 +147,7 @@ static int w1_therm_check_rom(u8 rom[9])
 
 static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
-	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-					   struct w1_slave, dev);
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	struct w1_master *dev = sl->master;
 	u8 rom[9], crc, verdict;
 	int i, max_trying = 10;

