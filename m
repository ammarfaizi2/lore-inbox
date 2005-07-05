Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVGEVC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVGEVC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVGEVCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:02:41 -0400
Received: from ozlabs.org ([203.10.76.45]:7363 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261921AbVGEVBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:01:39 -0400
Date: Wed, 6 Jul 2005 06:56:32 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] move ioprio syscalls into syscalls.h
Message-ID: <20050705205632.GF12786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Make ioprio syscalls return long, like set/getpriority syscalls.
- Move function prototypes into syscalls.h so we can pick them up in the
  32/64bit compat code.

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: foobar2/fs/ioprio.c
===================================================================
--- foobar2.orig/fs/ioprio.c	2005-07-04 01:09:20.311694190 +1000
+++ foobar2/fs/ioprio.c	2005-07-04 01:14:30.620438688 +1000
@@ -43,7 +43,7 @@
 	return 0;
 }
 
-asmlinkage int sys_ioprio_set(int which, int who, int ioprio)
+asmlinkage long sys_ioprio_set(int which, int who, int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
 	int data = IOPRIO_PRIO_DATA(ioprio);
@@ -115,7 +115,7 @@
 	return ret;
 }
 
-asmlinkage int sys_ioprio_get(int which, int who)
+asmlinkage long sys_ioprio_get(int which, int who)
 {
 	struct task_struct *g, *p;
 	struct user_struct *user;
Index: foobar2/include/linux/syscalls.h
===================================================================
--- foobar2.orig/include/linux/syscalls.h	2005-07-04 01:09:20.311694190 +1000
+++ foobar2/include/linux/syscalls.h	2005-07-04 01:14:43.583415901 +1000
@@ -506,4 +506,7 @@
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
 
+asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
+asmlinkage long sys_ioprio_get(int which, int who);
+
 #endif
Index: foobar2/include/linux/ioprio.h
===================================================================
--- foobar2.orig/include/linux/ioprio.h	2005-07-02 15:56:13.000000000 +1000
+++ foobar2/include/linux/ioprio.h	2005-07-04 01:16:44.216312182 +1000
@@ -34,9 +34,6 @@
  */
 #define IOPRIO_BE_NR	(8)
 
-asmlinkage int sys_ioprio_set(int, int, int);
-asmlinkage int sys_ioprio_get(int, int);
-
 enum {
 	IOPRIO_WHO_PROCESS = 1,
 	IOPRIO_WHO_PGRP,
