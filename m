Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbTCYCqI>; Mon, 24 Mar 2003 21:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbTCYCqI>; Mon, 24 Mar 2003 21:46:08 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:58309 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261360AbTCYCqG>; Mon, 24 Mar 2003 21:46:06 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add new ptrace defines for v850 to get process address details
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030325025657.516CF3702@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 25 Mar 2003 11:56:57 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some magic addresses for use with PT_USERPEEK that allow gdb
to find out where a process is located in memory, so it can correctly
relocate its symbols to match the running process.  The actual
implementation in sys_ptrace is currently tangled up with some other
ptrace changes, so I'll leave that for later.

diff -ruN -X../cludes linux-2.5.66-moo.orig/include/asm-v850/ptrace.h linux-2.5.66-moo/include/asm-v850/ptrace.h
--- linux-2.5.66-moo.orig/include/asm-v850/ptrace.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.66-moo/include/asm-v850/ptrace.h	2003-03-25 10:37:52.000000000 +0900
@@ -108,4 +110,11 @@
 #define PT_SIZE		((NUM_GPRS + 6) * _PT_REG_SIZE)
 
 
+/* These are `magic' values for PTRACE_PEEKUSR that return info about where
+   a process is located in memory.  */
+#define PT_TEXT_ADDR	(PT_SIZE + 1)
+#define PT_TEXT_LEN	(PT_SIZE + 2)
+#define PT_DATA_ADDR	(PT_SIZE + 3)
+
+
 #endif /* __V850_PTRACE_H__ */
