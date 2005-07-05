Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVGEVIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVGEVIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVGEVGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:06:39 -0400
Received: from afb200.neoplus.adsl.tpnet.pl ([83.25.131.200]:9875 "EHLO
	omega.xtr.net.pl") by vger.kernel.org with ESMTP id S261905AbVGEVFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:05:03 -0400
Message-ID: <3878.192.168.5.14.1120597493.squirrel@omega.xtr.net.pl>
Date: Tue, 5 Jul 2005 23:04:53 +0200 (CEST)
Subject: missing "platform_remove_devices" in kernel 2.6
From: "Pawel Kolodziejski" <pablo@omega.xtr.net.pl>
To: linux-kernel@vger.kernel.org
Reply-To: pablo@omega.xtr.net.pl
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050705230453_17111"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050705230453_17111
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I attached patch for kernel 2.6.12 which add missing
"platform_remove_devices" function in "drivers/base/platform.c" file.

Pawel Kolodziejski


------=_20050705230453_17111
Content-Type: text/x-patch; name="remove_platform_devices.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="remove_platform_devices.diff"

diff -u -r -N -P old/kernel26/drivers/base/platform.c new/kernel26/drivers/base/platform.c
--- old/kernel26/drivers/base/platform.c	2005-07-01 06:48:46.000000000 +0200
+++ new/kernel26/drivers/base/platform.c	2005-07-01 07:33:44.000000000 +0200
@@ -114,6 +114,22 @@
 }
 
 /**
+ *	platform_remove_devices - remove a numbers of platform devices
+ *	@devs: array of platform devices to remove
+ *	@num: number of platform devices in array
+ */
+int platform_remove_devices(struct platform_device **devs, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		platform_device_unregister(devs[i]);
+	}
+
+	return 0;
+}
+
+/**
  *	platform_device_register - add a platform-level device
  *	@pdev:	platform device we're adding
  *
@@ -347,6 +363,7 @@
 EXPORT_SYMBOL_GPL(platform_bus);
 EXPORT_SYMBOL_GPL(platform_bus_type);
 EXPORT_SYMBOL_GPL(platform_add_devices);
+EXPORT_SYMBOL_GPL(platform_remove_devices);
 EXPORT_SYMBOL_GPL(platform_device_register);
 EXPORT_SYMBOL_GPL(platform_device_register_simple);
 EXPORT_SYMBOL_GPL(platform_device_unregister);
------=_20050705230453_17111--

