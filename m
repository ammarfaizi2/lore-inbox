Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVCREC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCREC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVCREA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:57 -0500
Received: from soundwarez.org ([217.160.171.123]:46991 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261399AbVCREAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:13 -0500
Date: Fri, 18 Mar 2005 05:00:10 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 6/6] kobject/hotplug split - net bridge
Message-ID: <20050318040010.GA607@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_add() and kobject_del() don't emit hotplug events anymore.
We need to do it ourselves now.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== net/bridge/br_sysfs_if.c 1.2 vs edited =====
--- 1.2/net/bridge/br_sysfs_if.c	2004-06-18 22:15:34 +02:00
+++ edited/net/bridge/br_sysfs_if.c	2005-03-18 02:17:18 +01:00
@@ -248,6 +248,7 @@ int br_sysfs_addif(struct net_bridge_por
 	if (err)
 		goto out2;
 
+	kobject_hotplug(&p->kobj, KOBJ_ADD);
 	return 0;
  out2:
 	kobject_del(&p->kobj);
@@ -259,6 +260,7 @@ void br_sysfs_removeif(struct net_bridge
 {
 	pr_debug("br_sysfs_removeif\n");
 	sysfs_remove_link(&p->br->ifobj, p->dev->name);
+	kobject_hotplug(&p->kobj, KOBJ_REMOVE);
 	kobject_del(&p->kobj);
 }
 

