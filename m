Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVERPXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVERPXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVERPWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:22:15 -0400
Received: from fmr18.intel.com ([134.134.136.17]:62661 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262255AbVERPT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:19:58 -0400
Date: Wed, 18 May 2005 08:24:41 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200505181524.j4IFOfew026909@snoqualmie.dp.intel.com>
To: ak@muc.de, akpm@osdl.org
Subject: [patch 2/4] add x86-64 Kconfig options for sparsemem
Cc: apw@shadowen.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the requisite arch specific Kconfig options to enable 
the use of the sparsemem implementation for NUMA kernels
on x86-64.

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/x86_64/Kconfig |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)

diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/Kconfig linux-2.6.12-rc4-mm2-m/arch/x86_64/Kconfig
--- linux-2.6.12-rc4-mm2/arch/x86_64/Kconfig	2005-05-18 07:38:20.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/Kconfig	2005-05-18 07:44:42.000000000 -0400
@@ -274,8 +274,27 @@ config NUMA
        bool
        default n
 
+config ARCH_DISCONTIGMEM_ENABLE
+	def_bool y
+	depends on NUMA
+
+config ARCH_DISCONTIGMEM_DEFAULT
+	def_bool y
+	depends on NUMA
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	depends on NUMA
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+	depends on !NUMA
+
 source "mm/Kconfig"
 
+config HAVE_ARCH_EARLY_PFN_TO_NID
+	def_bool y
+
 config HAVE_DEC_LOCK
 	bool
 	depends on SMP
