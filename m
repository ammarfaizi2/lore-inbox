Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWALEPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWALEPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWALEPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:25523 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965025AbWALEPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:39 -0500
Subject: [PATCH -mm 10/10] unshare system call -v5 : system call
	registration for x86_64
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137039015.7488.222.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:11:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 10/10] unshare system call: system call registration for x86_64

Registers system call for the x86_64 architecture.

Changes since -v4 of this patch submitted on 12/13/05:
        - Forward ported to 2.6.15-mm3 which modified the syscall number.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 arch/x86_64/ia32/ia32entry.S     |    1 +
 include/asm-x86_64/ia32_unistd.h |    3 ++-
 include/asm-x86_64/unistd.h      |    4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff -Naurp 2.6.15-mm3/arch/x86_64/ia32/ia32entry.S 2.6.15-mm3+unsh-x86_64/arch/x86_64/ia32/ia32entry.S
--- 2.6.15-mm3/arch/x86_64/ia32/ia32entry.S	2006-01-11 20:21:49.000000000 +0000
+++ 2.6.15-mm3+unsh-x86_64/arch/x86_64/ia32/ia32entry.S	2006-01-12 00:49:51.000000000 +0000
@@ -685,6 +685,7 @@ ia32_sys_call_table:
 	.quad sys_readlinkat		/* 305 */
 	.quad sys_fchmodat
 	.quad sys_faccessat
+	.quad sys_unshare
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff -Naurp 2.6.15-mm3/include/asm-x86_64/ia32_unistd.h 2.6.15-mm3+unsh-x86_64/include/asm-x86_64/ia32_unistd.h
--- 2.6.15-mm3/include/asm-x86_64/ia32_unistd.h	2006-01-11 20:22:17.000000000 +0000
+++ 2.6.15-mm3+unsh-x86_64/include/asm-x86_64/ia32_unistd.h	2006-01-12 00:51:13.000000000 +0000
@@ -313,7 +313,8 @@
 #define __NR_ia32_readlinkat		305
 #define __NR_ia32_fchmodat		306
 #define __NR_ia32_faccessat		307
+#define __NR_ia32_unshare		308
 
-#define IA32_NR_syscalls 308	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 309	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -Naurp 2.6.15-mm3/include/asm-x86_64/unistd.h 2.6.15-mm3+unsh-x86_64/include/asm-x86_64/unistd.h
--- 2.6.15-mm3/include/asm-x86_64/unistd.h	2006-01-11 20:22:17.000000000 +0000
+++ 2.6.15-mm3+unsh-x86_64/include/asm-x86_64/unistd.h	2006-01-12 00:54:02.000000000 +0000
@@ -599,8 +599,10 @@ __SYSCALL(__NR_readlinkat, sys_readlinka
 __SYSCALL(__NR_fchmodat, sys_fchmodat)
 #define __NR_faccessat		269
 __SYSCALL(__NR_faccessat, sys_faccessat)
+#define __NR_unshare		270
+__SYSCALL(__NR_unshare, sys_unshare)
 
-#define __NR_syscall_max __NR_faccessat
+#define __NR_syscall_max __NR_unshare
 
 #ifndef __NO_STUBS
 


