Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTJUXVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTJUXVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 19:21:46 -0400
Received: from [65.172.181.6] ([65.172.181.6]:31360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263102AbTJUXVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 19:21:00 -0400
Date: Tue, 21 Oct 2003 16:20:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: (2/4) [PATCH] cpuset - Kconfig
Message-Id: <20031021162027.56f90c38.shemminger@osdl.org>
In-Reply-To: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an improvement to your Kconfig entry.

1. Use dependencies rather than using an 'if x86 || IA64' around it.
2. It is certainly experimental at this point
3. Better descriptive text (hopefully)
4. Let the config system do the PROC_FS dependency, not the human.

diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	Tue Oct 21 16:07:24 2003
+++ b/init/Kconfig	Tue Oct 21 16:07:24 2003
@@ -194,28 +194,28 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
-if X86 || IA64
-
 config CPUSETS
-        bool "cpusets"
-        depends on SMP
+        bool "Cpuset support"
+        depends on SMP && (X86 || IA64) && EXPERIMENTAL
         help
-          This options will let you create and manage sets of cpu where you
-          can run the processes.
+          This options will let you create and manage CPUSET's which
+	  allow partioning a SMP machine into execution areas. Processes
+	  in a CPUSET are not allowed to run on processor's outside
+	  the given group.
   
           Say N if unsure.
 
 config CPUSETS_PROC
         bool "/proc/cpusets support"
-        depends on CPUSETS
+        depends on CPUSETS && PROC_FS
+	default y
         help
           Get some info about the existing cpusets in your system.
-          To use this option, you have to ensure that the "/proc file system
-          support" (CONFIG_PROC_FS) is enabled, too.
 
 config CPUSETS_PROC_CPUINFO
         bool "/proc/cpuinfo uses current cpuset"
         depends on CPUSETS_PROC
+	default y
         help
           With this option enabled, a process reading /proc/cpuinfo will
           only see the CPUs that are in its current cpuset.
@@ -223,11 +223,11 @@
 config CPUSETS_PROC_STAT
         bool "/proc/stat uses current cpuset"
         depends on CPUSETS_PROC
+	default y
         help
           With this option enabled, a process reading /proc/stat will
           only see the CPUs that are in its current cpuset.
 
-endif
 
 source "drivers/block/Kconfig.iosched"
 
