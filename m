Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVFVG5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVFVG5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVFVGqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:46:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:20636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262791AbVFVFWB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:01 -0400
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] I2C: sysfs names: rename to cpu0_vid, take 3
In-Reply-To: <11194174641478@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174643895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: sysfs names: rename to cpu0_vid, take 3

This small patch changes two drivers, adm1025 and adm1026, to
report vid as cpu0_vid sysfs name as used by the other drivers.

Added duplicated names and six month warning for old names to
be removed as requested.  Compile tested.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 937df8df907ce63b0f7e19adf6e3cdef1687fac3
tree 4ac2a146290bcda4c741fa82b3a09e2d42f773b5
parent abc01922477104e8d72b494902aff37135c409e7
author Grant Coady <grant_lkml@dodo.com.au> Thu, 12 May 2005 11:59:29 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:56 -0700

 Documentation/feature-removal-schedule.txt |   10 ++++++++++
 drivers/i2c/chips/adm1025.c                |    4 ++++
 drivers/i2c/chips/adm1026.c                |    5 ++++-
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -83,3 +83,13 @@ Why:	Deprecated in favour of the new ioc
 	more efficient.  You should really be using libraw1394 for raw1394
 	access anyway.
 Who:	Jody McIntyre <scjody@steamballoon.com>
+
+---------------------------
+
+What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
+When:	November 2005
+Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
+Why:	Match the other drivers' name for the same function, duplicate names
+	will be available until removal of old names.
+Who:	Grant Coady <gcoady@gmail.com>
+
diff --git a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c
+++ b/drivers/i2c/chips/adm1025.c
@@ -286,7 +286,9 @@ static ssize_t show_vid(struct device *d
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
+/* in1_ref is deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -436,7 +438,9 @@ static int adm1025_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	/* in1_ref is deprecated, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_in1_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
diff --git a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c
+++ b/drivers/i2c/chips/adm1026.c
@@ -1224,8 +1224,9 @@ static ssize_t show_vid_reg(struct devic
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
-
+/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -1665,7 +1666,9 @@ int adm1026_detect(struct i2c_adapter *a
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
+	/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);

