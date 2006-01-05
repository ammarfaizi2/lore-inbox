Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWAEOgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWAEOgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWAEOgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:36:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40975 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751316AbWAEOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:36:53 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, PPC <linuxppc-embedded@ozlabs.org>
Subject: [CFT 14/29] Add vio_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:36:47 +0000
Message-ID: <20060105142951.13.14@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/powerpc/kernel/vio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/powerpc/kernel/vio.c linux/arch/powerpc/kernel/vio.c
--- linus/arch/powerpc/kernel/vio.c	Wed Nov  9 19:20:14 2005
+++ linux/arch/powerpc/kernel/vio.c	Sun Nov 13 16:14:10 2005
@@ -76,7 +76,7 @@ static void vio_bus_shutdown(struct devi
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct vio_driver *viodrv = to_vio_driver(dev->driver);
 
-	if (viodrv->shutdown)
+	if (dev->driver && viodrv->shutdown)
 		viodrv->shutdown(viodev);
 }
 
@@ -91,9 +91,6 @@ int vio_register_driver(struct vio_drive
 
 	/* fill in 'struct driver' fields */
 	viodrv->driver.bus = &vio_bus_type;
-	viodrv->driver.probe = vio_bus_probe;
-	viodrv->driver.remove = vio_bus_remove;
-	viodrv->driver.shutdown = vio_bus_shutdown;
 
 	return driver_register(&viodrv->driver);
 }
@@ -295,4 +292,7 @@ struct bus_type vio_bus_type = {
 	.name = "vio",
 	.hotplug = vio_hotplug,
 	.match = vio_bus_match,
+	.probe = vio_bus_probe,
+	.remove = vio_bus_remove,
+	.shutdown = vio_bus_shutdown,
 };
