Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSIEVwY>; Thu, 5 Sep 2002 17:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIEVwV>; Thu, 5 Sep 2002 17:52:21 -0400
Received: from hermes.domdv.de ([193.102.202.1]:38665 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318205AbSIEVvY>;
	Thu, 5 Sep 2002 17:51:24 -0400
Message-ID: <3D77C134.2010709@domdv.de>
Date: Thu, 05 Sep 2002 22:40:20 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compiler warning fix for dv1394.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050803000305090900070300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050803000305090900070300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached is a trivial fix for conpiler warnings for dv1394.c if
CONFIG_DEVFS_FS is not defined.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH


--------------050803000305090900070300
Content-Type: text/plain;
 name="dv1394.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dv1394.c.diff"

--- drivers/ieee1394/dv1394.c.orig	2002-09-05 22:31:43.000000000 +0200
+++ drivers/ieee1394/dv1394.c	2002-09-05 22:32:10.000000000 +0200
@@ -2580,6 +2580,7 @@
 	return NULL;
 }
 
+#ifdef CONFIG_DEVFS_FS
 static int dv1394_devfs_add_entry(struct video_card *video)
 {
 	char buf[32];
@@ -2674,6 +2675,7 @@
  err:
 	return -ENOMEM;
 }
+#endif
 
 void dv1394_devfs_del( char *name)
 {
@@ -2852,7 +2854,9 @@
 {
 	struct ti_ohci *ohci;
 	char buf[16];
+#ifdef CONFIG_DEVFS_FS
 	struct dv1394_devfs_entry *devfs_entry;
+#endif
 
 	/* We only work with the OHCI-1394 driver */
 	if (strcmp(host->driver->name, OHCI1394_DRIVER_NAME))


--------------050803000305090900070300--


