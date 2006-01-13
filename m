Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWAMTxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWAMTxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbWAMTvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:61332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422891AbWAMTuf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:35 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add ocp_bus_type probe and remove methods
In-Reply-To: <1137181809252@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:09 -0800
Message-Id: <11371818093332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add ocp_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 91fb53866d00b4eaeaf1cbfd2237799cb152f742
tree 5c9181d21c4f1e74cbc6592659d608b4855b6287
parent ad3ed31c682d956d2187e562635c55c8c74c1021
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:35:09 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:06 -0800

 arch/ppc/syslib/ocp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
index 9ccce43..ab34b1d 100644
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
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

