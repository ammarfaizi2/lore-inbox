Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbTGHUCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTGHUCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:02:49 -0400
Received: from smtp.terra.es ([213.4.129.129]:65266 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S267556AbTGHUBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:01:44 -0400
Date: Tue, 8 Jul 2003 22:12:09 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: [RFC] move ksymoops to the "embedded" section
Message-Id: <20030708221209.3b06d88c.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the "Load all symbols for debugging/kksymoops"
config option out of the kernel hacking.

It doesn't belong there; average users aren't kernel hackers
and they need to report their bugs. There're already some
bug reports un 2.5 from systems were this doesn't harm. For most
of the people, it doesn't have a lot of sense to remove it if
they have enought ram.


So move it to the "General setup" -> "Remove kernel features for
embedded systems"; where it belongs, IMHO

It has been moved from all arch/*/Kconfig files to init/Kconfig
(where the embedded section resides)

I suppose this won't work for all arches; some of them doesn't
define KALLSYMS in their arch/*/Kconfig files; and they include init/Kconfig
so now they have KALLSYMS when they shouldn't need it





diff -puN arch/i386/Kconfig~ksymoops_config_move arch/i386/Kconfig
--- unsta.moo/arch/i386/Kconfig~ksymoops_config_move	2003-07-08 16:46:27.000000000 +0200
+++ unsta.moo-diego/arch/i386/Kconfig	2003-07-08 16:51:35.000000000 +0200
@@ -1346,13 +1346,6 @@ config DEBUG_HIGHMEM
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
 	help
diff -puN init/Kconfig~ksymoops_config_move init/Kconfig
--- unsta.moo/init/Kconfig~ksymoops_config_move	2003-07-08 16:52:49.000000000 +0200
+++ unsta.moo-diego/init/Kconfig	2003-07-08 21:51:36.000000000 +0200
@@ -117,6 +117,14 @@ menuconfig EMBEDDED
 	  a "non-standard" kernel.  Only use this if you really know what you
 	  are doing.
 
+config KALLSYMS
+	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
+	 default y
+	 help
+	   Say Y here to let the kernel print out symbolic crash information and
+	   symbolic stack backtraces. This increases the size of the kernel
+	   somewhat, as all symbols have to be loaded into the kernel image.
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
diff -puN arch/arm/Kconfig~ksymoops_config_move arch/arm/Kconfig
--- unsta.moo/arch/arm/Kconfig~ksymoops_config_move	2003-07-08 16:57:43.000000000 +0200
+++ unsta.moo-diego/arch/arm/Kconfig	2003-07-08 16:58:05.000000000 +0200
@@ -1061,14 +1061,6 @@ config DEBUG_ERRORS
 	  you are concerned with the code size or don't want to see these
 	  messages.
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 # These options are only for real kernel hackers who want to get their hands dirty. 
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
diff -puN arch/arm26/Kconfig~ksymoops_config_move arch/arm26/Kconfig
--- unsta.moo/arch/arm26/Kconfig~ksymoops_config_move	2003-07-08 16:58:35.000000000 +0200
+++ unsta.moo-diego/arch/arm26/Kconfig	2003-07-08 16:58:40.000000000 +0200
@@ -523,14 +523,6 @@ config DEBUG_ERRORS
 	  you are concerned with the code size or don't want to see these
 	  messages.
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 # These options are only for real kernel hackers who want to get their hands dirty. 
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
diff -puN arch/ia64/Kconfig~ksymoops_config_move arch/ia64/Kconfig
--- unsta.moo/arch/ia64/Kconfig~ksymoops_config_move	2003-07-08 16:59:55.000000000 +0200
+++ unsta.moo-diego/arch/ia64/Kconfig	2003-07-08 16:59:58.000000000 +0200
@@ -667,14 +667,6 @@ config DEBUG_KERNEL
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 config IA64_PRINT_HAZARDS
 	bool "Print possible IA-64 dependency violations to console"
 	depends on DEBUG_KERNEL
diff -puN arch/parisc/Kconfig~ksymoops_config_move arch/parisc/Kconfig
--- unsta.moo/arch/parisc/Kconfig~ksymoops_config_move	2003-07-08 17:01:26.000000000 +0200
+++ unsta.moo-diego/arch/parisc/Kconfig	2003-07-08 17:01:35.000000000 +0200
@@ -287,14 +287,6 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 endmenu
 
 source "security/Kconfig"
diff -puN arch/ppc/Kconfig~ksymoops_config_move arch/ppc/Kconfig
--- unsta.moo/arch/ppc/Kconfig~ksymoops_config_move	2003-07-08 17:03:23.000000000 +0200
+++ unsta.moo-diego/arch/ppc/Kconfig	2003-07-08 17:03:25.000000000 +0200
@@ -1450,13 +1450,6 @@ config DEBUG_HIGHMEM
 	  This options enables additional error checking for high memory
 	  systems.  Disable for production systems.
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
 	depends on DEBUG_KERNEL
diff -puN arch/x86_64/Kconfig~ksymoops_config_move arch/x86_64/Kconfig
--- unsta.moo/arch/x86_64/Kconfig~ksymoops_config_move	2003-07-08 17:05:58.000000000 +0200
+++ unsta.moo-diego/arch/x86_64/Kconfig	2003-07-08 17:06:00.000000000 +0200
@@ -540,13 +540,6 @@ config INIT_DEBUG
 	  Fill __init and __initdata at the end of boot. This helps debugging
 	  illegal uses of __init and __initdata after initialization.	  
 
-config KALLSYMS
-	bool "Load all symbols for debugging/kksymoops"
-	help
-	  Say Y here to let the kernel print out symbolic crash information and
-	  symbolic stack backtraces. This increases the size of the kernel
-	  somewhat, as all symbols have to be loaded into the kernel image.
-
 config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
        help

_
