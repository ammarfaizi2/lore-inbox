Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWB1XYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWB1XYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbWB1XYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:24:16 -0500
Received: from fmr22.intel.com ([143.183.121.14]:45208 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932718AbWB1XYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:24:12 -0500
Message-Id: <20060301001722.646596000@araj-sfield>
References: <20060301001557.318047000@araj-sfield>
Date: Tue, 28 Feb 2006 16:15:58 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Len Brown <len.brown@intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 1/5] Remove entries in /sys/firmware/acpi for processor also.
Content-Disposition: inline; filename=remove-processor-entries-on-eject
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Processor entries under /sys/firmware/acpi/namespace/ACPI/_SB/CPU*
were not being removed due to acpi_bus_trim not asking for it
just for processors. Without which a new hot-add after a remove doesnt call 
appropriate init functions resulting in subsequent hot-add for same
cpu failing. 

Not clear why we restricted that to non-processor devices.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------
 drivers/acpi/scan.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.16-rc4-mm1/drivers/acpi/scan.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/drivers/acpi/scan.c
+++ linux-2.6.16-rc4-mm1/drivers/acpi/scan.c
@@ -434,10 +434,7 @@ acpi_eject_store(struct acpi_device *dev
 	islockable = device->flags.lockable;
 	handle = device->handle;
 
-	if (type == ACPI_TYPE_PROCESSOR)
-		result = acpi_bus_trim(device, 0);
-	else
-		result = acpi_bus_trim(device, 1);
+	result = acpi_bus_trim(device, 1);
 
 	if (!result)
 		result = acpi_eject_operation(handle, islockable);

--

