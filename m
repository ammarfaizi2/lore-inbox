Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWAEWbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWAEWbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWAEWbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:31:04 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:55069 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750707AbWAEWbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:31:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qwHDp5AgKiYY9kyvdI/l+QKoWWoNvLcu/xsLscBch5AjQ6YC5dkjbPCmPl3DIvUD8WHpDuvCaeE3v+bdeMfyUkHbHXipQxQm3f9VKymyifBcyCRv/UiaBa4fZ9xJQLdSWvule2i33eucRJmthUhq2M2VaLq60dysdb1bCI7bc1M=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [-mm PATCH] make DEBUG_KERNEL dependent options indent nicely and fix DEBUG_SHIRQ help text
Date: Thu, 5 Jan 2006 23:30:58 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601052330.58865.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move DEBUG_SHIRQ up a bit so that options depending on DEBUG_KERNEL are
still nicely indented in the menuconfig menu.
This patch also includes the change to the help text from my previous patch,
so you can just apply this one and get both :-)

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 lib/Kconfig.debug |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.15-mm1-orig/lib/Kconfig.debug	2006-01-05 18:15:43.000000000 +0100
+++ linux-2.6.15-mm1/lib/Kconfig.debug	2006-01-05 21:21:59.000000000 +0100
@@ -22,6 +22,15 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+config DEBUG_SHIRQ
+       bool "Debug shared IRQ handlers"
+       depends on GENERIC_HARDIRQS
+       help
+         Enable this to generate a spurious interrupt as soon as a shared interrupt
+	 handler is registered, and just before one is deregistered. Drivers ought
+	 to be able to handle interrupts coming in at those points; some don't and
+	 need to be caught.
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
@@ -186,15 +195,6 @@
 
 	  If unsure, say N.
 
-config DEBUG_SHIRQ
-       bool "Debug shared IRQ handlers"
-       depends on GENERIC_HARDIRQS
-       help
-         Enable this to generate a spurious interrupt as soon as a shared interrupt
-	 handler is registered, and just before one is deregistered. Drivers ought
-	 to be able to handle interrupts coming in at those some; some don't and
-	 need to be caught.
-
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML)
