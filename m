Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWASVcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWASVcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWASVbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:31:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422644AbWASVbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:23 -0500
Date: Thu, 19 Jan 2006 15:30:54 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dlm: remove true false defines
Message-ID: <20060119213054.GD31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace TRUE/FALSE with 1/0.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/ast.c
===================================================================
--- linux.orig/drivers/dlm/ast.c
+++ linux/drivers/dlm/ast.c
@@ -56,7 +56,7 @@ static void process_asts(void)
 	int type = 0, found, bmode;
 
 	for (;;) {
-		found = FALSE;
+		found = 0;
 		spin_lock(&ast_queue_lock);
 		list_for_each_entry(lkb, &ast_queue, lkb_astqueue) {
 			r = lkb->lkb_resource;
@@ -68,7 +68,7 @@ static void process_asts(void)
 			list_del(&lkb->lkb_astqueue);
 			type = lkb->lkb_ast_type;
 			lkb->lkb_ast_type = 0;
-			found = TRUE;
+			found = 1;
 			break;
 		}
 		spin_unlock(&ast_queue_lock);
Index: linux/drivers/dlm/dir.c
===================================================================
--- linux.orig/drivers/dlm/dir.c
+++ linux/drivers/dlm/dir.c
@@ -33,7 +33,7 @@ static void put_free_de(struct dlm_ls *l
 
 static struct dlm_direntry *get_free_de(struct dlm_ls *ls, int len)
 {
-	int found = FALSE;
+	int found = 0;
 	struct dlm_direntry *de;
 
 	spin_lock(&ls->ls_recover_list_lock);
@@ -42,7 +42,7 @@ static struct dlm_direntry *get_free_de(
 			list_del(&de->list);
 			de->master_nodeid = 0;
 			memset(de->name, 0, len);
-			found = TRUE;
+			found = 1;
 			break;
 		}
 	}
Index: linux/drivers/dlm/dlm_internal.h
===================================================================
--- linux.orig/drivers/dlm/dlm_internal.h
+++ linux/drivers/dlm/dlm_internal.h
@@ -42,14 +42,6 @@
 
 #define DLM_LOCKSPACE_LEN	64
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #if (BITS_PER_LONG == 64)
 #define PRIx64 "lx"
 #else
Index: linux/drivers/dlm/lock.c
===================================================================
--- linux.orig/drivers/dlm/lock.c
+++ linux/drivers/dlm/lock.c
@@ -215,15 +215,15 @@ static inline int is_master_copy(struct 
 {
 	if (lkb->lkb_flags & DLM_IFL_MSTCPY)
 		DLM_ASSERT(lkb->lkb_nodeid, dlm_print_lkb(lkb););
-	return (lkb->lkb_flags & DLM_IFL_MSTCPY) ? TRUE : FALSE;
+	return (lkb->lkb_flags & DLM_IFL_MSTCPY) ? 1 : 0;
 }
 
 static inline int middle_conversion(struct dlm_lkb *lkb)
 {
 	if ((lkb->lkb_grmode==DLM_LOCK_PR && lkb->lkb_rqmode==DLM_LOCK_CW) ||
 	    (lkb->lkb_rqmode==DLM_LOCK_PR && lkb->lkb_grmode==DLM_LOCK_CW))
-		return TRUE;
-	return FALSE;
+		return 1;
+	return 0;
 }
 
 static inline int down_conversion(struct dlm_lkb *lkb)
@@ -775,14 +775,14 @@ static int shrink_bucket(struct dlm_ls *
 	int count = 0, found;
 
 	for (;;) {
-		found = FALSE;
+		found = 0;
 		write_lock(&ls->ls_rsbtbl[b].lock);
 		list_for_each_entry_reverse(r, &ls->ls_rsbtbl[b].toss,
 					    res_hashchain) {
 			if (!time_after_eq(jiffies, r->res_toss_time +
 					   dlm_config.toss_secs * HZ))
 				continue;
-			found = TRUE;
+			found = 1;
 			break;
 		}
 
@@ -1027,9 +1027,9 @@ static inline int first_in_list(struct d
 	struct dlm_lkb *first = list_entry(head->next, struct dlm_lkb,
 					   lkb_statequeue);
 	if (lkb->lkb_id == first->lkb_id)
-		return TRUE;
+		return 1;
 
-	return FALSE;
+	return 0;
 }
 
 /* Return 1 if the locks' ranges overlap.  If the lkb has no range then it is
@@ -1038,13 +1038,13 @@ static inline int first_in_list(struct d
 static inline int ranges_overlap(struct dlm_lkb *lkb1, struct dlm_lkb *lkb2)
 {
 	if (!lkb1->lkb_range || !lkb2->lkb_range)
-		return TRUE;
+		return 1;
 
 	if (lkb1->lkb_range[RQ_RANGE_END] < lkb2->lkb_range[GR_RANGE_START] ||
 	    lkb1->lkb_range[RQ_RANGE_START] > lkb2->lkb_range[GR_RANGE_END])
-		return FALSE;
+		return 0;
 
-	return TRUE;
+	return 1;
 }
 
 /* Check if the given lkb conflicts with another lkb on the queue. */
@@ -1057,9 +1057,9 @@ static int queue_conflict(struct list_he
 		if (this == lkb)
 			continue;
 		if (ranges_overlap(lkb, this) && !modes_compat(this, lkb))
-			return TRUE;
+			return 1;
 	}
-	return FALSE;
+	return 0;
 }
 
 /*
@@ -1103,7 +1103,7 @@ static int conversion_deadlock_detect(st
 			continue;
 
 		if (!modes_compat(this, lkb) && !modes_compat(lkb, this))
-			return TRUE;
+			return 1;
 	}
 
 	/* if lkb is on the convert queue and is preventing the first
@@ -1114,10 +1114,10 @@ static int conversion_deadlock_detect(st
 	if (self && self != first) {
 		if (!modes_compat(lkb, first) &&
 		    !queue_conflict(&rsb->res_grantqueue, first))
-			return TRUE;
+			return 1;
 	}
 
-	return FALSE;
+	return 0;
 }
 
 /*
@@ -1157,7 +1157,7 @@ static int _can_be_granted(struct dlm_rs
 	 */
 
 	if (lkb->lkb_exflags & DLM_LKF_EXPEDITE)
-		return TRUE;
+		return 1;
 
 	/*
 	 * A shortcut. Without this, !queue_conflict(grantqueue, lkb) would be
@@ -1200,7 +1200,7 @@ static int _can_be_granted(struct dlm_rs
 	 */
 
 	if (now && conv && !(lkb->lkb_exflags & DLM_LKF_QUECVT))
-		return TRUE;
+		return 1;
 
 	/*
 	 * When using range locks the NOORDER flag is set to avoid the standard
@@ -1208,7 +1208,7 @@ static int _can_be_granted(struct dlm_rs
 	 */
 
 	if (lkb->lkb_exflags & DLM_LKF_NOORDER)
-		return TRUE;
+		return 1;
 
 	/*
 	 * 6-3: Once in that queue [CONVERTING], a conversion request cannot be
@@ -1217,7 +1217,7 @@ static int _can_be_granted(struct dlm_rs
 	 */
 
 	if (!now && conv && first_in_list(lkb, &r->res_convertqueue))
-		return TRUE;
+		return 1;
 
 	/*
 	 * 6-4: By default, a new request is immediately granted only if all
@@ -1232,7 +1232,7 @@ static int _can_be_granted(struct dlm_rs
 
 	if (now && !conv && list_empty(&r->res_convertqueue) &&
 	    list_empty(&r->res_waitqueue))
-		return TRUE;
+		return 1;
 
 	/*
 	 * 6-4: Once a lock request is in the queue of ungranted new requests,
@@ -1244,7 +1244,7 @@ static int _can_be_granted(struct dlm_rs
 
 	if (!now && !conv && list_empty(&r->res_convertqueue) &&
 	    first_in_list(lkb, &r->res_waitqueue))
-		return TRUE;
+		return 1;
 
  out:
 	/*
@@ -1257,7 +1257,7 @@ static int _can_be_granted(struct dlm_rs
 		lkb->lkb_sbflags |= DLM_SBF_DEMOTED;
 	}
 
-	return FALSE;
+	return 0;
 }
 
 /*
@@ -1308,7 +1308,7 @@ static int grant_pending_convert(struct 
 
 	list_for_each_entry_safe(lkb, s, &r->res_convertqueue, lkb_statequeue) {
 		demoted = is_demoted(lkb);
-		if (can_be_granted(r, lkb, FALSE)) {
+		if (can_be_granted(r, lkb, 0)) {
 			grant_lock_pending(r, lkb);
 			grant_restart = 1;
 		} else {
@@ -1333,7 +1333,7 @@ static int grant_pending_wait(struct dlm
 	struct dlm_lkb *lkb, *s;
 
 	list_for_each_entry_safe(lkb, s, &r->res_waitqueue, lkb_statequeue) {
-		if (can_be_granted(r, lkb, FALSE))
+		if (can_be_granted(r, lkb, 0))
 			grant_lock_pending(r, lkb);
                 else
 			high = max_t(int, lkb->lkb_rqmode, high);
@@ -1705,7 +1705,7 @@ static int do_request(struct dlm_rsb *r,
 {
 	int error = 0;
 
-	if (can_be_granted(r, lkb, TRUE)) {
+	if (can_be_granted(r, lkb, 1)) {
 		grant_lock(r, lkb);
 		queue_cast(r, lkb, 0);
 		goto out;
@@ -1733,7 +1733,7 @@ static int do_convert(struct dlm_rsb *r,
 
 	/* changing an existing lock may allow others to be granted */
 
-	if (can_be_granted(r, lkb, TRUE)) {
+	if (can_be_granted(r, lkb, 1)) {
 		grant_lock(r, lkb);
 		queue_cast(r, lkb, 0);
 		grant_pending_locks(r);
@@ -2556,7 +2556,7 @@ static void receive_convert(struct dlm_l
 {
 	struct dlm_lkb *lkb;
 	struct dlm_rsb *r;
-	int error, reply = TRUE;
+	int error, reply = 1;
 
 	error = find_lkb(ls, ms->m_remid, &lkb);
 	if (error)
Index: linux/drivers/dlm/member.c
===================================================================
--- linux.orig/drivers/dlm/member.c
+++ linux/drivers/dlm/member.c
@@ -79,9 +79,9 @@ static int dlm_is_member(struct dlm_ls *
 
 	list_for_each_entry(memb, &ls->ls_nodes, list) {
 		if (memb->nodeid == nodeid)
-			return TRUE;
+			return 1;
 	}
-	return FALSE;
+	return 0;
 }
 
 int dlm_is_removed(struct dlm_ls *ls, int nodeid)
@@ -90,9 +90,9 @@ int dlm_is_removed(struct dlm_ls *ls, in
 
 	list_for_each_entry(memb, &ls->ls_nodes_gone, list) {
 		if (memb->nodeid == nodeid)
-			return TRUE;
+			return 1;
 	}
-	return FALSE;
+	return 0;
 }
 
 static void clear_memb_list(struct list_head *head)
@@ -178,10 +178,10 @@ int dlm_recover_members(struct dlm_ls *l
 	/* move departed members from ls_nodes to ls_nodes_gone */
 
 	list_for_each_entry_safe(memb, safe, &ls->ls_nodes, list) {
-		found = FALSE;
+		found = 0;
 		for (i = 0; i < rv->node_count; i++) {
 			if (memb->nodeid == rv->nodeids[i]) {
-				found = TRUE;
+				found = 1;
 				break;
 			}
 		}
Index: linux/drivers/dlm/midcomms.c
===================================================================
--- linux.orig/drivers/dlm/midcomms.c
+++ linux/drivers/dlm/midcomms.c
@@ -119,7 +119,7 @@ int dlm_process_incoming_buffer(int node
 
 		switch (msg->h_cmd) {
 		case DLM_MSG:
-			dlm_receive_message(msg, nodeid, FALSE);
+			dlm_receive_message(msg, nodeid, 0);
 			break;
 
 		case DLM_RCOM:
Index: linux/drivers/dlm/recover.c
===================================================================
--- linux.orig/drivers/dlm/recover.c
+++ linux/drivers/dlm/recover.c
@@ -477,8 +477,8 @@ static int all_queues_empty(struct dlm_r
 	if (!list_empty(&r->res_grantqueue) ||
 	    !list_empty(&r->res_convertqueue) ||
 	    !list_empty(&r->res_waitqueue))
-		return FALSE;
-	return TRUE;
+		return 0;
+	return 1;
 }
 
 static int recover_locks(struct dlm_rsb *r)
@@ -586,18 +586,18 @@ static void recover_lvb(struct dlm_rsb *
 {
 	struct dlm_lkb *lkb, *high_lkb = NULL;
 	uint32_t high_seq = 0;
-	int lock_lvb_exists = FALSE;
-	int big_lock_exists = FALSE;
+	int lock_lvb_exists = 0;
+	int big_lock_exists = 0;
 	int lvblen = r->res_ls->ls_lvblen;
 
 	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
 		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
-		lock_lvb_exists = TRUE;
+		lock_lvb_exists = 1;
 
 		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = TRUE;
+			big_lock_exists = 1;
 			goto setflag;
 		}
 
@@ -611,10 +611,10 @@ static void recover_lvb(struct dlm_rsb *
 		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
-		lock_lvb_exists = TRUE;
+		lock_lvb_exists = 1;
 
 		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = TRUE;
+			big_lock_exists = 1;
 			goto setflag;
 		}
 
Index: linux/drivers/dlm/requestqueue.c
===================================================================
--- linux.orig/drivers/dlm/requestqueue.c
+++ linux/drivers/dlm/requestqueue.c
@@ -70,7 +70,7 @@ int dlm_process_requestqueue(struct dlm_
 		up(&ls->ls_requestqueue_lock);
 
 		hd = (struct dlm_header *) e->request;
-		error = dlm_receive_message(hd, e->nodeid, TRUE);
+		error = dlm_receive_message(hd, e->nodeid, 1);
 
 		if (error == -EINTR) {
 			/* entry is left on requestqueue */
