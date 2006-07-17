Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWGQQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWGQQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWGQQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:35004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750986AbWGQQdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:33 -0400
Date: Mon, 17 Jul 2006 09:25:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/45] memory hotplug: solve config broken: undefined reference to `online_page
Message-ID: <20060717162559.GF4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="memory-hotplug-solve-config-broken-undefined-reference-to-online_page.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Memory hotplug code of i386 adds memory to only highmem.  So, if
CONFIG_HIGHMEM is not set, CONFIG_MEMORY_HOTPLUG shouldn't be set.
Otherwise, it causes compile error.

In addition, many architecture can't use memory hotplug feature yet.  So, I
introduce CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/Kconfig    |    3 +++
 arch/ia64/Kconfig    |    3 +++
 arch/powerpc/Kconfig |    3 +++
 arch/x86_64/Kconfig  |    2 ++
 mm/Kconfig           |    2 +-
 5 files changed, 12 insertions(+), 1 deletion(-)

--- linux-2.6.17.2.orig/arch/i386/Kconfig
+++ linux-2.6.17.2/arch/i386/Kconfig
@@ -765,6 +765,9 @@ config HOTPLUG_CPU
 
 endmenu
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+	depends on HIGHMEM
 
 menu "Power management options (ACPI, APM)"
 	depends on !X86_VOYAGER
--- linux-2.6.17.2.orig/arch/ia64/Kconfig
+++ linux-2.6.17.2/arch/ia64/Kconfig
@@ -270,6 +270,9 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	depends on SMP
--- linux-2.6.17.2.orig/arch/powerpc/Kconfig
+++ linux-2.6.17.2/arch/powerpc/Kconfig
@@ -599,6 +599,9 @@ config HOTPLUG_CPU
 
 	  Say N if you are unsure.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
--- linux-2.6.17.2.orig/arch/x86_64/Kconfig
+++ linux-2.6.17.2/arch/x86_64/Kconfig
@@ -369,6 +369,8 @@ config HOTPLUG_CPU
 		can be controlled through /sys/devices/system/cpu/cpu#.
 		Say N if you want to disable CPU hotplug.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
 
 config HPET_TIMER
 	bool
--- linux-2.6.17.2.orig/mm/Kconfig
+++ linux-2.6.17.2/mm/Kconfig
@@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
-	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
+	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND && ARCH_ENABLE_MEMORY_HOTPLUG
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND

--
