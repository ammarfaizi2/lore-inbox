Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270006AbUIDApJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270006AbUIDApJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270012AbUIDAoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:44:25 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25284 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S270006AbUIDAfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:35:45 -0400
Date: Fri, 3 Sep 2004 20:40:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][8/8] updated arch agnostic completely out of line locks /
 other
Message-ID: <Pine.LNX.4.58.0409032033170.31136@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/alpha/kernel/vmlinux.lds.S  |    1 +
 arch/ia64/kernel/vmlinux.lds.S   |    1 +
 arch/mips/kernel/vmlinux.lds.S   |    1 +
 arch/parisc/kernel/vmlinux.lds.S |    1 +
 arch/s390/kernel/vmlinux.lds.S   |    1 +
 arch/sh/kernel/vmlinux.lds.S     |    1 +
 arch/sh64/kernel/vmlinux.lds.S   |    1 +
 arch/sparc/kernel/vmlinux.lds.S  |    1 +
 8 files changed, 8 insertions(+)

Status: Untested
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-bk9-sparc64/arch/alpha/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/alpha/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/alpha/kernel/vmlinux.lds.S	3 Sep 2004 01:30:17 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/alpha/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -18,6 +18,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
   } :kernel
Index: linux-2.6.9-rc1-bk9-sparc64/arch/ia64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/ia64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/ia64/kernel/vmlinux.lds.S	3 Sep 2004 01:30:19 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/ia64/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -42,6 +42,7 @@ SECTIONS
 	*(.text.ivt)
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
Index: linux-2.6.9-rc1-bk9-sparc64/arch/mips/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/mips/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/mips/kernel/vmlinux.lds.S	3 Sep 2004 01:30:22 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/mips/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -29,6 +29,7 @@ SECTIONS
   .text : {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.fixup)
     *(.gnu.warning)
   } =0
Index: linux-2.6.9-rc1-bk9-sparc64/arch/parisc/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/parisc/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/parisc/kernel/vmlinux.lds.S	3 Sep 2004 01:30:22 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/parisc/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -52,6 +52,7 @@ SECTIONS
   .text ALIGN(16) : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.text.do_softirq)
 	*(.text.sys_exit)
 	*(.text.do_sigaltstack)
Index: linux-2.6.9-rc1-bk9-sparc64/arch/s390/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/s390/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/s390/kernel/vmlinux.lds.S	3 Sep 2004 01:30:23 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/s390/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -24,6 +24,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sh/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sh/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/sh/kernel/vmlinux.lds.S	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sh/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -23,6 +23,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0009
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sh64/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sh64/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/sh64/kernel/vmlinux.lds.S	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sh64/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -59,6 +59,7 @@ SECTIONS
 	*(.text64)
         *(.text..SHmedia32)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 #ifdef CONFIG_LITTLE_ENDIAN
Index: linux-2.6.9-rc1-bk9-sparc64/arch/sparc/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk9/arch/sparc/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-bk9-sparc64/arch/sparc/kernel/vmlinux.lds.S	3 Sep 2004 01:30:24 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk9-sparc64/arch/sparc/kernel/vmlinux.lds.S	3 Sep 2004 23:55:27 -0000
@@ -13,6 +13,7 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;
