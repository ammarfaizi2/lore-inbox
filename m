Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUIOLRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUIOLRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUIOLRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:17:07 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:18817 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264915AbUIOLRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:17:00 -0400
Date: Wed, 15 Sep 2004 13:16:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
Subject: Cleanup macro abuse in battery.c
Message-ID: <20040915111646.GA19675@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ACPI likes to abuse #define's quite a lot. This kills one of worst
offenders. Please apply,
								Pavel

--- clean-mm/drivers/acpi/battery.c	2004-08-24 09:03:30.000000000 +0200
+++ linux-mm/drivers/acpi/battery.c	2004-09-15 13:00:50.000000000 +0200
@@ -49,8 +49,6 @@
 #define ACPI_BATTERY_FILE_ALARM		"alarm"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
-#define ACPI_BATTERY_UNITS_WATTS	"mW"
-#define ACPI_BATTERY_UNITS_AMPS		"mA"
 
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
@@ -378,7 +376,7 @@
 		goto end;
 	}
 
-	units = bif->power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	units = bif->power_unit ? "mA" : "mW";
 					
 	if (bif->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 		p += sprintf(p, "design capacity:         unknown\n");
@@ -471,7 +469,7 @@
 
 	/* Battery Units */
 
-	units = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	units = battery->flags.power_unit ? "mA" : "mW";
 
 	/* Battery Status (_BST) */
 
@@ -557,7 +555,7 @@
 
 	/* Battery Units */
 	
-	units = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	units = battery->flags.power_unit ? "mA" : "mW";
 
 	/* Battery Alarm */
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
