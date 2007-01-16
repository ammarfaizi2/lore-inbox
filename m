Return-Path: <linux-kernel-owner+w=401wt.eu-S1751527AbXAPQ5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbXAPQ5k (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbXAPQpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:45:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37971 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbXAPQor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:47 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       <netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       minyard@acm.org, openipmi-developer@lists.sourceforge.net,
       <tony.luck@intel.com>, linux-mips@linux-mips.org, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
       linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
       lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       <ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
       rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
       andrea@suse.de, tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 39/59] sysctl: C99 convert ctl_tables in arch/x86_64/ia32/ia32_binfmt.c
Date: Tue, 16 Jan 2007 09:39:44 -0700
Message-Id: <1168965664873-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/ia32/ia32_binfmt.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
index 75677ad..644b203 100644
--- a/arch/x86_64/ia32/ia32_binfmt.c
+++ b/arch/x86_64/ia32/ia32_binfmt.c
@@ -395,16 +395,26 @@ EXPORT_SYMBOL(ia32_setup_arg_pages);
 #include <linux/sysctl.h>
 
 static ctl_table abi_table2[] = {
-	{ 99, "vsyscall32", &sysctl_vsyscall32, sizeof(int), 0644, NULL,
-	  proc_dointvec },
-	{ 0, }
-}; 
-
-static ctl_table abi_root_table2[] = { 
-	{ .ctl_name = CTL_ABI, .procname = "abi", .mode = 0555, 
-	  .child = abi_table2 }, 
-	{ 0 }, 
-}; 
+	{
+		.ctl_name	= 99,
+		.procname	= "vsyscall32",
+		.data		= &sysctl_vsyscall32,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{}
+};
+
+static ctl_table abi_root_table2[] = {
+	{
+		.ctl_name = CTL_ABI,
+		.procname = "abi",
+		.mode = 0555,
+		.child = abi_table2
+	},
+	{}
+};
 
 static __init int ia32_binfmt_init(void)
 { 
-- 
1.4.4.1.g278f

