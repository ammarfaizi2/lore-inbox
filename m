Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVFWGOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVFWGOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVFWGLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:11:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:65413 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262223AbVFWGKf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:10:35 -0400
Cc: gregkh@suse.de
Subject: [PATCH] driver core: Fix up the device_attach() error handling in bus_add_device()
In-Reply-To: <11195070302202@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 22 Jun 2005 23:10:31 -0700
Message-Id: <11195070313420@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: Fix up the device_attach() error handling in bus_add_device()

Don't error out if something "bad" happens when trying to bind a driver to a
device.  We want the sysfs attributes to be present for later when we try to
tear down the device.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d377e85b537a5e166272f937da6ba84350676b6e
tree f3e5f347cbaa72a1479d991f7cab83228dd44bf0
parent 479f6ea85e513551510ad52f37e69e1c596ad356
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 16:09:05 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 23:01:10 -0700

 drivers/base/bus.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -270,10 +270,9 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		error = device_attach(dev);
+		device_attach(dev);
 		klist_add_tail(&bus->klist_devices, &dev->knode_bus);
-		if (error >= 0)
-			error = device_add_attrs(bus, dev);
+		error = device_add_attrs(bus, dev);
 		if (!error) {
 			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");

