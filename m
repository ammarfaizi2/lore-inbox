Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263223AbSJIAuv>; Tue, 8 Oct 2002 20:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJIAty>; Tue, 8 Oct 2002 20:49:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40364 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263223AbSJIAtY>;
	Tue, 8 Oct 2002 20:49:24 -0400
Date: Tue, 8 Oct 2002 17:57:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210081747180.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210081757250.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.599, 2002-10-08 17:23:56-07:00, mochel@osdl.org
  driver model: check return of get_device() when creating a driverfs file.

diff -Nru a/drivers/base/fs/device.c b/drivers/base/fs/device.c
--- a/drivers/base/fs/device.c	Tue Oct  8 17:55:20 2002
+++ b/drivers/base/fs/device.c	Tue Oct  8 17:55:20 2002
@@ -90,8 +90,7 @@
 {
 	int error = -EINVAL;
 
-	if (dev) {
-		get_device(dev);
+	if (get_device(dev)) {
 		error = driverfs_create_file(&entry->attr,&dev->dir);
 		put_device(dev);
 	}

