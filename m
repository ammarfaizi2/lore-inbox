Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVEQLO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVEQLO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVEQLO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:14:29 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:14687 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261374AbVEQKm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:42:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=rB9+3WKXd4gPt2Ui5qe40zqy4Dbydevb7drfEmUQIyrAdbY3IuEI5rGgbm/1pgggc+hGJa1bS7+xGy/21ASTXS3/c2ffffBHY6JMB4RQojo58WY23K818fDqJmmegKB7k3vqYjPx4+zdDOHPjHCU8ncC7+D+/KJy+/y2p73xWJI=
Message-ID: <2538186705051703422834d321@mail.gmail.com>
Date: Tue, 17 May 2005 06:42:58 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 9/15] drivers/i2c/chips/w83781d.c - drivers/s390/block/dcssblk.c: update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_280_21519119.1116326578072"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_280_21519119.1116326578072
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_280_21519119.1116326578072
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.4.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.4.diff.diffstat.txt"

 i2c/chips/w83781d.c          |   52 +++++++++++++++++++++----------------------
 i2c/chips/w83l785ts.c        |    4 +--
 i2c/i2c-core.c               |    4 +--
 ieee1394/nodemgr.c           |   16 ++++++-------
 ieee1394/sbp2.c              |    2 -
 input/gameport/gameport.c    |    4 +--
 input/keyboard/atkbd.c       |    4 +--
 input/mouse/psmouse.h        |    4 +--
 input/serio/serio.c          |   16 ++++++-------
 macintosh/therm_adt746x.c    |    8 +++---
 macintosh/therm_pm72.c       |    4 +--
 macintosh/therm_windtunnel.c |    4 +--
 mca/mca-bus.c                |    4 +--
 message/fusion/mptscsih.c    |    2 -
 mmc/mmc_sysfs.c              |    2 -
 pci/hotplug/cpqphp_sysfs.c   |    4 +--
 pci/hotplug/shpchp_sysfs.c   |    4 +--
 pci/pci-sysfs.c              |    6 ++--
 pcmcia/ds.c                  |    4 +--
 pnp/card.c                   |    4 +--
 pnp/interface.c              |    8 +++---
 s390/block/dasd_devmap.c     |   10 ++++----
 s390/block/dcssblk.c         |   24 +++++++++----------
 23 files changed, 97 insertions(+), 97 deletions(-)



------=_Part_280_21519119.1116326578072
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.4.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.4.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83781d.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83781d.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/w83781d.c	2005-05-16 23:45:52.000000000 -0400
@@ -309,18 +309,18 @@ store_in_reg(MAX, max);
 
 #define sysfs_in_offset(offset) \
 static ssize_t \
-show_regs_in_##offset (struct device *dev, char *buf) \
+show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
         return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
-static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_in_##reg (dev, buf, offset); \
 } \
-static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_in_##reg (dev, buf, count, offset); \
 } \
@@ -378,18 +378,18 @@ store_fan_min(struct device *dev, const 
 }
 
 #define sysfs_fan_offset(offset) \
-static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
-static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_min(dev, buf, offset); \
 } \
-static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_fan_min(dev, buf, count, offset); \
 } \
@@ -452,18 +452,18 @@ store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
-show_regs_temp_##offset (struct device *dev, char *buf) \
+show_regs_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
-static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp_##reg (dev, buf, offset); \
 } \
-static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_temp_##reg (dev, buf, count, offset); \
 } \
@@ -486,7 +486,7 @@ device_create_file(&client->dev, &dev_at
 } while (0)
 
 static ssize_t
-show_vid_reg(struct device *dev, char *buf)
+show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
@@ -497,14 +497,14 @@ DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_cpu0_vid);
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
+show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
 static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
@@ -521,7 +521,7 @@ DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm);
 static ssize_t
-show_alarms_reg(struct device *dev, char *buf)
+show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
@@ -531,13 +531,13 @@ static
 DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms);
-static ssize_t show_beep_mask (struct device *dev, char *buf)
+static ssize_t show_beep_mask (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
 		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
 }
-static ssize_t show_beep_enable (struct device *dev, char *buf)
+static ssize_t show_beep_enable (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
@@ -583,11 +583,11 @@ store_beep_reg(struct device *dev, const
 }
 
 #define sysfs_beep(REG, reg) \
-static ssize_t show_regs_beep_##reg (struct device *dev, char *buf) \
+static ssize_t show_regs_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
-	return show_beep_##reg(dev, buf); \
+	return show_beep_##reg(dev, attr, buf); \
 } \
-static ssize_t store_regs_beep_##reg (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_beep_##reg (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
@@ -653,11 +653,11 @@ store_fan_div_reg(struct device *dev, co
 }
 
 #define sysfs_fan_div(offset) \
-static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
@@ -737,11 +737,11 @@ store_pwmenable_reg(struct device *dev, 
 }
 
 #define sysfs_pwm(offset) \
-static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_pwm_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_pwm_##offset (struct device *dev, \
+static ssize_t store_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, \
 		const char *buf, size_t count) \
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
@@ -750,11 +750,11 @@ static DEVICE_ATTR(pwm##offset, S_IRUGO 
 		show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 #define sysfs_pwmenable(offset) \
-static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_pwmenable_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_pwmenable_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_pwmenable_##offset (struct device *dev, \
+static ssize_t store_regs_pwmenable_##offset (struct device *dev, struct device_attribute *attr, \
 		const char *buf, size_t count) \
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
@@ -832,11 +832,11 @@ store_sensor_reg(struct device *dev, con
 }
 
 #define sysfs_sensor(offset) \
-static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
     return show_sensor_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83l785ts.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83l785ts.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/w83l785ts.c	2005-05-16 23:45:52.000000000 -0400
@@ -118,13 +118,13 @@ struct w83l785ts_data {
  * Sysfs stuff
  */
 
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83l785ts_data *data = w83l785ts_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, char *buf)
+static ssize_t show_temp_over(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83l785ts_data *data = w83l785ts_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/i2c-core.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/i2c-core.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/i2c-core.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/i2c-core.c	2005-05-16 23:45:52.000000000 -0400
@@ -103,7 +103,7 @@ static struct class i2c_adapter_class = 
 	.release =	&i2c_adapter_class_dev_release,
 };
 
-static ssize_t show_adapter_name(struct device *dev, char *buf)
+static ssize_t show_adapter_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
 	return sprintf(buf, "%s\n", adap->name);
@@ -117,7 +117,7 @@ static void i2c_client_release(struct de
 	complete(&client->released);
 }
 
-static ssize_t show_client_name(struct device *dev, char *buf)
+static ssize_t show_client_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	return sprintf(buf, "%s\n", client->name);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/ieee1394/nodemgr.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/ieee1394/nodemgr.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/ieee1394/nodemgr.c	2005-05-16 20:36:03.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/ieee1394/nodemgr.c	2005-05-16 23:45:52.000000000 -0400
@@ -220,7 +220,7 @@ struct device nodemgr_dev_template_host 
 
 
 #define fw_attr(class, class_type, field, type, format_string)		\
-static ssize_t fw_show_##class##_##field (struct device *dev, char *buf)\
+static ssize_t fw_show_##class##_##field (struct device *dev, struct device_attribute *attr, char *buf)\
 {									\
 	class_type *class;						\
 	class = container_of(dev, class_type, device);			\
@@ -232,7 +232,7 @@ static struct device_attribute dev_attr_
 };
 
 #define fw_attr_td(class, class_type, td_kv)				\
-static ssize_t fw_show_##class##_##td_kv (struct device *dev, char *buf)\
+static ssize_t fw_show_##class##_##td_kv (struct device *dev, struct device_attribute *attr, char *buf)\
 {									\
 	int len;							\
 	class_type *class = container_of(dev, class_type, device);	\
@@ -265,7 +265,7 @@ static struct driver_attribute driver_at
 };
 
 
-static ssize_t fw_show_ne_bus_options(struct device *dev, char *buf)
+static ssize_t fw_show_ne_bus_options(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
 
@@ -281,7 +281,7 @@ static ssize_t fw_show_ne_bus_options(st
 static DEVICE_ATTR(bus_options,S_IRUGO,fw_show_ne_bus_options,NULL);
 
 
-static ssize_t fw_show_ne_tlabels_free(struct device *dev, char *buf)
+static ssize_t fw_show_ne_tlabels_free(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
 	return sprintf(buf, "%d\n", atomic_read(&ne->tpool->count.count) + 1);
@@ -289,7 +289,7 @@ static ssize_t fw_show_ne_tlabels_free(s
 static DEVICE_ATTR(tlabels_free,S_IRUGO,fw_show_ne_tlabels_free,NULL);
 
 
-static ssize_t fw_show_ne_tlabels_allocations(struct device *dev, char *buf)
+static ssize_t fw_show_ne_tlabels_allocations(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
 	return sprintf(buf, "%u\n", ne->tpool->allocations);
@@ -297,7 +297,7 @@ static ssize_t fw_show_ne_tlabels_alloca
 static DEVICE_ATTR(tlabels_allocations,S_IRUGO,fw_show_ne_tlabels_allocations,NULL);
 
 
-static ssize_t fw_show_ne_tlabels_mask(struct device *dev, char *buf)
+static ssize_t fw_show_ne_tlabels_mask(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
 #if (BITS_PER_LONG <= 32)
@@ -309,7 +309,7 @@ static ssize_t fw_show_ne_tlabels_mask(s
 static DEVICE_ATTR(tlabels_mask, S_IRUGO, fw_show_ne_tlabels_mask, NULL);
 
 
-static ssize_t fw_set_ignore_driver(struct device *dev, const char *buf, size_t count)
+static ssize_t fw_set_ignore_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct unit_directory *ud = container_of(dev, struct unit_directory, device);
 	int state = simple_strtoul(buf, NULL, 10);
@@ -324,7 +324,7 @@ static ssize_t fw_set_ignore_driver(stru
 
 	return count;
 }
-static ssize_t fw_get_ignore_driver(struct device *dev, char *buf)
+static ssize_t fw_get_ignore_driver(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct unit_directory *ud = container_of(dev, struct unit_directory, device);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/ieee1394/sbp2.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/ieee1394/sbp2.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/ieee1394/sbp2.c	2005-05-16 20:36:03.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/ieee1394/sbp2.c	2005-05-16 23:45:52.000000000 -0400
@@ -2766,7 +2766,7 @@ static const char *sbp2scsi_info (struct
         return "SCSI emulation for IEEE-1394 SBP-2 Devices";
 }
 
-static ssize_t sbp2_sysfs_ieee1394_id_show(struct device *dev, char *buf)
+static ssize_t sbp2_sysfs_ieee1394_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	struct scsi_id_instance_data *scsi_id;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/gameport/gameport.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/gameport/gameport.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/gameport/gameport.c	2005-05-16 20:35:58.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/gameport/gameport.c	2005-05-16 23:45:52.000000000 -0400
@@ -453,13 +453,13 @@ static int gameport_thread(void *nothing
  * Gameport port operations
  */
 
-static ssize_t gameport_show_description(struct device *dev, char *buf)
+static ssize_t gameport_show_description(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct gameport *gameport = to_gameport_port(dev);
 	return sprintf(buf, "%s\n", gameport->name);
 }
 
-static ssize_t gameport_rebind_driver(struct device *dev, const char *buf, size_t count)
+static ssize_t gameport_rebind_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct gameport *gameport = to_gameport_port(dev);
 	struct device_driver *drv;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/keyboard/atkbd.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/keyboard/atkbd.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/keyboard/atkbd.c	2005-05-16 20:35:58.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/keyboard/atkbd.c	2005-05-16 23:45:52.000000000 -0400
@@ -219,11 +219,11 @@ static ssize_t atkbd_attr_set_helper(str
 #define ATKBD_DEFINE_ATTR(_name)						\
 static ssize_t atkbd_show_##_name(struct atkbd *, char *);			\
 static ssize_t atkbd_set_##_name(struct atkbd *, const char *, size_t);		\
-static ssize_t atkbd_do_show_##_name(struct device *d, char *b)			\
+static ssize_t atkbd_do_show_##_name(struct device *d, struct device_attribute *attr, char *b)			\
 {										\
 	return atkbd_attr_show_helper(d, b, atkbd_show_##_name);		\
 }										\
-static ssize_t atkbd_do_set_##_name(struct device *d, const char *b, size_t s)	\
+static ssize_t atkbd_do_set_##_name(struct device *d, struct device_attribute *attr, const char *b, size_t s)	\
 {										\
 	return atkbd_attr_set_helper(d, b, s, atkbd_set_##_name);		\
 }										\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/mouse/psmouse.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/mouse/psmouse.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/mouse/psmouse.h	2005-05-16 20:35:58.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/mouse/psmouse.h	2005-05-16 23:45:52.000000000 -0400
@@ -91,11 +91,11 @@ ssize_t psmouse_attr_set_helper(struct d
 #define PSMOUSE_DEFINE_ATTR(_name)						\
 static ssize_t psmouse_attr_show_##_name(struct psmouse *, char *);		\
 static ssize_t psmouse_attr_set_##_name(struct psmouse *, const char *, size_t);\
-static ssize_t psmouse_do_show_##_name(struct device *d, char *b)		\
+static ssize_t psmouse_do_show_##_name(struct device *d, struct device_attribute *attr, char *b)		\
 {										\
 	return psmouse_attr_show_helper(d, b, psmouse_attr_show_##_name);	\
 }										\
-static ssize_t psmouse_do_set_##_name(struct device *d, const char *b, size_t s)\
+static ssize_t psmouse_do_set_##_name(struct device *d, struct device_attribute *attr, const char *b, size_t s)\
 {										\
 	return psmouse_attr_set_helper(d, b, s, psmouse_attr_set_##_name);	\
 }										\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/serio/serio.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/serio/serio.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/input/serio/serio.c	2005-05-16 20:35:58.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/input/serio/serio.c	2005-05-16 23:45:52.000000000 -0400
@@ -358,37 +358,37 @@ static int serio_thread(void *nothing)
  * Serio port operations
  */
 
-static ssize_t serio_show_description(struct device *dev, char *buf)
+static ssize_t serio_show_description(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-static ssize_t serio_show_id_type(struct device *dev, char *buf)
+static ssize_t serio_show_id_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.type);
 }
 
-static ssize_t serio_show_id_proto(struct device *dev, char *buf)
+static ssize_t serio_show_id_proto(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.proto);
 }
 
-static ssize_t serio_show_id_id(struct device *dev, char *buf)
+static ssize_t serio_show_id_id(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.id);
 }
 
-static ssize_t serio_show_id_extra(struct device *dev, char *buf)
+static ssize_t serio_show_id_extra(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.extra);
 }
 
-static ssize_t serio_rebind_driver(struct device *dev, const char *buf, size_t count)
+static ssize_t serio_rebind_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
 	struct device_driver *drv;
@@ -419,13 +419,13 @@ static ssize_t serio_rebind_driver(struc
 	return retval;
 }
 
-static ssize_t serio_show_bind_mode(struct device *dev, char *buf)
+static ssize_t serio_show_bind_mode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%s\n", serio->manual_bind ? "manual" : "auto");
 }
 
-static ssize_t serio_set_bind_mode(struct device *dev, const char *buf, size_t count)
+static ssize_t serio_set_bind_mode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
 	int retval;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/macintosh/therm_adt746x.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/macintosh/therm_adt746x.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/macintosh/therm_adt746x.c	2005-05-16 20:36:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/macintosh/therm_adt746x.c	2005-05-16 23:45:52.000000000 -0400
@@ -456,13 +456,13 @@ static int attach_one_thermostat(struct 
  *
  */
 #define BUILD_SHOW_FUNC_INT(name, data)				\
-static ssize_t show_##name(struct device *dev, char *buf)	\
+static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return sprintf(buf, "%d\n", data);			\
 }
 
 #define BUILD_SHOW_FUNC_FAN(name, data)				\
-static ssize_t show_##name(struct device *dev, char *buf)       \
+static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)       \
 {								\
 	return sprintf(buf, "%d (%d rpm)\n", 			\
 		thermostat->last_speed[data],			\
@@ -471,7 +471,7 @@ static ssize_t show_##name(struct device
 }
 
 #define BUILD_STORE_FUNC_DEG(name, data)			\
-static ssize_t store_##name(struct device *dev, const char *buf, size_t n) \
+static ssize_t store_##name(struct device *dev, struct device_attribute *attr, const char *buf, size_t n) \
 {								\
 	int val;						\
 	int i;							\
@@ -484,7 +484,7 @@ static ssize_t store_##name(struct devic
 }
 
 #define BUILD_STORE_FUNC_INT(name, data)			\
-static ssize_t store_##name(struct device *dev, const char *buf, size_t n) \
+static ssize_t store_##name(struct device *dev, struct device_attribute *attr, const char *buf, size_t n) \
 {								\
 	u32 val;						\
 	val = simple_strtoul(buf, NULL, 10);			\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/macintosh/therm_pm72.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/macintosh/therm_pm72.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/macintosh/therm_pm72.c	2005-05-16 20:36:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/macintosh/therm_pm72.c	2005-05-16 23:45:52.000000000 -0400
@@ -685,7 +685,7 @@ static void fetch_cpu_pumps_minmax(void)
  * the input twice... I accept patches :)
  */
 #define BUILD_SHOW_FUNC_FIX(name, data)				\
-static ssize_t show_##name(struct device *dev, char *buf)	\
+static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	ssize_t r;						\
 	down(&driver_lock);					\
@@ -694,7 +694,7 @@ static ssize_t show_##name(struct device
 	return r;						\
 }
 #define BUILD_SHOW_FUNC_INT(name, data)				\
-static ssize_t show_##name(struct device *dev, char *buf)	\
+static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return sprintf(buf, "%d", data);			\
 }
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/macintosh/therm_windtunnel.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/macintosh/therm_windtunnel.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/macintosh/therm_windtunnel.c	2005-05-16 20:36:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/macintosh/therm_windtunnel.c	2005-05-16 23:45:52.000000000 -0400
@@ -107,13 +107,13 @@ print_temp( const char *s, int temp )
 }
 
 static ssize_t
-show_cpu_temperature( struct device *dev, char *buf )
+show_cpu_temperature( struct device *dev, struct device_attribute *attr, char *buf )
 {
 	return sprintf(buf, "%d.%d\n", x.temp>>8, (x.temp & 255)*10/256 );
 }
 
 static ssize_t
-show_case_temperature( struct device *dev, char *buf )
+show_case_temperature( struct device *dev, struct device_attribute *attr, char *buf )
 {
 	return sprintf(buf, "%d.%d\n", x.casetemp>>8, (x.casetemp & 255)*10/256 );
 }
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/mca/mca-bus.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/mca/mca-bus.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/mca/mca-bus.c	2005-05-16 20:35:35.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/mca/mca-bus.c	2005-05-16 23:45:52.000000000 -0400
@@ -69,7 +69,7 @@ struct bus_type mca_bus_type = {
 };
 EXPORT_SYMBOL (mca_bus_type);
 
-static ssize_t mca_show_pos_id(struct device *dev, char *buf)
+static ssize_t mca_show_pos_id(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	/* four digits, \n and trailing \0 */
 	struct mca_device *mca_dev = to_mca_device(dev);
@@ -81,7 +81,7 @@ static ssize_t mca_show_pos_id(struct de
 		len = sprintf(buf, "none\n");
 	return len;
 }
-static ssize_t mca_show_pos(struct device *dev, char *buf)
+static ssize_t mca_show_pos(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	/* enough for 8 two byte hex chars plus space and new line */
 	int j, len=0;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/message/fusion/mptscsih.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/message/fusion/mptscsih.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/message/fusion/mptscsih.c	2005-05-16 20:36:03.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/message/fusion/mptscsih.c	2005-05-16 23:45:52.000000000 -0400
@@ -2759,7 +2759,7 @@ slave_configure_exit:
 }
 
 static ssize_t
-mptscsih_store_queue_depth(struct device *dev, const char *buf, size_t count)
+mptscsih_store_queue_depth(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int			 depth;
 	struct scsi_device	*sdev = to_scsi_device(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/mmc/mmc_sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/mmc/mmc_sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/mmc/mmc_sysfs.c	2005-05-16 20:35:35.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/mmc/mmc_sysfs.c	2005-05-16 23:45:52.000000000 -0400
@@ -22,7 +22,7 @@
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
 
 #define MMC_ATTR(name, fmt, args...)					\
-static ssize_t mmc_##name##_show (struct device *dev, char *buf)	\
+static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	struct mmc_card *card = dev_to_mmc_card(dev);			\
 	return sprintf(buf, fmt, args);					\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pci/hotplug/cpqphp_sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pci/hotplug/cpqphp_sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pci/hotplug/cpqphp_sysfs.c	2005-05-16 20:35:43.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pci/hotplug/cpqphp_sysfs.c	2005-05-16 23:45:52.000000000 -0400
@@ -38,7 +38,7 @@
 
 /* A few routines that create sysfs entries for the hot plug controller */
 
-static ssize_t show_ctrl (struct device *dev, char *buf)
+static ssize_t show_ctrl (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
@@ -82,7 +82,7 @@ static ssize_t show_ctrl (struct device 
 }
 static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-static ssize_t show_dev (struct device *dev, char *buf)
+static ssize_t show_dev (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pci/hotplug/shpchp_sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pci/hotplug/shpchp_sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pci/hotplug/shpchp_sysfs.c	2005-05-16 20:35:43.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pci/hotplug/shpchp_sysfs.c	2005-05-16 23:45:52.000000000 -0400
@@ -38,7 +38,7 @@
 
 /* A few routines that create sysfs entries for the hot plug controller */
 
-static ssize_t show_ctrl (struct device *dev, char *buf)
+static ssize_t show_ctrl (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
@@ -82,7 +82,7 @@ static ssize_t show_ctrl (struct device 
 }
 static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-static ssize_t show_dev (struct device *dev, char *buf)
+static ssize_t show_dev (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev;
 	struct controller *ctrl;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pci/pci-sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pci/pci-sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pci/pci-sysfs.c	2005-05-16 20:35:43.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pci/pci-sysfs.c	2005-05-16 23:45:52.000000000 -0400
@@ -29,7 +29,7 @@ static int sysfs_initialized;	/* = 0 */
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
-field##_show(struct device *dev, char *buf)				\
+field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct pci_dev *pdev;						\
 									\
@@ -44,7 +44,7 @@ pci_config_attr(subsystem_device, "0x%04
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
 
-static ssize_t local_cpus_show(struct device *dev, char *buf)
+static ssize_t local_cpus_show(struct device *dev, struct device_attribute *attr, char *buf)
 {		
 	cpumask_t mask = pcibus_to_cpumask(to_pci_dev(dev)->bus);
 	int len = cpumask_scnprintf(buf, PAGE_SIZE-2, mask);
@@ -54,7 +54,7 @@ static ssize_t local_cpus_show(struct de
 
 /* show resources */
 static ssize_t
-resource_show(struct device * dev, char * buf)
+resource_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pcmcia/ds.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pcmcia/ds.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pcmcia/ds.c	2005-05-16 20:36:04.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pcmcia/ds.c	2005-05-16 23:45:52.000000000 -0400
@@ -604,14 +604,14 @@ static int pcmcia_bus_match(struct devic
 /************************ per-device sysfs output ***************************/
 
 #define pcmcia_device_attr(field, test, format)				\
-static ssize_t field##_show (struct device *dev, char *buf)		\
+static ssize_t field##_show (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);		\
 	return p_dev->test ? sprintf (buf, format, p_dev->field) : -ENODEV; \
 }
 
 #define pcmcia_device_stringattr(name, field)					\
-static ssize_t name##_show (struct device *dev, char *buf)		\
+static ssize_t name##_show (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);		\
 	return p_dev->field ? sprintf (buf, "%s\n", p_dev->field) : -ENODEV; \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pnp/card.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pnp/card.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pnp/card.c	2005-05-16 20:35:43.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pnp/card.c	2005-05-16 23:45:52.000000000 -0400
@@ -140,7 +140,7 @@ static void pnp_release_card(struct devi
 }
 
 
-static ssize_t pnp_show_card_name(struct device *dmdev, char *buf)
+static ssize_t pnp_show_card_name(struct device *dmdev, struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_card *card = to_pnp_card(dmdev);
@@ -150,7 +150,7 @@ static ssize_t pnp_show_card_name(struct
 
 static DEVICE_ATTR(name,S_IRUGO,pnp_show_card_name,NULL);
 
-static ssize_t pnp_show_card_ids(struct device *dmdev, char *buf)
+static ssize_t pnp_show_card_ids(struct device *dmdev, struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_card *card = to_pnp_card(dmdev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pnp/interface.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pnp/interface.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/pnp/interface.c	2005-05-16 20:35:43.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/pnp/interface.c	2005-05-16 23:45:52.000000000 -0400
@@ -205,7 +205,7 @@ static void pnp_print_option(pnp_info_bu
 }
 
 
-static ssize_t pnp_show_options(struct device *dmdev, char *buf)
+static ssize_t pnp_show_options(struct device *dmdev, struct device_attribute *attr, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	struct pnp_option * independent = dev->independent;
@@ -236,7 +236,7 @@ static ssize_t pnp_show_options(struct d
 static DEVICE_ATTR(options,S_IRUGO,pnp_show_options,NULL);
 
 
-static ssize_t pnp_show_current_resources(struct device *dmdev, char *buf)
+static ssize_t pnp_show_current_resources(struct device *dmdev, struct device_attribute *attr, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	int i, ret;
@@ -308,7 +308,7 @@ static ssize_t pnp_show_current_resource
 extern struct semaphore pnp_res_mutex;
 
 static ssize_t
-pnp_set_current_resources(struct device * dmdev, const char * ubuf, size_t count)
+pnp_set_current_resources(struct device * dmdev, struct device_attribute *attr, const char * ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	char	*buf = (void *)ubuf;
@@ -444,7 +444,7 @@ pnp_set_current_resources(struct device 
 static DEVICE_ATTR(resources,S_IRUGO | S_IWUSR,
 		   pnp_show_current_resources,pnp_set_current_resources);
 
-static ssize_t pnp_show_current_ids(struct device *dmdev, char *buf)
+static ssize_t pnp_show_current_ids(struct device *dmdev, struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/block/dasd_devmap.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/block/dasd_devmap.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/block/dasd_devmap.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/block/dasd_devmap.c	2005-05-16 23:45:52.000000000 -0400
@@ -615,7 +615,7 @@ dasd_device_from_cdev(struct ccw_device 
  * readonly controls the readonly status of a dasd
  */
 static ssize_t
-dasd_ro_show(struct device *dev, char *buf)
+dasd_ro_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dasd_devmap *devmap;
 	int ro_flag;
@@ -629,7 +629,7 @@ dasd_ro_show(struct device *dev, char *b
 }
 
 static ssize_t
-dasd_ro_store(struct device *dev, const char *buf, size_t count)
+dasd_ro_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
 	int ro_flag;
@@ -656,7 +656,7 @@ static DEVICE_ATTR(readonly, 0644, dasd_
  * to talk to the device
  */
 static ssize_t 
-dasd_use_diag_show(struct device *dev, char *buf)
+dasd_use_diag_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dasd_devmap *devmap;
 	int use_diag;
@@ -670,7 +670,7 @@ dasd_use_diag_show(struct device *dev, c
 }
 
 static ssize_t
-dasd_use_diag_store(struct device *dev, const char *buf, size_t count)
+dasd_use_diag_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
 	ssize_t rc;
@@ -698,7 +698,7 @@ static
 DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
 
 static ssize_t
-dasd_discipline_show(struct device *dev, char *buf)
+dasd_discipline_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dasd_devmap *devmap;
 	char *dname;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/block/dcssblk.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/block/dcssblk.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/s390/block/dcssblk.c	2005-05-16 20:35:52.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/s390/block/dcssblk.c	2005-05-16 23:45:52.000000000 -0400
@@ -45,16 +45,16 @@ static struct block_device_operations dc
 	.release = dcssblk_release,
 };
 
-static ssize_t dcssblk_add_store(struct device * dev, const char * buf,
+static ssize_t dcssblk_add_store(struct device * dev, struct device_attribute *attr, const char * buf,
 				  size_t count);
-static ssize_t dcssblk_remove_store(struct device * dev, const char * buf,
+static ssize_t dcssblk_remove_store(struct device * dev, struct device_attribute *attr, const char * buf,
 				  size_t count);
-static ssize_t dcssblk_save_store(struct device * dev, const char * buf,
+static ssize_t dcssblk_save_store(struct device * dev, struct device_attribute *attr, const char * buf,
 				  size_t count);
-static ssize_t dcssblk_save_show(struct device *dev, char *buf);
-static ssize_t dcssblk_shared_store(struct device * dev, const char * buf,
+static ssize_t dcssblk_save_show(struct device *dev, struct device_attribute *attr, char *buf);
+static ssize_t dcssblk_shared_store(struct device * dev, struct device_attribute *attr, const char * buf,
 				  size_t count);
-static ssize_t dcssblk_shared_show(struct device *dev, char *buf);
+static ssize_t dcssblk_shared_show(struct device *dev, struct device_attribute *attr, char *buf);
 
 static DEVICE_ATTR(add, S_IWUSR, NULL, dcssblk_add_store);
 static DEVICE_ATTR(remove, S_IWUSR, NULL, dcssblk_remove_store);
@@ -195,7 +195,7 @@ dcssblk_segment_warn(int rc, char* seg_n
  * operation (show + store)
  */
 static ssize_t
-dcssblk_shared_show(struct device *dev, char *buf)
+dcssblk_shared_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dcssblk_dev_info *dev_info;
 
@@ -204,7 +204,7 @@ dcssblk_shared_show(struct device *dev, 
 }
 
 static ssize_t
-dcssblk_shared_store(struct device *dev, const char *inbuf, size_t count)
+dcssblk_shared_store(struct device *dev, struct device_attribute *attr, const char *inbuf, size_t count)
 {
 	struct dcssblk_dev_info *dev_info;
 	int rc;
@@ -288,7 +288,7 @@ out:
  * (show + store)
  */
 static ssize_t
-dcssblk_save_show(struct device *dev, char *buf)
+dcssblk_save_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dcssblk_dev_info *dev_info;
 
@@ -297,7 +297,7 @@ dcssblk_save_show(struct device *dev, ch
 }
 
 static ssize_t
-dcssblk_save_store(struct device *dev, const char *inbuf, size_t count)
+dcssblk_save_store(struct device *dev, struct device_attribute *attr, const char *inbuf, size_t count)
 {
 	struct dcssblk_dev_info *dev_info;
 
@@ -343,7 +343,7 @@ dcssblk_save_store(struct device *dev, c
  * device attribute for adding devices
  */
 static ssize_t
-dcssblk_add_store(struct device *dev, const char *buf, size_t count)
+dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int rc, i;
 	struct dcssblk_dev_info *dev_info;
@@ -517,7 +517,7 @@ out_nobuf:
  * device attribute for removing devices
  */
 static ssize_t
-dcssblk_remove_store(struct device *dev, const char *buf, size_t count)
+dcssblk_remove_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct dcssblk_dev_info *dev_info;
 	int rc, i;



------=_Part_280_21519119.1116326578072--
