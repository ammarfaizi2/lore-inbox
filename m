Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTEODTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTEODSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:43 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:6124 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263780AbTEODSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:17 -0400
Date: Thu, 15 May 2003 04:31:02 +0100
Message-Id: <200305150331.h4F3V21s000551@deviant.impure.org.uk>
To: mochel@osdl.org
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: sysfs bits
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look sane ?

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/base/cpu.c linux-2.5/drivers/base/cpu.c
--- bk-linus/drivers/base/cpu.c	2003-04-30 16:02:26.000000000 +0100
+++ linux-2.5/drivers/base/cpu.c	2003-05-01 03:12:55.000000000 +0100
@@ -46,7 +46,7 @@ int __init register_cpu(struct cpu *cpu,
 	snprintf(cpu->sysdev.class_dev.class_id, BUS_ID_SIZE, "cpu%d", num);
 	retval = class_device_register(&cpu->sysdev.class_dev);
 	if (retval) {
-		// FIXME cleanup sys_device_register
+		sys_device_unregister(&cpu->sysdev);
 		return retval;
 	}
 	return 0;
@@ -58,10 +58,12 @@ int __init cpu_dev_init(void)
 	int error;
 
 	error = class_register(&cpu_class);
-	if (!error) {
-		error = driver_register(&cpu_driver);
-		if (error)
-			class_unregister(&cpu_class);
-	}
+	if (error)
+		goto out;
+	
+	error = driver_register(&cpu_driver);
+	if (error)
+		class_unregister(&cpu_class);
+out:
 	return error;
 }
