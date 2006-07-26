Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWGZRcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWGZRcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWGZRcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:32:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:45743 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751723AbWGZRcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:32:45 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105072699:sNHT17081026438"
Date: Wed, 26 Jul 2006 10:32:26 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org,
       zippel@linux-m68k.org, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Message-Id: <20060726103226.69aa79c1.kristen.c.accardi@intel.com>
In-Reply-To: <20060725164125.A15861@unix-os.sc.intel.com>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
	<20060725164125.A15861@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
I confirmed that Anil's patch will work, here is a proper patch with
Anil's changes.

Change the build options for acpiphp so that it may build without being
dependent on the ACPI_DOCK option, but yet does not allow the option of
acpiphp being built-in when dock is built as a module.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/pci/hotplug/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6-git.orig/drivers/pci/hotplug/Kconfig
+++ 2.6-git/drivers/pci/hotplug/Kconfig
@@ -76,7 +76,7 @@ config HOTPLUG_PCI_IBM
 
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
-	depends on ACPI_DOCK && HOTPLUG_PCI
+	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
 	help
 	  Say Y here if you have a system that supports PCI Hotplug using
 	  ACPI.
