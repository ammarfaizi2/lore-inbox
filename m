Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUHHAda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUHHAda (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 20:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUHHAda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 20:33:30 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:33008 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264256AbUHHAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 20:33:28 -0400
Date: Sat, 7 Aug 2004 20:37:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI/Panic 2.6.8-rc3
In-Reply-To: <20040805003426.GA18820@net-ronin.org>
Message-ID: <Pine.LNX.4.58.0408072036280.19619@montezuma.fsmlabs.com>
References: <20040805003426.GA18820@net-ronin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, carbonated beverage wrote:

> Reported this a while ago, but tried it again, still getting oops
> when doing an rmmod of the ACPI processor module.
>
> Hardware: IBM T30, P4 2.4GHz, 256MiB, Debian/stable, did an rmmod processor.
>
> Note: Oops below was copied by hand, so may not be fully reliable.  Also,
> EIP was screwy, so no idea what was executing.

It should be fixed before 2.6.8, a patch has already been sent to the big
wigs.

Index: linux-2.6.8-rc1-mm1/drivers/acpi/processor.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/drivers/acpi/processor.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.c
--- linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	14 Jul 2004 04:56:25 -0000	1.1.1.1
+++ linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	20 Jul 2004 15:31:46 -0000
@@ -2372,8 +2372,10 @@ acpi_processor_remove (
 	pr = (struct acpi_processor *) acpi_driver_data(device);

 	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0)
+	if (pr->id == 0) {
 		pm_idle = pm_idle_save;
+		synchronize_kernel();
+	}

 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 		acpi_processor_notify);
