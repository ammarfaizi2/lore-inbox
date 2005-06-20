Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVFUCq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVFUCq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVFUCp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:45:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:21732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261681AbVFTW7m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:42 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Call klist_del() instead of klist_remove().
In-Reply-To: <1119308366913@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083662356@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Call klist_del() instead of klist_remove().

- Can't wait on removing the current item in the list (the positive refcount *because*
  we are using it causes it to deadlock).

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0956af53afea290c5676c75249fc2c180d831375
tree 43ba929157462d22b6320a8924823a56cb292569
parent 63c4f204ffc8219696bda88eb20c9873d007a2fc
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 18:58:45 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:19 -0700

 drivers/base/dd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -177,7 +177,7 @@ void device_release_driver(struct device
 
 	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 	sysfs_remove_link(&dev->kobj, "driver");
-	klist_remove(&dev->knode_driver);
+	klist_del(&dev->knode_driver);
 
 	down(&dev->sem);
 	if (drv->remove)

