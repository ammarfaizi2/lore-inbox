Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWEOQTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWEOQTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWEOQTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:19:44 -0400
Received: from mail.suse.de ([195.135.220.2]:47531 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932078AbWEOQTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:19:43 -0400
Date: Mon, 15 May 2006 18:19:41 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, gregkh@suse.de,
       len.brown@intel.com
Subject: [PATCH for 2.6.17] [3/5] i386/x86_64: Force pci=noacpi on HP 
 XW9300
Message-ID: <4468AA1D.mail5VE1HT8PJ@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is needed to see all devices.

The system has multiple PCI segments and we don't handle that properly
yet in PCI and ACPI. Short term before this is fixed blacklist it to
pci=noacpi.

Cc: len.brown@intel.com
Cc: gregkh@suse.de

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/acpi/boot.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -1066,6 +1066,14 @@ static struct dmi_system_id __initdata a
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+	{
+	 .callback = disable_acpi_pci,
+	 .ident = "HP xw9300",
+	 .matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
+		    },
+	},
 	{}
 };
 
