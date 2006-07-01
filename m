Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWGAAVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWGAAVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWGAAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:21:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750967AbWGAAVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:21:08 -0400
Date: Fri, 30 Jun 2006 17:24:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, torvalds@osdl.org
Subject: Re: ACPI: Device [kobj-name] is not power manageable
Message-Id: <20060630172431.3422e268.akpm@osdl.org>
In-Reply-To: <20060630171542.ebd05bb4.rdunlap@xenotime.net>
References: <200606302359.k5UNxPJ1002907@hera.kernel.org>
	<20060630171542.ebd05bb4.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> Andrew, can you send Linus the typo correction patch for this??
> or should I?

Is OK, I have a couple of post-acpi-merge fixlets queued which I'll be
sending in the next batch.

diff -puN drivers/acpi/acpi_memhotplug.c~acpi-printk-fix drivers/acpi/acpi_memhotplug.c
--- a/drivers/acpi/acpi_memhotplug.c~acpi-printk-fix
+++ a/drivers/acpi/acpi_memhotplug.c
@@ -248,7 +248,7 @@ static int acpi_memory_enable_device(str
 		num_enabled++;
 	}
 	if (!num_enabled) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
+		printk(KERN_ERR PREFIX "add_memory failed\n");
 		mem_device->state = MEMORY_INVALID_STATE;
 		return -EINVAL;
 	}
_


and

--- a/drivers/acpi/bus.c~acpi-identify-which-device-is-not-power-manageable
+++ a/drivers/acpi/bus.c
@@ -192,7 +192,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		printk(KERN_DEBUG "Device `[%s]is not power manageable",
+		printk(KERN_DEBUG "Device `[%s]' is not power manageable",
 				device->kobj.name);
 		return -ENODEV;
 	}
_

