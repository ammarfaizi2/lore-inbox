Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVCYWBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVCYWBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCYWAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:00:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:53165 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261829AbVCYVyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:54:46 -0500
Subject: [RFC][PATCH 1/4] create mm/Kconfig for arch-independent memory options
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 13:54:43 -0800
Message-Id: <E1DEwlP-0006BQ-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With sparsemem and memory hotplug there are quite a few options that
we kept adding identically in several different architectures.  This
new file allows some of these to be consolidated.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/Kconfig |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)

diff -puN mm/Kconfig~A6-mm-Kconfig mm/Kconfig
--- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-03-25 08:08:22.000000000 -0800
+++ memhotplug-dave/mm/Kconfig	2005-03-25 08:08:22.000000000 -0800
@@ -0,0 +1,41 @@
+choice
+	prompt "Memory model"
+	default FLATMEM
+	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
+	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
+
+config FLATMEM
+	bool "Flat Memory"
+	depends on !ARCH_DISCONTIGMEM_ENABLE || ARCH_FLATMEM_ENABLE
+	help
+	  This option allows you to change some of the ways that
+	  Linux manages its memory internally.  Most users will
+	  only have one option here: FLATMEM.  This is normal
+	  and a correct option.
+
+	  Some users of more advanced features like NUMA and
+	  memory hotplug may have different options here.
+	  DISCONTIGMEM is an more mature, better tested system,
+	  but is incompatible with memory hotplug and may suffer
+	  decreased performance over SPARSEMEM.  If unsure between
+	  "Sparse Memory" and "Discontiguous Memory", choose
+	  "Discontiguous Memory".
+
+	  If unsure, choose FLATMEM.
+
+config DISCONTIGMEM
+	bool "Discontigious Memory"
+	depends on ARCH_DISCONTIGMEM_ENABLE
+	help
+	  If unsure, choose this option over "Sparse Memory".
+
+endchoice
+
+#
+# Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
+# to represent different areas of memory.  This variable allows
+# those dependencies to exist individually.
+#
+config NEED_MULTIPLE_NODES
+	def_bool y
+	depends on DISCONTIGMEM || NUMA
_
