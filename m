Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWAMTyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWAMTyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWAMTvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:62868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422890AbWAMTug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:36 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add ecard_bus_type probe/remove/shutdown methods
In-Reply-To: <1137181809687@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:09 -0800
Message-Id: <113718180990@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add ecard_bus_type probe/remove/shutdown methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e08b754161d6de4f91e2d3c805f350b35a95d8b8
tree 5a0dad12bed3064416e78f753982d9c7137a36be
parent b15d686a2b589c9e4f1ea116553e9c3c3d030dae
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:30:57 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:05 -0800

 arch/arm/kernel/ecard.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index 96fd919..74ea29c 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -1147,9 +1147,11 @@ static void ecard_drv_shutdown(struct de
 	struct ecard_driver *drv = ECARD_DRV(dev->driver);
 	struct ecard_request req;
 
-	if (drv->shutdown)
-		drv->shutdown(ec);
-	ecard_release(ec);
+	if (dev->driver) {
+		if (drv->shutdown)
+			drv->shutdown(ec);
+		ecard_release(ec);
+	}
 
 	/*
 	 * If this card has a loader, call the reset handler.
@@ -1164,9 +1166,6 @@ static void ecard_drv_shutdown(struct de
 int ecard_register_driver(struct ecard_driver *drv)
 {
 	drv->drv.bus = &ecard_bus_type;
-	drv->drv.probe = ecard_drv_probe;
-	drv->drv.remove = ecard_drv_remove;
-	drv->drv.shutdown = ecard_drv_shutdown;
 
 	return driver_register(&drv->drv);
 }
@@ -1195,6 +1194,9 @@ struct bus_type ecard_bus_type = {
 	.name		= "ecard",
 	.dev_attrs	= ecard_dev_attrs,
 	.match		= ecard_match,
+	.probe		= ecard_drv_probe,
+	.remove		= ecard_drv_remove,
+	.shutdown	= ecard_drv_shutdown,
 };
 
 static int ecard_bus_init(void)

