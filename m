Return-Path: <linux-kernel-owner+w=401wt.eu-S1751617AbXAPQsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXAPQsJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXAPQsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:48:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38172 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbXAPQqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:46:31 -0500
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
Subject: [PATCH 26/59] sysctl: C99 convert arch/frv/kernel/sysctl.c
Date: Tue, 16 Jan 2007 09:39:31 -0700
Message-Id: <11689656454112-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/frv/kernel/sysctl.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/frv/kernel/sysctl.c b/arch/frv/kernel/sysctl.c
index 37528eb..577ad16 100644
--- a/arch/frv/kernel/sysctl.c
+++ b/arch/frv/kernel/sysctl.c
@@ -175,11 +175,25 @@ static int procctl_frv_pin_cxnr(ctl_table *table, int write, struct file *filp,
  */
 static struct ctl_table frv_table[] =
 {
-	{ 1, "cache-mode",	NULL, 0, 0644, NULL, &procctl_frv_cachemode },
+	{
+		.ctl_name 	= 1,
+		.procname 	= "cache-mode",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= &procctl_frv_cachemode,
+	},
 #ifdef CONFIG_MMU
-	{ 2, "pin-cxnr",	NULL, 0, 0644, NULL, &procctl_frv_pin_cxnr },
+	{
+		.ctl_name	= 2,
+		.procname	= "pin-cxnr",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= &procctl_frv_pin_cxnr
+	},
 #endif
-	{ 0 }
+	{}
 };
 
 /*
@@ -188,8 +202,13 @@ static struct ctl_table frv_table[] =
  */
 static struct ctl_table frv_dir_table[] =
 {
-	{CTL_FRV, "frv", NULL, 0, 0555, frv_table},
-	{0}
+	{
+		.ctl_name	= CTL_FRV,
+		.procname	= "frv",
+		.mode 		= 0555,
+		.child		= frv_table
+	},
+	{}
 };
 
 /*
-- 
1.4.4.1.g278f

