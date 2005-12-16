Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVLPLpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVLPLpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVLPLpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:45:50 -0500
Received: from canuck.infradead.org ([205.233.218.70]:25786 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932207AbVLPLpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:45:36 -0500
Subject: [PATCH] [6/6] Add pselect/ppoll system calls on i386
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: dhowells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1134732739.7104.54.camel@pmac.infradead.org>
References: <1134732739.7104.54.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 11:45:30 +0000
Message-Id: <1134733530.7104.102.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the sys_pselect6() and sys_poll() calls to the i386 syscall
table.

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

 arch/i386/kernel/syscall_table.S  |    2 ++
 arch/i386/kernel/syscall_table.S~ |only
 include/asm-i386/unistd.h         |    4 +++-
 include/asm-i386/unistd.h~        |only
 4 files changed, 5 insertions(+), 1 deletion(-)

diff -urp linux-2.6.15-rc5-mm3-pselect5/arch/i386/kernel/syscall_table.S linux-2.6.15-rc5-mm3-pselect6/arch/i386/kernel/syscall_table.S
--- linux-2.6.15-rc5-mm3-pselect5/arch/i386/kernel/syscall_table.S	2005-12-16 10:56:09.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect6/arch/i386/kernel/syscall_table.S	2005-12-16 11:14:19.000000000 +0000
@@ -297,3 +297,5 @@ ENTRY(sys_call_table)
 	.long sys_preadv		/* 295 */
 	.long sys_pwritev
 	.long sys_unshare
+	.long sys_pselect6
+	.long sys_ppoll
Only in linux-2.6.15-rc5-mm3-pselect6/arch/i386/kernel: syscall_table.S~
diff -urp linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/unistd.h linux-2.6.15-rc5-mm3-pselect6/include/asm-i386/unistd.h
--- linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/unistd.h	2005-12-16 11:09:59.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect6/include/asm-i386/unistd.h	2005-12-16 11:13:51.000000000 +0000
@@ -303,8 +303,10 @@
 #define __NR_preadv		295
 #define __NR_pwritev		296
 #define __NR_unshare		297
+#define __NR_pselect6		298
+#define __NR_ppoll		299
 
-#define NR_syscalls 298
+#define NR_syscalls 300
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
Only in linux-2.6.15-rc5-mm3-pselect6/include/asm-i386: unistd.h~


-- 
dwmw2

