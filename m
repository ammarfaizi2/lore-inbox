Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWAEOf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWAEOf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWAEOf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:35:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57104 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751363AbWAEOfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:35:23 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, Matt Porter <mporter@kernel.crashing.org>
Subject: [CFT 11/29] Add ocp_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:35:09 +0000
Message-ID: <20060105142951.13.11@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/ppc/syslib/ocp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/ppc/syslib/ocp.c linux/arch/ppc/syslib/ocp.c
--- linus/arch/ppc/syslib/ocp.c	Sun Nov  6 22:14:53 2005
+++ linux/arch/ppc/syslib/ocp.c	Sun Nov 13 16:09:45 2005
@@ -189,6 +189,8 @@ ocp_device_resume(struct device *dev)
 struct bus_type ocp_bus_type = {
 	.name = "ocp",
 	.match = ocp_device_match,
+	.probe = ocp_driver_probe,
+	.remove = ocp_driver_remove,
 	.suspend = ocp_device_suspend,
 	.resume = ocp_device_resume,
 };
@@ -210,8 +212,6 @@ ocp_register_driver(struct ocp_driver *d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &ocp_bus_type;
-	drv->driver.probe = ocp_device_probe;
-	drv->driver.remove = ocp_device_remove;
 
 	/* register with core */
 	return driver_register(&drv->driver);
