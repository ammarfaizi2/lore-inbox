Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVBQOJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVBQOJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBQOJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:09:30 -0500
Received: from ns.suse.de ([195.135.220.2]:3769 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262153AbVBQOJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:09:00 -0500
Date: Thu, 17 Feb 2005 15:08:58 +0100
From: Olaf Hering <olh@suse.de>
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] PHYSDEVDRIVER=<NULL>
Message-ID: <20050217140858.GA32212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reasons, PHYSDEVDRIVER can be <NULL> for block events.
So just check for that.

 base/class.c  |    4 ++--
 base/core.c   |    4 ++--
 block/genhd.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags ../linux-2.6.11-rc4.orig/drivers/base/class.c ./drivers/base/class.c
--- ../linux-2.6.11-rc4.orig/drivers/base/class.c	2005-02-13 04:08:06.000000000 +0100
+++ ./drivers/base/class.c	2005-02-17 14:42:56.000000000 +0100
@@ -314,13 +314,13 @@ static int class_hotplug(struct kset *ks
 		kfree(path);
 
 		/* add bus name of physical device */
-		if (dev->bus)
+		if (dev->bus && dev->bus->name)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
 					    "PHYSDEVBUS=%s", dev->bus->name);
 
 		/* add driver name of physical device */
-		if (dev->driver)
+		if (dev->driver && dev->driver->name)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
 					    "PHYSDEVDRIVER=%s", dev->driver->name);
diff -purNx tags ../linux-2.6.11-rc4.orig/drivers/base/core.c ./drivers/base/core.c
--- ../linux-2.6.11-rc4.orig/drivers/base/core.c	2005-02-13 04:05:10.000000000 +0100
+++ ./drivers/base/core.c	2005-02-17 14:42:08.000000000 +0100
@@ -121,13 +121,13 @@ static int dev_hotplug(struct kset *kset
 	int retval = 0;
 
 	/* add bus name of physical device */
-	if (dev->bus)
+	if (dev->bus && dev->bus->name)
 		add_hotplug_env_var(envp, num_envp, &i,
 				    buffer, buffer_size, &length,
 				    "PHYSDEVBUS=%s", dev->bus->name);
 
 	/* add driver name of physical device */
-	if (dev->driver)
+	if (dev->driver && dev->driver->name)
 		add_hotplug_env_var(envp, num_envp, &i,
 				    buffer, buffer_size, &length,
 				    "PHYSDEVDRIVER=%s", dev->driver->name);
diff -purNx tags ../linux-2.6.11-rc4.orig/drivers/block/genhd.c ./drivers/block/genhd.c
--- ../linux-2.6.11-rc4.orig/drivers/block/genhd.c	2005-02-13 04:06:23.000000000 +0100
+++ ./drivers/block/genhd.c	2005-02-17 14:43:26.000000000 +0100
@@ -453,13 +453,13 @@ static int block_hotplug(struct kset *ks
 		kfree(path);
 
 		/* add bus name of physical device */
-		if (dev->bus)
+		if (dev->bus && dev->bus->name)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
 					    "PHYSDEVBUS=%s", dev->bus->name);
 
 		/* add driver name of physical device */
-		if (dev->driver)
+		if (dev->driver && dev->driver->name)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
 					    "PHYSDEVDRIVER=%s", dev->driver->name);
