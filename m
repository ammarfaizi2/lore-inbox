Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWDNULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWDNULd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWDNULL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:3469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965145AbWDNULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:06 -0400
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/7] driver core: safely unbind drivers for devices not on a bus
In-Reply-To: <11450453963619-git-send-email-greg@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:56 -0700
Message-Id: <11450453961549-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as667) changes the __device_release_driver() routine to
prevent it from crashing when it runs across a device not on any bus.
This seems logical, inasmuch as the corresponding bus_add_device()
routine has an explicit check allowing it to accept such devices.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/dd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0f836ca4c122f4ef096110d652a6326fe34e6961
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 730a9ce..889c711 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -209,7 +209,7 @@ static void __device_release_driver(stru
 		sysfs_remove_link(&dev->kobj, "driver");
 		klist_remove(&dev->knode_driver);
 
-		if (dev->bus->remove)
+		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
-- 
1.2.6


