Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUHWWrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUHWWrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268104AbUHWWrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:47:15 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:56788 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267773AbUHWWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:36:58 -0400
Date: Mon, 23 Aug 2004 18:41:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
In-Reply-To: <200408171728.06262.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0408231839280.13924@montezuma.fsmlabs.com>
References: <200408171728.06262.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, BlaisorBlade wrote:

> (CC me on replies as I'm not subscribed).
>
> A short description, with my hypothesis about how the panic() happened:

There is a short one liner for this which is already in the latest
kernel;

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
