Return-Path: <linux-kernel-owner+w=401wt.eu-S1751887AbXAPREo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbXAPREo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXAPRDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:03:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37833 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXAPQoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:15 -0500
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
Subject: [PATCH 34/59] sysctl: s390 Remove unnecessary use of insert_at_head
Date: Tue, 16 Jan 2007 09:39:39 -0700
Message-Id: <11689656581195-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/s390/appldata/appldata_base.c |    4 ++--
 arch/s390/kernel/debug.c           |    2 +-
 arch/s390/mm/cmm.c                 |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index b8c2372..cdc4109 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -506,7 +506,7 @@ int appldata_register_ops(struct appldata_ops *ops)
 
 	ops->ctl_table[3].ctl_name = 0;
 
-	ops->sysctl_header = register_sysctl_table(ops->ctl_table,1);
+	ops->sysctl_header = register_sysctl_table(ops->ctl_table,0);
 
 	P_INFO("%s-ops registered!\n", ops->name);
 	return 0;
@@ -606,7 +606,7 @@ static int __init appldata_init(void)
 	/* Register cpu hotplug notifier */
 	register_hotcpu_notifier(&appldata_nb);
 
-	appldata_sysctl_header = register_sysctl_table(appldata_dir_table, 1);
+	appldata_sysctl_header = register_sysctl_table(appldata_dir_table, 0);
 #ifdef MODULE
 	appldata_dir_table[0].de->owner = THIS_MODULE;
 	appldata_table[0].de->owner = THIS_MODULE;
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c81f8e5..d38cb27 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1053,7 +1053,7 @@ __init debug_init(void)
 {
 	int rc = 0;
 
-	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table, 1);
+	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table, 0);
 	down(&debug_lock);
 	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT,NULL);
 	printk(KERN_INFO "debug: Initialization complete\n");
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index df733d5..5f83a3f 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -418,7 +418,7 @@ cmm_init (void)
 	int rc = -ENOMEM;
 
 #ifdef CONFIG_CMM_PROC
-	cmm_sysctl_header = register_sysctl_table(cmm_dir_table, 1);
+	cmm_sysctl_header = register_sysctl_table(cmm_dir_table, 0);
 	if (!cmm_sysctl_header)
 		goto out;
 #endif
-- 
1.4.4.1.g278f

