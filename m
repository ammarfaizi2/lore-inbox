Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbUKLX4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUKLX4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKLXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:53:17 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:18948
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262683AbUKLXrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:47:43 -0500
Message-Id: <200411130200.iAD20ipT005854@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/11] - UML 64-bit type cleanups 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

64-bit cleanliness - Fix the number of bits of the time_t field in the
COW header to be 32 and change an int to a longs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/drivers/cow_user.c
===================================================================
--- 2.6.9.orig/arch/um/drivers/cow_user.c	2004-11-08 19:14:44.000000000 -0500
+++ 2.6.9/arch/um/drivers/cow_user.c	2004-11-12 13:33:26.000000000 -0500
@@ -67,7 +67,7 @@
 struct cow_header_v3 {
 	__u32 magic;
 	__u32 version;
-	time_t mtime;
+	__u32 mtime;
 	__u64 size;
 	__u32 sectorsize;
 	__u32 alignment;
Index: 2.6.9/arch/um/include/kern_util.h
===================================================================
--- 2.6.9.orig/arch/um/include/kern_util.h	2004-11-08 19:14:44.000000000 -0500
+++ 2.6.9/arch/um/include/kern_util.h	2004-11-12 18:05:29.000000000 -0500
@@ -41,7 +41,7 @@
 extern int segv_syscall(void);
 extern void kern_finish_exec(void *task, int new_pid, unsigned long stack);
 extern int page_size(void);
-extern int page_mask(void);
+extern unsigned long page_mask(void);
 extern int need_finish_fork(void);
 extern void free_stack(unsigned long stack, int order);
 extern void add_input_request(int op, void (*proc)(int), void *arg);
Index: 2.6.9/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process_kern.c	2004-11-12 13:26:04.000000000 -0500
+++ 2.6.9/arch/um/kernel/process_kern.c	2004-11-12 18:05:29.000000000 -0500
@@ -1,5 +1,6 @@
 /* 
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
  * Licensed under the GPL
  */
 
@@ -225,7 +226,7 @@
 	return(PAGE_SIZE);
 }
 
-int page_mask(void)
+unsigned long page_mask(void)
 {
 	return(PAGE_MASK);
 }

