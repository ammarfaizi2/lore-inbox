Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWILLzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWILLzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWILLzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:55:13 -0400
Received: from mx10.go2.pl ([193.17.41.74]:54678 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932259AbWILLzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:55:11 -0400
Date: Tue, 12 Sep 2006 13:58:56 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: [PATCH] drivers/acpi/processor.o - Section mismatch Bug# 6992
Message-ID: <20060912115856.GA4211@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Maybe I miss why it takes so long to remove this warning
or maybe it's only the lack of time, so here is my proposal.

Jarek P.

diff -Nurp linux-2.6.18-rc6-git1-/drivers/acpi/processor_core.c linux-2.6.18-rc6-git1/drivers/acpi/processor_core.c
--- linux-2.6.18-rc6-git1-/drivers/acpi/processor_core.c	2006-09-12 00:01:00.000000000 +0200
+++ linux-2.6.18-rc6-git1/drivers/acpi/processor_core.c	2006-09-12 00:01:00.000000000 +0200
@@ -81,7 +81,7 @@ MODULE_DESCRIPTION(ACPI_PROCESSOR_DRIVER
 MODULE_LICENSE("GPL");
 
 static int acpi_processor_add(struct acpi_device *device);
-static int acpi_processor_start(struct acpi_device *device);
+static int __cpuinit acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
 static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
@@ -519,7 +519,7 @@ static int acpi_processor_get_info(struc
 
 static void *processor_device_array[NR_CPUS];
 
-static int acpi_processor_start(struct acpi_device *device)
+static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
diff -Nurp linux-2.6.18-rc6-git1-/drivers/acpi/processor_idle.c linux-2.6.18-rc6-git1/drivers/acpi/processor_idle.c
--- linux-2.6.18-rc6-git1-/drivers/acpi/processor_idle.c	2006-09-12 00:01:00.000000000 +0200
+++ linux-2.6.18-rc6-git1/drivers/acpi/processor_idle.c	2006-09-12 00:01:00.000000000 +0200
@@ -1077,7 +1077,7 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
diff -Nurp linux-2.6.18-rc6-git1-/include/acpi/processor.h linux-2.6.18-rc6-git1/include/acpi/processor.h
--- linux-2.6.18-rc6-git1-/include/acpi/processor.h	2006-09-12 00:01:00.000000000 +0200
+++ linux-2.6.18-rc6-git1/include/acpi/processor.h	2006-09-12 00:01:00.000000000 +0200
@@ -251,7 +251,7 @@ int acpi_processor_set_throttling(struct
 extern struct file_operations acpi_processor_throttling_fops;
 
 /* in processor_idle.c */
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device);
 int acpi_processor_cst_has_changed(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr,
