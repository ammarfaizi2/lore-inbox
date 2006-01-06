Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752456AbWAFQbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbWAFQbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbWAFQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34751 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752451AbWAFQaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:00 -0500
Date: Fri, 6 Jan 2006 16:29:35 GMT
Message-Id: <200601061629.k06GTZ4m011365@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 3/17] FRV: Drop unsupported debugging features
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch drops support for debugging features that aren't supported
on FRV:

 (*) EARLY_PRINTK

	The on-chip UARTs are set up early enough that this isn't required,
	and VGA support isn't available. There's also a gdbstub available.

 (*) DEBUG_PAGEALLOC

	This can't be easily be done since we use huge static mappings to
	cover the kernel, not pages.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-debugging-2615.diff
 arch/frv/Kconfig.debug |   22 ----------------------
 1 files changed, 22 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/Kconfig.debug linux-2.6.15-frv/arch/frv/Kconfig.debug
--- /warthog/kernels/linux-2.6.15/arch/frv/Kconfig.debug	2005-06-22 13:51:25.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/Kconfig.debug	2006-01-06 14:43:43.000000000 +0000
@@ -2,32 +2,10 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config EARLY_PRINTK
-	bool "Early printk"
-	depends on EMBEDDED && DEBUG_KERNEL
-	default n
-	help
-	  Write kernel log output directly into the VGA buffer or to a serial
-	  port.
-
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized. For normal operation
-	  it is not recommended because it looks ugly and doesn't cooperate
-	  with klogd/syslogd or the X server. You should normally N here,
-	  unless you want to debug such a crash.
-
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
 
-config DEBUG_PAGEALLOC
-	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
-
 config GDBSTUB
 	bool "Remote GDB kernel debugging"
 	depends on DEBUG_KERNEL
