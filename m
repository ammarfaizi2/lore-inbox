Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWDSTOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWDSTOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDSTN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:13:58 -0400
Received: from mga06.intel.com ([134.134.136.21]:7281 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751180AbWDSTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:13:35 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113903:sNHT31954692"
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25113881:sNHT42656866"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25141602:sNHT17016335"
Message-Id: <20060419190135.561415342@csdlinux-2.jf.intel.com>
References: <20060419190059.452500615@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 12:01:05 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>
Subject: [patch 6/6] Kprobes registers for notify page fault
Content-Disposition: inline; filename=notify_page_fault_kprobes.patch
X-OriginalArrivalTime: 19 Apr 2006 19:10:23.0805 (UTC) FILETIME=[E8EB0ED0:01C663E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes now registers for the page fault notifications.

---
 kernel/kprobes.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
+++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
@@ -544,6 +544,11 @@ static struct notifier_block kprobe_exce
 	.priority = 0x7fffffff /* we need to notified first */
 };
 
+static struct notifier_block kprobe_page_fault_nb = {
+	.notifier_call = kprobe_exceptions_notify,
+	.priority = 0x7fffffff /* we need to notified first */
+};
+
 int __kprobes register_jprobe(struct jprobe *jp)
 {
 	/* Todo: Verify probepoint is a function entry point */
@@ -654,6 +659,9 @@ static int __init init_kprobes(void)
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
 
+	if (!err)
+		err = register_page_fault_notifier(&kprobe_page_fault_nb);
+
 	return err;
 }
 

--
