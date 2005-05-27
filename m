Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVE0Ksz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVE0Ksz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVE0Ksz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:48:55 -0400
Received: from mailfe10.tele2.se ([212.247.155.33]:20370 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262433AbVE0Ksw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:48:52 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] ACPI build fix for 2.6.12-rc5
From: Alexander Nyberg <alexn@telia.com>
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
Cc: ak@suse.de, torvalds@osdl.org, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
	 <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
Content-Type: text/plain
Date: Fri, 27 May 2005 12:48:50 +0200
Message-Id: <1117190930.949.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-05-27 klockan 04:53 -0400 skrev Len Brown:
> Linus,
> Please apply this CONFIG_ACPI=n build fix to 2.6.12-rc5
> 
> thanks,
> Len
> 
> Fix 2.6.12 CONFIG_ACPI=n build regression.
> CONFIG_ACPI_BOOT shall be set only if CONFIG_ACPI.
>

You can still set CONFIG_ACPI_BOOT && !CONFIG_ACPI by choosing
CONFIG_PCI => CONFIG_PCI_MMCONFIG (doesn't build very well either).

Make CONFIG_ACPI_BOOT fully depend on CONFIG_ACPI

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/arch/i386/Kconfig
===================================================================
--- linux-2.6.orig/arch/i386/Kconfig	2005-05-17 23:14:51.000000000 +0200
+++ linux-2.6/arch/i386/Kconfig	2005-05-27 12:33:42.000000000 +0200
@@ -1163,7 +1163,7 @@
 
 config PCI_MMCONFIG
 	bool
-	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI))
+	depends on PCI && ACPI && (PCI_GOMMCONFIG || PCI_GOANY)
 	select ACPI_BOOT
 	default y
 
Index: linux-2.6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86_64/Kconfig	2005-05-17 23:14:53.000000000 +0200
+++ linux-2.6/arch/x86_64/Kconfig	2005-05-27 12:32:59.000000000 +0200
@@ -421,7 +421,7 @@
 
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
-	depends on PCI
+	depends on PCI && ACPI
 	select ACPI_BOOT
 
 config UNORDERED_IO


