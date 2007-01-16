Return-Path: <linux-kernel-owner+w=401wt.eu-S1751590AbXAPQt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbXAPQt2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbXAPQtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:49:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38165 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbXAPQq2 (ORCPT
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
Subject: [PATCH 3/59] sysctl: sunrpc Remove unnecessary insert_at_head flag
Date: Tue, 16 Jan 2007 09:39:08 -0700
Message-Id: <11689656133336-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Because the sunrpc sysctls don't conflict with any other
sysctls the setting the insert at head flag to register_sysctl
has no semantic meaning.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 net/sunrpc/sysctl.c   |    2 +-
 net/sunrpc/xprtsock.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 82b2752..3852689 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -36,7 +36,7 @@ void
 rpc_register_sysctl(void)
 {
 	if (!sunrpc_table_header) {
-		sunrpc_table_header = register_sysctl_table(sunrpc_table, 1);
+		sunrpc_table_header = register_sysctl_table(sunrpc_table, 0);
 #ifdef CONFIG_PROC_FS
 		if (sunrpc_table[0].de)
 			sunrpc_table[0].de->owner = THIS_MODULE;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 49cabff..98d1af9 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1630,7 +1630,7 @@ int init_socket_xprt(void)
 {
 #ifdef RPC_DEBUG
 	if (!sunrpc_table_header) {
-		sunrpc_table_header = register_sysctl_table(sunrpc_table, 1);
+		sunrpc_table_header = register_sysctl_table(sunrpc_table, 0);
 #ifdef CONFIG_PROC_FS
 		if (sunrpc_table[0].de)
 			sunrpc_table[0].de->owner = THIS_MODULE;
-- 
1.4.4.1.g278f

