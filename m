Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbUKMClF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbUKMClF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 21:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUKLXDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:39316 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262656AbUKLXAk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:40 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <11003004061439@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:07 -0800
Message-Id: <11003004071194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2097, 2004/11/12 11:43:08-08:00, kay.sievers@vrfy.org

[PATCH] add the driver name to the hotplug environment

Add the name of the device's driver to the hotplug environment of class
and block devices.

  ACTION=add
  DEVPATH=/block/sda
  SUBSYSTEM=block
  SEQNUM=986
  PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host0/target0:0:0/0:0:0:0
  PHYSDEVBUS=scsi
  PHYSDEVDRIVER=sd

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/class.c  |    6 ++++++
 drivers/block/genhd.c |    6 ++++++
 2 files changed, 12 insertions(+)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2004-11-12 14:53:11 -08:00
+++ b/drivers/base/class.c	2004-11-12 14:53:11 -08:00
@@ -303,6 +303,12 @@
 					    buffer, buffer_size, &length,
 					    "PHYSDEVBUS=%s", dev->bus->name);
 
+		/* add driver name of physical device */
+		if (dev->driver)
+			add_hotplug_env_var(envp, num_envp, &i,
+					    buffer, buffer_size, &length,
+					    "PHYSDEVDRIVER=%s", dev->driver->name);
+
 		/* terminate, set to next free slot, shrink available space */
 		envp[i] = NULL;
 		envp = &envp[i];
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2004-11-12 14:53:11 -08:00
+++ b/drivers/block/genhd.c	2004-11-12 14:53:11 -08:00
@@ -469,6 +469,12 @@
 					    buffer, buffer_size, &length,
 					    "PHYSDEVBUS=%s", dev->bus->name);
 
+		/* add driver name of physical device */
+		if (dev->driver)
+			add_hotplug_env_var(envp, num_envp, &i,
+					    buffer, buffer_size, &length,
+					    "PHYSDEVDRIVER=%s", dev->driver->name);
+
 		envp[i] = NULL;
 	}
 

