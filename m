Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVFIFVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVFIFVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 01:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVFIFVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 01:21:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32928 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262276AbVFIFVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 01:21:41 -0400
Date: Thu, 9 Jun 2005 10:54:04 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: [PATCH] Kprobes: move aggregate probe handlers and few return probe routines to static
Message-ID: <20050609052404.GA2220@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch moves kprobes aggregate probe handlers and few return probe routines
to static.

Thanks
Prasanna

Several aggregate kprobe handlers and return probe routines were unnecessarily
made global. This patch moves several global routines to static.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.12-rc6-mm1-prasanna/kernel/kprobes.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff -puN kernel/kprobes.c~move-aggr-kprobe-handlers-to-static kernel/kprobes.c
--- linux-2.6.12-rc6-mm1/kernel/kprobes.c~move-aggr-kprobe-handlers-to-static	2005-06-08 15:14:52.000000000 +0530
+++ linux-2.6.12-rc6-mm1-prasanna/kernel/kprobes.c	2005-06-08 15:24:21.000000000 +0530
@@ -82,7 +82,7 @@ struct kprobe *get_kprobe(void *addr)
  * Aggregate handlers for multiple kprobes support - these handlers
  * take care of invoking the individual kprobe handlers on p->list
  */
-int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
+static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe *kp;
 
@@ -97,8 +97,8 @@ int aggr_pre_handler(struct kprobe *p, s
 	return 0;
 }
 
-void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
-		unsigned long flags)
+static void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
+			      unsigned long flags)
 {
 	struct kprobe *kp;
 
@@ -112,7 +112,8 @@ void aggr_post_handler(struct kprobe *p,
 	return;
 }
 
-int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr)
+static int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
+			      int trapnr)
 {
 	/*
 	 * if we faulted "during" the execution of a user specified
@@ -153,7 +154,7 @@ struct kretprobe_instance *get_free_rp_i
 	return NULL;
 }
 
-struct kretprobe_instance *get_used_rp_inst(struct kretprobe *rp)
+static struct kretprobe_instance *get_used_rp_inst(struct kretprobe *rp)
 {
 	struct hlist_node *node;
 	struct kretprobe_instance *ri;
@@ -252,7 +253,7 @@ void kprobe_flush_task(struct task_struc
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.
  */
-int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
+static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
 
@@ -261,7 +262,7 @@ int pre_handler_kretprobe(struct kprobe 
 	return 0;
 }
 
-inline void free_rp_inst(struct kretprobe *rp)
+static inline void free_rp_inst(struct kretprobe *rp)
 {
 	struct kretprobe_instance *ri;
 	while ((ri = get_free_rp_inst(rp)) != NULL) {

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
