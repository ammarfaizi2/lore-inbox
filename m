Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSJVAcM>; Mon, 21 Oct 2002 20:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261846AbSJVAbz>; Mon, 21 Oct 2002 20:31:55 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:19703 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S261849AbSJVAac>; Mon, 21 Oct 2002 20:30:32 -0400
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210220036.g9M0aT431407@scl2.sfbay.sun.com>
Subject: [BK PATCH 4/4] fix NGROUPS hard limit (resend)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2002 17:36:29 -0700 (PDT)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.811   -> 1.812  
#	include/linux/nfsiod.h	1.1     ->         (deleted)      
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/21	thockin@freakshow.cobalt.com	1.812
# no one references nfsiod.h anymore - nix it.
# --------------------------------------------
#
diff -Nru a/include/linux/nfsiod.h b/include/linux/nfsiod.h
--- a/include/linux/nfsiod.h	Mon Oct 21 17:14:31 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,52 +0,0 @@
-/*
- * linux/include/linux/nfsiod.h
- *
- * Declarations for asynchronous NFS RPC calls.
- *
- */
-
-#ifndef _LINUX_NFSIOD_H
-#define _LINUX_NFSIOD_H
-
-#include <linux/rpcsock.h>
-#include <linux/nfs_fs.h>
-
-#ifdef __KERNEL__
-
-/*
- * This is the callback handler for nfsiod requests.
- * Note that the callback procedure must NOT sleep.
- */
-struct nfsiod_req;
-typedef int	(*nfsiod_callback_t)(int result, struct nfsiod_req *);
-
-/*
- * This is the nfsiod request struct.
- */
-struct nfsiod_req {
-	struct nfsiod_req *	rq_next;
-	struct nfsiod_req *	rq_prev;
-	wait_queue_head_t	rq_wait;
-	struct rpc_ioreq	rq_rpcreq;
-	nfsiod_callback_t	rq_callback;
-	struct nfs_server *	rq_server;
-	struct inode *		rq_inode;
-	struct page *		rq_page;
-
-	/* user creds */
-	uid_t			rq_fsuid;
-	gid_t			rq_fsgid;
-	int			rq_groups[NGROUPS];
-
-	/* retry handling */
-	int			rq_retries;
-};
-
-struct nfsiod_req *	nfsiod_reserve(struct nfs_server *);
-void			nfsiod_release(struct nfsiod_req *);
-void			nfsiod_enqueue(struct nfsiod_req *);
-int			nfsiod(void);
-
-
-#endif /* __KERNEL__ */
-#endif /* _LINUX_NFSIOD_H */
