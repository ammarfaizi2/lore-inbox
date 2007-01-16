Return-Path: <linux-kernel-owner+w=401wt.eu-S1751860AbXAPRCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbXAPRCH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbXAPRBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:01:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37921 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbXAPQoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:32 -0500
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
Subject: [PATCH 43/59] sysctl: Remove sys_sysctl support from drivers/char/rtc.c
Date: Tue, 16 Jan 2007 09:39:48 -0700
Message-Id: <1168965669760-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

The real time clock driver was using the binary number reserved
for cdroms in the sysctl binary number interface, which is a no-no.
So since the sysctl binary interface is wrong remove it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/rtc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 664f36c..df11289 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -282,7 +282,7 @@ irqreturn_t rtc_interrupt(int irq, void *dev_id)
  */
 static ctl_table rtc_table[] = {
 	{
-		.ctl_name	= 1,
+		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "max-user-freq",
 		.data		= &rtc_max_user_freq,
 		.maxlen		= sizeof(int),
@@ -294,9 +294,8 @@ static ctl_table rtc_table[] = {
 
 static ctl_table rtc_root[] = {
 	{
-		.ctl_name	= 1,
+		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "rtc",
-		.maxlen		= 0,
 		.mode		= 0555,
 		.child		= rtc_table,
 	},
@@ -307,7 +306,6 @@ static ctl_table dev_root[] = {
 	{
 		.ctl_name	= CTL_DEV,
 		.procname	= "dev",
-		.maxlen		= 0,
 		.mode		= 0555,
 		.child		= rtc_root,
 	},
-- 
1.4.4.1.g278f

