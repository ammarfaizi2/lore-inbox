Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTK1QwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTK1QwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:52:11 -0500
Received: from gprs148-17.eurotel.cz ([160.218.148.17]:43392 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262709AbTK1QwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:52:08 -0500
Date: Fri, 28 Nov 2003 17:52:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Tell user when ACPI is killing machine
Message-ID: <20031128165246.GA323@elf.ucw.cz>
References: <20031128145558.GA576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128145558.GA576@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On critical overheat (or perceived critical overheat -- acpi bioses on
> some notebooks apparently report bogus values from time to time),
> kernel itself calls /sbin/halt *without telling anything*. User can
> not see anything, his machine just shuts down cleanly. Bad.
> 
> We should at least tell the user what is going on... 

Okay, I had two bugs in single line of code (%ld and
KELVIN_TO_CELSIUS). Sorry about that, here's better version.

								Pavel

--- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2003-11-28 17:42:17.000000000 +0100
@@ -467,6 +474,7 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n", KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
