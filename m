Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbTBQWkF>; Mon, 17 Feb 2003 17:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbTBQWkF>; Mon, 17 Feb 2003 17:40:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:30084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267618AbTBQWkE>;
	Mon, 17 Feb 2003 17:40:04 -0500
Subject: [PATCH] Fix warnings for XFS on 2.5.61
From: Stephen Hemminger <shemminger@osdl.org>
To: owner-xfs@oss.sgi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045522194.12947.92.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 14:49:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of the following warnings.

fs/xfs/support/qsort.c: In function `qsort':
fs/xfs/support/qsort.c:202: warning: duplicate `const'

diff -Nru a/fs/xfs/support/qsort.c b/fs/xfs/support/qsort.c
--- a/fs/xfs/support/qsort.c	Mon Feb 17 14:16:15 2003
+++ b/fs/xfs/support/qsort.c	Mon Feb 17 14:16:15 2003
@@ -199,7 +199,7 @@
   {
     char *const end_ptr = &base_ptr[size * (total_elems - 1)];
     char *tmp_ptr = base_ptr;
-    char *thresh = min(end_ptr, base_ptr + max_thresh);
+    char *const thresh = min_t(char *const, end_ptr, base_ptr + max_thresh);
     register char *run_ptr;
 
     /* Find smallest element in first threshold and place it at the



