Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUCPBV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUCPBUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:20:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:51119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262870AbUCPADK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:10 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951473255@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:07 -0800
Message-Id: <10793951472319@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.6, 2004/03/10 16:06:14-08:00, chrisw@osdl.org

[PATCH] class_simple cleanup in sg

The only spot that seems to care about class_simple_device_add possibly
failing, but it gets the wrong error test.


 drivers/scsi/sg.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Mon Mar 15 15:29:36 2004
+++ b/drivers/scsi/sg.c	Mon Mar 15 15:29:36 2004
@@ -1439,7 +1439,7 @@
 				MKDEV(SCSI_GENERIC_MAJOR, k), 
 				cl_dev->dev, "%s", 
 				disk->disk_name);
-		if (NULL == sg_class_member)
+		if (IS_ERR(sg_class_member))
 			printk(KERN_WARNING "sg_add: "
 				"class_simple_device_add failed\n");
 		class_set_devdata(sg_class_member, sdp);

