Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSJ2T1j>; Tue, 29 Oct 2002 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJ2T0x>; Tue, 29 Oct 2002 14:26:53 -0500
Received: from kathmandu.sun.com ([192.18.98.36]:43427 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id <S262194AbSJ2T01>;
	Tue, 29 Oct 2002 14:26:27 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210291932.g9TJWnc30637@scl2.sfbay.sun.com>
Subject: [BK PATCH 4/4] fix NGROUPS hard limit (resend)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 29 Oct 2002 11:32:49 -0800 (PST)
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
