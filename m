Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCREC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCREC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCREAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:43 -0500
Received: from soundwarez.org ([217.160.171.123]:41103 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261327AbVCREAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:11 -0500
Date: Fri, 18 Mar 2005 05:00:08 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 4/6] kobject/hotplug split - devices core
Message-ID: <20050318040008.GA546@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_add() and kobject_del() don't emit hotplug events anymore. Do it
ourselves if we are finished populating the device directory.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

--- 1.91/drivers/base/core.c	2004-11-12 13:16:42 +01:00
+++ edited/drivers/base/core.c	2005-03-18 02:17:17 +01:00
@@ -260,6 +260,8 @@ int device_add(struct device *dev)
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
+
+	kobject_hotplug(&dev->kobj, KOBJ_ADD);
  Done:
 	put_device(dev);
 	return error;
@@ -349,6 +351,7 @@ void device_del(struct device * dev)
 		platform_notify_remove(dev);
 	bus_remove_device(dev);
 	device_pm_remove(dev);
+	kobject_hotplug(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
 	if (parent)
 		put_device(parent);

