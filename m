Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTHOS1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270711AbTHOS0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:26:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:60546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270712AbTHOSZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:35 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719492406@kroah.com>
Subject: Re: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <10609719494170@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.6, 2003/08/15 10:08:00-07:00, greg@kroah.com

Remove usage of struct device.name from scsi core


 drivers/scsi/scsi_debug.c |    2 --
 drivers/scsi/scsi_scan.c  |   20 --------------------
 drivers/scsi/scsi_sysfs.c |    2 --
 3 files changed, 24 deletions(-)


diff -Nru a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
--- a/drivers/scsi/scsi_debug.c	Fri Aug 15 11:15:52 2003
+++ b/drivers/scsi/scsi_debug.c	Fri Aug 15 11:15:52 2003
@@ -1566,7 +1566,6 @@
 module_exit(scsi_debug_exit);
 
 static struct device pseudo_primary = {
-	.name		= "Host/Pseudo Bridge",
 	.bus_id		= "pseudo_0",
 };
 
@@ -1630,7 +1629,6 @@
         sdbg_host->dev.bus = &pseudo_lld_bus;
         sdbg_host->dev.parent = &pseudo_primary;
         sdbg_host->dev.release = &sdebug_release_adapter;
-        sprintf(sdbg_host->dev.name, "scsi debug adapter");
         sprintf(sdbg_host->dev.bus_id, "adapter%d", scsi_debug_add_host);
 
         error = device_register(&sdbg_host->dev);
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Fri Aug 15 11:15:52 2003
+++ b/drivers/scsi/scsi_scan.c	Fri Aug 15 11:15:52 2003
@@ -447,24 +447,6 @@
 	return;
 }
 
-static void scsi_set_name(struct scsi_device *sdev, char *inq_result)
-{
-	int i;
-	char type[72];
-
-	i = inq_result[0] & 0x1f;
-	if (i < MAX_SCSI_DEVICE_CODE)
-		strcpy(type, scsi_device_types[i]);
-	else
-		strcpy(type, "Unknown");
-
-	i = strlen(type) - 1;
-	while (i >= 0 && type[i] == ' ')
-		type[i--] = '\0';
-
-	snprintf(sdev->sdev_gendev.name, DEVICE_NAME_SIZE, "SCSI %s", type);
-}
-
 /**
  * scsi_add_lun - allocate and fully initialze a Scsi_Device
  * @sdevscan:	holds information to be stored in the new Scsi_Device
@@ -538,8 +520,6 @@
 	default:
 		printk(KERN_INFO "scsi: unknown device type %d\n", sdev->type);
 	}
-
-	scsi_set_name(sdev, inq_result);
 
 	print_inquiry(inq_result);
 
diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	Fri Aug 15 11:15:52 2003
+++ b/drivers/scsi/scsi_sysfs.c	Fri Aug 15 11:15:52 2003
@@ -408,8 +408,6 @@
 	device_initialize(&shost->shost_gendev);
 	snprintf(shost->shost_gendev.bus_id, BUS_ID_SIZE, "host%d",
 		shost->host_no);
-	snprintf(shost->shost_gendev.name, DEVICE_NAME_SIZE, "%s",
-		shost->hostt->proc_name);
 	shost->shost_gendev.release = scsi_host_dev_release;
 
 	class_device_initialize(&shost->shost_classdev);

