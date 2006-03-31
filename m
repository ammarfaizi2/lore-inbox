Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCaOx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCaOx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCaOx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:53:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24331 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751376AbWCaOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:53:57 -0500
Date: Fri, 31 Mar 2006 16:53:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ocfs2/dlm/dlmrecovery.c: make dlm_lockres_master_requery() static
Message-ID: <20060331145355.GF3893@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dlm_lockres_master_requery() became global without any external usage.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/dlm/dlmcommon.h   |    2 --
 fs/ocfs2/dlm/dlmrecovery.c |    8 ++++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.16-mm2-full/fs/ocfs2/dlm/dlmcommon.h.old	2006-03-31 15:46:51.000000000 +0200
+++ linux-2.6.16-mm2-full/fs/ocfs2/dlm/dlmcommon.h	2006-03-31 15:46:58.000000000 +0200
@@ -801,8 +801,6 @@
 int dlm_finalize_reco_handler(struct o2net_msg *msg, u32 len, void *data);
 int dlm_do_master_requery(struct dlm_ctxt *dlm, struct dlm_lock_resource *res,
 			  u8 nodenum, u8 *real_master);
-int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
-			       struct dlm_lock_resource *res, u8 *real_master);
 
 
 int dlm_dispatch_assert_master(struct dlm_ctxt *dlm,
--- linux-2.6.16-mm2-full/fs/ocfs2/dlm/dlmrecovery.c.old	2006-03-31 15:47:07.000000000 +0200
+++ linux-2.6.16-mm2-full/fs/ocfs2/dlm/dlmrecovery.c	2006-03-31 15:47:49.000000000 +0200
@@ -95,6 +95,9 @@
 static void dlm_request_all_locks_worker(struct dlm_work_item *item,
 					 void *data);
 static void dlm_mig_lockres_worker(struct dlm_work_item *item, void *data);
+static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
+				      struct dlm_lock_resource *res,
+				      u8 *real_master);
 
 static u64 dlm_get_next_mig_cookie(void);
 
@@ -1312,8 +1315,9 @@
 
 
 
-int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
-			       struct dlm_lock_resource *res, u8 *real_master)
+static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
+				      struct dlm_lock_resource *res,
+				      u8 *real_master)
 {
 	struct dlm_node_iter iter;
 	int nodenum;

