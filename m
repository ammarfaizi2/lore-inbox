Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUGTPiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUGTPiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 11:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUGTPiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 11:38:21 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:59093 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265383AbUGTPiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 11:38:09 -0400
Date: Tue, 20 Jul 2004 11:41:22 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
In-Reply-To: <Pine.LNX.4.58.0407201008460.21932@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0407201133520.23033@montezuma.fsmlabs.com>
References: <200407161011.36677.m.watts@eris.qinetiq.com>
 <Pine.LNX.4.58.0407161331090.26950@montezuma.fsmlabs.com>
 <200407190918.04053.m.watts@eris.qinetiq.com> <200407190922.34480.m.watts@eris.qinetiq.com>
 <Pine.LNX.4.58.0407201008460.21932@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004, Zwane Mwaikambo wrote:

> On Mon, 19 Jul 2004, Mark Watts wrote:
>
> > Sorry - read that as 'run lsmod'
>
> No problem, i seem to have fired off a premature email too, i'll eyeball
> the patches on the bugzilla report (http://bugme.osdl.org/process_bug.cgi).

Does the following patch work for you?

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
