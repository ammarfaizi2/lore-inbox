Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267726AbUG3Wcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267726AbUG3Wcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267862AbUG3Wcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:32:53 -0400
Received: from waste.org ([209.173.204.2]:47324 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267726AbUG3Wcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:32:50 -0400
Date: Fri, 30 Jul 2004 17:32:46 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [TRIVIAL] Fix CON_BUF_SIZE usage
Message-ID: <20040730223246.GV16310@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/drivers/char/vt.c
===================================================================
--- tiny.orig/drivers/char/vt.c	2004-07-24 11:53:05.000000000 -0500
+++ tiny/drivers/char/vt.c	2004-07-27 17:02:56.000000000 -0500
@@ -1864,7 +1864,7 @@
  * since console_init (and thus con_init) are called before any
  * kernel memory allocation is available.
  */
-char con_buf[PAGE_SIZE];
+char con_buf[CON_BUF_SIZE];
 DECLARE_MUTEX(con_buf_sem);
 
 /* acquires console_sem */
Index: tiny/include/linux/vt_kern.h
===================================================================
--- tiny.orig/include/linux/vt_kern.h	2004-07-24 11:53:28.000000000 -0500
+++ tiny/include/linux/vt_kern.h	2004-07-27 17:04:34.000000000 -0500
@@ -89,8 +89,8 @@
  * vc_screen.c shares this temporary buffer with the console write code so that
  * we can easily avoid touching user space while holding the console spinlock.
  */
-extern char con_buf[PAGE_SIZE];
 #define CON_BUF_SIZE	PAGE_SIZE
+extern char con_buf[CON_BUF_SIZE];
 extern struct semaphore con_buf_sem;
 
 #endif /* _VT_KERN_H */

-- 
Mathematics is the supreme nostalgia of our time.
