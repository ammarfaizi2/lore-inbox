Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWGMUS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWGMUS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWGMUS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:18:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29966 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030351AbWGMUS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:18:28 -0400
Date: Thu, 13 Jul 2006 22:18:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] DEBUG_SHIRQ should depend on DEBUG_KERNEL
Message-ID: <20060713201826.GC32259@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_SHIRQ is clearly a debugging option.

While moving the option below DEBUG_KERNEL, I also adjusted the help 
text to be completely visible in "make menuconfig" with a 80 char
width.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 lib/Kconfig.debug |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.18-rc1-mm1-full/lib/Kconfig.debug.old	2006-07-13 21:52:55.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/lib/Kconfig.debug	2006-07-13 21:55:52.000000000 +0200
@@ -46,21 +46,21 @@
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
-config DEBUG_SHIRQ
-       bool "Debug shared IRQ handlers"
-       depends on GENERIC_HARDIRQS
-       help
-         Enable this to generate a spurious interrupt as soon as a shared interrupt
-	 handler is registered, and just before one is deregistered. Drivers ought
-	 to be able to handle interrupts coming in at those points; some don't and
-	 need to be caught.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config DEBUG_SHIRQ
+	bool "Debug shared IRQ handlers"
+	depends on DEBUG_KERNEL && GENERIC_HARDIRQS
+	help
+	  Enable this to generate a spurious interrupt as soon as a shared
+	  interrupt handler is registered, and just before one is deregistered.
+	  Drivers ought to be able to handle interrupts coming in at those
+	  points; some don't and need to be caught.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 21

