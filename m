Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWDSWcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWDSWcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWDSWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:31:48 -0400
Received: from mga07.intel.com ([143.182.124.22]:51563 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751195AbWDSWbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:31:46 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25223907:sNHT65314515"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25223891:sNHT143565681"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25987149:sNHT51435503"
Message-Id: <20060419221948.507988202@csdlinux-2.jf.intel.com>
References: <20060419221419.382297865@csdlinux-2.jf.intel.com>
Date: Wed, 19 Apr 2006 15:14:25 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(resend)patch 6/7] Kprobes registers for notify page fault
Content-Disposition: inline; filename=notify_page_fault_kprobes.patch
X-OriginalArrivalTime: 19 Apr 2006 22:31:44.0295 (UTC) FILETIME=[09738B70:01C66401]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes now registers for the page fault notifications.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

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
