Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSLBVNf>; Mon, 2 Dec 2002 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSLBVNe>; Mon, 2 Dec 2002 16:13:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63246
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265211AbSLBVNd>; Mon, 2 Dec 2002 16:13:33 -0500
Subject: [PATCH] deprecate use of bdflush()
From: Robert Love <rml@tech9.net>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038864066.1221.43.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 16:21:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can never get rid of it if we do not deprecate it - so do so and
print a stern warning to those who still run bdflush daemons.

Patch is against 2.5.49-mm2.  Please apply.

	Robert Love


 fs/buffer.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -urN linux-2.5.49-mm2/fs/buffer.c linux/fs/buffer.c
--- linux-2.5.49-mm2/fs/buffer.c	2002-12-02 16:07:53.000000000 -0500
+++ linux/fs/buffer.c	2002-12-02 16:17:16.000000000 -0500
@@ -2757,11 +2757,17 @@
 /*
  * There are no bdflush tunables left.  But distributions are
  * still running obsolete flush daemons, so we terminate them here.
+ *
+ * Use of bdflush() is deprecated and will be removed in a future kernel.
+ * The `pdflush' kernel threads fully replace bdflush daemons and this call.
  */
 asmlinkage long sys_bdflush(int func, long data)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
+
+	printk(KERN_WARNING "warning: the bdflush system call is deprecated "
+			 "and no longer needed.  Stop using it.\n");
 	if (func == 1)
 		do_exit(0);
 	return 0;



