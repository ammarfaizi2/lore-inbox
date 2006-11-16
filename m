Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162239AbWKPCn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162239AbWKPCn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162242AbWKPCn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:43:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16783 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162239AbWKPCnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:43:49 -0500
Message-Id: <20061116024500.986926000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:38 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [patch 06/30] SPARC: Fix missed bump of NR_SYSCALLS.
Content-Disposition: inline; filename=sparc-fix-missed-bump-of-nr_syscalls.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

When I added the robust futex syscall entries I forgot to bump
NR_SYSCALLS.  This is an easy mistake to make because NR_SYSCALLS
lived in entry.S which is nowhere near unistd.h or syscalls.S, so
while we're here move it's definition into unistd.h so this is
unlikely to ever happen again.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/sparc/kernel/entry.S    |    3 +--
 arch/sparc64/kernel/entry.S  |    3 +--
 include/asm-sparc/unistd.h   |    2 ++
 include/asm-sparc64/unistd.h |    2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.18.2.orig/arch/sparc/kernel/entry.S
+++ linux-2.6.18.2/arch/sparc/kernel/entry.S
@@ -32,13 +32,12 @@
 #include <asm/mxcc.h>
 #include <asm/thread_info.h>
 #include <asm/param.h>
+#include <asm/unistd.h>
 
 #include <asm/asmmacro.h>
 
 #define curptr      g6
 
-#define NR_SYSCALLS 300      /* Each OS is different... */
-
 /* These are just handy. */
 #define _SV	save	%sp, -STACKFRAME_SZ, %sp
 #define _RS     restore 
--- linux-2.6.18.2.orig/arch/sparc64/kernel/entry.S
+++ linux-2.6.18.2/arch/sparc64/kernel/entry.S
@@ -22,11 +22,10 @@
 #include <asm/auxio.h>
 #include <asm/sfafsr.h>
 #include <asm/pil.h>
+#include <asm/unistd.h>
 
 #define curptr      g6
 
-#define NR_SYSCALLS 300      /* Each OS is different... */
-
 	.text
 	.align		32
 
--- linux-2.6.18.2.orig/include/asm-sparc/unistd.h
+++ linux-2.6.18.2/include/asm-sparc/unistd.h
@@ -319,6 +319,8 @@
 #define __NR_set_robust_list	300
 #define __NR_get_robust_list	301
 
+#define NR_SYSCALLS		302
+
 #ifdef __KERNEL__
 /* WARNING: You MAY NOT add syscall numbers larger than 301, since
  *          all of the syscall tables in the Sparc kernel are
--- linux-2.6.18.2.orig/include/asm-sparc64/unistd.h
+++ linux-2.6.18.2/include/asm-sparc64/unistd.h
@@ -321,6 +321,8 @@
 #define __NR_set_robust_list	300
 #define __NR_get_robust_list	301
 
+#define NR_SYSCALLS		302
+
 #ifdef __KERNEL__
 /* WARNING: You MAY NOT add syscall numbers larger than 301, since
  *          all of the syscall tables in the Sparc kernel are

--
