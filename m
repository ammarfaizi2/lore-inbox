Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWDTXwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWDTXwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWDTXvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:08 -0400
Received: from mga06.intel.com ([134.134.136.21]:48206 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932143AbWDTXvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:03 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813697:sNHT15257312"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25813672:sNHT15704612"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831785:sNHT16603062"
Message-Id: <20060420233912.410449785@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:25:02 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: [(take 2)patch 6/7] Kprobes registers for notify page fault
Content-Disposition: inline; filename=notify_page_fault_kprobes.patch
X-OriginalArrivalTime: 20 Apr 2006 23:50:58.0583 (UTC) FILETIME=[45A41270:01C664D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
