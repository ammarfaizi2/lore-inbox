Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263087AbTCSQbx>; Wed, 19 Mar 2003 11:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263088AbTCSQbx>; Wed, 19 Mar 2003 11:31:53 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4365
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263087AbTCSQbw>; Wed, 19 Mar 2003 11:31:52 -0500
Subject: [patch] trivisl sg.c compile warning fix
From: Robert Love <rml@tech9.net>
To: hch@infradead.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048092165.828.921.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 19 Mar 2003 11:42:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sending this to the usual SCSI suspects ... ]

Trivial fix for a trivial problem in sg.c :: sg_device_kdev_read().

The sprintf() argument is a 'unsigned long' not an 'unsigned int'.

Patch is against 2.5.65.  Danke,

	Robert Love


 drivers/scsi/sg.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -urN linux-2.5.65/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-2.5.65/drivers/scsi/sg.c	2003-03-17 16:44:05.000000000 -0500
+++ linux/drivers/scsi/sg.c	2003-03-19 11:35:50.706607408 -0500
@@ -1331,9 +1331,11 @@
 sg_device_kdev_read(struct device *driverfs_dev, char *page)
 {
 	Sg_device *sdp = list_entry(driverfs_dev, Sg_device, sg_driverfs_dev);
-	return sprintf(page, "%x\n", MKDEV(sdp->disk->major,
-					   sdp->disk->first_minor));
+
+	return sprintf(page, "%lx\n", MKDEV(sdp->disk->major,
+					sdp->disk->first_minor));
 }
+
 static DEVICE_ATTR(kdev,S_IRUGO,sg_device_kdev_read,NULL);
 
 static ssize_t



