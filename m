Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWDRKfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWDRKfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDRKfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:35:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:16293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932089AbWDRKfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:35:23 -0400
Date: Tue, 18 Apr 2006 12:35:22 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into arch/i386 where 
 it belongs.
Message-ID: <4444C0EA.mailKK411J5GA@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/Kconfig.debug |    9 +++++++++
 init/Kconfig            |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: linux/arch/i386/Kconfig.debug
===================================================================
--- linux.orig/arch/i386/Kconfig.debug
+++ linux/arch/i386/Kconfig.debug
@@ -81,4 +81,13 @@ config X86_MPPARSE
 	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
 
+config DOUBLEFAULT
+	default y
+	bool "Enable doublefault exception handler" if EMBEDDED
+	help
+          This option allows trapping of rare doublefault exceptions that
+          would otherwise cause a system to silently reboot. Disabling this
+          option saves about 4k and might cause you much additional grey
+          hair.
+
 endmenu
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig
+++ linux/init/Kconfig
@@ -374,15 +374,6 @@ config SLAB
 	  SLOB is more space efficient but does not scale well and is
 	  more susceptible to fragmentation.
 
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EMBEDDED && X86_32
-	help
-          This option allows trapping of rare doublefault exceptions that
-          would otherwise cause a system to silently reboot. Disabling this
-          option saves about 4k and might cause you much additional grey
-          hair.
-
 endmenu		# General setup
 
 config TINY_SHMEM
