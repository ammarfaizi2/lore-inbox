Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbSIXUpq>; Tue, 24 Sep 2002 16:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261795AbSIXUpq>; Tue, 24 Sep 2002 16:45:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39684
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261794AbSIXUpo>; Tue, 24 Sep 2002 16:45:44 -0400
Subject: [PATCH] s/preempt_count()/in_atomic() in do_exit()
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-oC8+S5VnVDB7YE7Zm9iS"
Organization: 
Message-Id: <1032900654.1007.89.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 24 Sep 2002 16:50:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oC8+S5VnVDB7YE7Zm9iS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus,

This patch converts the debugging check in do_exit from a check on
preempt_count() to in_atomic().

The main benefit to this is we will stop warning over the BKL and now
use the standard mechanism for such checks.

Patch is against current BK, please apply.

	Robert Love


--=-oC8+S5VnVDB7YE7Zm9iS
Content-Disposition: attachment; filename=do_exit-in_atomic-rml-2.5.38-1.patch
Content-Type: text/x-patch; name=do_exit-in_atomic-rml-2.5.38-1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.5.38/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.38/kernel/exit.c	Tue Sep 24 16:14:44 2002
+++ linux/kernel/exit.c	Tue Sep 24 16:34:27 2002
@@ -626,7 +626,7 @@
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
 
-	if (unlikely(preempt_count()))
+	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
 				current->comm, current->pid,
 				preempt_count());

--=-oC8+S5VnVDB7YE7Zm9iS--

