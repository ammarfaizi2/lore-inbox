Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTJIUKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTJIUKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:10:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9656 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262416AbTJIUKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:10:52 -0400
Subject: [PATCH] BUG() in exec_mmap()
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1065730208.27064.20.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 15:10:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
A recent change to exec_mmap() removed the initialization of old_mm,
leaving an uninitialized use of it.  This patch would completely remove
old_mm from the function.  Is this what was intended?

===== fs/exec.c 1.30 vs edited =====
--- 1.30/fs/exec.c	Thu Oct  9 08:48:43 2003
+++ edited/fs/exec.c	Thu Oct  9 14:58:42 2003
@@ -423,7 +423,7 @@
 
 static int exec_mmap(void)
 {
-	struct mm_struct * mm, * old_mm;
+	struct mm_struct * mm;
 
 	mm = mm_alloc();
 	if (mm) {
@@ -447,11 +447,6 @@
 		task_unlock(current);
 		activate_mm(active_mm, mm);
 		mm_release();
-		if (old_mm) {
-			if (active_mm != old_mm) BUG();
-			mmput(old_mm);
-			return 0;
-		}
 		mmdrop(active_mm);
 		return 0;
 	}

-- 
David Kleikamp
IBM Linux Technology Center

