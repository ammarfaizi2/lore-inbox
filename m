Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWIOEyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWIOEyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 00:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbWIOEyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 00:54:14 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:37337 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750710AbWIOEyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 00:54:13 -0400
Date: Fri, 15 Sep 2006 00:47:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] Kconfig: move CONFIG_EMBEDDED options to submenu
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Message-ID: <200609150051_MC3-1-CB41-781E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two problems with the CONFIG_EMBEDDED submenu:

(1) The menu was split in two by the rt_mutex patch, which moved
    half the items into the "General setup" menu.

(2) CONFIG_SYSCTL and CONFIG_UID16 were added to the main menu
    instead of the submenu.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---

 init/Kconfig |   56 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

--- 2.6.18-rc7-64.orig/init/Kconfig
+++ 2.6.18-rc7-64/init/Kconfig
@@ -182,23 +182,6 @@ config TASK_DELAY_ACCT
 
 	  Say N if unsure.
 
-config SYSCTL
-	bool "Sysctl support" if EMBEDDED
-	default y
-	---help---
-	  The sysctl interface provides a means of dynamically changing
-	  certain kernel parameters and variables on the fly without requiring
-	  a recompile of the kernel or reboot of the system.  The primary
-	  interface consists of a system call, but if you say Y to "/proc
-	  file system support", a tree of modifiable sysctl entries will be
-	  generated beneath the /proc/sys directory. They are explained in the
-	  files in <file:Documentation/sysctl/>.  Note that enabling this
-	  option will enlarge the kernel by at least 8 KB.
-
-	  As it is generally a good thing, you should say Y here unless
-	  building a kernel for install/rescue disks or your system is very
-	  limited in memory.
-
 config AUDIT
 	bool "Auditing support"
 	depends on NET
@@ -261,13 +244,6 @@ config RELAY
 
 source "usr/Kconfig"
 
-config UID16
-	bool "Enable 16-bit UID system calls" if EMBEDDED
-	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
-	default y
-	help
-	  This enables the legacy 16-bit UID syscall wrappers.
-
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size (Look out for broken compilers!)"
 	default y
@@ -289,6 +265,30 @@ menuconfig EMBEDDED
           environments which can tolerate a "non-standard" kernel.
           Only use this if you really know what you are doing.
 
+config UID16
+	bool "Enable 16-bit UID system calls" if EMBEDDED
+	depends on ARM || CRIS || FRV || H8300 || X86_32 || M68K || (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && SPARC32_COMPAT) || UML || (X86_64 && IA32_EMULATION)
+	default y
+	help
+	  This enables the legacy 16-bit UID syscall wrappers.
+
+config SYSCTL
+	bool "Sysctl support" if EMBEDDED
+	default y
+	---help---
+	  The sysctl interface provides a means of dynamically changing
+	  certain kernel parameters and variables on the fly without requiring
+	  a recompile of the kernel or reboot of the system.  The primary
+	  interface consists of a system call, but if you say Y to "/proc
+	  file system support", a tree of modifiable sysctl entries will be
+	  generated beneath the /proc/sys directory. They are explained in the
+	  files in <file:Documentation/sysctl/>.  Note that enabling this
+	  option will enlarge the kernel by at least 8 KB.
+
+	  As it is generally a good thing, you should say Y here unless
+	  building a kernel for install/rescue disks or your system is very
+	  limited in memory.
+
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
 	 default y
@@ -363,10 +363,6 @@ config BASE_FULL
 	  kernel data structures. This saves memory on small machines,
 	  but may reduce performance.
 
-config RT_MUTEXES
-	boolean
-	select PLIST
-
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
@@ -414,6 +410,10 @@ config VM_EVENT_COUNTERS
 
 endmenu		# General setup
 
+config RT_MUTEXES
+	boolean
+	select PLIST
+
 config TINY_SHMEM
 	default !SHMEM
 	bool
-- 
Chuck
