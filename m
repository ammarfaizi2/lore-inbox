Return-Path: <linux-kernel-owner+w=401wt.eu-S1751724AbWLNXFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWLNXFK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWLNXFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:05:09 -0500
Received: from hera.kernel.org ([140.211.167.34]:36918 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbWLNXFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:05:07 -0500
X-Greylist: delayed 2466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:05:07 EST
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Holger Macht <hmacht@suse.de>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Thu, 14 Dec 2006 17:23:20 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Brandon Philips <brandon@ifup.org>
References: <20061204224037.713257809@localhost.localdomain> <20061211120508.2f2704ac.kristen.c.accardi@intel.com> <20061214071631.GA6575@homac2.gate.uni-erlangen.de>
In-Reply-To: <20061214071631.GA6575@homac2.gate.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141723.20565.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 02:16, Holger Macht wrote:
> On Mon 11. Dec - 12:05:08, Kristen Carlson Accardi wrote:

> > Ok - how is this?
>
> Looks good to me, thanks!

> > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>
> Signed-off-by: Holger Macht <hmacht@suse.de>

Applied.
thanks,
-Len

commit 8ea86e0ba7c9d16ae0f35cb0c4165194fa573f7a
Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Date:   Mon Dec 11 12:05:08 2006 -0800

    ACPI: dock: add uevent to indicate change in device status
    
    Send a uevent to indicate a device change whenever we dock or
    undock, so that userspace may now check the dock status via sysfs.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Holger Macht <hmacht@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 8c6828b..215f5b3 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -326,10 +326,12 @@ static void hotplug_dock_devices(struct dock_station 
*ds, u32 event)
 
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
