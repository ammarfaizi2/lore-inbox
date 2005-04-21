Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVDUIJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDUIJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVDUIHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:07:32 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:57783 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261453AbVDUHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 15/22] W1: add slave_ttl master attribute
Date: Thu, 21 Apr 2005 02:22:06 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210222.06866.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: add slave_ttl attribute to w1 masters.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -447,6 +447,28 @@ w1_master_attribute_set_max_slave_count(
 	return 0;
 }
 
+static ssize_t w1_master_attribute_show_slave_ttl(struct device *dev, char *buf)
+{
+	struct w1_master *master = to_w1_master(dev);
+
+	return sprintf(buf, "%d\n", master->slave_ttl);
+}
+
+static ssize_t
+w1_master_attribute_set_slave_ttl(struct device *dev, const char *buf, size_t n)
+{
+	struct w1_master *master = to_w1_master(dev);
+	int slave_ttl;
+
+	slave_ttl = simple_strtoul(buf, NULL, 10);
+	if (!slave_ttl)
+		return -EINVAL;
+
+	master->slave_ttl = slave_ttl;
+	return 0;
+}
+
+
 #define W1_MASTER_ATTR_RO(_name, _mode)				\
 	struct device_attribute w1_master_attribute_##_name =	\
 		__ATTR(_name, _mode,				\
@@ -461,11 +483,13 @@ w1_master_attribute_set_max_slave_count(
 static W1_MASTER_ATTR_RO(name, S_IRUGO);
 static W1_MASTER_ATTR_RW(max_slave_count, S_IWUSR | S_IRUGO);
 static W1_MASTER_ATTR_RW(scan_interval, S_IWUSR | S_IRUGO);
+static W1_MASTER_ATTR_RW(slave_ttl, S_IWUSR | S_IRUGO);
 
 static struct attribute *w1_master_default_attrs[] = {
 	&w1_master_attribute_name.attr,
 	&w1_master_attribute_max_slave_count.attr,
 	&w1_master_attribute_scan_interval.attr,
+	&w1_master_attribute_slave_ttl.attr,
 	NULL
 };
 
