Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSKOLwq>; Fri, 15 Nov 2002 06:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKOLwq>; Fri, 15 Nov 2002 06:52:46 -0500
Received: from holomorphy.com ([66.224.33.161]:33742 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266125AbSKOLwn>;
	Fri, 15 Nov 2002 06:52:43 -0500
Date: Fri, 15 Nov 2002 03:55:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: fix swsusp warning
Message-ID: <20021115115558.GU22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	kernel-janitor-discuss@lists.sourceforge.net, pavel@suse.cz,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning caused by conflicting static vs. extern wrt. swsusp.

 include/linux/reboot.h |    7 -------
 kernel/sys.c           |    1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff -urpN cleanup-2.5.47-3/include/linux/reboot.h cleanup-2.5.47-4/include/linux/reboot.h
--- cleanup-2.5.47-3/include/linux/reboot.h	2002-11-10 19:28:33.000000000 -0800
+++ cleanup-2.5.47-4/include/linux/reboot.h	2002-11-15 03:10:22.000000000 -0800
@@ -48,13 +48,6 @@ extern void machine_restart(char *cmd);
 extern void machine_halt(void);
 extern void machine_power_off(void);
 
-/*
- * Architecture-independent suspend facility
- */
-
-extern void software_suspend(void);
-extern unsigned char software_suspend_enabled;
-
 #endif
 
 #endif /* _LINUX_REBOOT_H */
diff -urpN cleanup-2.5.47-3/kernel/sys.c cleanup-2.5.47-4/kernel/sys.c
--- cleanup-2.5.47-3/kernel/sys.c	2002-11-14 23:42:02.000000000 -0800
+++ cleanup-2.5.47-4/kernel/sys.c	2002-11-15 03:10:35.000000000 -0800
@@ -21,6 +21,7 @@
 #include <linux/times.h>
 #include <linux/security.h>
 #include <linux/dcookies.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
