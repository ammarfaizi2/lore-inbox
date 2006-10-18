Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422826AbWJRULM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWJRULM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWJRUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:29162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422826AbWJRUJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:26 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/16] driver core fixes: sysfs_create_link() retval check in class.c
Date: Wed, 18 Oct 2006 13:08:58 -0700
Message-Id: <1161202166551-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202163247-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of sysfs_create_link() in class_device_add().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index b32b77f..0ff267a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
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
-- 
1.4.2.4

