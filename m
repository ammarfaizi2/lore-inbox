Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbTEGJJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTEGJJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:09:54 -0400
Received: from axion.xs4all.nl ([213.84.8.90]:40234 "EHLO axion.demon.nl")
	by vger.kernel.org with ESMTP id S263013AbTEGJJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:09:52 -0400
Date: Wed, 7 May 2003 11:22:22 +0200
From: Monchi Abbad <kernel@axion.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: dvbdev fixes ( /dev/dvb/adapter0demux0 -> /dev/dvb/adapter0/demux0
Message-ID: <20030507092222.GA18446@axion.demon.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I found a mistake in the dvbdev.c file when creating the dvb /devfs files, it created /dev/dvb/adapter0device0 instead of /dev/dvb/adapter0/device0. But here is a simple fix.

Monchi.

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-dvbdev.diff"

--- linux/drivers/media/dvb/dvb-core/dvbdev.c2	2003-05-05 01:53:07.000000000 +0200
+++ linux/drivers/media/dvb/dvb-core/dvbdev.c	2003-05-07 10:14:30.000000000 +0200
@@ -219,7 +219,7 @@
 
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
 
-	sprintf(name, "dvb/adapter%d%s%d", adap->num, dnames[type], id);
+	sprintf(name, "dvb/adapter%d/%s%d", adap->num, dnames[type], id);
 	devfs_register(NULL, name, 0, DVB_MAJOR, nums2minor(adap->num, type, id),
 			S_IFCHR | S_IRUSR | S_IWUSR, dvbdev->fops, dvbdev);
 
@@ -234,7 +234,7 @@
 void dvb_unregister_device(struct dvb_device *dvbdev)
 {
 	if (dvbdev) {
-		devfs_remove("dvb/adapter%d%s%d", dvbdev->adapter->num,
+		devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
 				dnames[dvbdev->type], dvbdev->id);
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);

--HcAYCG3uE/tztfnV--
