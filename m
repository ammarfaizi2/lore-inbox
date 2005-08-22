Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVHVW0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVHVW0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVHVW0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:26:02 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751435AbVHVWZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:30 -0400
Date: Mon, 22 Aug 2005 10:26:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: [patch] only compile kernel/power when neccessary
Message-ID: <20050822082649.GA5614@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only compile kernel/power if sleep support is going to be used.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 847ddd5de8a88b2d47e759bc94186a77140bc673
tree 5b7cb15723ef57e4cf3f72124c92176e394566b0
parent 790df7223ac29afec81e7201adc879973311f27e
author <pavel@amd.(none)> Mon, 22 Aug 2005 10:25:05 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 10:25:05 +0200

 drivers/acpi/Kconfig |    1 +
 kernel/Makefile      |    2 +-
 kernel/power/Kconfig |    7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,7 @@ config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86 && (!SMP || SUSPEND_SMP)
 	depends on EXPERIMENTAL && PM
+	select SLEEP
 	default y
 	---help---
 	  This option adds support for ACPI suspend states. 
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
-obj-$(CONFIG_PM) += power/
+obj-$(CONFIG_SLEEP) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -18,6 +18,10 @@ config PM
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SLEEP
+	bool
+	depends on PM
+
 config PM_DEBUG
 	bool "Power Management Debug Support"
 	depends on PM
@@ -28,7 +32,8 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
+	depends on PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
+	select SLEEP
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

-- 
if you have sharp zaurus hardware you don't need... you know my address
