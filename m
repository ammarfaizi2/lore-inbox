Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWIVJgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWIVJgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWIVJgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:45 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:37455 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751121AbWIVJgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:41 -0400
Date: Fri, 22 Sep 2006 11:37:04 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [4/9] driver core fixes: bus_add_attrs() retval check
Message-ID: <20060922113704.25a8cd2e@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check return value of bus_add_attrs() in bus_register().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/bus.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6-CH.orig/drivers/base/bus.c
+++ linux-2.6-CH/drivers/base/bus.c
@@ -746,11 +746,15 @@ int bus_register(struct bus_type * bus)
 
 	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&bus->klist_drivers, NULL, NULL);
-	bus_add_attrs(bus);
+	retval = bus_add_attrs(bus);
+	if (retval)
+		goto bus_attrs_fail;
 
 	pr_debug("bus type '%s' registered\n", bus->name);
 	return 0;
 
+bus_attrs_fail:
+	kset_unregister(&bus->drivers);
 bus_drivers_fail:
 	kset_unregister(&bus->devices);
 bus_devices_fail:
