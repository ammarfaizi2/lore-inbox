Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWBHHL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWBHHL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBHHL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23964 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161042AbWBHHKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:51 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] s390 misc __user annotations
Cc: schwidefsky@de.ibm.com
Message-Id: <E1F6jTX-0002a5-1P@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138794959 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/s390/kernel/sys_s390.c |    4 ++--
 arch/s390/kernel/traps.c    |    2 +-
 include/asm-s390/uaccess.h  |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

793af244090ccb5f99091c5a999ce97e4d017834
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 6a63553..e351780 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -122,8 +122,8 @@ out:
 #ifndef CONFIG_64BIT
 struct sel_arg_struct {
 	unsigned long n;
-	fd_set *inp, *outp, *exp;
-	struct timeval *tvp;
+	fd_set __user *inp, *outp, *exp;
+	struct timeval __user *tvp;
 };
 
 asmlinkage long old_select(struct sel_arg_struct __user *arg)
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 5d21e9e..a46793b 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -486,7 +486,7 @@ asmlinkage void illegal_op(struct pt_reg
 		info.si_signo = signal;
 		info.si_errno = 0;
 		info.si_code = ILL_ILLOPC;
-		info.si_addr = (void *) location;
+		info.si_addr = (void __user *) location;
 		do_trap(interruption_code, signal,
 			"illegal operation", regs, &info);
 	}
diff --git a/include/asm-s390/uaccess.h b/include/asm-s390/uaccess.h
index be104f2..e2c73b4 100644
--- a/include/asm-s390/uaccess.h
+++ b/include/asm-s390/uaccess.h
@@ -61,7 +61,7 @@
 #define segment_eq(a,b) ((a).ar4 == (b).ar4)
 
 
-static inline int __access_ok(const void *addr, unsigned long size)
+static inline int __access_ok(const void __user *addr, unsigned long size)
 {
 	return 1;
 }
-- 
0.99.9.GIT

