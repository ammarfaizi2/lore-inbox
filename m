Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVCYGRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVCYGRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:09:44 -0500
Received: from digitalimplant.org ([64.62.235.95]:7379 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261420AbVCYFyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:51 -0500
Date: Thu, 24 Mar 2005 21:54:45 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [8/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242152200.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2246, 2005-03-24 18:58:45-08:00, mochel@digitalimplant.org
  [driver core] Call klist_del() instead of klist_remove().

  - Can't wait on removing the current item in the list (the positive refcount *because*
    we are using it causes it to deadlock).


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c	2005-03-24 20:33:09 -08:00
+++ b/drivers/base/dd.c	2005-03-24 20:33:09 -08:00
@@ -184,7 +184,7 @@

 	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 	sysfs_remove_link(&dev->kobj, "driver");
-	klist_remove(&dev->knode_driver);
+	klist_del(&dev->knode_driver);

 	down(&dev->sem);
 	device_detach_shutdown(dev);
