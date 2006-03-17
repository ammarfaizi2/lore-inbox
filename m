Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752479AbWCQBSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbWCQBSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbWCQBSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:18:53 -0500
Received: from fmr17.intel.com ([134.134.136.16]:58782 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752479AbWCQBSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:18:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Fri, 17 Mar 2006 09:17:40 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B37ABA9@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZJDMVGuR5H8T1jTHu7WiZHFgaXQAAUfNGg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 17 Mar 2006 01:17:42.0124 (UTC) FILETIME=[96BC2AC0:01C64960]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Bad news.  It hangs when I do the usual stress test:

Hmm,  we can continue to have fun with debugging. Right?

>
>echo 1 > THM0/polling_frequency
>sleep.sh
>sleep.sh
>
>The second sleep.sh hangs going to sleep.  It is in an endless loop
>printing the following line, once per second (from the
>polling_frequency):
>
>  Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

This should be the diffient problem with the previous reported hang.
I recall it was hang at a loop in SMPI waiting for BIOS's response.
Please confirm, Also please mute THM0 polling.

>
>> Please also make sure you have vanilla DSDT
>
>$ grep DSDT /boot/config-2.6.16-rc5.fake-thermal_active+passive
># CONFIG_ACPI_CUSTOM_DSDT is not set
>
>> vanilla Kernel, and just hacked acpi_thermal_active/passive.
>
>Only diff between pristine 2.6.16-rc5 tree and mine is:
>
>diff -rup /tmp/linux-2.6.16-rc5/drivers/acpi/thermal.c 
>/usr/src/linux-2.6.16-rc5/drivers/acpi/thermal.c
>--- /tmp/linux-2.6.16-rc5/drivers/acpi/thermal.c	
>2006-02-27 00:09:35.000000000 -0500
>+++ /usr/src/linux-2.6.16-rc5/drivers/acpi/thermal.c	
>2006-03-16 09:45:30.000000000 -0500
>@@ -526,6 +526,8 @@ static void acpi_thermal_passive(struct 
> 
> 	ACPI_FUNCTION_TRACE("acpi_thermal_passive");
> 
>+	return;
>+
> 	if (!tz || !tz->trips.passive.flags.valid)
> 		return;
> 
>@@ -615,6 +617,8 @@ static void acpi_thermal_active(struct a
> 
> 	ACPI_FUNCTION_TRACE("acpi_thermal_active");
> 
>+	return;
>+
> 	if (!tz)
> 		return;
> 
>

This looks ok for debugging.
