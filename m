Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422892AbWAMTyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbWAMTyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWAMTvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:61844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422892AbWAMTuf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:35 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add gameport bus_type probe and remove methods
In-Reply-To: <11371818102241@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818102581@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add gameport bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 29a4a20e9fe7459f9d464b8be070ce8b7335be7e
tree fab8064c3d917482ee8c885ed10f75860f240d70
parent b864c7d5d17c171c4ead0791b44ab05d7a21dc0c
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:38:22 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:07 -0800

 drivers/input/gameport/gameport.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index caac6d6..b765a15 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
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
 

