Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVHWVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVHWVtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVHWVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:49:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14262 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932440AbVHWVo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:29 -0400
To: torvalds@osdl.org
Subject: [PATCH] (33/43) broken inline asm on s390 (misuse of labels)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gcG-0007E4-8S@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use of explicit labels in inline asm is a Bad Idea(tm), since gcc can
decide to inline the function in several places.  Fixed by use of 1f/f:
instead of .Lfitsin/.Lfitsin:

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-sio/arch/s390/kernel/cpcmd.c RC13-rc6-git13-s390/arch/s390/kernel/cpcmd.c
--- RC13-rc6-git13-m32r-sio/arch/s390/kernel/cpcmd.c	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git13-s390/arch/s390/kernel/cpcmd.c	2005-08-21 13:17:15.000000000 -0400
@@ -46,9 +46,9 @@
 				"lra	3,0(%4)\n"
 				"lr	5,%5\n"
 				"diag	2,4,0x8\n"
-				"brc	8, .Litfits\n"
+				"brc	8, 1f\n"
 				"ar	5, %5\n"
-				".Litfits: \n"
+				"1: \n"
 				"lr	%0,4\n"
 				"lr	%1,5\n"
 				: "=d" (return_code), "=d" (return_len)
@@ -64,9 +64,9 @@
 				"sam31\n"
 				"diag	2,4,0x8\n"
 				"sam64\n"
-				"brc	8, .Litfits\n"
+				"brc	8, 1f\n"
 				"agr	5, %5\n"
-				".Litfits: \n"
+				"1: \n"
 				"lgr	%0,4\n"
 				"lgr	%1,5\n"
 				: "=d" (return_code), "=d" (return_len)
