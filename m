Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCDEKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUCDEG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:06:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:43445 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261447AbUCDEG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:06:27 -0500
Date: Wed, 3 Mar 2004 20:06:25 -0800
From: Chris Wright <chrisw@osdl.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] class_simple cleanup in sg
Message-ID: <20040303200625.N21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only spot that seems to care about class_simple_device_add possibly
failing, but it gets the wrong error test.

===== drivers/scsi/sg.c 1.81 vs edited =====
--- 1.81/drivers/scsi/sg.c	Fri Feb  6 00:21:23 2004
+++ edited/drivers/scsi/sg.c	Wed Mar  3 19:56:13 2004
@@ -1439,7 +1439,7 @@
 				MKDEV(SCSI_GENERIC_MAJOR, k), 
 				cl_dev->dev, "%s", 
 				disk->disk_name);
-		if (NULL == sg_class_member)
+		if (IS_ERR(sg_class_member))
 			printk(KERN_WARNING "sg_add: "
 				"class_simple_device_add failed\n");
 		class_set_devdata(sg_class_member, sdp);
