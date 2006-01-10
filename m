Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWAJFQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWAJFQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 00:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWAJFQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 00:16:18 -0500
Received: from xenotime.net ([66.160.160.81]:30417 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750738AbWAJFQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 00:16:17 -0500
Date: Mon, 9 Jan 2006 21:16:14 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] i386: put HOTPLUG_CPU under Processor type, not Bus options
Message-Id: <20060109211614.609fb795.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Move the HOTPLUG_CPU option under "Processor type" instead of under
"Bus options".  This makes it the same for i386 as most other processor
types (arm, ia64, parisc, ppc, s390, & x86_64; but not for powerpc).
Besides, it takes me too long to find it under Bus options.
I can't be the only person who has trouble finding it.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

--- linux-2615-g5.orig/arch/i386/Kconfig
+++ linux-2615-g5/arch/i386/Kconfig
@@ -680,6 +680,16 @@ config CRASH_DUMP
 	depends on HIGHMEM
 	help
 	  Generate crash dump after being started by kexec.
+
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && HOTPLUG && EXPERIMENTAL
+	---help---
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N.
+
 endmenu
 
 
@@ -966,15 +976,6 @@ config SCx200
 	  This support is also available as a module.  If compiled as a
 	  module, it will be called scx200.
 
-config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL
-	---help---
-	  Say Y here to experiment with turning CPUs off and on.  CPUs
-	  can be controlled through /sys/devices/system/cpu.
-
-	  Say N.
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"


---
