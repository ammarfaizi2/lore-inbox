Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVJ1Gdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVJ1Gdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVJ1Gbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:43754 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965143AbVJ1GbY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:24 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Driver core: send hotplug event before adding class interfaces
In-Reply-To: <11304810233647@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:23 -0700
Message-Id: <1130481023423@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: send hotplug event before adding class interfaces

Move call to kobject_hotplug() above code that adds interfaces
to a class device, otherwise children's hotplug events may reach
userspace first.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 85a44726f49989a2647cd850d55ec5be75727c5b
tree f9d837c5fb3f70626ea55bbb522c485be79b2039
parent 454a289c5bc26384c2bdc40c0d232cf47bcf0a5d
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:37 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:00 -0700

 drivers/base/class.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index ce23dc8..8df58c5 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -524,6 +524,8 @@ int class_device_add(struct class_device
 				  class_name);
 	}
 
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+
 	/* notify any interfaces this device is now here */
 	if (parent) {
 		down(&parent->sem);
@@ -533,7 +535,6 @@ int class_device_add(struct class_device
 				class_intf->add(class_dev);
 		up(&parent->sem);
 	}
-	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 
  register_done:
 	if (error && parent)

