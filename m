Return-Path: <linux-kernel-owner+w=401wt.eu-S1751130AbXAFCbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbXAFCbD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXAFCae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36610 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXAFCaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:18 -0500
Message-Id: <20070106023338.303307000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Chuck Ebbert <76306.1226@compuserve.com>,
       Shaohua Li <shaohua.li@intel.com>
Subject: [patch 25/50] [stable] [stable patch] i386: CPU hotplug broken with 2GB VMSPLIT
Content-Disposition: inline; filename=i386-cpu-hotplug-broken-with-2gb-vmsplit.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Shaohua Li <shaohua.li@intel.com>

In VMSPLIT mode, kernel PGD might have more entries than user space

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/smpboot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.19.1/arch/i386/kernel/smpboot.c
@@ -1095,7 +1095,7 @@ static int __cpuinit __smp_prepare_cpu(i
 
 	/* init low mem mapping */
 	clone_pgd_range(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
-			KERNEL_PGD_PTRS);
+			min_t(unsigned long, KERNEL_PGD_PTRS, USER_PGD_PTRS));
 	flush_tlb_all();
 	schedule_work(&task);
 	wait_for_completion(&done);

--
