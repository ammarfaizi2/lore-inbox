Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161304AbWI2Dlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWI2Dlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWI2Dlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:41:36 -0400
Received: from xenotime.net ([66.160.160.81]:7862 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751328AbWI2Dlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:41:35 -0400
Date: Thu, 28 Sep 2006 20:42:51 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, 76306.1226@compuserve.com, ebiederm@xmission.com
Subject: [PATCH] fix EMBEDDED + SYSCTL menu
Message-Id: <20060928204251.a20470c5.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

SYSCTL should still depend on EMBEDDED.  This unbreaks the
EMBEDDED menu (from the recent SYSCTL_SYCALL menu option patch).

Fix typos in new SYSCTL_SYSCALL menu.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 init/Kconfig |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2618-g10.orig/init/Kconfig
+++ linux-2618-g10/init/Kconfig
@@ -257,6 +257,9 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+config SYSCTL
+	bool
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
@@ -272,11 +275,8 @@ config UID16
 	help
 	  This enables the legacy 16-bit UID syscall wrappers.
 
-config SYSCTL
-	bool
-
 config SYSCTL_SYSCALL
-	bool "Sysctl syscall support"
+	bool "Sysctl syscall support" if EMBEDDED
 	default n
 	select SYSCTL
 	---help---
@@ -285,11 +285,11 @@ config SYSCTL_SYSCALL
 	  and use.  The interface in /proc/sys is now the primary and what
 	  everyone uses.
 
-	  Nothing has been using the binary sysctl interface for some time
+	  Nothing has been using the binary sysctl interface for some
 	  time now so nothing should break if you disable sysctl syscall
-	  support, and you kernel will get marginally smaller.
+	  support, and your kernel will get marginally smaller.
 
-	  Unless you have an application that uses the sys_syscall interface
+	  Unless you have an application that uses the sys_sysctl interface
  	  you should probably say N here.
 
 config KALLSYMS


---
