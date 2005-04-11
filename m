Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVDKTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVDKTnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVDKTns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:43:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:11203 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261900AbVDKTnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:43:37 -0400
Date: Mon, 11 Apr 2005 21:46:18 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux390@de.ibm.com, linux-390@vm.marist.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: drop redundant NULL pointer checks before kfree()
Message-ID: <Pine.LNX.4.62.0504112142070.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC when replying)


Checking for NULL before calling kfree() on a pointer is redundant. This 
patch drops such checks from arch/s390/


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 extmem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -upr linux-2.6.12-rc2-mm3-orig/arch/s390/mm/extmem.c linux-2.6.12-rc2-mm3/arch/s390/mm/extmem.c
--- linux-2.6.12-rc2-mm3-orig/arch/s390/mm/extmem.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc2-mm3/arch/s390/mm/extmem.c	2005-04-11 21:40:10.000000000 +0200
@@ -234,8 +234,8 @@ query_segment_type (struct dcss_segment 
 	rc = 0;
 
  out_free:
-	if (qin) kfree(qin);
-	if (qout) kfree(qout);
+	kfree(qin);
+	kfree(qout);
 	return rc;
 }
 
@@ -394,7 +394,7 @@ __segment_load (char *name, int do_nonsh
 				segtype_string[seg->vm_segtype]);
 	goto out;
  out_free:
-	kfree (seg);
+	kfree(seg);
  out:
 	return rc;
 }
@@ -505,7 +505,7 @@ segment_modify_shared (char *name, int d
 	list_del(&seg->list);
 	dcss_diag(DCSS_PURGESEG, seg->dcss_name,
 		  &dummy, &dummy);
-	kfree (seg);
+	kfree(seg);
  out_unlock:
 	spin_unlock(&dcss_lock);
 	return rc;


