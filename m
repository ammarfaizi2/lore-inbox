Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbSJISr3>; Wed, 9 Oct 2002 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbSJISr3>; Wed, 9 Oct 2002 14:47:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262483AbSJISr1>;
	Wed, 9 Oct 2002 14:47:27 -0400
Subject: [PATCH] Eliminate compiler warnings from jbd_kmalloc
From: Stephen Hemminger <shemminger@osdl.org>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 11:52:50 -0700
Message-Id: <1034189570.1895.33.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks trivial and fixes compiler warnings. __FUNCTION__ is a
constant and gcc warns about passing it as a mutuable string.

--- linux-2.5/include/linux/jbd.h	2002-09-09 10:27:12.000000000 -0700
+++ dcl-latest/include/linux/jbd.h	2002-10-09 11:40:00.000000000 -0700
@@ -54,7 +54,7 @@
 #define jbd_debug(f, a...)	/**/
 #endif
 
-extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
+extern void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry);
 #define jbd_kmalloc(size, flags) \
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), journal_oom_retry)
 #define jbd_rep_kmalloc(size, flags) \
--- linux-2.5/fs/jbd/journal.c	2002-09-30 10:00:49.000000000 -0700
+++ dcl-latest/fs/jbd/journal.c	2002-10-09 11:41:07.000000000 -0700
@@ -1526,7 +1526,7 @@
  * Simple support for retying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies. 
  */
-void * __jbd_kmalloc (char *where, size_t size, int flags, int retry)
+void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry)
 {
 	void *p;
 	static unsigned long last_warning;



