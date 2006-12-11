Return-Path: <linux-kernel-owner+w=401wt.eu-S937566AbWLKTJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937566AbWLKTJy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937575AbWLKTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:09:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4072 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937566AbWLKTJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:09:52 -0500
Date: Mon, 11 Dec 2006 20:10:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [RFC: -mm patch] OCFS2: make code static
Message-ID: <20061211191001.GF28443@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
>  git-ocfs2.patch
>...
>  git trees.
>...

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/cluster/tcp.c   |    2 +-
 fs/ocfs2/dlm/dlmcommon.h |    6 ------
 fs/ocfs2/dlm/dlmmaster.c |    8 +++++---
 fs/ocfs2/dlm/dlmthread.c |    3 ++-
 4 files changed, 8 insertions(+), 11 deletions(-)

--- linux-2.6.19-mm1/fs/ocfs2/cluster/tcp.c.old	2006-12-11 18:34:09.000000000 +0100
+++ linux-2.6.19-mm1/fs/ocfs2/cluster/tcp.c	2006-12-11 18:34:19.000000000 +0100
@@ -380,7 +380,7 @@
 		sc_put(sc);
 }
 
-atomic_t o2net_connected_peers = ATOMIC_INIT(0);
+static atomic_t o2net_connected_peers = ATOMIC_INIT(0);
 
 int o2net_num_connected_peers(void)
 {
--- linux-2.6.19-mm1/fs/ocfs2/dlm/dlmcommon.h.old	2006-12-11 18:34:44.000000000 +0100
+++ linux-2.6.19-mm1/fs/ocfs2/dlm/dlmcommon.h	2006-12-11 18:36:22.000000000 +0100
@@ -739,8 +739,6 @@
 			      struct dlm_lock_resource *res);
 void dlm_lockres_calc_usage(struct dlm_ctxt *dlm,
 			    struct dlm_lock_resource *res);
-int dlm_purge_lockres(struct dlm_ctxt *dlm,
-		      struct dlm_lock_resource *lockres);
 static inline void dlm_lockres_get(struct dlm_lock_resource *res)
 {
 	/* This is called on every lookup, so it might be worth
@@ -864,10 +862,6 @@
 void dlm_hb_node_down_cb(struct o2nm_node *node, int idx, void *data);
 void dlm_hb_node_up_cb(struct o2nm_node *node, int idx, void *data);
 
-int dlm_lockres_is_dirty(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
-int dlm_migrate_lockres(struct dlm_ctxt *dlm,
-			struct dlm_lock_resource *res,
-			u8 target);
 int dlm_empty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
 int dlm_finish_migration(struct dlm_ctxt *dlm,
 			 struct dlm_lock_resource *res,
--- linux-2.6.19-mm1/fs/ocfs2/dlm/dlmmaster.c.old	2006-12-11 18:35:13.000000000 +0100
+++ linux-2.6.19-mm1/fs/ocfs2/dlm/dlmmaster.c	2006-12-11 18:37:28.000000000 +0100
@@ -2327,8 +2327,9 @@
  */
 
 
-int dlm_migrate_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res,
-			u8 target)
+static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
+			       struct dlm_lock_resource *res,
+			       u8 target)
 {
 	struct dlm_master_list_entry *mle = NULL;
 	struct dlm_master_list_entry *oldmle = NULL;
@@ -2676,7 +2677,8 @@
 	return can_proceed;
 }
 
-int dlm_lockres_is_dirty(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
+static int dlm_lockres_is_dirty(struct dlm_ctxt *dlm,
+				struct dlm_lock_resource *res)
 {
 	int ret;
 	spin_lock(&res->spinlock);
--- linux-2.6.19-mm1/fs/ocfs2/dlm/dlmthread.c.old	2006-12-11 18:36:29.000000000 +0100
+++ linux-2.6.19-mm1/fs/ocfs2/dlm/dlmthread.c	2006-12-11 18:36:41.000000000 +0100
@@ -154,7 +154,8 @@
 	spin_unlock(&dlm->spinlock);
 }
 
-int dlm_purge_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
+static int dlm_purge_lockres(struct dlm_ctxt *dlm,
+			     struct dlm_lock_resource *res)
 {
 	int master;
 	int ret = 0;

