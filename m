Return-Path: <linux-kernel-owner+w=401wt.eu-S932428AbWLLUYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWLLUYP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWLLUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:24:15 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:38001 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932428AbWLLUYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:24:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=TCSbDDWDW2qsJ1107G885EHXdRCKeZJcdWmim6EkKIfsX9iIeVZMKi52vEc67jX9oZW7QoLs5U5NgPU/l7re59h8Hf6o8Kp6AuylJ5/QyHZR4/GS+z6CKQ48yHCMq87PcF3zgPFJ66pfJ0StYieMf2OtCp1WOxiYf+SfEBdytu4=  ;
X-YMail-OSG: xhQA0XUVM1mvk95VOrg_ms7HqUNHqPhzPBbKbVoQvioFclui6bleT_S9AmvkSnbYfNyiqOIZCu1Y_ISG1EYuvnipUcfxXauI1_4maQZJOSYTL6P7krAKG5KN6h15vP6yhf.VjTYIoCMfmA--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-git] rtc, remove syslog spam on registration
Date: Tue, 12 Dec 2006 11:23:55 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612121123.56778.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes some syslog spam as RTC drivers register; debug messages 
shouldn't come out at "info" level.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/rtc-proc.c
===================================================================
--- g26.orig/drivers/rtc/rtc-proc.c	2006-12-12 11:08:09.000000000 -0800
+++ g26/drivers/rtc/rtc-proc.c	2006-12-12 11:20:51.000000000 -0800
@@ -120,7 +120,7 @@ static int rtc_proc_add_device(struct cl
 			ent->owner = rtc->owner;
 			ent->data = class_dev;
 
-			dev_info(class_dev->dev, "rtc intf: proc\n");
+			dev_dbg(class_dev->dev, "rtc intf: proc\n");
 		}
 		else
 			rtc_dev = NULL;
Index: g26/drivers/rtc/rtc-sysfs.c
===================================================================
--- g26.orig/drivers/rtc/rtc-sysfs.c	2006-12-12 11:08:09.000000000 -0800
+++ g26/drivers/rtc/rtc-sysfs.c	2006-12-12 11:20:51.000000000 -0800
@@ -83,7 +83,7 @@ static int __devinit rtc_sysfs_add_devic
 {
 	int err;
 
-	dev_info(class_dev->dev, "rtc intf: sysfs\n");
+	dev_dbg(class_dev->dev, "rtc intf: sysfs\n");
 
 	err = sysfs_create_group(&class_dev->kobj, &rtc_attr_group);
 	if (err)
Index: g26/drivers/rtc/rtc-dev.c
===================================================================
--- g26.orig/drivers/rtc/rtc-dev.c	2006-12-12 11:08:09.000000000 -0800
+++ g26/drivers/rtc/rtc-dev.c	2006-12-12 11:20:51.000000000 -0800
@@ -435,7 +435,7 @@ static int rtc_dev_add_device(struct cla
 		goto err_cdev_del;
 	}
 
-	dev_info(class_dev->dev, "rtc intf: dev (%d:%d)\n",
+	dev_dbg(class_dev->dev, "rtc intf: dev (%d:%d)\n",
 		MAJOR(rtc->rtc_dev->devt),
 		MINOR(rtc->rtc_dev->devt));
 
