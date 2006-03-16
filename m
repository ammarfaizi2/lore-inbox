Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWCPPPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWCPPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCPPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:15:16 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:17057 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751331AbWCPPPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:15:14 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Thu, 16 Mar 2006 16:18:05 +0800."
             <3ACA40606221794F80A5670F0AF15F840B37A7EF@pdsmsx403> 
Date: Thu, 16 Mar 2006 15:15:10 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJuBy-0004Sd-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bad news.  It hangs when I do the usual stress test:

echo 1 > THM0/polling_frequency
sleep.sh
sleep.sh

The second sleep.sh hangs going to sleep.  It is in an endless loop
printing the following line, once per second (from the
polling_frequency):

  Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)

> Please also make sure you have vanilla DSDT

$ grep DSDT /boot/config-2.6.16-rc5.fake-thermal_active+passive
# CONFIG_ACPI_CUSTOM_DSDT is not set

> vanilla Kernel, and just hacked acpi_thermal_active/passive.

Only diff between pristine 2.6.16-rc5 tree and mine is:

diff -rup /tmp/linux-2.6.16-rc5/drivers/acpi/thermal.c /usr/src/linux-2.6.16-rc5/drivers/acpi/thermal.c
--- /tmp/linux-2.6.16-rc5/drivers/acpi/thermal.c	2006-02-27 00:09:35.000000000 -0500
+++ /usr/src/linux-2.6.16-rc5/drivers/acpi/thermal.c	2006-03-16 09:45:30.000000000 -0500
@@ -526,6 +526,8 @@ static void acpi_thermal_passive(struct 
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_passive");
 
+	return;
+
 	if (!tz || !tz->trips.passive.flags.valid)
 		return;
 
@@ -615,6 +617,8 @@ static void acpi_thermal_active(struct a
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_active");
 
+	return;
+
 	if (!tz)
 		return;
 

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
