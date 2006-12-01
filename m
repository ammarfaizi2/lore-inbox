Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162250AbWLAXWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162250AbWLAXWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162249AbWLAXWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:20717 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162245AbWLAXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:40 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/36] CONFIG_SYSFS_DEPRECATED - PHYSDEV* uevent variables
Date: Fri,  1 Dec 2006 15:21:38 -0800
Message-Id: <1165015349830-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153463092-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Disable the PHYSDEV* uevent variables if CONFIG_SYSFS_DEPRECATED is
enabled.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b565b7e..f544adc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -154,20 +154,24 @@ static int dev_uevent(struct kset *kset,
 			       "MINOR=%u", MINOR(dev->devt));
 	}
 
+#ifdef CONFIG_SYSFS_DEPRECATED
 	/* add bus name (same as SUBSYSTEM, deprecated) */
 	if (dev->bus)
 		add_uevent_var(envp, num_envp, &i,
 			       buffer, buffer_size, &length,
 			       "PHYSDEVBUS=%s", dev->bus->name);
+#endif
 
 	/* add driver name (PHYSDEV* values are deprecated)*/
 	if (dev->driver) {
 		add_uevent_var(envp, num_envp, &i,
 			       buffer, buffer_size, &length,
 			       "DRIVER=%s", dev->driver->name);
+#ifdef CONFIG_SYSFS_DEPRECATED
 		add_uevent_var(envp, num_envp, &i,
 			       buffer, buffer_size, &length,
 			       "PHYSDEVDRIVER=%s", dev->driver->name);
+#endif
 	}
 
 	/* terminate, set to next free slot, shrink available space */
-- 
1.4.4.1

