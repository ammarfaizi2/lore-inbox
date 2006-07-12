Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWGLFpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWGLFpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGLFpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:45:45 -0400
Received: from xenotime.net ([66.160.160.81]:25003 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751321AbWGLFpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:45:44 -0400
Date: Tue, 11 Jul 2006 22:47:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>
Subject: [PATCH -mm] acpi: handle firmware_register init errors
Message-Id: <20060711224702.295b892f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/bus.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2618-rc1mm1.orig/drivers/acpi/bus.c
+++ linux-2618-rc1mm1/drivers/acpi/bus.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
@@ -738,7 +739,10 @@ static int __init acpi_init(void)
 		return -ENODEV;
 	}
 
-	firmware_register(&acpi_subsys);
+	result = firmware_register(&acpi_subsys);
+	if (result < 0)
+		printk(KERN_WARNING "%s: firmware_register error: %d\n",
+			__FUNCTION__, result);
 
 	result = acpi_bus_init();
 


---
