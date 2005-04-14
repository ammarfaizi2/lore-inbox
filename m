Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVDNMOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVDNMOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVDNMOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:14:40 -0400
Received: from h4.net39.bmstu.ru ([195.19.39.4]:40445 "EHLO
	xantippe.fb12.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261488AbVDNMOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:14:33 -0400
From: JustMan <justman@e1.bmstu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] on usb removal, and minicom closing 2.6.11.7
Date: Thu, 14 Apr 2005 16:14:03 +0400
User-Agent: KMail/1.7.2
References: <425E5682.6060606@pointblue.com.pl>
In-Reply-To: <425E5682.6060606@pointblue.com.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L6lXCTfnmvt2ouh"
Message-Id: <200504141614.03459.justman@e1.bmstu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_L6lXCTfnmvt2ouh
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> So,
> 
> I plugged in e680 motorola phone, played a bit with minicom on
> /dev/ttyACM0, and when I closed minicom, got this oops. USB is useless,
> got to reboot computer to use it again!
> it's vanilla 2.6.11.7
> 
> oops attached.
> 

Try attached patch... (nasty solution, but it work for my C350  motorola phone)

> 
> 

-- 
Regards, JustMan.

--Boundary-00=_L6lXCTfnmvt2ouh
Content-Type: text/x-diff;
  charset="koi8-r";
  name="fix_class_hotplug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix_class_hotplug.diff"

diff -uNrp linux/drivers/base/class.orig.c  linux/drivers/base/class.c
--- linux/drivers/base/class.orig.c	2005-03-10 12:19:00.000000000 +0300
+++ linux/drivers/base/class.c	2005-03-10 13:59:27.000000000 +0300
@@ -307,12 +307,14 @@ static int class_hotplug(struct kset *ks
 	if (class_dev->dev) {
 		/* add physical device, backing this device  */
 		struct device *dev = class_dev->dev;
-		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
-		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-				    &length, "PHYSDEVPATH=%s", path);
-		kfree(path);
+		if(kobject_name(&dev->kobj)) {
+			char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
+			add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+				    &length, "PHYSDEVPATH=%s", path);
+			kfree(path);
+		}
 		/* add bus name of physical device */
 		if (dev->bus)
 			add_hotplug_env_var(envp, num_envp, &i,

--Boundary-00=_L6lXCTfnmvt2ouh--
