Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422894AbWAMTvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbWAMTvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWAMTvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:64916 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422895AbWAMTug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:36 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add vio_bus_type probe and remove methods
In-Reply-To: <11371818102581@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <1137181810928@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add vio_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2f53a80fc0f6287d4bd6cc2422cd095c90f30410
tree 2247f49c965012d22f6d67442b7be64122958f55
parent 79f9fb8886d901fd549793a4ad632ece51c68405
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:36:47 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:07 -0800

 arch/powerpc/kernel/vio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 13c4149..13c655b 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
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
 	.uevent = vio_hotplug,
 	.match = vio_bus_match,
+	.probe = vio_bus_probe,
+	.remove = vio_bus_remove,
+	.shutdown = vio_bus_shutdown,
 };

