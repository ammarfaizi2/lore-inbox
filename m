Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbVIOHcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbVIOHcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVIOHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:32:34 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:23388 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965228AbVIOHcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:32:33 -0400
Message-Id: <20050915070302.574089000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 06/28] Driver core: send hotplug event before adding class interfaces
Content-Disposition: inline; filename=class-call-hotplug-earier.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core: send hotplug event before adding class interfaces

Move call to kobject_hotplug() above code that adds interfaces
to a class device, otherwise children's hotplug events may reach
userspace first.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -540,6 +540,8 @@ int class_device_add(struct class_device
 				  class_name);
 	}
 
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+
 	/* notify any interfaces this device is now here */
 	if (parent) {
 		down(&parent->sem);
@@ -549,7 +551,6 @@ int class_device_add(struct class_device
 				class_intf->add(class_dev, class_intf);
 		up(&parent->sem);
 	}
-	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 
  register_done:
 	if (error && parent)

