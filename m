Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVAXU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVAXU30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAXU10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:27:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52229 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261625AbVAXU0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:26:06 -0500
Date: Mon, 24 Jan 2005 21:26:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/lockd/clntproc.c: make 2 functions static
Message-ID: <20050124202603.GX3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/lockd/clntproc.c         |    4 ++--
 include/linux/lockd/lockd.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

This patch was already sent on:
- 8 Jan 2005

--- linux-2.6.10-mm2-full/include/linux/lockd/lockd.h.old	2005-01-08 04:29:36.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/lockd/lockd.h	2005-01-08 04:30:09.000000000 +0100
@@ -143,8 +143,6 @@
  * Lockd client functions
  */
 struct nlm_rqst * nlmclnt_alloc_call(void);
-int		  nlmclnt_call(struct nlm_rqst *, u32);
-int		  nlmclnt_async_call(struct nlm_rqst *, u32, rpc_action);
 int		  nlmclnt_block(struct nlm_host *, struct file_lock *, u32 *);
 int		  nlmclnt_cancel(struct nlm_host *, struct file_lock *);
 u32		  nlmclnt_grant(struct nlm_lock *);
--- linux-2.6.10-mm2-full/fs/lockd/clntproc.c.old	2005-01-08 04:29:49.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/lockd/clntproc.c	2005-01-08 04:30:15.000000000 +0100
@@ -322,7 +322,7 @@
 /*
  * Generic NLM call
  */
-int
+static int
 nlmclnt_call(struct nlm_rqst *req, u32 proc)
 {
 	struct nlm_host	*host = req->a_host;
@@ -428,7 +428,7 @@
 	return status;
 }
 
-int
+static int
 nlmclnt_async_call(struct nlm_rqst *req, u32 proc, rpc_action callback)
 {
 	struct nlm_host	*host = req->a_host;

