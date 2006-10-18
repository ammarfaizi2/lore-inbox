Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWJRQZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWJRQZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJRQZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:25:48 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49167 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751495AbWJRQZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:25:47 -0400
Date: Wed, 18 Oct 2006 18:25:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Wire up epoll_pwait syscall.
Message-ID: <20061018162553.GB7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Wire up epoll_pwait syscall.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/syscalls.S |    1 +
 include/asm-s390/unistd.h   |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2006-10-18 17:12:28.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2006-10-18 17:12:52.000000000 +0200
@@ -320,3 +320,4 @@ SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
 NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
+SYSCALL(sys_epoll_pwait,sys_epoll_pwait,sys_ni_syscall)
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2006-10-18 17:12:41.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/unistd.h	2006-10-18 17:12:52.000000000 +0200
@@ -249,8 +249,9 @@
 #define __NR_vmsplice		309
 /* Number 310 is reserved for new sys_move_pages */
 #define __NR_getcpu		311
+#define __NR_epoll_pwait	312
 
-#define NR_syscalls 312
+#define NR_syscalls 313
 
 /* 
  * There are some system calls that are not present on 64 bit, some
