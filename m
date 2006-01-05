Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWAEAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWAEAzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWAEAug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:62905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750965AbWAEAtx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:53 -0500
Cc: galak@gate.crashing.org
Subject: [PATCH] Allow overlapping resources for platform devices
In-Reply-To: <11364221701993@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <1136422170815@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Allow overlapping resources for platform devices

There are cases in which a device's memory mapped registers overlap
with another device's memory mapped registers.  On several PowerPC
devices this occurs for the MDIO bus, whose registers tended to overlap
with one of the ethernet controllers.

By switching from request_resource to insert_resource we can register
the MDIO bus as a proper platform device and not hack around how we
handle its memory mapped registers.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d960bb4db9f422b5c3c82e0dfd6c8213a4fc430d
tree a5d79803da3f7e20fa55f6fd1b8ec9c74ef0c322
parent e22dafbcd7a579c29a424d5203b5b33b131948a7
author Kumar Gala <galak@gate.crashing.org> Mon, 28 Nov 2005 10:15:39 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

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

