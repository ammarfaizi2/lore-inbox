Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbTBFV0m>; Thu, 6 Feb 2003 16:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTBFV0m>; Thu, 6 Feb 2003 16:26:42 -0500
Received: from fmr04.intel.com ([143.183.121.6]:9961 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267414AbTBFV0l>; Thu, 6 Feb 2003 16:26:41 -0500
Subject: [PATCH][TRIVIAL] ACPI_PROCESSOR depends on CPU_FREQ
From: Rusty Lynch <rusty@linux.co.intel.com>
To: andrew.grover@intel.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Feb 2003 13:28:11 -0800
Message-Id: <1044566892.3098.19.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After pulling from Linus's tree my build broke while attempting to
compile drivers/acpi/processor.c because cpufreq_get_policy() and
cpufreq_set_policy() were not defined.

Here is a quick Kconfig fix.

    --rustyl

--- drivers/acpi/Kconfig.orig	2003-02-06 13:29:24.000000000 -0800
+++ drivers/acpi/Kconfig	2003-02-06 13:31:01.000000000 -0800
@@ -110,6 +110,7 @@
 
 config ACPI_PROCESSOR
 	tristate "Processor"
+	depends on CPU_FREQ
 	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses



