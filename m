Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVDEV3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVDEV3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVDEV3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:29:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47780 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262053AbVDEV2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:28:13 -0400
Date: Tue, 5 Apr 2005 14:27:27 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       paulus@samba.org, anton@samba.org
Subject: [PATCH] ppc64 Kconfig memory models
Message-ID: <20050405212727.GA7513@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes some of the default behavior in the ppc64 Kconfig
file that was recently changed/added to 2.6.12-rc2-mm1 by Dave Hansen
in preparation for SPARSEMEM.  Patch allows the display of both FLAT
and DISCONTIG models on pseries.  As before, default is DISCONTIG for
SMP and PSERIES and FLAT for others.

-- 
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.12-rc2-mm1/arch/ppc64/Kconfig linux-2.6.12-rc2-mm1.work/arch/ppc64/Kconfig
--- linux-2.6.12-rc2-mm1/arch/ppc64/Kconfig	2005-04-05 18:44:57.000000000 +0000
+++ linux-2.6.12-rc2-mm1.work/arch/ppc64/Kconfig	2005-04-05 18:54:36.000000000 +0000
@@ -199,9 +199,16 @@ config HMT
 	  pSeries systems p620 and p660 have such a cpu type.
 
 config ARCH_DISCONTIGMEM_ENABLE
-	bool "Discontiguous Memory Support"
+	def_bool y
 	depends on SMP && PPC_PSERIES
 
+config ARCH_DISCONTIGMEM_DEFAULT
+	def_bool y
+	depends on ARCH_DISCONTIGMEM_ENABLE
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+
 source "mm/Kconfig"
 
 config NUMA
