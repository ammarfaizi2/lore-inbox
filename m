Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVKNVcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVKNVcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVKNVcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61135 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932147AbVKNVcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:22 -0500
Message-Id: <20051114212526.678083000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:45 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 04/13] Change pid accesses: include/.
Content-Disposition: inline; filename=B3-change-pid-tgid-references-include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: include/.
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses under include/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 include/linux/reiserfs_fs.h |    2 +-
 include/net/scm.h           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc1/include/linux/reiserfs_fs.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/reiserfs_fs.h
+++ linux-2.6.15-rc1/include/linux/reiserfs_fs.h
@@ -83,7 +83,7 @@ void reiserfs_warning(struct super_block
 if( !( cond ) ) 								\
   reiserfs_panic( NULL, "reiserfs[%i]: assertion " #cond " failed at "	\
 		  __FILE__ ":%i:%s: " format "\n",		\
-		  in_interrupt() ? -1 : current -> pid, __LINE__ , __FUNCTION__ , ##args )
+		  in_interrupt() ? -1 : task_pid(current), __LINE__ , __FUNCTION__ , ##args )
 
 #if defined( CONFIG_REISERFS_CHECK )
 #define RFALSE( cond, format, args... ) RASSERT( !( cond ), format, ##args )
Index: linux-2.6.15-rc1/include/net/scm.h
===================================================================
--- linux-2.6.15-rc1.orig/include/net/scm.h
+++ linux-2.6.15-rc1/include/net/scm.h
@@ -40,7 +40,7 @@ static __inline__ int scm_send(struct so
 	memset(scm, 0, sizeof(*scm));
 	scm->creds.uid = current->uid;
 	scm->creds.gid = current->gid;
-	scm->creds.pid = current->tgid;
+	scm->creds.pid = task_tgid(current);
 	if (msg->msg_controllen <= 0)
 		return 0;
 	return __scm_send(sock, msg, scm);

--

