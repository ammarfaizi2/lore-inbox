Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311479AbSCTD4Q>; Tue, 19 Mar 2002 22:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311485AbSCTD4H>; Tue, 19 Mar 2002 22:56:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18445 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311479AbSCTDzy>; Tue, 19 Mar 2002 22:55:54 -0500
Message-ID: <3C9807F2.B6A8ACFA@zip.com.au>
Date: Tue, 19 Mar 2002 19:54:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-010-show_stack
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lamely provides a generic interface to show_stack() for those
architectures which have an appropriate implementation.

The alternative of course is to just take out Andrea's debug calls to
show_stack().  But it would be nice to have an arch-independent way of
spitting out a stack trace.


=====================================

--- 2.4.19-pre3/include/linux/kernel.h~aa-010-show_stack	Tue Mar 19 19:48:52 2002
+++ 2.4.19-pre3-akpm/include/linux/kernel.h	Tue Mar 19 19:48:52 2002
@@ -106,6 +106,17 @@ extern int oops_in_progress;		/* If set,
 extern int tainted;
 extern const char *print_tainted(void);
 
+/*
+ * show_stack() differs across architectures.  If it exists, and takes
+ * an unsigned long * then it can be used here.
+ */
+#if defined(CONFIG_X86) || defined(CONFIG_MIPS) || defined(CONFIG_ARCH_S390)
+extern void show_stack(unsigned long *);
+#define arch_show_stack(p) show_stack(p)
+#else
+#define arch_show_stack(p)	printk("show_stack() unsupported\n");
+#endif
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
