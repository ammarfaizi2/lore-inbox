Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUICAMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUICAMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269388AbUICAEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:04:49 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25588 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269406AbUIBX6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:58:14 -0400
Date: Thu, 2 Sep 2004 20:02:30 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2/8] Arch agnostic completely out of line locks / other
Message-ID: <Pine.LNX.4.58.0409021212220.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch covers basic support for the other architectures (without lock profile).

 arch/alpha/kernel/vmlinux.lds.S  |    1 +
 arch/ia64/kernel/vmlinux.lds.S   |    1 +
 arch/mips/kernel/vmlinux.lds.S   |    1 +
 arch/parisc/kernel/vmlinux.lds.S |    1 +
 arch/s390/kernel/vmlinux.lds.S   |    1 +
 arch/sh/kernel/vmlinux.lds.S     |    1 +
 arch/sh64/kernel/vmlinux.lds.S   |    1 +
 arch/sparc/kernel/vmlinux.lds.S  |    1 +
 8 files changed, 8 insertions(+)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1-stage/arch/alpha/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/alpha/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/alpha/kernel/vmlinux.lds.S	26 Aug 2004 13:13:04 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/alpha/kernel/vmlinux.lds.S	2 Sep 2004 13:08:12 -0000
@@ -18,6 +18,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
   } :kernel
Index: linux-2.6.9-rc1-mm1-stage/arch/ia64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/ia64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/ia64/kernel/vmlinux.lds.S	26 Aug 2004 13:13:03 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/ia64/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -42,6 +42,7 @@ SECTIONS
 	*(.text.ivt)
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
Index: linux-2.6.9-rc1-mm1-stage/arch/mips/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/mips/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/mips/kernel/vmlinux.lds.S	26 Aug 2004 13:12:59 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/mips/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -29,6 +29,7 @@ SECTIONS
   .text : {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.fixup)
     *(.gnu.warning)
   } =0
Index: linux-2.6.9-rc1-mm1-stage/arch/parisc/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/parisc/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/parisc/kernel/vmlinux.lds.S	26 Aug 2004 13:13:05 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/parisc/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -52,6 +52,7 @@ SECTIONS
   .text ALIGN(16) : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.text.do_softirq)
 	*(.text.sys_exit)
 	*(.text.do_sigaltstack)
Index: linux-2.6.9-rc1-mm1-stage/arch/s390/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/s390/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/s390/kernel/vmlinux.lds.S	26 Aug 2004 13:13:06 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/s390/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -24,6 +24,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
Index: linux-2.6.9-rc1-mm1-stage/arch/sh/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/sh/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/sh/kernel/vmlinux.lds.S	26 Aug 2004 13:13:02 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/sh/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -23,6 +23,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0009
Index: linux-2.6.9-rc1-mm1-stage/arch/sh64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/sh64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/sh64/kernel/vmlinux.lds.S	26 Aug 2004 13:13:07 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/sh64/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -59,6 +59,7 @@ SECTIONS
 	*(.text64)
         *(.text..SHmedia32)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 #ifdef CONFIG_LITTLE_ENDIAN
Index: linux-2.6.9-rc1-mm1-stage/arch/sparc/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/sparc/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/sparc/kernel/vmlinux.lds.S	26 Aug 2004 13:12:47 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/sparc/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -13,6 +13,7 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;

