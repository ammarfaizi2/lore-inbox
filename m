Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbUCEGsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 01:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUCEGso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 01:48:44 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:2466 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261834AbUCEGsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 01:48:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] NET: fix class reporting in TBF qdisc 
Date: Fri, 5 Mar 2004 01:47:37 -0500
User-Agent: KMail/1.6
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       marek cervenka <cer20um@axpsu.fpf.slu.cz>, linux-net@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
References: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk> <200403050144.17622.dtor_core@ameritech.net>
In-Reply-To: <200403050144.17622.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403050147.39657.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1648, 2004-03-05 01:02:36-05:00, dtor_core@ameritech.net
  NET: Fix class reporting in TBF qdisc


 sch_tbf.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
--- a/net/sched/sch_tbf.c	Fri Mar  5 01:26:33 2004
+++ b/net/sched/sch_tbf.c	Fri Mar  5 01:26:33 2004
@@ -434,8 +434,7 @@
 	if (cl != 1) 	/* only one class */ 
 		return -ENOENT;
     
-	tcm->tcm_parent = TC_H_ROOT;
-	tcm->tcm_handle = 1;
+	tcm->tcm_handle |= TC_H_MIN(1);
 	tcm->tcm_info = q->qdisc->handle;
 
 	return 0;
@@ -486,11 +485,9 @@
 
 static void tbf_walk(struct Qdisc *sch, struct qdisc_walker *walker)
 {
-	struct tbf_sched_data *q = (struct tbf_sched_data *)sch->data;
-
 	if (!walker->stop) {
-		if (walker->count >= walker->skip) 
-			if (walker->fn(sch, (unsigned long)q, walker) < 0) { 
+		if (walker->count >= walker->skip)
+			if (walker->fn(sch, 1, walker) < 0) {
 				walker->stop = 1;
 				return;
 			}
