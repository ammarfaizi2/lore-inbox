Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVAFSI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVAFSI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVAFSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:05:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19216 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262932AbVAFR5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:57:10 -0500
Date: Thu, 6 Jan 2005 18:57:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.10-mm2: move CPUSETS above EMBEDDED
Message-ID: <20050106175707.GF3096@stusta.de>
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The placement of CPUSETS somewhere in the middle of the EMBEDDED options 
breaks the EMBEDDED submenu (at least in menuconfig).

The patch below fixes this by simply moving CPUSETS above EMBEDDED.


diffstat output:
 init/Kconfig |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/init/Kconfig.old	2005-01-06 18:49:14.000000000 +0100
+++ linux-2.6.10-mm2-full/init/Kconfig	2005-01-06 18:51:11.000000000 +0100
@@ -248,6 +248,16 @@
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
+config CPUSETS
+	bool "Cpuset support"
+	depends on SMP
+	help
+	  This options will let you create and manage CPUSET's which
+	  allow dynamically partitioning a system into sets of CPUs and
+	  Memory Nodes and assigning tasks to run only within those sets.
+	  This is primarily useful on large SMP or NUMA systems.
+
+	  Say N if unsure.
 
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
@@ -302,17 +312,6 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
-config CPUSETS
-	bool "Cpuset support"
-	depends on SMP
-	help
-	  This options will let you create and manage CPUSET's which
-	  allow dynamically partitioning a system into sets of CPUs and
-	  Memory Nodes and assigning tasks to run only within those sets.
-	  This is primarily useful on large SMP or NUMA systems.
-
-	  Say N if unsure.
-
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
 	default y if ARM || H8300
