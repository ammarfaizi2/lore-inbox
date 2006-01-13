Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422909AbWAMTvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbWAMTvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422906AbWAMTvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:3477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422898AbWAMTui convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:38 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add rio_bus_type probe and remove methods
In-Reply-To: <1137181812570@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <1137181812140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add rio_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fc3d3ddd3e628d9f22d4aa56a640d0b31c977a8f
tree 78d353c96c168963c12a666bcfabaf87df6cec99
parent b6a01e9bda69aaf22f3a23bafc91c0fb51420a7a
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:44:14 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:10 -0800

 drivers/rapidio/rio-driver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index dc74960..5480119 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -147,8 +147,6 @@ int rio_register_driver(struct rio_drive
 	/* initialize common driver fields */
 	rdrv->driver.name = rdrv->name;
 	rdrv->driver.bus = &rio_bus_type;
-	rdrv->driver.probe = rio_device_probe;
-	rdrv->driver.remove = rio_device_remove;
 
 	/* register with core */
 	return driver_register(&rdrv->driver);
@@ -204,7 +202,9 @@ static struct device rio_bus = {
 struct bus_type rio_bus_type = {
 	.name = "rapidio",
 	.match = rio_match_bus,
-	.dev_attrs = rio_dev_attrs
+	.dev_attrs = rio_dev_attrs,
+	.probe = rio_device_probe,
+	.remove = rio_device_remove,
 };
 
 /**

