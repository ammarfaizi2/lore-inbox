Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422821AbWJRUN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWJRUN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWJRUJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:52 -0400
Received: from mx1.suse.de ([195.135.220.2]:13746 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422835AbWJRUJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:29 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/16] driver core fixes: bus_add_attrs() retval check
Date: Wed, 18 Oct 2006 13:08:59 -0700
Message-Id: <11612021701905-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202166551-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check return value of bus_add_attrs() in bus_register().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 12173d1..b90f6e6 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -732,11 +732,15 @@ int bus_register(struct bus_type * bus)
 
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
-- 
1.4.2.4

