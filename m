Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279684AbRJ3AbB>; Mon, 29 Oct 2001 19:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279686AbRJ3Aau>; Mon, 29 Oct 2001 19:30:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61127 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279684AbRJ3Aao>; Mon, 29 Oct 2001 19:30:44 -0500
Date: Mon, 29 Oct 2001 16:25:19 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] making the printk buffer bigger 
Message-ID: <3645339074.1004372719@mbligh.des.sequent.com>
In-Reply-To: <3040507575.1003767887@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For larger machines, 16K isn't big enough to hold all the boot
> messages - which means some of the earlier boot messages don't 
> make it to the log files.
> 
> Could you add this tiny patch to fix it?

OK, seeing as people don't seem to want a decent size buffer on 
CONFIG_SMP machines, could we at least do it under
CONFIG_MULTIQUAD? Loosing half my boot time messages is 
annoying, and I have gigabytes of RAM to waste. Please .......

M.

diff -urN virgin-2.4.13-pre2/kernel/printk.c linux-2.4.13-pre2/kernel/printk.c
--- virgin-2.4.13-pre2/kernel/printk.c	Mon Sep 17 13:16:30 2001
+++ linux-2.4.13-pre2/kernel/printk.c	Mon Oct 15 13:15:37 2001
@@ -27,7 +27,12 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#ifdef CONFIG_MULTIQUAD
+#define LOG_BUF_LEN	(65536)		/* This must be a power of two */
+#else
+#define LOG_BUF_LEN	(16384)		/* This must be a power of two */
+#endif
+
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 /* printk's without a loglevel use this.. */

