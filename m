Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWJRR74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWJRR74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWJRR74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:59:56 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:63647 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161237AbWJRR7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:59:55 -0400
Date: Wed, 18 Oct 2006 11:01:18 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>
Subject: [PATCH] cad_pid sysctl with PROC_FS=n
Message-Id: <20061018110118.82cd12b1.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

mainline and -mm have this error if CONFIG_PROC_FS=n:

kernel/sysctl.c:148: warning: 'proc_do_cad_pid' used but never defined
kernel/built-in.o:(.data+0x1228): undefined reference to `proc_do_cad_pid'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kernel/sysctl.c |    4 ++++
 1 files changed, 4 insertions(+)

--- linux-2619-rc2-mm1.orig/kernel/sysctl.c
+++ linux-2619-rc2-mm1/kernel/sysctl.c
@@ -144,8 +144,10 @@ static int parse_table(int __user *, int
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 
+#ifdef CONFIG_PROC_SYSCTL
 static int proc_do_cad_pid(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
+#endif
 
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
@@ -558,6 +560,7 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_PROC_SYSCTL
 	{
 		.ctl_name	= KERN_CADPID,
 		.procname	= "cad_pid",
@@ -566,6 +569,7 @@ static ctl_table kern_table[] = {
 		.mode		= 0600,
 		.proc_handler	= &proc_do_cad_pid,
 	},
+#endif
 	{
 		.ctl_name	= KERN_MAX_THREADS,
 		.procname	= "threads-max",


---
