Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWIVJgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWIVJgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWIVJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:47 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:36062 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751114AbWIVJgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:37 -0400
Date: Fri, 22 Sep 2006 11:37:00 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [3/9] driver core fixes: sysfs_create_link() retval check in
 class.c
Message-ID: <20060922113700.42dcb8d0@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of sysfs_create_link() in class_device_add().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/class.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6-CH.orig/drivers/base/class.c
+++ linux-2.6-CH/drivers/base/class.c
@@ -602,7 +602,10 @@ int class_device_add(struct class_device
 		goto out2;
 
 	/* add the needed attributes to this device */
-	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+	error = sysfs_create_link(&class_dev->kobj,
+				  &parent_class->subsys.kset.kobj, "subsystem");
+	if (error)
+		goto out3;
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
