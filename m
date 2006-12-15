Return-Path: <linux-kernel-owner+w=401wt.eu-S964992AbWLOBgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWLOBgA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWLOBf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:35:58 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46211 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964997AbWLOBfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:45 -0500
Message-Id: <20061215013814.210732000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Russell King <rmk@arm.linux.org.uk>,
       Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [patch 19/24] ARM: Add sys_*at syscalls
Content-Disposition: inline; filename=arm-add-sys_-at-syscalls.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Russell King <rmk@arm.linux.org.uk>

Later glibc requires the *at syscalls.  Add them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/arm/kernel/calls.S  |   13 +++++++++++++
 include/asm-arm/unistd.h |   13 +++++++++++++
 2 files changed, 26 insertions(+)

bca0b8e75f6b7cf52cf52c967286b72d84f9b37e
--- linux-2.6.18.5.orig/arch/arm/kernel/calls.S
+++ linux-2.6.18.5/arch/arm/kernel/calls.S
@@ -331,6 +331,19 @@
 		CALL(sys_mbind)
 /* 320 */	CALL(sys_get_mempolicy)
 		CALL(sys_set_mempolicy)
+		CALL(sys_openat)
+		CALL(sys_mkdirat)
+		CALL(sys_mknodat)
+/* 325 */	CALL(sys_fchownat)
+		CALL(sys_futimesat)
+		CALL(sys_fstatat64)
+		CALL(sys_unlinkat)
+		CALL(sys_renameat)
+/* 330 */	CALL(sys_linkat)
+		CALL(sys_symlinkat)
+		CALL(sys_readlinkat)
+		CALL(sys_fchmodat)
+		CALL(sys_faccessat)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
--- linux-2.6.18.5.orig/include/asm-arm/unistd.h
+++ linux-2.6.18.5/include/asm-arm/unistd.h
@@ -347,6 +347,19 @@
 #define __NR_mbind			(__NR_SYSCALL_BASE+319)
 #define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
 #define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
+#define __NR_openat			(__NR_SYSCALL_BASE+322)
+#define __NR_mkdirat			(__NR_SYSCALL_BASE+323)
+#define __NR_mknodat			(__NR_SYSCALL_BASE+324)
+#define __NR_fchownat			(__NR_SYSCALL_BASE+325)
+#define __NR_futimesat			(__NR_SYSCALL_BASE+326)
+#define __NR_fstatat64			(__NR_SYSCALL_BASE+327)
+#define __NR_unlinkat			(__NR_SYSCALL_BASE+328)
+#define __NR_renameat			(__NR_SYSCALL_BASE+329)
+#define __NR_linkat			(__NR_SYSCALL_BASE+330)
+#define __NR_symlinkat			(__NR_SYSCALL_BASE+331)
+#define __NR_readlinkat			(__NR_SYSCALL_BASE+332)
+#define __NR_fchmodat			(__NR_SYSCALL_BASE+333)
+#define __NR_faccessat			(__NR_SYSCALL_BASE+334)
 
 /*
  * The following SWIs are ARM private.

--
