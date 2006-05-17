Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWEQWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWEQWMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWEQWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:13 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14720 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751238AbWEQWME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:04 -0400
Message-Id: <20060517221412.058186000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:17 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Andi Kleen <ak@suse.de>, len.brown@intel.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/22] [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Content-Disposition: inline; filename=i386-x86_64-Force-pci-noacpi-on-HP-XW9300.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This is needed to see all devices.

The system has multiple PCI segments and we don't handle that properly
yet in PCI and ACPI. Short term before this is fixed blacklist it to
pci=noacpi.

Acked-by: len.brown@intel.com
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/acpi/boot.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.16.16.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.16.16/arch/i386/kernel/acpi/boot.c
@@ -1060,6 +1060,14 @@ static struct dmi_system_id __initdata a
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
 

--
