Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbULOBic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbULOBic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbULOBhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:37:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54542 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261834AbULOB15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:27:57 -0500
Date: Wed, 15 Dec 2004 02:27:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/sched/: possible cleanups
Message-ID: <20041215012754.GH12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contans the following possible cleanups:
- make some needlessly global code static
- sch_htb.c: #undef HTB_DEBUG


diffstat output:
 include/net/act_api.h   |    3 ---
 net/sched/gact.c        |    2 +-
 net/sched/police.c      |    8 ++++----
 net/sched/sch_api.c     |   11 ++++++-----
 net/sched/sch_dsmark.c  |    2 +-
 net/sched/sch_generic.c |    4 ++--
 net/sched/sch_htb.c     |    2 +-
 net/sched/sch_ingress.c |    2 +-
 net/sched/sch_prio.c    |    3 ++-
 9 files changed, 18 insertions(+), 19 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/sched/gact.c.old	2004-12-14 22:32:34.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/gact.c	2004-12-14 22:32:42.000000000 +0100
@@ -68,7 +68,7 @@
 }
 
 
-g_rand gact_rand[MAX_RAND]= { NULL,gact_net_rand, gact_determ};
+static g_rand gact_rand[MAX_RAND]= { NULL,gact_net_rand, gact_determ};
 
 #endif
 static int
--- linux-2.6.10-rc3-mm1-full/include/net/act_api.h.old	2004-12-14 22:33:02.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/act_api.h	2004-12-14 22:33:14.000000000 +0100
@@ -82,9 +82,6 @@
 extern int tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int, int);
 extern int tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int, int);
 extern int tcf_action_copy_stats (struct sk_buff *,struct tc_action *);
-extern int tcf_act_police_locate(struct rtattr *rta, struct rtattr *est,struct tc_action *,int , int );
-extern int tcf_act_police_dump(struct sk_buff *, struct tc_action *, int, int);
-extern int tcf_act_police(struct sk_buff **skb, struct tc_action *a);
 #endif /* CONFIG_NET_CLS_ACT */
 
 extern int tcf_police(struct sk_buff *skb, struct tcf_police *p);
--- linux-2.6.10-rc3-mm1-full/net/sched/police.c.old	2004-12-14 22:33:22.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/police.c	2004-12-14 22:33:39.000000000 +0100
@@ -163,7 +163,7 @@
 }
 
 #ifdef CONFIG_NET_CLS_ACT
-int tcf_act_police_locate(struct rtattr *rta, struct rtattr *est,struct tc_action *a, int ovr, int bind)
+static int tcf_act_police_locate(struct rtattr *rta, struct rtattr *est,struct tc_action *a, int ovr, int bind)
 {
 	unsigned h;
 	int ret = 0;
@@ -265,7 +265,7 @@
 	return -1;
 }
 
-int tcf_act_police_cleanup(struct tc_action *a, int bind)
+static int tcf_act_police_cleanup(struct tc_action *a, int bind)
 {
 	struct tcf_police *p;
 	p = PRIV(a);
@@ -275,7 +275,7 @@
 	return 0;
 }
 
-int tcf_act_police(struct sk_buff **pskb, struct tc_action *a)
+static int tcf_act_police(struct sk_buff **pskb, struct tc_action *a)
 {
 	psched_time_t now;
 	struct sk_buff *skb = *pskb;
@@ -338,7 +338,7 @@
 	return p->action;
 }
 
-int tcf_act_police_dump(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
+static int tcf_act_police_dump(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
 {
 	unsigned char	 *b = skb->tail;
 	struct tc_police opt;
--- linux-2.6.10-rc3-mm1-full/net/sched/sch_api.c.old	2004-12-14 22:36:33.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/sch_api.c	2004-12-14 22:39:03.000000000 +0100
@@ -207,7 +207,7 @@
 	return NULL;
 }
 
-struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid)
+static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid)
 {
 	unsigned long cl;
 	struct Qdisc *leaf;
@@ -226,7 +226,7 @@
 
 /* Find queueing discipline by name */
 
-struct Qdisc_ops *qdisc_lookup_ops(struct rtattr *kind)
+static struct Qdisc_ops *qdisc_lookup_ops(struct rtattr *kind)
 {
 	struct Qdisc_ops *q = NULL;
 
@@ -290,7 +290,7 @@
 
 /* Allocate an unique handle from space managed by kernel */
 
-u32 qdisc_alloc_handle(struct net_device *dev)
+static u32 qdisc_alloc_handle(struct net_device *dev)
 {
 	int i = 0x10000;
 	static u32 autohandle = TC_H_MAKE(0x80000000U, 0);
@@ -356,8 +356,9 @@
    Old qdisc is not destroyed but returned in *old.
  */
 
-int qdisc_graft(struct net_device *dev, struct Qdisc *parent, u32 classid,
-		struct Qdisc *new, struct Qdisc **old)
+static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
+		       u32 classid,
+		       struct Qdisc *new, struct Qdisc **old)
 {
 	int err = 0;
 	struct Qdisc *q = *old;
--- linux-2.6.10-rc3-mm1-full/net/sched/sch_dsmark.c.old	2004-12-14 22:39:16.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/sch_dsmark.c	2004-12-14 22:39:24.000000000 +0100
@@ -320,7 +320,7 @@
 }
 
 
-int dsmark_init(struct Qdisc *sch,struct rtattr *opt)
+static int dsmark_init(struct Qdisc *sch,struct rtattr *opt)
 {
 	struct dsmark_qdisc_data *p = PRIV(sch);
 	struct rtattr *tb[TCA_DSMARK_MAX];
--- linux-2.6.10-rc3-mm1-full/net/sched/sch_generic.c.old	2004-12-14 22:39:41.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/sch_generic.c	2004-12-14 22:40:00.000000000 +0100
@@ -283,7 +283,7 @@
 	.list		=	LIST_HEAD_INIT(noop_qdisc.list),
 };
 
-struct Qdisc_ops noqueue_qdisc_ops = {
+static struct Qdisc_ops noqueue_qdisc_ops = {
 	.next		=	NULL,
 	.cl_ops		=	NULL,
 	.id		=	"noqueue",
@@ -294,7 +294,7 @@
 	.owner		=	THIS_MODULE,
 };
 
-struct Qdisc noqueue_qdisc = {
+static struct Qdisc noqueue_qdisc = {
 	.enqueue	=	NULL,
 	.dequeue	=	noop_dequeue,
 	.flags		=	TCQ_F_BUILTIN,
--- linux-2.6.10-rc3-mm1-full/net/sched/sch_ingress.c.old	2004-12-14 22:40:25.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/sch_ingress.c	2004-12-14 22:40:34.000000000 +0100
@@ -274,7 +274,7 @@
 #endif
 #endif
 
-int ingress_init(struct Qdisc *sch,struct rtattr *opt)
+static int ingress_init(struct Qdisc *sch,struct rtattr *opt)
 {
 	struct ingress_qdisc_data *p = PRIV(sch);
 
--- linux-2.6.10-rc3-mm1-full/net/sched/sch_prio.c.old	2004-12-14 22:40:49.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/sch_prio.c	2004-12-14 22:41:03.000000000 +0100
@@ -47,7 +47,8 @@
 };
 
 
-struct Qdisc *prio_classify(struct sk_buff *skb, struct Qdisc *sch,int *r)
+static struct Qdisc *prio_classify(struct sk_buff *skb,
+				   struct Qdisc *sch, int *r)
 {
 	struct prio_sched_data *q = qdisc_priv(sch);
 	u32 band = skb->priority;
--- linux-2.6.10-rc3-mm1-full/net/sched/sch_htb.c.old	2004-12-14 22:41:56.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/sched/sch_htb.c	2004-12-14 23:46:12.000000000 +0100
@@ -71,7 +71,7 @@
 
 #define HTB_HSIZE 16	/* classid hash size */
 #define HTB_EWMAC 2	/* rate average over HTB_EWMAC*HTB_HSIZE sec */
-#define HTB_DEBUG 1	/* compile debugging support (activated by tc tool) */
+#undef HTB_DEBUG	/* compile debugging support (activated by tc tool) */
 #define HTB_RATECM 1    /* whether to use rate computer */
 #define HTB_HYSTERESIS 1/* whether to use mode hysteresis for speedup */
 #define HTB_QLOCK(S) spin_lock_bh(&(S)->dev->queue_lock)

