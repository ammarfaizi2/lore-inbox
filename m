Return-Path: <linux-kernel-owner+w=401wt.eu-S1751690AbXAPQt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXAPQt2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbXAPQtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:49:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38164 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbXAPQq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:46:28 -0500
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
Subject: [PATCH 30/59] sysctl: mips/au1000 Remove sys_sysctl support
Date: Tue, 16 Jan 2007 09:39:35 -0700
Message-Id: <11689656521540-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

The assignment of binary numbers for sys_sysctl use was in
shambles and despite requiring methods.  Nothing was implemented
on the sys_sysctl side.

So this patch gives a mercy killing to the sys_sysctl support for
powermanagment on mips/au1000.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/mips/au1000/common/power.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 7504a63..b531ab7 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -62,12 +62,6 @@ extern unsigned long save_local_and_disable(int controller);
 extern void restore_local_and_enable(int controller, unsigned long mask);
 extern void local_enable_irq(unsigned int irq_nr);
 
-/* Quick acpi hack. This will have to change! */
-#define	CTL_ACPI 9999
-#define	ACPI_S1_SLP_TYP 19
-#define	ACPI_SLEEP 21
-
-
 static DEFINE_SPINLOCK(pm_lock);
 
 /* We need to save/restore a bunch of core registers that are
@@ -425,14 +419,14 @@ static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
 
 
 static struct ctl_table pm_table[] = {
-	{ACPI_S1_SLP_TYP, "suspend", NULL, 0, 0600, NULL, &pm_do_suspend},
-	{ACPI_SLEEP, "sleep", NULL, 0, 0600, NULL, &pm_do_sleep},
-	{CTL_ACPI, "freq", NULL, 0, 0600, NULL, &pm_do_freq},
+	{CTL_UNNUMBERED, "suspend", NULL, 0, 0600, NULL, &pm_do_suspend},
+	{CTL_UNNUMBERED, "sleep", NULL, 0, 0600, NULL, &pm_do_sleep},
+	{CTL_UNNUMBERED, "freq", NULL, 0, 0600, NULL, &pm_do_freq},
 	{0}
 };
 
 static struct ctl_table pm_dir_table[] = {
-	{CTL_ACPI, "pm", NULL, 0, 0555, pm_table},
+	{CTL_UNNUMBERED, "pm", NULL, 0, 0555, pm_table},
 	{0}
 };
 
@@ -441,7 +435,7 @@ static struct ctl_table pm_dir_table[] = {
  */
 static int __init pm_init(void)
 {
-	register_sysctl_table(pm_dir_table, 1);
+	register_sysctl_table(pm_dir_table, 0);
 	return 0;
 }
 
-- 
1.4.4.1.g278f

