Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161411AbWG2Cwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161411AbWG2Cwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWG2Cwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:52:53 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45031 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161408AbWG2Cwp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:52:45 -0400
Subject: [Patch] 3/5 in support of hot-add memory x86_64 arch_find_node
	x86_64
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: lhms-devel <lhms-devel@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       andrew <akpm@osdl.org>, kame <kamezawa.hiroyu@jp.fujitsu.com>,
       dave hansen <haveblue@us.ibm.com>, discuss <discuss@x86-64.org>,
       konrad <darnok@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-yqJ8PBk6GT7r4nthdHsP"
Organization: Linux Technology Center IBM
Date: Fri, 28 Jul 2006 19:52:41 -0700
Message-Id: <1154141562.5874.147.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yqJ8PBk6GT7r4nthdHsP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all
  This is a enablement of the generic arch_find_node for x86_64. It uses
the nodes_add date collected from the SRAT to do it's lookup. 

I suspect and i386 version will be needed when I get to that arch with
my work. 

This was built against 2.6.18-rc2.

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

--=-yqJ8PBk6GT7r4nthdHsP
Content-Disposition: attachment; filename=patch-2.6.18-rc2-arch_find_node_x86_64
Content-Type: text/x-patch; name=patch-2.6.18-rc2-arch_find_node_x86_64; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN orig/arch/x86_64/Kconfig work/arch/x86_64/Kconfig
--- orig/arch/x86_64/Kconfig	2006-07-28 13:57:35.000000000 -0400
+++ work/arch/x86_64/Kconfig	2006-07-28 21:20:16.000000000 -0400
@@ -343,6 +343,10 @@
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config ARCH_FIND_NODE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on !NUMA
diff -urN orig/arch/x86_64/mm/srat.c work/arch/x86_64/mm/srat.c
--- orig/arch/x86_64/mm/srat.c	2006-07-28 13:57:35.000000000 -0400
+++ work/arch/x86_64/mm/srat.c	2006-07-28 21:19:01.000000000 -0400
@@ -450,3 +450,15 @@
 }
 
 EXPORT_SYMBOL(__node_distance);
+
+int arch_find_node(unsigned long start, unsigned long size) 
+{
+	int i, ret = 0;
+	unsigned long end = start+size;
+	
+	for_each_node(i) {
+		if (nodes_add[i].start <= start && nodes_add[i].end >= end)
+			ret = i;
+	}
+	return ret;
+}

--=-yqJ8PBk6GT7r4nthdHsP--

