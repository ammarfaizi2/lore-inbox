Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbTIMW2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTIMW2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:28:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53755 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262238AbTIMW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:27:59 -0400
Date: Sun, 14 Sep 2003 00:27:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030913222751.GP27368@fs.tum.de>
References: <20030913222443.GN27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913222443.GN27368@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- move "struct movsl_mask movsl_mask" to usercopy.c
  (CONFIG_X86_INTEL_USERCOPY is used on non-Intel CPUs)

diffstat output:

 kernel/cpu/intel.c |    7 -------
 lib/usercopy.c     |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)


--- linux-2.6.0-test5/arch/i386/kernel/cpu/intel.c.old	2003-09-13 18:06:45.000000000 +0200
+++ linux-2.6.0-test5/arch/i386/kernel/cpu/intel.c	2003-09-13 18:08:00.000000000 +0200
@@ -13,13 +13,6 @@
 
 extern int trap_init_f00f_bug(void);
 
-#ifdef CONFIG_X86_INTEL_USERCOPY
-/*
- * Alignment at which movsl is preferred for bulk memory copies.
- */
-struct movsl_mask movsl_mask;
-#endif
-
 /*
  *	Early probe support logic for ppro memory erratum #50
  *
--- linux-2.6.0-test5/arch/i386/lib/usercopy.c.old	2003-09-13 18:06:56.000000000 +0200
+++ linux-2.6.0-test5/arch/i386/lib/usercopy.c	2003-09-13 18:07:51.000000000 +0200
@@ -12,6 +12,13 @@
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
+#ifdef CONFIG_X86_INTEL_USERCOPY
+/*
+ * Alignment at which movsl is preferred for bulk memory copies.
+ */
+struct movsl_mask movsl_mask;
+#endif
+
 static inline int __movsl_is_ok(unsigned long a1, unsigned long a2, unsigned long n)
 {
 #ifdef CONFIG_X86_INTEL_USERCOPY
