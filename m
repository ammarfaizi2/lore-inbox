Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVK1QTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVK1QTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVK1QTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:19:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:16286 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751249AbVK1QTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:19:52 -0500
Date: Mon, 28 Nov 2005 10:15:39 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: [DRIVER MODEL] Allow overlapping resources for platform devices
Message-ID: <Pine.LNX.4.44.0511281015060.25081-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases in which a device's memory mapped registers overlap
with another device's memory mapped registers.  On several PowerPC
devices this occurs for the MDIO bus, whose registers tended to overlap
with one of the ethernet controllers.

By switching from request_resource to insert_resource we can register
the MDIO bus as a proper platform device and not hack around how we
handle its memory mapped registers.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 32fa7cc4cb3ef6aed2d4ef06befa6686f6b7568a
tree 6f932a12c9663a9fc4705f31039c52159f14c59e
parent a20eafe40e6ae9d3db96918c9512c577b9a5814c
author Kumar Gala <galak@kernel.crashing.org> Mon, 28 Nov 2005 10:14:09 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 28 Nov 2005 10:14:09 -0600

 drivers/base/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8827daf..1091af1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -257,7 +257,7 @@ int platform_device_add(struct platform_
 				p = &ioport_resource;
 		}
 
-		if (p && request_resource(p, r)) {
+		if (p && insert_resource(p, r)) {
 			printk(KERN_ERR
 			       "%s: failed to claim resource %d\n",
 			       pdev->dev.bus_id, i);

