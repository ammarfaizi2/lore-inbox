Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVCRECV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVCRECV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVCREA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:26 -0500
Received: from soundwarez.org ([217.160.171.123]:39055 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261241AbVCREAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:08 -0500
Date: Fri, 18 Mar 2005 05:00:05 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2/6] kobject/hotplug split - class core
Message-ID: <20050318040005.GA547@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_add() and kobject_del() don't emit hotplug events anymore. Do it
ourselves if we are finished populating the device directory.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/base/class.c 1.61 vs edited =====
--- 1.61/drivers/base/class.c	2005-03-15 17:52:00 +01:00
+++ edited/drivers/base/class.c	2005-03-18 02:17:17 +01:00
@@ -491,6 +491,7 @@ int class_device_add(struct class_device
 		up(&parent->sem);
 	}
 
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
  register_done:
 	if (error && parent)
 		class_put(parent);
@@ -562,6 +563,7 @@ void class_device_del(struct class_devic
 	}
 	class_device_remove_attrs(class_dev);
 
+	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
 	if (parent)

