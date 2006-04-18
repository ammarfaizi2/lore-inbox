Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWDRJKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWDRJKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWDRJKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:10:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:7051 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750913AbWDRJKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:10:09 -0400
Date: Tue, 18 Apr 2006 14:39:50 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH] kprobes: NULL out non-relevant fields in struct kretprobe
Message-ID: <20060418090950.GA5461@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

In cases where a struct kretprobe's *_handler fields are non-NULL, it
is possible to cause a system crash, due to the possibility of calls
ending up in zombie functions. Documentation clearly states that unused
*_handlers should be set to NULL, but kprobe users sometimes fail to
do so.

Fix it by setting the non-relevant fields of the struct kretprobe to NULL.


Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Jim Keniston <jkenisto@us.ibm.com>

---
 kernel/kprobes.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.17-rc1/kernel/kprobes.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/kprobes.c
+++ linux-2.6.17-rc1/kernel/kprobes.c
@@ -585,6 +585,9 @@ int __kprobes register_kretprobe(struct 
 	int i;
 
 	rp->kp.pre_handler = pre_handler_kretprobe;
+	rp->kp.post_handler = NULL;
+	rp->kp.fault_handler = NULL;
+	rp->kp.break_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
