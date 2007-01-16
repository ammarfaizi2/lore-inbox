Return-Path: <linux-kernel-owner+w=401wt.eu-S1751823AbXAPRBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbXAPRBc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbXAPRAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:00:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37932 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbXAPQoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:34 -0500
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
Subject: [PATCH 49/59] sysctl: Move init_irq_proc into init/main where it belongs
Date: Tue, 16 Jan 2007 09:39:54 -0700
Message-Id: <1168965684147-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 init/main.c     |    3 +++
 kernel/sysctl.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 8b4a7d7..8af5c6e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -691,6 +691,9 @@ static void __init do_basic_setup(void)
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
 #endif
+#ifdef CONFIG_PROC_FS
+	init_irq_proc();
+#endif
 
 	do_initcalls();
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 600b333..7420761 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1172,8 +1172,6 @@ static ctl_table dev_table[] = {
 	{ .ctl_name = 0 }
 };
 
-extern void init_irq_proc (void);
-
 static DEFINE_SPINLOCK(sysctl_lock);
 
 /* called under sysctl_lock */
@@ -1219,7 +1217,6 @@ void __init sysctl_init(void)
 {
 #ifdef CONFIG_PROC_SYSCTL
 	register_proc_table(root_table, proc_sys_root, &root_table_header);
-	init_irq_proc();
 #endif
 }
 
-- 
1.4.4.1.g278f

