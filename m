Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSE2LnI>; Wed, 29 May 2002 07:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSE2LnH>; Wed, 29 May 2002 07:43:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:44212 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315155AbSE2LnG>;
	Wed, 29 May 2002 07:43:06 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15604.48752.953866.585175@argo.ozlabs.ibm.com>
Date: Wed, 29 May 2002 21:41:36 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix platforms without suspend
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, any architecture that doesn't have <asm/suspend.h>
won't compile.  The patch below changes <linux/suspend.h> so it only
looks for <asm/suspend.h> if CONFIG_SOFTWARE_SUSPEND is set.

Linus, it would be good if you would apply this to your tree so that
architectures other than i386 will compile.

Thanks,
Paul.

diff -urN linux-2.5/include/linux/suspend.h pmac-2.5/include/linux/suspend.h
--- linux-2.5/include/linux/suspend.h	Thu May 23 12:02:19 2002
+++ pmac-2.5/include/linux/suspend.h	Sat May 25 10:54:02 2002
@@ -1,17 +1,18 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#include <asm/suspend.h>
+#include <linux/config.h>
 #include <linux/swap.h>
 #include <linux/notifier.h>
-#include <linux/config.h>
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+#include <asm/suspend.h>
 
 extern unsigned char software_suspend_enabled;
 
 #define NORESUME	 1
 #define RESUME_SPECIFIED 2
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
 /* page backup entry */
 typedef struct pbe {
 	unsigned long address;		/* address of the copy */
