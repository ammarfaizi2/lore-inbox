Return-Path: <linux-kernel-owner+w=401wt.eu-S1751847AbXAPQ4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbXAPQ4q (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbXAPQy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:54:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46007 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbXAPQtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:49:39 -0500
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
Subject: [PATCH 48/59] sysctl: Register the ocfs2 sysctl numbers
Date: Tue, 16 Jan 2007 09:39:53 -0700
Message-Id: <11689656823041-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

ocfs2 was did not have the binary number it uses under CTL_FS
registered in sysctl.h.  Register it to avoid future conflicts,
and change the name of the definition to be in line with the
rest of the sysctl numbers.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/ocfs2/cluster/nodemanager.c |    4 ++--
 fs/ocfs2/cluster/nodemanager.h |    3 +--
 include/linux/sysctl.h         |    1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index b17333a..df763c7 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -55,7 +55,7 @@ static ctl_table ocfs2_nm_table[] = {
 
 static ctl_table ocfs2_mod_table[] = {
 	{
-		.ctl_name	= KERN_OCFS2_NM,
+		.ctl_name	= FS_OCFS2_NM,
 		.procname	= "nm",
 		.data		= NULL,
 		.maxlen		= 0,
@@ -67,7 +67,7 @@ static ctl_table ocfs2_mod_table[] = {
 
 static ctl_table ocfs2_kern_table[] = {
 	{
-		.ctl_name	= KERN_OCFS2,
+		.ctl_name	= FS_OCFS2,
 		.procname	= "ocfs2",
 		.data		= NULL,
 		.maxlen		= 0,
diff --git a/fs/ocfs2/cluster/nodemanager.h b/fs/ocfs2/cluster/nodemanager.h
index 8fb23ca..0705221 100644
--- a/fs/ocfs2/cluster/nodemanager.h
+++ b/fs/ocfs2/cluster/nodemanager.h
@@ -33,8 +33,7 @@
 #include <linux/configfs.h>
 #include <linux/rbtree.h>
 
-#define KERN_OCFS2		988
-#define KERN_OCFS2_NM		1
+#define FS_OCFS2_NM		1
 
 const char *o2nm_get_hb_ctl_path(void);
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index f4ba72e..63e1bac 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -813,6 +813,7 @@ enum
 	FS_AIO_NR=18,	/* current system-wide number of aio requests */
 	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
 	FS_INOTIFY=20,	/* inotify submenu */
+	FS_OCFS2=988,	/* ocfs2 */
 };
 
 /* /proc/sys/fs/quota/ */
-- 
1.4.4.1.g278f

