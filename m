Return-Path: <linux-kernel-owner+w=401wt.eu-S1422805AbXAMXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbXAMXQs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbXAMXKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:54 -0500
Received: from gw.goop.org ([64.81.55.164]:59915 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030526AbXAMXKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:25 -0500
Message-Id: <20070113014647.589054873@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:44 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 05/20] XEN-paravirt: paravirt: reserve fixmap slot
Content-Disposition: inline; filename=paravirt-fixmap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve a new fixmap slot for paravirt backends.  Xen uses this for
mapping the hypervisor shared-info page, which doesn't really exist in
the guest address space.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/include/asm-i386/fixmap.h
+++ b/include/asm-i386/fixmap.h
@@ -86,6 +86,9 @@ enum fixed_addresses {
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
+#ifdef CONFIG_PARAVIRT
+	FIX_PARAVIRT,
+#endif
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
 #define NR_FIX_BTMAPS	16

-- 

