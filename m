Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVHXQwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVHXQwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVHXQwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:52:47 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:58257 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751156AbVHXQwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:52:46 -0400
Date: Wed, 24 Aug 2005 11:52:35 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, starvik@axis.com, dev-etrax@axis.com
Subject: [PATCH 04/15] cris: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241150510.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed cris architecture specific users of asm/segment.h and
asm-cris/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 352a43ca6e4cb29ca7ee1742a00f3b6d98465a0d
tree b3816f312ed0b9206e344ceb62bb4f82a5c469e6
parent 13e9876eff93029eb24affd8842db94035c370f5
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:47:26 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:47:26 -0500

 arch/cris/arch-v10/kernel/fasttimer.c |    1 -
 arch/cris/kernel/sys_cris.c           |    1 -
 include/asm-cris/processor.h          |    4 ++++
 include/asm-cris/segment.h            |    8 --------
 include/asm-cris/thread_info.h        |    1 -
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/cris/arch-v10/kernel/fasttimer.c b/arch/cris/arch-v10/kernel/fasttimer.c
--- a/arch/cris/arch-v10/kernel/fasttimer.c
+++ b/arch/cris/arch-v10/kernel/fasttimer.c
@@ -105,7 +105,6 @@
 #include <linux/time.h>
 #include <linux/delay.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
diff --git a/arch/cris/kernel/sys_cris.c b/arch/cris/kernel/sys_cris.c
--- a/arch/cris/kernel/sys_cris.c
+++ b/arch/cris/kernel/sys_cris.c
@@ -24,7 +24,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
-#include <asm/segment.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating
diff --git a/include/asm-cris/processor.h b/include/asm-cris/processor.h
--- a/include/asm-cris/processor.h
+++ b/include/asm-cris/processor.h
@@ -21,6 +21,10 @@
  */
 #define TASK_UNMAPPED_BASE      (PAGE_ALIGN(TASK_SIZE / 3))
 
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
 /* THREAD_SIZE is the size of the task_struct/kernel_stack combo.
  * normally, the stack is found by doing something like p + THREAD_SIZE
  * in CRIS, a page is 8192 bytes, which seems like a sane size
diff --git a/include/asm-cris/segment.h b/include/asm-cris/segment.h
deleted file mode 100644
--- a/include/asm-cris/segment.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _ASM_SEGMENT_H
-#define _ASM_SEGMENT_H
-
-typedef struct {
-  unsigned long seg;
-} mm_segment_t;
-
-#endif
diff --git a/include/asm-cris/thread_info.h b/include/asm-cris/thread_info.h
--- a/include/asm-cris/thread_info.h
+++ b/include/asm-cris/thread_info.h
@@ -15,7 +15,6 @@
 #include <asm/types.h>
 #include <asm/processor.h>
 #include <asm/arch/thread_info.h>
-#include <asm/segment.h>
 #endif
 
 
