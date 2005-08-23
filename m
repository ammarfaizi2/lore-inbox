Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVHWVwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVHWVwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVHWVnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5814 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932429AbVHWVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] (23/43) Kconfig fix (CONFIG_PM on 44x)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1E7gbR-0007C8-R6@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PM is broken on 44x; removed duplicate entry for CONFIG_PM, made
the inclusion of generic one conditional on BROKEN || !44x.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-4xx-early-serial/arch/ppc/Kconfig RC13-rc6-git13-44x-PM/arch/ppc/Kconfig
--- RC13-rc6-git13-4xx-early-serial/arch/ppc/Kconfig	2005-08-21 13:17:04.000000000 -0400
+++ RC13-rc6-git13-44x-PM/arch/ppc/Kconfig	2005-08-21 13:17:06.000000000 -0400
@@ -1126,7 +1126,9 @@
 
 source "drivers/zorro/Kconfig"
 
+if !44x || BROKEN
 source kernel/power/Kconfig
+endif
 
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
diff -urN RC13-rc6-git13-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig RC13-rc6-git13-44x-PM/arch/ppc/platforms/4xx/Kconfig
--- RC13-rc6-git13-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig	2005-08-21 13:17:05.000000000 -0400
+++ RC13-rc6-git13-44x-PM/arch/ppc/platforms/4xx/Kconfig	2005-08-21 13:17:06.000000000 -0400
@@ -240,10 +240,6 @@
 	depends on 4xx
 	default y
 
-config PM
-	bool "Power Management support (EXPERIMENTAL)"
-	depends on 4xx && EXPERIMENTAL
-
 choice
 	prompt "TTYS0 device and default console"
 	depends on 40x
