Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUGBLPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUGBLPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGBLPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:15:49 -0400
Received: from ozlabs.org ([203.10.76.45]:57537 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262322AbUGBLPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 07:15:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16613.17387.121340.459559@cargo.ozlabs.ibm.com>
Date: Fri, 2 Jul 2004 21:15:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64: Set ppc_md.log_error
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a platform-specific function pointer on ppc64 for a function
to log errors detected by the platform, but it was never getting set.
This patch sets it on pSeries (the only ppc64 platform which has an
error logging function).

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/chrp_setup.c ppc64-2.5/arch/ppc64/kernel/chrp_setup.c
--- linux-2.5/arch/ppc64/kernel/chrp_setup.c	2004-06-30 22:03:45.000000000 +1000
+++ ppc64-2.5/arch/ppc64/kernel/chrp_setup.c	2004-07-02 20:15:38.143035112 +1000
@@ -243,6 +243,8 @@
 		ppc_md.get_irq        = xics_get_irq;
 	}
 
+	ppc_md.log_error      = pSeries_log_error;
+
 	ppc_md.init           = chrp_init2;
 
 	ppc_md.pcibios_fixup  = pSeries_final_fixup;
