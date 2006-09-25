Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWIYKit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWIYKit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWIYKit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:38:49 -0400
Received: from server6.greatnet.de ([83.133.96.26]:58047 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751093AbWIYKis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:38:48 -0400
Message-ID: <4517B1C5.30609@nachtwindheim.de>
Date: Mon, 25 Sep 2006 12:39:01 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: jirislaby@gmail.com, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: droping a patch in mm
References: <451792E2.2020800@nachtwindheim.de> <4517950D.8010907@gmail.com>
In-Reply-To: <4517950D.8010907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jiri Slaby schrieb:

>>Henne wrote:
>>Hi!
>>Would you please drop:
>>pci_module_init_conversion-in-scsi-subsys-2nd-try.patch
>>cause it the moving of libata now it will only produce a lot of errors.
>>I'll rewrite it today.
>
>And this wrong too in that patch:
>-    /* Translate error or zero return into zero or one */
>-    return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
>+    return pci_register_driver(&aic7xxx_pci_driver);
>
>regards,

Acked! But I don't think thats good style to __translate__ return values,
even if this one is ignored.
I'll keep it the way it was and just change pci_module_init() into pci_register_driver().

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes pci_module_init() to pci_register_driver() in the scsi-subsys
for drivers which just return the returvalue of that function.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 3w-9xxx.c                 |    2 +-
 3w-xxxx.c                 |    2 +-
 a100u2w.c                 |    2 +-
 aic7xxx/aic79xx_osm_pci.c |    2 +-
 aic7xxx/aic7xxx_osm_pci.c |    2 +-
 dc395x.c                  |    2 +-
 dmx3191d.c                |    2 +-
 ipr.c                     |    2 +-
 nsp32.c                   |    2 +-
 qla1280.c                 |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff -ruN linux-2.6/drivers/scsi/3w-9xxx.c linux-2.6.18-git4/drivers/scsi/3w-9xxx.c
--- linux-2.6/drivers/scsi/3w-9xxx.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/3w-9xxx.c	2006-09-25 12:00:36.000000000 +0200
@@ -2211,7 +2211,7 @@
 {
 	printk(KERN_WARNING "3ware 9000 Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&twa_driver);
+	return pci_register_driver(&twa_driver);
 } /* End twa_init() */
 
 /* This function is called on driver exit */
diff -ruN linux-2.6/drivers/scsi/3w-xxxx.c linux-2.6.18-git4/drivers/scsi/3w-xxxx.c
--- linux-2.6/drivers/scsi/3w-xxxx.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/3w-xxxx.c	2006-09-25 12:01:13.000000000 +0200
@@ -2486,7 +2486,7 @@
 {
 	printk(KERN_WARNING "3ware Storage Controller device driver for Linux v%s.\n", TW_DRIVER_VERSION);
 
-	return pci_module_init(&tw_driver);
+	return pci_register_driver(&tw_driver);
 } /* End tw_init() */
 
 /* This function is called on driver exit */
diff -ruN linux-2.6/drivers/scsi/a100u2w.c linux-2.6.18-git4/drivers/scsi/a100u2w.c
--- linux-2.6/drivers/scsi/a100u2w.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/a100u2w.c	2006-09-25 12:01:59.000000000 +0200
@@ -1187,7 +1187,7 @@
 
 static int __init inia100_init(void)
 {
-	return pci_module_init(&inia100_pci_driver);
+	return pci_register_driver(&inia100_pci_driver);
 }
 
 static void __exit inia100_exit(void)
diff -ruN linux-2.6/drivers/scsi/aic7xxx/aic79xx_osm_pci.c linux-2.6.18-git4/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- linux-2.6/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2006-09-25 12:02:56.000000000 +0200
@@ -198,7 +198,7 @@
 int
 ahd_linux_pci_init(void)
 {
-	return (pci_module_init(&aic79xx_pci_driver));
+	return pci_register_driver(&aic79xx_pci_driver);
 }
 
 void
diff -ruN linux-2.6/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux-2.6.18-git4/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.6/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-09-25 12:05:09.000000000 +0200
@@ -247,7 +247,7 @@
 ahc_linux_pci_init(void)
 {
 	/* Translate error or zero return into zero or one */
-	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
+	return pci_register_driver(&aic7xxx_pci_driver) ? 0 : 1;
 }
 
 void
diff -ruN linux-2.6/drivers/scsi/dc395x.c linux-2.6.18-git4/drivers/scsi/dc395x.c
--- linux-2.6/drivers/scsi/dc395x.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/dc395x.c	2006-09-25 12:05:40.000000000 +0200
@@ -4949,7 +4949,7 @@
  **/
 static int __init dc395x_module_init(void)
 {
-	return pci_module_init(&dc395x_driver);
+	return pci_register_driver(&dc395x_driver);
 }
 
 
diff -ruN linux-2.6/drivers/scsi/dmx3191d.c linux-2.6.18-git4/drivers/scsi/dmx3191d.c
--- linux-2.6/drivers/scsi/dmx3191d.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/dmx3191d.c	2006-09-25 12:06:10.000000000 +0200
@@ -155,7 +155,7 @@
 
 static int __init dmx3191d_init(void)
 {
-	return pci_module_init(&dmx3191d_pci_driver);
+	return pci_register_driver(&dmx3191d_pci_driver);
 }
 
 static void __exit dmx3191d_exit(void)
diff -ruN linux-2.6/drivers/scsi/ipr.c linux-2.6.18-git4/drivers/scsi/ipr.c
--- linux-2.6/drivers/scsi/ipr.c	2006-09-25 09:27:47.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/ipr.c	2006-09-25 12:06:45.000000000 +0200
@@ -6749,7 +6749,7 @@
 	ipr_info("IBM Power RAID SCSI Device Driver version: %s %s\n",
 		 IPR_DRIVER_VERSION, IPR_DRIVER_DATE);
 
-	return pci_module_init(&ipr_driver);
+	return pci_register_driver(&ipr_driver);
 }
 
 /**
diff -ruN linux-2.6/drivers/scsi/nsp32.c linux-2.6.18-git4/drivers/scsi/nsp32.c
--- linux-2.6/drivers/scsi/nsp32.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/nsp32.c	2006-09-25 12:07:30.000000000 +0200
@@ -3581,7 +3581,7 @@
  */
 static int __init init_nsp32(void) {
 	nsp32_msg(KERN_INFO, "loading...");
-	return pci_module_init(&nsp32_driver);
+	return pci_register_driver(&nsp32_driver);
 }
 
 static void __exit exit_nsp32(void) {
diff -ruN linux-2.6/drivers/scsi/qla1280.c linux-2.6.18-git4/drivers/scsi/qla1280.c
--- linux-2.6/drivers/scsi/qla1280.c	2006-08-01 01:31:43.000000000 +0200
+++ linux-2.6.18-git4/drivers/scsi/qla1280.c	2006-09-25 12:08:41.000000000 +0200
@@ -4484,7 +4484,7 @@
 		qla1280_setup(qla1280);
 #endif
 
-	return pci_module_init(&qla1280_pci_driver);
+	return pci_register_driver(&qla1280_pci_driver);
 }
 
 static void __exit




