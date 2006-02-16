Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWBPQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWBPQmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWBPQmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:42:38 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18032 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932332AbWBPQmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:42:37 -0500
Date: Thu, 16 Feb 2006 17:42:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/3] s390: sys32_fstatat -> sys32_fstatat64
Message-ID: <20060216164233.GJ9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Just rename the compat system call to keep the name consistent with
all the other *64 compat system calls.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_linux.c   |    4 ++--
 arch/s390/kernel/compat_wrapper.S |    6 +++---
 arch/s390/kernel/syscalls.S       |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 2d02162..cc058dc 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -905,8 +905,8 @@ asmlinkage long sys32_fstat64(unsigned l
 	return ret;
 }
 
-asmlinkage long sys32_fstatat(unsigned int dfd, char __user *filename,
-			      struct stat64_emu31 __user* statbuf, int flag)
+asmlinkage long sys32_fstatat64(unsigned int dfd, char __user *filename,
+				struct stat64_emu31 __user* statbuf, int flag)
 {
 	struct kstat stat;
 	int error = -EINVAL;
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index dd2d6c3..615964c 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1523,13 +1523,13 @@ compat_sys_futimesat_wrapper:
 	llgtr	%r4,%r4			# struct timeval *
 	jg	compat_sys_futimesat
 
-	.globl sys32_fstatat_wrapper
-sys32_fstatat_wrapper:
+	.globl sys32_fstatat64_wrapper
+sys32_fstatat64_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgtr	%r4,%r4			# struct stat64 *
 	lgfr	%r5,%r5			# int
-	jg	sys32_fstatat
+	jg	sys32_fstatat64
 
 	.globl sys_unlinkat_wrapper
 sys_unlinkat_wrapper:
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 84921fe..7c88d85 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -301,7 +301,7 @@ SYSCALL(sys_mkdirat,sys_mkdirat,sys_mkdi
 SYSCALL(sys_mknodat,sys_mknodat,sys_mknodat_wrapper)	/* 290 */
 SYSCALL(sys_fchownat,sys_fchownat,sys_fchownat_wrapper)
 SYSCALL(sys_futimesat,sys_futimesat,compat_sys_futimesat_wrapper)
-SYSCALL(sys_fstatat64,sys_newfstatat,sys32_fstatat_wrapper)
+SYSCALL(sys_fstatat64,sys_newfstatat,sys32_fstatat64_wrapper)
 SYSCALL(sys_unlinkat,sys_unlinkat,sys_unlinkat_wrapper)
 SYSCALL(sys_renameat,sys_renameat,sys_renameat_wrapper)	/* 295 */
 SYSCALL(sys_linkat,sys_linkat,sys_linkat_wrapper)
