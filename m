Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422873AbWAMUDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422873AbWAMUDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWAMUCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:02:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:45204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422875AbWAMTua convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:30 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add serio bus_type probe and remove methods
In-Reply-To: <1137181810928@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818101175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add serio bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 30226f8199cb7f5ace767f65bcebb85941612dfc
tree 8155e420d407bf831aa6aa838328a5a2fbfe3ee0
parent 29a4a20e9fe7459f9d464b8be070ce8b7335be7e
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:38:53 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:07 -0800

 drivers/input/serio/serio.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 8e530cc..2f76813 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
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

