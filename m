Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUCEGvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 01:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUCEGtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 01:49:46 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:40074 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262223AbUCEGsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 01:48:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] NET: fix class reporting in TBF qdisc
Date: Fri, 5 Mar 2004 01:48:20 -0500
User-Agent: KMail/1.6
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       marek cervenka <cer20um@axpsu.fpf.slu.cz>, linux-net@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
References: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk> <200403050144.17622.dtor_core@ameritech.net> <200403050147.39657.dtor_core@ameritech.net>
In-Reply-To: <200403050147.39657.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403050148.22964.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1649, 2004-03-05 01:18:18-05:00, dtor_core@ameritech.net
  NET: TBF trailing whitespace cleanup


 sch_tbf.c |   68 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 34 insertions(+), 34 deletions(-)


===================================================================



diff -Nru a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
--- a/net/sched/sch_tbf.c	Fri Mar  5 01:26:58 2004
+++ b/net/sched/sch_tbf.c	Fri Mar  5 01:26:58 2004
@@ -62,7 +62,7 @@
 
 	Algorithm.
 	----------
-	
+
 	Let N(t_i) be B/R initially and N(t) grow continuously with time as:
 
 	N(t+delta) = min{B/R, N(t) + delta}
@@ -146,15 +146,15 @@
 		if (sch->reshape_fail == NULL || sch->reshape_fail(skb, sch))
 #endif
 			kfree_skb(skb);
-	
+
 		return NET_XMIT_DROP;
 	}
-	
+
 	if ((ret = q->qdisc->enqueue(skb, q->qdisc)) != 0) {
 		sch->stats.drops++;
 		return ret;
-	}	
-	
+	}
+
 	sch->q.qlen++;
 	sch->stats.bytes += skb->len;
 	sch->stats.packets++;
@@ -165,10 +165,10 @@
 {
 	struct tbf_sched_data *q = (struct tbf_sched_data *)sch->data;
 	int ret;
-	
+
 	if ((ret = q->qdisc->ops->requeue(skb, q->qdisc)) == 0)
-		sch->q.qlen++; 
-	
+		sch->q.qlen++;
+
 	return ret;
 }
 
@@ -176,7 +176,7 @@
 {
 	struct tbf_sched_data *q = (struct tbf_sched_data *)sch->data;
 	unsigned int len;
-	
+
 	if ((len = q->qdisc->ops->drop(q->qdisc)) != 0) {
 		sch->q.qlen--;
 		sch->stats.drops++;
@@ -196,7 +196,7 @@
 {
 	struct tbf_sched_data *q = (struct tbf_sched_data *)sch->data;
 	struct sk_buff *skb;
-	
+
 	skb = q->qdisc->dequeue(q->qdisc);
 
 	if (skb) {
@@ -204,7 +204,7 @@
 		long toks;
 		long ptoks = 0;
 		unsigned int len = skb->len;
-		
+
 		PSCHED_GET_TIME(now);
 
 		toks = PSCHED_TDIFF_SAFE(now, q->t_c, q->buffer, 0);
@@ -248,13 +248,13 @@
 		   This is the main idea of all FQ algorithms
 		   (cf. CSZ, HPFQ, HFSC)
 		 */
-		
+
 		if (q->qdisc->ops->requeue(skb, q->qdisc) != NET_XMIT_SUCCESS) {
-			/* When requeue fails skb is dropped */ 
+			/* When requeue fails skb is dropped */
 			sch->q.qlen--;
 			sch->stats.drops++;
-		}	
-		
+		}
+
 		sch->flags |= TCQ_F_THROTTLED;
 		sch->stats.overlimits++;
 	}
@@ -279,24 +279,24 @@
 	struct Qdisc *q = qdisc_create_dflt(dev, &bfifo_qdisc_ops);
         struct rtattr *rta;
 	int ret;
-	
+
 	if (q) {
 		rta = kmalloc(RTA_LENGTH(sizeof(struct tc_fifo_qopt)), GFP_KERNEL);
 		if (rta) {
 			rta->rta_type = RTM_NEWQDISC;
 			rta->rta_len = RTA_LENGTH(sizeof(struct tc_fifo_qopt)); 
 			((struct tc_fifo_qopt *)RTA_DATA(rta))->limit = limit;
-			
+
 			ret = q->ops->change(q, rta);
 			kfree(rta);
-			
+
 			if (ret == 0)
 				return q;
 		}
 		qdisc_destroy(q);
 	}
 
-	return NULL;	
+	return NULL;
 }
 
 static int tbf_change(struct Qdisc* sch, struct rtattr *opt)
@@ -340,7 +340,7 @@
 	}
 	if (max_size < 0)
 		goto done;
-	
+
 	if (q->qdisc == &noop_qdisc) {
 		if ((child = tbf_create_dflt_qdisc(sch->dev, qopt->limit)) == NULL)
 			goto done;
@@ -369,17 +369,17 @@
 static int tbf_init(struct Qdisc* sch, struct rtattr *opt)
 {
 	struct tbf_sched_data *q = (struct tbf_sched_data *)sch->data;
-	
+
 	if (opt == NULL)
 		return -EINVAL;
-	
+
 	PSCHED_GET_TIME(q->t_c);
 	init_timer(&q->wd_timer);
 	q->wd_timer.function = tbf_watchdog;
 	q->wd_timer.data = (unsigned long)sch;
 
 	q->qdisc = &noop_qdisc;
-	
+
 	return tbf_change(sch, opt);
 }
 
@@ -393,7 +393,7 @@
 		qdisc_put_rtab(q->P_tab);
 	if (q->R_tab)
 		qdisc_put_rtab(q->R_tab);
-	
+
 	qdisc_destroy(q->qdisc);
 	q->qdisc = &noop_qdisc;
 }
@@ -404,10 +404,10 @@
 	unsigned char	 *b = skb->tail;
 	struct rtattr *rta;
 	struct tc_tbf_qopt opt;
-	
+
 	rta = (struct rtattr*)b;
 	RTA_PUT(skb, TCA_OPTIONS, 0, NULL);
-	
+
 	opt.limit = q->limit;
 	opt.rate = q->R_tab->rate;
 	if (q->P_tab)
@@ -427,13 +427,13 @@
 }
 
 static int tbf_dump_class(struct Qdisc *sch, unsigned long cl,
-	       		  struct sk_buff *skb, struct tcmsg *tcm)
+			  struct sk_buff *skb, struct tcmsg *tcm)
 {
 	struct tbf_sched_data *q = (struct tbf_sched_data*)sch->data;
 
-	if (cl != 1) 	/* only one class */ 
+	if (cl != 1) 	/* only one class */
 		return -ENOENT;
-    
+
 	tcm->tcm_handle |= TC_H_MIN(1);
 	tcm->tcm_info = q->qdisc->handle;
 
@@ -448,12 +448,12 @@
 	if (new == NULL)
 		new = &noop_qdisc;
 
-	sch_tree_lock(sch);	
+	sch_tree_lock(sch);
 	*old = xchg(&q->qdisc, new);
 	qdisc_reset(*old);
 	sch->q.qlen = 0;
 	sch_tree_unlock(sch);
-	
+
 	return 0;
 }
 
@@ -473,7 +473,7 @@
 }
 
 static int tbf_change_class(struct Qdisc *sch, u32 classid, u32 parentid, 
-			struct rtattr **tca, unsigned long *arg)
+			    struct rtattr **tca, unsigned long *arg)
 {
 	return -ENOSYS;
 }
@@ -497,7 +497,7 @@
 
 static struct Qdisc_class_ops tbf_class_ops =
 {
-	.graft		= 	tbf_graft,
+	.graft		=	tbf_graft,
 	.leaf		=	tbf_leaf,
 	.get		=	tbf_get,
 	.put		=	tbf_put,
@@ -529,7 +529,7 @@
 	return register_qdisc(&tbf_qdisc_ops);
 }
 
-static void __exit tbf_module_exit(void) 
+static void __exit tbf_module_exit(void)
 {
 	unregister_qdisc(&tbf_qdisc_ops);
 }
