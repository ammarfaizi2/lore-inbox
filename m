Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVKVVJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVKVVJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVKVVHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:07:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965189AbVKVVHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:07:00 -0500
Date: Tue, 22 Nov 2005 13:06:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Joel Schopp <jschopp@austin.ibm.com>, Greg KH <greg@kroah.com>,
       Andy Whitcroft <apw@shadowen.org>
Subject: [patch 01/23] [PATCH] ppc64 memory model depends on NUMA
Message-ID: <20051122210602.GB28140@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ppc64-memory-model-depends-on-NUMA.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---
 arch/ppc64/Kconfig |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.14.2.orig/arch/ppc64/Kconfig
+++ linux-2.6.14.2/arch/ppc64/Kconfig
@@ -234,6 +234,10 @@ config HMT
 	  This option enables hardware multithreading on RS64 cpus.
 	  pSeries systems p620 and p660 have such a cpu type.
 
+config NUMA
+	bool "NUMA support"
+	default y if DISCONTIGMEM || SPARSEMEM
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
@@ -249,9 +253,6 @@ config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 
-config ARCH_FLATMEM_ENABLE
-	def_bool y
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
@@ -274,10 +275,6 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
-config NUMA
-	bool "NUMA support"
-	default y if DISCONTIGMEM || SPARSEMEM
-
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP

--
