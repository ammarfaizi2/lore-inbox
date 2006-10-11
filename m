Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030657AbWJKGLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbWJKGLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbWJKGLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:11:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17266 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1030647AbWJKGLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:11:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAFonLEWMCCw
Message-Id: <20061011061030.151797574.dtor@insightbb.com>
References: <20061011060138.920913139.dtor@insightbb.com>
Date: Wed, 11 Oct 2006 02:01:39 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-pm@lists.osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, pavel@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: [RFC/PATCH 1/3] Use kobject_name() to access kobject names
Content-Disposition: inline; filename=dpm-use-kobject-name.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PM: use kobject_name() to access kobject names

Noone should use kobj.name directly since it may contain garbage.
Objects with longer names have them stored in memory pointed by
kobj->k_name.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/power/main.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: work/drivers/base/power/main.c
===================================================================
--- work.orig/drivers/base/power/main.c
+++ work/drivers/base/power/main.c
@@ -54,7 +54,8 @@ int device_pm_add(struct device * dev)
 	int error;
 
 	pr_debug("PM: Adding info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+		 dev->bus ? dev->bus->name : "No Bus",
+		 kobject_name(&dev->kobj));
 	down(&dpm_list_sem);
 	list_add_tail(&dev->power.entry, &dpm_active);
 	device_pm_set_parent(dev, dev->parent);
@@ -67,7 +68,8 @@ int device_pm_add(struct device * dev)
 void device_pm_remove(struct device * dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+		 dev->bus ? dev->bus->name : "No Bus",
+		 kobject_name(&dev->kobj));
 	down(&dpm_list_sem);
 	dpm_sysfs_remove(dev);
 	put_device(dev->power.pm_parent);
