Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWAQO6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWAQO6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWAQO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:58:19 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:28139 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751159AbWAQOue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:34 -0500
Message-Id: <20060117143324.692490000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:02 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 04/34] PID Virtualization Change pid accesses: include/.
Content-Disposition: inline; filename=B3-change-pid-tgid-references-include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change pid accesses under include/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 linux/reiserfs_fs.h |    2 +-
 net/scm.h           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.15/include/linux/reiserfs_fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/reiserfs_fs.h	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/include/linux/reiserfs_fs.h	2006-01-17 08:36:59.000000000 -0500
@@ -83,7 +83,7 @@
 if( !( cond ) ) 								\
   reiserfs_panic( NULL, "reiserfs[%i]: assertion " #cond " failed at "	\
 		  __FILE__ ":%i:%s: " format "\n",		\
-		  in_interrupt() ? -1 : current -> pid, __LINE__ , __FUNCTION__ , ##args )
+		  in_interrupt() ? -1 : task_pid(current), __LINE__ , __FUNCTION__ , ##args )
 
 #if defined( CONFIG_REISERFS_CHECK )
 #define RFALSE( cond, format, args... ) RASSERT( !( cond ), format, ##args )
Index: linux-2.6.15/include/net/scm.h
===================================================================
--- linux-2.6.15.orig/include/net/scm.h	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/include/net/scm.h	2006-01-17 08:36:59.000000000 -0500
@@ -40,7 +40,7 @@
 	memset(scm, 0, sizeof(*scm));
 	scm->creds.uid = current->uid;
 	scm->creds.gid = current->gid;
-	scm->creds.pid = current->tgid;
+	scm->creds.pid = task_tgid(current);
 	if (msg->msg_controllen <= 0)
 		return 0;
 	return __scm_send(sock, msg, scm);

--

