Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWBPUcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWBPUcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWBPUcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:32:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28429 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932357AbWBPUcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:32:31 -0500
Date: Thu, 16 Feb 2006 21:32:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ACPI should depend on, not select PCI
Message-ID: <20060216203229.GB3694@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI should depend on, not select PCI.

Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are 
possible.

This patch also fixes the options select'ing ACPI to also select PCI.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/ia64/Kconfig    |    1 +
 arch/x86_64/Kconfig  |    1 +
 drivers/acpi/Kconfig |    3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc3-mm1-full/drivers/acpi/Kconfig.old	2006-02-16 21:21:23.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/drivers/acpi/Kconfig	2006-02-16 21:21:42.000000000 +0100
@@ -10,9 +10,8 @@
 config ACPI
 	bool "ACPI Support"
 	depends on IA64 || X86
+	depends on PCI
 	select PM
-	select PCI
-
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 
--- linux-2.6.16-rc3-mm1-full/arch/ia64/Kconfig.old	2006-02-16 21:21:52.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/arch/ia64/Kconfig	2006-02-16 21:22:08.000000000 +0100
@@ -73,6 +73,7 @@
 config IA64_GENERIC
 	bool "generic"
 	select ACPI
+	select PCI
 	select NUMA
 	select ACPI_NUMA
 	help
--- linux-2.6.16-rc3-mm1-full/arch/x86_64/Kconfig.old	2006-02-16 21:22:19.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/arch/x86_64/Kconfig	2006-02-16 21:23:39.000000000 +0100
@@ -285,6 +285,7 @@
        bool "ACPI NUMA detection"
        depends on NUMA
        select ACPI 
+	select PCI
        select ACPI_NUMA
        default y
        help

