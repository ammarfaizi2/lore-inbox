Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTDZQ5C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTDZQ5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:57:02 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:8088 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262627AbTDZQ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:56:57 -0400
Date: Sat, 26 Apr 2003 13:03:35 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] TRIVIAL -- fix annoying dependency order in menu
Message-ID: <Pine.LNX.4.44.0304261302240.32403-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- curr/arch/i386/Kconfig	2003-04-19 22:48:52.000000000 -0400
+++ rday/arch/i386/Kconfig	2003-04-20 17:33:33.000000000 -0400
@@ -413,6 +413,18 @@
 
 	  If you don't know what to do here, say N.
 
+config NR_CPUS
+	int "Maximum number of CPUs (2-32)"
+	depends on SMP
+	default "32"
+	help
+	  This allows you to specify the maximum number of CPUs which this
+	  kernel will support.  The maximum supported value is 32 and the
+	  minimum value which makes sense is 2.
+
+	  This is purely to save memory - each supported CPU adds
+	  approximately eight kilobytes to the kernel image.
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
@@ -465,18 +477,6 @@
 	depends on !SMP && X86_UP_IOAPIC
 	default y
 
-config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	depends on SMP
-	default "32"
-	help
-	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support.  The maximum supported value is 32 and the
-	  minimum value which makes sense is 2.
-
-	  This is purely to save memory - each supported CPU adds
-	  approximately eight kilobytes to the kernel image.
-
 config X86_TSC
 	bool
 	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ


