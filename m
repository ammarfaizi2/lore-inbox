Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282904AbRLQV7g>; Mon, 17 Dec 2001 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbRLQV71>; Mon, 17 Dec 2001 16:59:27 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13185 "EHLO e21")
	by vger.kernel.org with ESMTP id <S282898AbRLQV7P>;
	Mon, 17 Dec 2001 16:59:15 -0500
Date: Mon, 17 Dec 2001 13:59:05 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
Message-Id: <200112172159.fBHLx5a11340@localhost.localdomain>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] remove redundant lock_kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/proc/proc_misc.c:locks_read_proc(), the BKL is grabbed while calling get_locks_status().  But, this function holds the BKL for all of its list operations already.  I know that the BKL can be held recursively, but I don't see any need for this extra lock.  Patch against 2.5.1 attached. 
   
--- linux-2.5.1/fs/proc/proc_misc.c	Fri Dec 14 14:46:57 2001
+++ linux/fs/proc/proc_misc.c	Mon Dec 17 13:45:49 2001
@@ -409,9 +409,7 @@
 				 int count, int *eof, void *data)
 {
 	int len;
-	lock_kernel();
 	len = get_locks_status(page, start, off, count);
-	unlock_kernel();
 	if (len < count) *eof = 1;
 	return len;
 }
