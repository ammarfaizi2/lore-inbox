Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWBHMkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWBHMkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWBHMkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:40:55 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:46680 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030406AbWBHMky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:40:54 -0500
Date: Wed, 8 Feb 2006 13:40:43 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 08/10] s390: add support for unshare system call
Message-ID: <20060208124043.GI1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add support for unshare system call.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    5 +++++
 arch/s390/kernel/syscalls.S       |    1 +
 include/asm-s390/unistd.h         |    3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 83b33fe..38a6ef5 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1602,3 +1602,8 @@ compat_sys_ppoll_wrapper:
 	llgtr	%r5,%r5			# const sigset_t *
 	llgfr	%r6,%r6			# size_t
 	jg	compat_sys_ppoll
+
+	.globl sys_unshare_wrapper
+sys_unshare_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	jg	sys_unshare
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 3280345..e86a4de 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -311,3 +311,4 @@ SYSCALL(sys_fchmodat,sys_fchmodat,sys_fc
 SYSCALL(sys_faccessat,sys_faccessat,sys_faccessat_wrapper)	/* 300 */
 SYSCALL(sys_pselect6,sys_pselect6,compat_sys_pselect6_wrapper)
 SYSCALL(sys_ppoll,sys_ppoll,compat_sys_ppoll_wrapper)
+SYSCALL(sys_unshare,sys_unshare,sys_unshare_wrapper)
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index 29a9f35..0a2f666 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -295,8 +295,9 @@
 #define __NR_faccessat		300
 #define __NR_pselect6		301
 #define __NR_ppoll		302
+#define __NR_unshare		303
 
-#define NR_syscalls 303
+#define NR_syscalls 304
 
 /* 
  * There are some system calls that are not present on 64 bit, some
