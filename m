Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTDLPrj (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbTDLPrj (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:47:39 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:39814
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263320AbTDLPri (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 11:47:38 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix cond_syscall macro on Alpha
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 12 Apr 2003 18:00:22 +0200
Message-ID: <yw1x1y07wvs9.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the cond_syscall macro that was broken in 2.5.67.
The patch is against vanilla 2.5.67.

--- include/asm-alpha/unistd.h~	Mon Apr  7 19:31:08 2003
+++ include/asm-alpha/unistd.h	Sat Apr 12 17:55:03 2003
@@ -612,6 +612,6 @@
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asmlinkage long x(void) __attribute__((weak,alias("sys_ni_syscall")));
+#define cond_syscall(x) asm("\t.weak\t" #x "\n" #x " = sys_ni_syscall");
 
 #endif /* _ALPHA_UNISTD_H */


-- 
Måns Rullgård
mru@users.sf.net
