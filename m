Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKIIfO>; Thu, 9 Nov 2000 03:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKIIfD>; Thu, 9 Nov 2000 03:35:03 -0500
Received: from [213.8.184.211] ([213.8.184.211]:40721 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129033AbQKIIfA>;
	Thu, 9 Nov 2000 03:35:00 -0500
Date: Thu, 9 Nov 2000 10:32:26 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/fork.c - tiny cleanup
Message-ID: <Pine.LNX.4.21.0011091010040.32673-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, 

This replaces an explict __MOD_INC_USE_COUNT in do_fork() with the right
macro (get_exec_domain) to reflect the counterpart (put_exec_domain) in  
do_exit().

--- linux/kernel-2.4.0-test11-pre1/fork.c	Sun Nov  5 00:27:50 2000
+++ linux/kernel/fork.c	Thu Nov  9 10:04:50 2000
@@ -572,9 +572,9 @@
 	 */
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
+	
+	get_exec_domain(p->exec_domain);
 
-	if (p->exec_domain && p->exec_domain->module)
-		__MOD_INC_USE_COUNT(p->exec_domain->module);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_INC_USE_COUNT(p->binfmt->module);
 



-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
