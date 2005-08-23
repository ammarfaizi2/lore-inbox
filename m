Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVHWVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVHWVtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVHWVoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7606 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932414AbVHWVns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] (25/43) Kconfig fix (sparc32 drivers/char dependencies)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gbb-0007CV-TZ@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

since sparc32 Kconfig includes drivers/char/Kconfig (instead of duplicating
its parts) we need several new dependencies there to exclude the stuff
broken on sparc32 and not excluded by existing dependencies.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-emac/drivers/char/Kconfig RC13-rc6-git13-sparc-char/drivers/char/Kconfig
--- RC13-rc6-git13-emac/drivers/char/Kconfig	2005-08-21 13:16:49.000000000 -0400
+++ RC13-rc6-git13-sparc-char/drivers/char/Kconfig	2005-08-21 13:17:07.000000000 -0400
@@ -80,7 +80,7 @@
 
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP && (BROKEN || !SPARC32)
 	---help---
 	  This driver supports the entire family of Intelliport II/Plus
 	  controllers with the exception of the MicroChannel controllers and
@@ -208,7 +208,7 @@
 
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
 	help
 	  Enable support for the SyncLink Multiport (2 or 4 ports)
 	  serial adapter, running asynchronous and HDLC communications up
@@ -736,7 +736,7 @@
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !PPC64 && !M32R
+	depends on RTC!=y && !IA64 && !ARM && !PPC64 && !M32R && !SPARC32
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
