Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWAWFWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWAWFWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAWFWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:22:52 -0500
Received: from xenotime.net ([66.160.160.81]:2012 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932329AbWAWFWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:22:51 -0500
Date: Sun, 22 Jan 2006 21:23:01 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: jengelh@linux01.gwdg.de, akpm <akpm@osdl.org>
Subject: [PATCH] menu: relocate DOUBLEFAULT option
Message-Id: <20060122212301.3c9f6136.rdunlap@xenotime.net>
In-Reply-To: <20060122210524.2f25d0e5.rdunlap@xenotime.net>
References: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
	<20060122210524.2f25d0e5.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Move the DOUBLEFAULT option from the top-level menu to the
EMBEDDED menu.  Only applicable to X86_32.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig |    9 ---------
 init/Kconfig      |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2616-rc1g4.orig/arch/i386/Kconfig
+++ linux-2616-rc1g4/arch/i386/Kconfig
@@ -47,15 +47,6 @@ config DMI
 
 source "init/Kconfig"
 
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EMBEDDED
-	help
-          This option allows trapping of rare doublefault exceptions that
-          would otherwise cause a system to silently reboot. Disabling this
-          option saves about 4k and might cause you much additional grey
-          hair.
-
 menu "Processor type and features"
 
 choice
--- linux-2616-rc1g4.orig/init/Kconfig
+++ linux-2616-rc1g4/init/Kconfig
@@ -412,6 +412,15 @@ config SLAB
 	  SLOB is more space efficient but does not scale well and is
 	  more susceptible to fragmentation.
 
+config DOUBLEFAULT
+	default y
+	bool "Enable doublefault exception handler" if EMBEDDED && X86_32
+	help
+          This option allows trapping of rare doublefault exceptions that
+          would otherwise cause a system to silently reboot. Disabling this
+          option saves about 4k and might cause you much additional grey
+          hair.
+
 endmenu		# General setup
 
 config TINY_SHMEM


---
