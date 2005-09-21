Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVIUKji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVIUKji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVIUKji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:39:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:956 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750806AbVIUKjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:39:37 -0400
Date: Wed, 21 Sep 2005 16:11:17 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, anil.s.keshavamurthy@intel.com, ananth@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Moving Kprobes and Oprofile to "Instrumentation Support" menu
Message-ID: <20050921104117.GA5130@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton suggested to move kprobes from kernel hacking menu, 
since kernel hacking menu is in-appropriate for the Kprobes. This 
patch moves Kprobes and Oprofile under instrumentation menu.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---



---

 linux-2.6.14-rc2-prasanna/arch/i386/Kconfig             |   13 +++++++++++++
 linux-2.6.14-rc2-prasanna/arch/i386/Kconfig.debug       |   10 ----------
 linux-2.6.14-rc2-prasanna/arch/i386/oprofile/Kconfig    |    6 ------
 linux-2.6.14-rc2-prasanna/arch/ia64/Kconfig             |   13 +++++++++++++
 linux-2.6.14-rc2-prasanna/arch/ia64/Kconfig.debug       |   11 -----------
 linux-2.6.14-rc2-prasanna/arch/ia64/oprofile/Kconfig    |    6 ------
 linux-2.6.14-rc2-prasanna/arch/ppc64/Kconfig            |   13 +++++++++++++
 linux-2.6.14-rc2-prasanna/arch/ppc64/Kconfig.debug      |   10 ----------
 linux-2.6.14-rc2-prasanna/arch/ppc64/oprofile/Kconfig   |    6 ------
 linux-2.6.14-rc2-prasanna/arch/sparc64/Kconfig          |   13 +++++++++++++
 linux-2.6.14-rc2-prasanna/arch/sparc64/Kconfig.debug    |   10 ----------
 linux-2.6.14-rc2-prasanna/arch/sparc64/oprofile/Kconfig |    6 ------
 linux-2.6.14-rc2-prasanna/arch/x86_64/Kconfig           |   13 +++++++++++++
 linux-2.6.14-rc2-prasanna/arch/x86_64/Kconfig.debug     |   10 ----------
 linux-2.6.14-rc2-prasanna/arch/x86_64/oprofile/Kconfig  |    6 ------
 15 files changed, 65 insertions(+), 81 deletions(-)

diff -puN arch/i386/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/i386/Kconfig
--- linux-2.6.14-rc2/arch/i386/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.145968360 +0530
+++ linux-2.6.14-rc2-prasanna/arch/i386/Kconfig	2005-09-21 16:08:22.246953008 +0530
@@ -1295,8 +1295,21 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+	depends on EXPERIMENTAL
+
 source "arch/i386/oprofile/Kconfig"
 
+config KPROBES
+	bool "Kprobes (EXPERIMENTAL)"
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+endmenu
+
 source "arch/i386/Kconfig.debug"
 
 source "security/Kconfig"
diff -puN arch/i386/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu arch/i386/Kconfig.debug
--- linux-2.6.14-rc2/arch/i386/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.193961064 +0530
+++ linux-2.6.14-rc2-prasanna/arch/i386/Kconfig.debug	2005-09-21 16:08:22.247952856 +0530
@@ -22,16 +22,6 @@ config DEBUG_STACKOVERFLOW
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit.
 
-config KPROBES
-	bool "Kprobes"
-	depends on DEBUG_KERNEL
-	help
-	  Kprobes allows you to trap at almost any kernel address and
-	  execute a callback function.  register_kprobe() establishes
-	  a probepoint and specifies the callback.  Kprobes is useful
-	  for kernel debugging, non-intrusive instrumentation and testing.
-	  If in doubt, say "N".
-
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff -puN arch/i386/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/i386/oprofile/Kconfig
--- linux-2.6.14-rc2/arch/i386/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.196960608 +0530
+++ linux-2.6.14-rc2-prasanna/arch/i386/oprofile/Kconfig	2005-09-21 16:08:22.247952856 +0530
@@ -1,7 +1,3 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
 config PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
 	help
@@ -19,5 +15,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-
diff -puN arch/ia64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/ia64/Kconfig
--- linux-2.6.14-rc2/arch/ia64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.200960000 +0530
+++ linux-2.6.14-rc2-prasanna/arch/ia64/Kconfig	2005-09-21 16:08:22.248952704 +0530
@@ -404,8 +404,21 @@ config GENERIC_PENDING_IRQ
 
 source "arch/ia64/hp/sim/Kconfig"
 
+menu "Instrumentation Support"
+        depends on EXPERIMENTAL
+
 source "arch/ia64/oprofile/Kconfig"
 
+config KPROBES
+	bool "Kprobes (EXPERIMENTAL)"
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+endmenu
+
 source "arch/ia64/Kconfig.debug"
 
 source "security/Kconfig"
diff -puN arch/ia64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu arch/ia64/Kconfig.debug
--- linux-2.6.14-rc2/arch/ia64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.203959544 +0530
+++ linux-2.6.14-rc2-prasanna/arch/ia64/Kconfig.debug	2005-09-21 16:08:22.249952552 +0530
@@ -2,17 +2,6 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config KPROBES
-        bool "Kprobes"
-        depends on DEBUG_KERNEL
-        help
-          Kprobes allows you to trap at almost any kernel address and
-          execute a callback function.  register_kprobe() establishes
-          a probepoint and specifies the callback.  Kprobes is useful
-          for kernel debugging, non-intrusive instrumentation and testing.
-          If in doubt, say "N".
-
-
 choice
 	prompt "Physical memory granularity"
 	default IA64_GRANULE_64MB
diff -puN arch/ia64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/ia64/oprofile/Kconfig
--- linux-2.6.14-rc2/arch/ia64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.208958784 +0530
+++ linux-2.6.14-rc2-prasanna/arch/ia64/oprofile/Kconfig	2005-09-21 16:08:22.249952552 +0530
@@ -1,7 +1,3 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
 config PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
 	help
@@ -22,5 +18,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-
diff -puN arch/ppc64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/ppc64/Kconfig
--- linux-2.6.14-rc2/arch/ppc64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.211958328 +0530
+++ linux-2.6.14-rc2-prasanna/arch/ppc64/Kconfig	2005-09-21 16:08:22.250952400 +0530
@@ -461,8 +461,21 @@ config VIOPATH
 	depends on VIOCONS || VIODASD || VIOCD || VIOTAPE || VETH
 	default y
 
+menu "Instrumentation Support"
+        depends on EXPERIMENTAL
+
 source "arch/ppc64/oprofile/Kconfig"
 
+config KPROBES
+	bool "Kprobes (EXPERIMENTAL)"
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+endmenu
+
 source "arch/ppc64/Kconfig.debug"
 
 source "security/Kconfig"
diff -puN arch/ppc64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu arch/ppc64/Kconfig.debug
--- linux-2.6.14-rc2/arch/ppc64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.215957720 +0530
+++ linux-2.6.14-rc2-prasanna/arch/ppc64/Kconfig.debug	2005-09-21 16:08:22.251952248 +0530
@@ -9,16 +9,6 @@ config DEBUG_STACKOVERFLOW
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit.
 
-config KPROBES
-	bool "Kprobes"
-	depends on DEBUG_KERNEL
-	help
-	  Kprobes allows you to trap at almost any kernel address and
-	  execute a callback function.  register_kprobe() establishes
-	  a probepoint and specifies the callback.  Kprobes is useful
-	  for kernel debugging, non-intrusive instrumentation and testing.
-	  If in doubt, say "N".
-
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL
diff -puN arch/ppc64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/ppc64/oprofile/Kconfig
--- linux-2.6.14-rc2/arch/ppc64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.218957264 +0530
+++ linux-2.6.14-rc2-prasanna/arch/ppc64/oprofile/Kconfig	2005-09-21 16:08:22.251952248 +0530
@@ -1,7 +1,3 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
 config PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
 	help
@@ -19,5 +15,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-
diff -puN arch/sparc64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/sparc64/Kconfig
--- linux-2.6.14-rc2/arch/sparc64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.222956656 +0530
+++ linux-2.6.14-rc2-prasanna/arch/sparc64/Kconfig	2005-09-21 16:08:22.252952096 +0530
@@ -377,8 +377,21 @@ source "drivers/fc4/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+        depends on EXPERIMENTAL
+
 source "arch/sparc64/oprofile/Kconfig"
 
+config KPROBES
+	bool "Kprobes (EXPERIMENTAL)"
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+endmenu
+
 source "arch/sparc64/Kconfig.debug"
 
 source "security/Kconfig"
diff -puN arch/sparc64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu arch/sparc64/Kconfig.debug
--- linux-2.6.14-rc2/arch/sparc64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.225956200 +0530
+++ linux-2.6.14-rc2-prasanna/arch/sparc64/Kconfig.debug	2005-09-21 16:08:22.253951944 +0530
@@ -11,16 +11,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config KPROBES
-	bool "Kprobes"
-	depends on DEBUG_KERNEL
-	help
-	  Kprobes allows you to trap at almost any kernel address and
-	  execute a callback function.  register_kprobe() establishes
-	  a probepoint and specifies the callback.  Kprobes is useful
-	  for kernel debugging, non-intrusive instrumentation and testing.
-	  If in doubt, say "N".
-
 config DEBUG_DCFLUSH
 	bool "D-cache flush debugging"
 	depends on DEBUG_KERNEL
diff -puN arch/sparc64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/sparc64/oprofile/Kconfig
--- linux-2.6.14-rc2/arch/sparc64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.228955744 +0530
+++ linux-2.6.14-rc2-prasanna/arch/sparc64/oprofile/Kconfig	2005-09-21 16:08:22.253951944 +0530
@@ -1,7 +1,3 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
 config PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
 	help
@@ -19,5 +15,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-
diff -puN arch/x86_64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/x86_64/Kconfig
--- linux-2.6.14-rc2/arch/x86_64/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.232955136 +0530
+++ linux-2.6.14-rc2-prasanna/arch/x86_64/Kconfig	2005-09-21 16:08:22.254951792 +0530
@@ -532,8 +532,21 @@ source "drivers/firmware/Kconfig"
 
 source fs/Kconfig
 
+menu "Instrumentation Support"
+        depends on EXPERIMENTAL
+
 source "arch/x86_64/oprofile/Kconfig"
 
+config KPROBES
+	bool "Kprobes (EXPERIMENTAL)"
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+endmenu
+
 source "arch/x86_64/Kconfig.debug"
 
 source "security/Kconfig"
diff -puN arch/x86_64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu arch/x86_64/Kconfig.debug
--- linux-2.6.14-rc2/arch/x86_64/Kconfig.debug~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.235954680 +0530
+++ linux-2.6.14-rc2-prasanna/arch/x86_64/Kconfig.debug	2005-09-21 16:08:22.255951640 +0530
@@ -33,16 +33,6 @@ config IOMMU_DEBUG
 	 options. See Documentation/x86_64/boot-options.txt for more
 	 details.
 
-config KPROBES
-	bool "Kprobes"
-	depends on DEBUG_KERNEL
-	help
-	  Kprobes allows you to trap at almost any kernel address and
-	  execute a callback function.  register_kprobe() establishes
-	  a probepoint and specifies the callback.  Kprobes is useful
-	  for kernel debugging, non-intrusive instrumentation and testing.
-	  If in doubt, say "N".
-
 config IOMMU_LEAK
        bool "IOMMU leak tracing"
        depends on DEBUG_KERNEL
diff -puN arch/x86_64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu arch/x86_64/oprofile/Kconfig
--- linux-2.6.14-rc2/arch/x86_64/oprofile/Kconfig~moving-oprofile-kprobes-to-instrumentation-menu	2005-09-21 16:08:22.239954072 +0530
+++ linux-2.6.14-rc2-prasanna/arch/x86_64/oprofile/Kconfig	2005-09-21 16:08:22.255951640 +0530
@@ -1,7 +1,3 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
 config PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
 	help
@@ -19,5 +15,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
