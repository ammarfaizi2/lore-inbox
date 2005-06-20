Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVFUCkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVFUCkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVFUCiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:38:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:25828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261691AbVFTW7o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:44 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Use driver_for_each_device() in drivers/pnp/driver.c instead of manually walking list.
In-Reply-To: <11193083644157@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <11193083642637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Use driver_for_each_device() in drivers/pnp/driver.c instead of manually walking list.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c

---
commit 8d618afdd61ccaacbab4976a556c0ddcf36e2d8a
tree abe9d05aacee69b9b59375e867db295982222e65
parent fae3cd00255e3e51ffd59fedb1bdb91ec96be395
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 11:07:54 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:13 -0700

 drivers/pnp/driver.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -160,10 +160,16 @@ struct bus_type pnp_bus_type = {
 };
 
 
+static int count_devices(struct device * dev, void * c)
+{
+	int * count = c;
+	(*count)++;
+	return 0;
+}
+
 int pnp_register_driver(struct pnp_driver *drv)
 {
 	int count;
-	struct list_head *pos;
 
 	pnp_dbg("the driver '%s' has been registered", drv->name);
 
@@ -177,9 +183,7 @@ int pnp_register_driver(struct pnp_drive
 	/* get the number of initial matches */
 	if (count >= 0){
 		count = 0;
-		list_for_each(pos,&drv->driver.devices){
-			count++;
-		}
+		driver_for_each_device(&drv->driver, NULL, &count, count_devices);
 	}
 	return count;
 }

