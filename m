Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVGGVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVGGVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVGGVbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:31:05 -0400
Received: from coderock.org ([193.77.147.115]:12428 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262074AbVGGVaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:30:17 -0400
Message-Id: <20050707212956.660238000@homer>
Date: Thu, 07 Jul 2005 23:29:54 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 3/4] cfq-iosched: fix sparse warnings (__nocast type)
Content-Disposition: inline; filename=sparse-drivers_block_cfq-iosched
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: drivers/block/cfq-iosched

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 cfq-iosched.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: quilt/drivers/block/cfq-iosched.c
===================================================================
--- quilt.orig/drivers/block/cfq-iosched.c
+++ quilt/drivers/block/cfq-iosched.c
@@ -1415,7 +1415,7 @@ static void cfq_exit_io_context(struct c
 }
 
 static struct cfq_io_context *
-cfq_alloc_io_context(struct cfq_data *cfqd, int gfp_mask)
+cfq_alloc_io_context(struct cfq_data *cfqd, unsigned int __nocast gfp_mask)
 {
 	struct cfq_io_context *cic = kmem_cache_alloc(cfq_ioc_pool, gfp_mask);
 
@@ -1510,7 +1510,7 @@ static int cfq_ioc_set_ioprio(struct io_
 
 static struct cfq_queue *
 cfq_get_queue(struct cfq_data *cfqd, unsigned int key, unsigned short ioprio,
-	      int gfp_mask)
+	      unsigned int __nocast gfp_mask)
 {
 	const int hashval = hash_long(key, CFQ_QHASH_SHIFT);
 	struct cfq_queue *cfqq, *new_cfqq = NULL;
@@ -1571,7 +1571,7 @@ out:
  * cfqq, so we don't need to worry about it disappearing
  */
 static struct cfq_io_context *
-cfq_get_io_context(struct cfq_data *cfqd, pid_t pid, int gfp_mask)
+cfq_get_io_context(struct cfq_data *cfqd, pid_t pid, unsigned int __nocast gfp_mask)
 {
 	struct io_context *ioc = NULL;
 	struct cfq_io_context *cic;
@@ -2063,7 +2063,7 @@ static void cfq_put_request(request_queu
  */
 static int
 cfq_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		int gfp_mask)
+		unsigned int __nocast gfp_mask)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;

--
