Return-Path: <linux-kernel-owner+w=401wt.eu-S1751356AbXAPREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXAPREp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXAPRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:02:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37842 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbXAPQoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:16 -0500
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
Subject: [PATCH 28/59] sysctl: C99 Convert arch/ia64/sn/kernel/xpc_main.c
Date: Tue, 16 Jan 2007 09:39:33 -0700
Message-Id: <11689656481444-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/sn/kernel/xpc_main.c |   86 +++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/arch/ia64/sn/kernel/xpc_main.c b/arch/ia64/sn/kernel/xpc_main.c
index 24adb75..e04f7b5 100644
--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -101,67 +101,57 @@ static int xpc_disengage_request_max_timelimit = 120;
 
 static ctl_table xpc_sys_xpc_hb_dir[] = {
 	{
-		CTL_UNNUMBERED,
-		"hb_interval",
-		&xpc_hb_interval,
-		sizeof(int),
-		0644,
-		NULL,
-		&proc_dointvec_minmax,
-		&sysctl_intvec,
-		NULL,
-		&xpc_hb_min_interval,
-		&xpc_hb_max_interval
+		.ctl_name 	= CTL_UNNUMBERED,
+		.procname	= "hb_interval",
+		.data		= &xpc_hb_interval,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &xpc_hb_min_interval,
+		.extra2		= &xpc_hb_max_interval
 	},
 	{
-		CTL_UNNUMBERED,
-		"hb_check_interval",
-		&xpc_hb_check_interval,
-		sizeof(int),
-		0644,
-		NULL,
-		&proc_dointvec_minmax,
-		&sysctl_intvec,
-		NULL,
-		&xpc_hb_check_min_interval,
-		&xpc_hb_check_max_interval
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "hb_check_interval",
+		.data		= &xpc_hb_check_interval,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &xpc_hb_check_min_interval,
+		.extra2		= &xpc_hb_check_max_interval
 	},
-	{0}
+	{}
 };
 static ctl_table xpc_sys_xpc_dir[] = {
 	{
-		CTL_UNNUMBERED,
-		"hb",
-		NULL,
-		0,
-		0555,
-		xpc_sys_xpc_hb_dir
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "hb",
+		.mode		= 0555,
+		.child		= xpc_sys_xpc_hb_dir
 	},
 	{
-		CTL_UNNUMBERED,
-		"disengage_request_timelimit",
-		&xpc_disengage_request_timelimit,
-		sizeof(int),
-		0644,
-		NULL,
-		&proc_dointvec_minmax,
-		&sysctl_intvec,
-		NULL,
-		&xpc_disengage_request_min_timelimit,
-		&xpc_disengage_request_max_timelimit
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "disengage_request_timelimit",
+		.data		= &xpc_disengage_request_timelimit,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &xpc_disengage_request_min_timelimit,
+		.extra2		= &xpc_disengage_request_max_timelimit
 	},
-	{0}
+	{}
 };
 static ctl_table xpc_sys_dir[] = {
 	{
-		CTL_UNNUMBERED,
-		"xpc",
-		NULL,
-		0,
-		0555,
-		xpc_sys_xpc_dir
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "xpc",
+		.mode		= 0555,
+		.child		= xpc_sys_xpc_dir
 	},
-	{0}
+	{}
 };
 static struct ctl_table_header *xpc_sysctl;
 
-- 
1.4.4.1.g278f

