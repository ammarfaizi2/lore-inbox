Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWAEOjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWAEOjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAEOjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:39:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43535 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751277AbWAEOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:38:59 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, INPUT <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [CFT 18/29] Add serio bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:38:53 +0000
Message-ID: <20060105142951.13.18@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/input/serio/serio.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/input/serio/serio.c linux/drivers/input/serio/serio.c
--- linus/drivers/input/serio/serio.c	Sun Nov  6 22:16:18 2005
+++ linux/drivers/input/serio/serio.c	Sun Nov 13 16:27:06 2005
@@ -59,9 +59,7 @@ static DECLARE_MUTEX(serio_sem);
 
 static LIST_HEAD(serio_list);
 
-static struct bus_type serio_bus = {
-	.name =	"serio",
-};
+static struct bus_type serio_bus;
 
 static void serio_add_port(struct serio *serio);
 static void serio_destroy_port(struct serio *serio);
@@ -750,11 +748,15 @@ static int serio_driver_remove(struct de
 	return 0;
 }
 
+static struct bus_type serio_bus = {
+	.name =	"serio",
+	.probe = serio_driver_probe,
+	.remove = serio_driver_remove,
+};
+
 void __serio_register_driver(struct serio_driver *drv, struct module *owner)
 {
 	drv->driver.bus = &serio_bus;
-	drv->driver.probe = serio_driver_probe;
-	drv->driver.remove = serio_driver_remove;
 
 	serio_queue_event(drv, owner, SERIO_REGISTER_DRIVER);
 }
