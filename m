Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbTIOPps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTIOPps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:45:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:56282 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261487AbTIOPpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:45:46 -0400
Date: Mon, 15 Sep 2003 08:42:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: Daniel Blueman <daniel.blueman@gmx.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-2.4.0-test5] swsusp w/o swap fail...
In-Reply-To: <1063405774.1195.26.camel@gimli.at.home>
Message-ID: <Pine.LNX.4.33.0309150836060.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't really know what's the problem, but CONFIG_ACPI_SLEEP=y selects
> CONFIG_SOFTWARE_SUSPEND independent if it or CONFIG_SWAP is selected.
> And it's somewhat confusing if one cannot turn off
> CONFIG_SOFTWARE_SUSPEND (after enabling CONFIG_SWAP) via `make
> menuconfig` even it is bool.
> So the workaroung was to simply disable CONFIG_SLEEP. 

Ah, I see. ACPI_SLEEP definitely does not imply SOFTWARE_SUSPEND. Thanks 
for pointing that out. The patch below should fix it.


	Pat


===== drivers/acpi/Kconfig 1.20 vs edited =====
--- 1.20/drivers/acpi/Kconfig	Sat Aug 23 04:07:34 2003
+++ edited/drivers/acpi/Kconfig	Mon Sep 15 08:37:24 2003
@@ -69,7 +69,6 @@
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86 && ACPI
 	depends on EXPERIMENTAL && PM
-	select SOFTWARE_SUSPEND
 	default y
 	---help---
 	  This option adds support for ACPI suspend states. 

