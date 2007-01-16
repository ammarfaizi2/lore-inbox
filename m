Return-Path: <linux-kernel-owner+w=401wt.eu-S1751355AbXAPQyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbXAPQyd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbXAPQyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:54:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46004 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbXAPQth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:49:37 -0500
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
Subject: [PATCH 54/59] sysctl: Remove support for directory strategy routines.
Date: Tue, 16 Jan 2007 09:39:59 -0700
Message-Id: <11689656993630-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

parse_table has support for calling a strategy routine
when descending into a directory.  To date no one has
used this functionality and the /proc/sys interface has
no analog to it.

So no one is using this functionality kill it and make
the binary sysctl code easier to follow.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/sysctl.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e655b11..2c3703d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1171,14 +1171,6 @@ repeat:
 			if (table->child) {
 				if (ctl_perm(table, 001))
 					return -EPERM;
-				if (table->strategy) {
-					error = table->strategy(
-						table, name, nlen,
-						oldval, oldlenp,
-						newval, newlen);
-					if (error)
-						return error;
-				}
 				name++;
 				nlen--;
 				table = table->child;
-- 
1.4.4.1.g278f

