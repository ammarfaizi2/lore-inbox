Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTK1Ozi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTK1Ozi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:55:38 -0500
Received: from gprs148-17.eurotel.cz ([160.218.148.17]:898 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262344AbTK1Ozb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:55:31 -0500
Date: Fri, 28 Nov 2003 15:55:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Tell user when ACPI is killing machine
Message-ID: <20031128145558.GA576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On critical overheat (or perceived critical overheat -- acpi bioses on
some notebooks apparently report bogus values from time to time),
kernel itself calls /sbin/halt *without telling anything*. User can
not see anything, his machine just shuts down cleanly. Bad.

We should at least tell the user what is going on... 

								Pavel

--- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2003-11-25 22:27:11.000000000 +0100
@@ -467,6 +474,7 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down.\n", tz->temperature);
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
