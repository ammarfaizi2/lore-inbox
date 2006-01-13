Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422917AbWAMT7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917AbWAMT7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422904AbWAMT56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:49812 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422881AbWAMTub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:31 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add macio_bus_type probe and remove methods
In-Reply-To: <11371818102735@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:11 -0800
Message-Id: <1137181811158@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add macio_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4866b124a1ded3b94b0cea0bd543f46ffa9a3943
tree 5b9bcc0a631e34db71dbb2e3856a8bc3e5a07e07
parent 30226f8199cb7f5ace767f65bcebb85941612dfc
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:39:24 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:08 -0800

 drivers/macintosh/macio_asic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 2a545ce..ed6d317 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -211,6 +211,9 @@ struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
        .uevent = macio_uevent,
+       .probe	= macio_device_probe,
+       .remove	= macio_device_remove,
+       .shutdown = macio_device_shutdown,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
        .dev_attrs = macio_dev_attrs,
@@ -528,9 +531,6 @@ int macio_register_driver(struct macio_d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &macio_bus_type;
-	drv->driver.probe = macio_device_probe;
-	drv->driver.remove = macio_device_remove;
-	drv->driver.shutdown = macio_device_shutdown;
 
 	/* register with core */
 	count = driver_register(&drv->driver);

