Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWF3CUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWF3CUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWF3CUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:20:48 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58755 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750732AbWF3CUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:20:48 -0400
Date: Thu, 29 Jun 2006 19:20:23 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] solve config broken: undefined reference to `online_page'
Message-ID: <20060630022023.GD11977@sequoia.sous-sol.org>
References: <44A1204F.3070704@shadowen.org> <20060628110338.9B6A.Y-GOTO@jp.fujitsu.com> <20060629114417.2A02.Y-GOTO@jp.fujitsu.com> <20060630021407.GC11977@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630021407.GC11977@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> This patch didn't
> quite apply to 2.6.17.2, so I fixed it up, could you double check
> please?

Bah, the refreshed patch attached.  Sorry about the noise.

thanks,
-chris
--
> From cc57637b0b015fb5d70dbbec740de516d33af07d Mon Sep 17 00:00:00 2001
From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: solve config broken: undefined reference to `online_page'

Memory hotplug code of i386 adds memory to only highmem.  So, if
CONFIG_HIGHMEM is not set, CONFIG_MEMORY_HOTPLUG shouldn't be set.
Otherwise, it causes compile error.

In addition, many architecture can't use memory hotplug feature yet.  So, I
introduce CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
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
