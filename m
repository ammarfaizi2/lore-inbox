Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVCYGNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVCYGNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVCYGLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:11:20 -0500
Received: from digitalimplant.org ([64.62.235.95]:7123 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261421AbVCYFyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:51 -0500
Date: Thu, 24 Mar 2005 21:54:43 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [7/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242152010.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2245, 2005-03-24 13:08:05-08:00, mochel@digitalimplant.org
  [driver core] Remove struct device::driver_list.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2005-03-24 20:33:16 -08:00
+++ b/drivers/base/core.c	2005-03-24 20:33:16 -08:00
@@ -212,7 +212,6 @@
 	kobject_init(&dev->kobj);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
-	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 }
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-24 20:33:16 -08:00
+++ b/include/linux/device.h	2005-03-24 20:33:16 -08:00
@@ -264,7 +264,6 @@

 struct device {
 	struct list_head node;		/* node in sibling list */
-	struct list_head driver_list;
 	struct list_head children;
 	struct klist_node	knode_driver;
 	struct klist_node	knode_bus;
