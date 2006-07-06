Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWGFQZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWGFQZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWGFQZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:25:05 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:62915 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964964AbWGFQZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:25:04 -0400
Date: Thu, 6 Jul 2006 12:20:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: require ACPI for NUMA with generic architecture
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>
Message-ID: <200607061221_MC3-1-C44C-BE6A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

X86 Generic Architecture (X86_GENERICARCH) includes support for
Summit architecture.  Enabling X86_GENERICARCH, SMP and HIGHMEM64G
allows NUMA to be selected but that configuration will not build
because it requires ACPI for the Summit NUMA support.

Fix:
        require ACPI for NUMA support with X86_GENERICARCH

        update the menu comment noting this

        set default NR_CPUS to 32 for GENERICARCH (since it
                includes BIGSMP and SUMMIT which default to 32)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-mm6-nb.orig/arch/i386/Kconfig
+++ 2.6.17-mm6-nb/arch/i386/Kconfig
@@ -228,7 +228,7 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-255)"
 	range 2 255
 	depends on SMP
-	default "32" if X86_NUMAQ || X86_SUMMIT || X86_BIGSMP || X86_ES7000
+	default "32" if X86_NUMAQ || X86_SUMMIT || X86_BIGSMP || X86_ES7000 || X86_GENERICARCH
 	default "8"
 	help
 	  This allows you to specify the maximum number of CPUs which this
@@ -546,15 +546,15 @@ config X86_PAE
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
-	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
+	depends on SMP && HIGHMEM64G && (X86_NUMAQ || (ACPI && (X86_GENERICARCH || X86_SUMMIT)))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
 	help
 		NUMA support. Note this only works on IBM x440 or IBM NUMAQ.
 		Don't try to use it anywhere else.
 
-comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
-	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
+comment "NUMA (Summit, Generic arch) requires SMP, 64GB highmem support, ACPI"
+	depends on (X86_SUMMIT || X86_GENERICARCH) && (!HIGHMEM64G || !ACPI)
 
 config NODES_SHIFT
 	int
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
