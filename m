Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVCJMJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVCJMJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCJMJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:09:32 -0500
Received: from h4.net39.bmstu.ru ([195.19.39.4]:62448 "EHLO
	xantippe.fb12.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262541AbVCJMJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:09:02 -0500
From: JustMan <justman@e1.bmstu.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] fix: drivers/base/class.c
Date: Thu, 10 Mar 2005 15:08:56 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503101508.56696.justman@e1.bmstu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix: drivers/base/class.c

Signed-off-by: Serge A. Suchkov <justman@e1.bmstu.ru>

diff -uNrp linux/drivers/base/class.orig.c  linux/drivers/base/class.c
--- linux/drivers/base/class.orig.c 2005-03-10 12:19:00.000000000 +0300
+++ linux/drivers/base/class.c 2005-03-10 13:59:27.000000000 +0300
@@ -307,12 +307,14 @@ static int class_hotplug(struct kset *ks
  if (class_dev->dev) {
   /* add physical device, backing this device  */
   struct device *dev = class_dev->dev;
-  char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
-  add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-        &length, "PHYSDEVPATH=%s", path);
-  kfree(path);
+  if(kobject_name(&dev->kobj)) {
+   char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
+   add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+        &length, "PHYSDEVPATH=%s", path);
+   kfree(path);
+  }
   /* add bus name of physical device */
   if (dev->bus)
    add_hotplug_env_var(envp, num_envp, &i,

-- 
Regards, JustMan.
