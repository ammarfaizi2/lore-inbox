Return-Path: <linux-kernel-owner+w=401wt.eu-S1751597AbXAPQz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXAPQz2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXAPQyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:54:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46001 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbXAPQte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:49:34 -0500
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
Subject: [PATCH 47/59] sysctl: C99 convert ctl_tables in NTFS and remove sys_sysctl support
Date: Tue, 16 Jan 2007 09:39:52 -0700
Message-Id: <11689656793474-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Putting ntfs-debug under FS_NRINODE was not a kosher thing to do
so don't give it any binary number.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/ntfs/sysctl.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 1c23138..bc217de 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -33,20 +33,28 @@
 #include "sysctl.h"
 #include "debug.h"
 
-#define FS_NTFS	1
-
 /* Definition of the ntfs sysctl. */
 static ctl_table ntfs_sysctls[] = {
-	{ FS_NTFS, "ntfs-debug",		/* Binary and text IDs. */
-	  &debug_msgs,sizeof(debug_msgs),	/* Data pointer and size. */
-	  0644,	NULL, &proc_dointvec },		/* Mode, child, proc handler. */
-	{ 0 }
+	{
+		.ctl_name	= CTL_UNUMBERED,	/* Binary and text IDs. */
+		.procname	= "ntfs-debug",
+		.data		= &debug_msgs,		/* Data pointer and size. */
+		.maxlen		= sizeof(debug_msgs),
+		.mode		= 0644,			/* Mode, proc handler. */
+		.proc_handler	= &proc_dointvec
+	},
+	{}
 };
 
 /* Define the parent directory /proc/sys/fs. */
 static ctl_table sysctls_root[] = {
-	{ CTL_FS, "fs", NULL, 0, 0555, ntfs_sysctls },
-	{ 0 }
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= ntfs_sysctls
+	},
+	{}
 };
 
 /* Storage for the sysctls header. */
-- 
1.4.4.1.g278f

