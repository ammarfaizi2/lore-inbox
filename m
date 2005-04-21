Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVDUIn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVDUIn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDUIbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:31:34 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:18854 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261480AbVDUHiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:38:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 22/22] W1: expose module parameters in sysfs
Date: Thu, 21 Apr 2005 02:38:38 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/h1ZCJJJSn064Au"
Message-Id: <200504210238.39307.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/h1ZCJJJSn064Au
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_/h1ZCJJJSn064Au
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="w1-module-attrs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w1-module-attrs.patch"

W1: allow changing w1 module parameters through sysfs, add parameter
    descriptions and document them in Documentation/kernel-parameters.txt

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/kernel-parameters.txt |   19 ++++++++++++++++---
 drivers/w1/w1.c                     |   12 ++++++++----
 2 files changed, 24 insertions(+), 7 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -43,12 +43,16 @@ MODULE_AUTHOR("Evgeniy Polyakov <johnpol
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
 
 static int w1_scan_interval = 10;
+module_param_named(scan_interval, w1_scan_interval, int, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(scan_interval, "Interval between scans for slave devices on a wire.");
+
 static int w1_max_slave_count = 10;
-static int w1_max_slave_ttl = 10;
+module_param_named(max_slave_count, w1_max_slave_count, int, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(max_slave_count, "Maximum number of slaves we allow on a wire.");
 
-module_param_named(scan_interval, w1_scan_interval, int, 0);
-module_param_named(max_slave_count, w1_max_slave_count, int, 0);
-module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
+static int w1_max_slave_ttl = 10;
+module_param_named(slave_ttl, w1_max_slave_ttl, int, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(slave_ttl, "Number of unsuccessful scans before slave device is deleted.");
 
 struct device_driver w1_master_driver = {
 	.name = "master",
Index: dtor/Documentation/kernel-parameters.txt
===================================================================
--- dtor.orig/Documentation/kernel-parameters.txt
+++ dtor/Documentation/kernel-parameters.txt
@@ -78,6 +78,7 @@ restrictions referred to are that the re
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
+	W1	Dallas 1-Wire support is enabled.
 	WDT	Watchdog support is enabled.
 	XT	IBM PC/XT MFM hard disk support is enabled.
 	X86-64	X86-64 architecture is enabled.
@@ -1471,11 +1472,23 @@ running once the system is up.
 
 	vmhalt=		[KNL,S390]
 
-	vmpoff=		[KNL,S390] 
- 
+	vmpoff=		[KNL,S390]
+
+	w1.max_slave_count=
+			[HW,W1] Maximum number of slave devices we expect on
+			a wire (for one master). Default is 10.
+
+	w1.scan_interval=
+			[HW,W1] Interval between scans for connected slave
+			devices on a wire. Default is 10 sec.
+
+	w1.slave_ttl=	[HW,W1] Number of unsuccessful scans before slave
+			device is declared disconncted and removed from the
+			bus. Default is 10.
+
 	waveartist=	[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>
- 
+
 	wd33c93=	[HW,SCSI]
 			See header of drivers/scsi/wd33c93.c.
 

--Boundary-00=_/h1ZCJJJSn064Au--
