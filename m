Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSKOTlJ>; Fri, 15 Nov 2002 14:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSKOTlI>; Fri, 15 Nov 2002 14:41:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266578AbSKOTlI>;
	Fri, 15 Nov 2002 14:41:08 -0500
Date: Fri, 15 Nov 2002 19:48:03 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] Move fd-related function declarations out of sched.h
Message-ID: <20021115194803.J20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A minor removal of 6 function definitions from sched.h.  They clearly
fit better in file.h.  All users of these functions already include file.h.

diff -u linux-2.5.47-wait/include/linux/sched.h linux-2.5.47-wait/include/linux/sched.h
--- linux-2.5.47-wait/include/linux/sched.h	2002-11-15 05:44:44.000000000 -0800
+++ linux-2.5.47-wait/include/linux/sched.h	2002-11-15 11:11:47.000000000 -0800
@@ -606,17 +606,6 @@
 /* Remove the current tasks stale references to the old mm_struct */
 extern void mm_release(void);
 
-/*
- * Routines for handling the fd arrays
- */
-extern struct file ** alloc_fd_array(int);
-extern int expand_fd_array(struct files_struct *, int nr);
-extern void free_fd_array(struct file **, int);
-
-extern fd_set *alloc_fdset(int);
-extern int expand_fdset(struct files_struct *, int nr);
-extern void free_fdset(fd_set *, int);
-
 extern int  copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
 extern void flush_thread(void);
 extern void exit_thread(void);
only in patch2:
unchanged:
--- linux-2.5.47/include/linux/file.h	2002-08-01 14:16:00.000000000 -0700
+++ linux-2.5.47-wait/include/linux/file.h	2002-11-15 11:14:31.000000000 -0800
@@ -41,6 +41,13 @@ extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
 
+extern struct file ** alloc_fd_array(int);
+extern int expand_fd_array(struct files_struct *, int nr);
+extern void free_fd_array(struct file **, int);
+
+extern fd_set *alloc_fdset(int);
+extern int expand_fdset(struct files_struct *, int nr);
+extern void free_fdset(fd_set *, int);
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
 {

-- 
Revolutions do not require corporate support.
