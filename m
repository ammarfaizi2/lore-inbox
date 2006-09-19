Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWISGD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWISGD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWISGD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:03:27 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:14345 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S964844AbWISGD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:03:26 -0400
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection
	capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20060914102033.462112306@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102033.462112306@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:57:51 -0700
Message-Id: <1158645471.2419.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Push fault-injection entries earlier in the list, so that they appear
nested under DEBUG_KERNEL in menuconfig/xconfig.


Signed-off-by: Don Mullis <dwm@meer.net>

---
 lib/Kconfig.debug |   70 +++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

Index: linux-2.6.17/lib/Kconfig.debug
===================================================================
--- linux-2.6.17.orig/lib/Kconfig.debug
+++ linux-2.6.17/lib/Kconfig.debug
@@ -294,6 +294,41 @@ config DEBUG_INFO
 
 	  If unsure, say N.
 
+config FAULT_INJECTION
+	bool
+	depends on DEBUG_KERNEL
+	select STACKTRACE
+	select FRAME_POINTER
+
+config FAILSLAB
+	bool "fault-injection capability for kmalloc"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capability for kmalloc.
+
+config FAIL_PAGE_ALLOC
+	bool "fault-injection capability for alloc_pages()"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capability for alloc_pages().
+
+config FAIL_MAKE_REQUEST
+	bool "fault-injection capability for disk IO"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capability to disk IO.
+
+config FAULT_INJECTION_DEBUGFS
+	tristate "runtime configuration for fault-injection capabilities"
+	depends on DEBUG_KERNEL && SYSFS && FAULT_INJECTION
+	select DEBUG_FS
+	help
+	  This option provides kernel module that provides runtime
+	  configuration interface by debugfs.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	depends on SYSFS
@@ -368,38 +403,3 @@ config RCU_TORTURE_TEST
 	  at boot time (you probably don't).
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
-
-config FAULT_INJECTION
-	bool
-	select STACKTRACE
-	select FRAME_POINTER
-
-config FAILSLAB
-	bool "fault-injection capabilitiy for kmalloc"
-	depends on DEBUG_KERNEL
-	select FAULT_INJECTION
-	help
-	  This option provides fault-injection capabilitiy for kmalloc.
-
-config FAIL_PAGE_ALLOC
-	bool "fault-injection capabilitiy for alloc_pages()"
-	depends on DEBUG_KERNEL
-	select FAULT_INJECTION
-	help
-	  This option provides fault-injection capabilitiy for alloc_pages().
-
-config FAIL_MAKE_REQUEST
-	bool "fault-injection capabilitiy for disk IO"
-	depends on DEBUG_KERNEL
-	select FAULT_INJECTION 
-	help
-	  This option provides fault-injection capabilitiy to disk IO.
-
-config FAULT_INJECTION_DEBUGFS 
-	tristate "runtime configuration for fault-injection capabilities"
-	depends on DEBUG_KERNEL && SYSFS && FAULT_INJECTION
-	select DEBUG_FS
-	help
-	  This option provides kernel module that provides runtime
-	  configuration interface by debugfs.
-


