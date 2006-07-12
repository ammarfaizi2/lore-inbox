Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWGLGEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWGLGEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWGLGED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:04:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:18311 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932436AbWGLGEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:04:01 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="64659632:sNHT2880405570"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH -mm] acpi: handle firmware_register init errors
Date: Wed, 12 Jul 2006 02:03:47 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F31863@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH -mm] acpi: handle firmware_register init errors
Thread-Index: Acaldm32Ebvw6HWdRUmL/lpKnk6LKgAAXmOQ
From: "Brown, Len" <len.brown@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "lkml" <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Cc: "akpm" <akpm@osdl.org>
X-OriginalArrivalTime: 12 Jul 2006 06:03:49.0871 (UTC) FILETIME=[F1D737F0:01C6A578]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is syntatically correct, and I'll apply it.

For this to actually trigger, it appears that create_dir()
would have to fail, which is hard to imagine.

One might question the value of /sys/firmware/acpi based
on the fact that the only thing we do differently if we
can't create it is print a message...

-Len


>-----Original Message-----
>From: Randy.Dunlap [mailto:rdunlap@xenotime.net] 
>Sent: Wednesday, July 12, 2006 1:47 AM
>To: lkml; linux-acpi@vger.kernel.org
>Cc: Brown, Len; akpm
>Subject: [PATCH -mm] acpi: handle firmware_register init errors
>
>From: Randy Dunlap <rdunlap@xenotime.net>
>
>Check and handle init errors.
>
>Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>---
> drivers/acpi/bus.c |    6 +++++-
> 1 files changed, 5 insertions(+), 1 deletion(-)
>
>--- linux-2618-rc1mm1.orig/drivers/acpi/bus.c
>+++ linux-2618-rc1mm1/drivers/acpi/bus.c
>@@ -25,6 +25,7 @@
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/ioport.h>
>+#include <linux/kernel.h>
> #include <linux/list.h>
> #include <linux/sched.h>
> #include <linux/pm.h>
>@@ -738,7 +739,10 @@ static int __init acpi_init(void)
> 		return -ENODEV;
> 	}
> 
>-	firmware_register(&acpi_subsys);
>+	result = firmware_register(&acpi_subsys);
>+	if (result < 0)
>+		printk(KERN_WARNING "%s: firmware_register error: %d\n",
>+			__FUNCTION__, result);
> 
> 	result = acpi_bus_init();
> 
>
>
>---
>
