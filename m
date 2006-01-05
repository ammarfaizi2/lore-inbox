Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWAEOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWAEOik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWAEOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:38:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42511 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751277AbWAEOi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:38:28 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, INPUT <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [CFT 17/29] Add gameport bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:38:22 +0000
Message-ID: <20060105142951.13.17@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/input/gameport/gameport.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/input/gameport/gameport.c linux/drivers/input/gameport/gameport.c
--- linus/drivers/input/gameport/gameport.c	Sun Nov  6 22:16:11 2005
+++ linux/drivers/input/gameport/gameport.c	Sun Nov 13 16:25:51 2005
@@ -50,9 +50,7 @@ static DECLARE_MUTEX(gameport_sem);
 
 static LIST_HEAD(gameport_list);
 
-static struct bus_type gameport_bus = {
-	.name =	"gameport",
-};
+static struct bus_type gameport_bus;
 
 static void gameport_add_port(struct gameport *gameport);
 static void gameport_destroy_port(struct gameport *gameport);
@@ -703,11 +701,15 @@ static int gameport_driver_remove(struct
 	return 0;
 }
 
+static struct bus_type gameport_bus = {
+	.name =	"gameport",
+	.probe = gameport_driver_probe,
+	.remove = gameport_driver_remove,
+};
+
 void __gameport_register_driver(struct gameport_driver *drv, struct module *owner)
 {
 	drv->driver.bus = &gameport_bus;
-	drv->driver.probe = gameport_driver_probe;
-	drv->driver.remove = gameport_driver_remove;
 	gameport_queue_event(drv, owner, GAMEPORT_REGISTER_DRIVER);
 }
 
