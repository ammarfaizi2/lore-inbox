Return-Path: <linux-kernel-owner+w=401wt.eu-S936332AbWLIIki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936332AbWLIIki (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936337AbWLIIki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:40:38 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51652 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936332AbWLIIkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:40:37 -0500
Date: Sat, 9 Dec 2006 00:38:01 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, akpm <akpm@osdl.org>
Subject: [PATCH] ipc-procfs-sysctl mixups
Message-Id: <20061209003801.1df115b6.randy.dunlap@oracle.com>
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

When CONFIG_PROC_FS=n and CONFIG_PROC_SYSCTL=n but CONFIG_SYSVIPC=y,
we get this build error:

kernel/built-in.o:(.data+0xc38): undefined reference to `proc_ipc_doulongvec_minmax'
kernel/built-in.o:(.data+0xc88): undefined reference to `proc_ipc_doulongvec_minmax'
kernel/built-in.o:(.data+0xcd8): undefined reference to `proc_ipc_dointvec'
kernel/built-in.o:(.data+0xd28): undefined reference to `proc_ipc_dointvec'
kernel/built-in.o:(.data+0xd78): undefined reference to `proc_ipc_dointvec'
kernel/built-in.o:(.data+0xdc8): undefined reference to `proc_ipc_dointvec'
kernel/built-in.o:(.data+0xe18): undefined reference to `proc_ipc_dointvec'
make: *** [vmlinux] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kernel/sysctl.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.19-git13.orig/kernel/sysctl.c
+++ linux-2.6.19-git13/kernel/sysctl.c
@@ -2408,6 +2408,17 @@ static int proc_do_ipc_string(ctl_table 
 {
 	return -ENOSYS;
 }
+static int proc_ipc_dointvec(ctl_table *table, int write, struct file *filp,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+static int proc_ipc_doulongvec_minmax(ctl_table *table, int write,
+		struct file *filp, void __user *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
 #endif
 
 int proc_dointvec(ctl_table *table, int write, struct file *filp,


---
