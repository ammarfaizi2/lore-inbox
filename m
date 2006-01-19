Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWASVbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWASVbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWASVbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:31:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422643AbWASVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:20 -0500
Date: Thu, 19 Jan 2006 15:30:57 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dlm: printk with ll
Message-ID: <20060119213057.GE31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use ll printk format for 64 bit values.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/debug_fs.c
===================================================================
--- linux.orig/drivers/dlm/debug_fs.c
+++ linux/drivers/dlm/debug_fs.c
@@ -63,12 +63,12 @@ static void print_lock(struct seq_file *
 		/* FIXME: this warns on Alpha */
 		if (lkb->lkb_status == DLM_LKSTS_CONVERT
 		    || lkb->lkb_status == DLM_LKSTS_GRANTED)
-			seq_printf(s, " %" PRIx64 "-%" PRIx64,
+			seq_printf(s, " %llx-%llx",
 				   lkb->lkb_range[GR_RANGE_START],
 				   lkb->lkb_range[GR_RANGE_END]);
 		if (lkb->lkb_status == DLM_LKSTS_CONVERT
 		    || lkb->lkb_status == DLM_LKSTS_WAITING)
-			seq_printf(s, " (%" PRIx64 "-%" PRIx64 ")",
+			seq_printf(s, " (%llx-%llx)",
 				   lkb->lkb_range[RQ_RANGE_START],
 				   lkb->lkb_range[RQ_RANGE_END]);
 	}
Index: linux/drivers/dlm/dlm_internal.h
===================================================================
--- linux.orig/drivers/dlm/dlm_internal.h
+++ linux/drivers/dlm/dlm_internal.h
@@ -42,12 +42,6 @@
 
 #define DLM_LOCKSPACE_LEN	64
 
-#if (BITS_PER_LONG == 64)
-#define PRIx64 "lx"
-#else
-#define PRIx64 "Lx"
-#endif
-
 /* Size of the temp buffer midcomms allocates on the stack.
    We try to make this large enough so most messages fit.
    FIXME: should sctp make this unnecessary? */
Index: linux/drivers/dlm/recover.c
===================================================================
--- linux.orig/drivers/dlm/recover.c
+++ linux/drivers/dlm/recover.c
@@ -420,7 +420,7 @@ int dlm_recover_master_reply(struct dlm_
 
 	r = recover_list_find(ls, rc->rc_id);
 	if (!r) {
-		log_error(ls, "dlm_recover_master_reply no id %"PRIx64"",
+		log_error(ls, "dlm_recover_master_reply no id %llx",
 			  rc->rc_id);
 		goto out;
 	}
Index: linux/drivers/dlm/recoverd.c
===================================================================
--- linux.orig/drivers/dlm/recoverd.c
+++ linux/drivers/dlm/recoverd.c
@@ -45,7 +45,7 @@ static int ls_recover(struct dlm_ls *ls,
 	unsigned long start;
 	int error, neg = 0;
 
-	log_debug(ls, "recover %"PRIx64"", rv->seq);
+	log_debug(ls, "recover %llx", rv->seq);
 
 	down(&ls->ls_recoverd_active);
 
@@ -199,7 +199,7 @@ static int ls_recover(struct dlm_ls *ls,
 
 	dlm_astd_wake();
 
-	log_debug(ls, "recover %"PRIx64" done: %u ms", rv->seq,
+	log_debug(ls, "recover %llx done: %u ms", rv->seq,
 		  jiffies_to_msecs(jiffies - start));
 	up(&ls->ls_recoverd_active);
 
@@ -207,7 +207,7 @@ static int ls_recover(struct dlm_ls *ls,
 
  fail:
 	dlm_release_root_list(ls);
-	log_debug(ls, "recover %"PRIx64" error %d", rv->seq, error);
+	log_debug(ls, "recover %llx error %d", rv->seq, error);
 	up(&ls->ls_recoverd_active);
 	return error;
 }
