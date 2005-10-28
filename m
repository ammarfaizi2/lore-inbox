Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVJ1Gql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVJ1Gql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVJ1GbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:20202 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965107AbVJ1GbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:03 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: show sysfs path in /proc/bus/input/devices
In-Reply-To: <11304810251108@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <11304810263972@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: show sysfs path in /proc/bus/input/devices

Input: show sysfs path in /proc/bus/input/devices

Show that sysfs and phys path are different objects.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2870664a166086db34c99dfa2fc15e881131b45b
tree 702481ec0d84499eb6eeceeb08483a61be70f54f
parent 5555c7bc942fff098f65b233d1a47b611a81e7bc
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:54 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/input.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 0e2e890..ceaed63 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -475,17 +475,21 @@ static int input_devices_read(char *buf,
 {
 	struct input_dev *dev;
 	struct input_handle *handle;
+	const char *path;
 
 	off_t at = 0;
 	int i, len, cnt = 0;
 
 	list_for_each_entry(dev, &input_dev_list, node) {
 
+		path = dev->dynalloc ? kobject_get_path(&dev->cdev.kobj, GFP_KERNEL) : NULL;
+
 		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
 			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
 
 		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
 		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
+		len += sprintf(buf + len, "S: Sysfs=%s\n", path ? path : "");
 		len += sprintf(buf + len, "H: Handlers=");
 
 		list_for_each_entry(handle, &dev->h_list, d_node)
@@ -516,6 +520,8 @@ static int input_devices_read(char *buf,
 			if (cnt >= count)
 				break;
 		}
+
+		kfree(path);
 	}
 
 	if (&dev->node == &input_dev_list)

