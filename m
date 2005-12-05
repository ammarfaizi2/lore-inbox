Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVLEFxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVLEFxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLEFxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:53:08 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:7332 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S1750970AbVLEFxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:53:07 -0500
Message-ID: <4393D6F8.1080303@student.ltu.se>
Date: Mon, 05 Dec 2005 06:58:16 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] *rest*: Replace driver_data with dev_[gs]et_drvdata
References: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace (found) dev->driver_data with dev_[gs]et_drvdata().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 ide/ide.c      |    4 ++--
 scsi/aha1740.c |    2 +-
 usb/core/usb.c |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff -Narup a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-12-02 14:46:04.000000000 +0100
+++ b/drivers/ide/ide.c	2005-12-02 14:48:47.000000000 +0100
@@ -1216,7 +1216,7 @@ EXPORT_SYMBOL(system_bus_clock);
 
 static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_drive_t *drive = dev_get_drvdata(dev);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
@@ -1235,7 +1235,7 @@ static int generic_ide_suspend(struct de
 
 static int generic_ide_resume(struct device *dev)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_drive_t *drive = dev_get_drvdata(dev);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
diff -Narup a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
--- a/drivers/scsi/aha1740.c	2005-12-02 15:05:35.000000000 +0100
+++ b/drivers/scsi/aha1740.c	2005-12-02 15:06:48.000000000 +0100
@@ -659,7 +659,7 @@ static int aha1740_probe (struct device 
 
 static __devexit int aha1740_remove (struct device *dev)
 {
-	struct Scsi_Host *shpnt = dev->driver_data;
+	struct Scsi_Host *shpnt = dev_get_drvdata(dev);
 	struct aha1740_hostdata *host = HOSTDATA (shpnt);
 
 	scsi_remove_host(shpnt);
diff -Narup a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-12-02 14:26:11.000000000 +0100
+++ b/drivers/usb/core/usb.c	2005-12-02 14:30:14.000000000 +0100
@@ -574,7 +574,7 @@ static int usb_hotplug (struct device *d
 
 	/* Must check driver_data here, as on remove driver is always NULL */
 	if ((dev->driver == &usb_generic_driver) || 
-	    (dev->driver_data == &usb_generic_driver_data))
+	    (dev_get_drvdata(dev) == &usb_generic_driver_data))
 		return 0;
 
 	intf = to_usb_interface(dev);
@@ -1414,7 +1414,7 @@ static int usb_generic_suspend(struct de
 	}
 
 	if ((dev->driver == NULL) ||
-	    (dev->driver_data == &usb_generic_driver_data))
+	    (dev_get_drvdata(dev) == &usb_generic_driver_data))
 		return 0;
 
 	intf = to_usb_interface(dev);
@@ -1460,7 +1460,7 @@ static int usb_generic_resume(struct dev
 	}
 
 	if ((dev->driver == NULL) ||
-	    (dev->driver_data == &usb_generic_driver_data))
+	    (dev_get_drvdata(dev) == &usb_generic_driver_data))
 		return 0;
 
 	intf = to_usb_interface(dev);


