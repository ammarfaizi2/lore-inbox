Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWIMQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWIMQjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIMQim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:38:42 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:43463 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750741AbWIMQi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:26 -0400
Date: Wed, 13 Sep 2006 18:38:46 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [05/12] driver core fixes: sysfs_create_link() retval check in
 class.c
Message-ID: <20060913183846.7c82eeaa@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of sysfs_create_link() in class_device_add().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 class.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc6/drivers/base/class.c	2006-09-12 17:01:56.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/class.c	2006-09-12 17:03:21.000000000 +0200
@@ -562,7 +562,10 @@ int class_device_add(struct class_device
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
