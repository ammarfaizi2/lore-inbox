Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUDORrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDORp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:45:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:25270 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263153AbUDORmN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:13 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509113014@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509122054@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.4, 2004/03/19 14:15:17-08:00, greg@kroah.com

Driver class: remove possible oops

This happens when the device associated with a class device goes away before
the class does.


 drivers/base/class.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Thu Apr 15 10:21:13 2004
+++ b/drivers/base/class.c	Thu Apr 15 10:21:13 2004
@@ -155,8 +155,7 @@
 
 static void class_device_dev_unlink(struct class_device * class_dev)
 {
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, "device");
+	sysfs_remove_link(&class_dev->kobj, "device");
 }
 
 static int class_device_driver_link(struct class_device * class_dev)
@@ -169,8 +168,7 @@
 
 static void class_device_driver_unlink(struct class_device * class_dev)
 {
-	if ((class_dev->dev) && (class_dev->dev->driver))
-		sysfs_remove_link(&class_dev->kobj, "driver");
+	sysfs_remove_link(&class_dev->kobj, "driver");
 }
 
 

