Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279083AbRJVX2B>; Mon, 22 Oct 2001 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279087AbRJVX1n>; Mon, 22 Oct 2001 19:27:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:945 "EHLO e31.bld.us.ibm.com")
	by vger.kernel.org with ESMTP id <S279086AbRJVX1i>;
	Mon, 22 Oct 2001 19:27:38 -0400
Date: Mon, 22 Oct 2001 16:24:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] making the printk buffer bigger 
Message-ID: <3040507575.1003767887@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For larger machines, 16K isn't big enough to hold all the boot
messages - which means some of the earlier boot messages don't 
make it to the log files.

Could you add this tiny patch to fix it?

Thanks,

Martin.

diff -urN virgin-2.4.13-pre2/kernel/printk.c linux-2.4.13-pre2/kernel/printk.c
--- virgin-2.4.13-pre2/kernel/printk.c	Mon Sep 17 13:16:30 2001
+++ linux-2.4.13-pre2/kernel/printk.c	Mon Oct 15 13:15:37 2001
@@ -27,7 +27,12 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#ifdef CONFIG_SMP
+#define LOG_BUF_LEN	(65536)		/* This must be a power of two */
+#else
+#define LOG_BUF_LEN	(16384)		/* This must be a power of two */
+#endif
+
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 /* printk's without a loglevel use this.. */


