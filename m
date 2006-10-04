Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWJDBZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWJDBZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWJDBZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:25:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:57548 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030380AbWJDBZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:25:55 -0400
Subject: [PATCH 1/1]  i383 numa: fix numaq/summit apicid conflict
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, andrew <akpm@osdl.org>,
       apw@shadowen.org
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Tue, 03 Oct 2006 18:25:52 -0700
Message-Id: <1159925153.6512.11.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com> 

  This patch allows numaq to properly align cpus to their given node
during boot. Pass logical apicid to apicid_to_node and allow the summit
sub-arch to use physical apicid (hard_smp_processor_id()). 
  Tested against numaq and summit based systems with no issues. against
2.6.18-git18. 

Signed-off-by: Keith Mannthey  <kmannth@us.ibm.com>
---
 arch/i386/kernel/smpboot.c               |    2 +-
 include/asm-i386/mach-summit/mach_apic.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.6.18/arch/i386/kernel/smpboot.c linux-2.6.18-git18/arch/i386/kernel/smpboot.c
--- linux-2.6.18/arch/i386/kernel/smpboot.c	2006-10-02 02:59:49.000000000 -0700
+++ linux-2.6.18-git18/arch/i386/kernel/smpboot.c	2006-10-02 00:36:52.000000000 -0700
@@ -648,7 +648,7 @@
 {
 	int cpu = smp_processor_id();
 	int apicid = logical_smp_processor_id();
-	int node = apicid_to_node(hard_smp_processor_id());
+	int node = apicid_to_node(apicid);
 
 	if (!node_online(node))
 		node = first_online_node;
diff -urN linux-2.6.18/include/asm-i386/mach-summit/mach_apic.h linux-2.6.18-git18/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.18/include/asm-i386/mach-summit/mach_apic.h	2006-10-02 02:59:54.000000000 -0700
+++ linux-2.6.18-git18/include/asm-i386/mach-summit/mach_apic.h	2006-10-02 00:51:24.000000000 -0700
@@ -88,7 +88,7 @@
 
 static inline int apicid_to_node(int logical_apicid)
 {
-	return apicid_2_node[logical_apicid];
+	return apicid_2_node[hard_smp_processor_id()];
 }
 
 /* Mapping from cpu number to logical apicid */


