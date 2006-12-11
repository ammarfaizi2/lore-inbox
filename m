Return-Path: <linux-kernel-owner+w=401wt.eu-S1763043AbWLKUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763043AbWLKUF3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763045AbWLKUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:05:29 -0500
Received: from mga03.intel.com ([143.182.124.21]:1043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763037AbWLKUF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:05:27 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,521,1157353200"; 
   d="scan'208"; a="156792386:sNHT43741341"
Date: Mon, 11 Dec 2006 12:05:08 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Holger Macht <hmacht@suse.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Message-Id: <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
In-Reply-To: <20061209115957.GA5254@homac2>
References: <20061204224037.713257809@localhost.localdomain>
	<20061204144958.207e58e2.kristen.c.accardi@intel.com>
	<20061209115957.GA5254@homac2>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 12:59:58 +0100
Holger Macht <hmacht@suse.de> wrote:

> Well, I like to have them ;-)

Ok - how is this?

Send a uevent to indicate a device change whenever we dock or
undock, so that userspace may now check the dock status via 
sysfs.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- kristen-2.6.orig/drivers/acpi/dock.c
+++ kristen-2.6/drivers/acpi/dock.c
@@ -326,10 +326,12 @@ static void hotplug_dock_devices(struct 
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
+	struct device *dev = &dock_device.dev;
 	/*
-	 * we don't do events until someone tells me that
-	 * they would like to have them.
+	 * Indicate that the status of the dock station has
+	 * changed.
 	 */
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 /**
