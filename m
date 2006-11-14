Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933245AbWKNHW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbWKNHW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbWKNHW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:22:27 -0500
Received: from mga05.intel.com ([192.55.52.89]:36661 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S933199AbWKNHW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:22:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,420,1157353200"; 
   d="scan'208"; a="15498174:sNHT17847864"
Subject: [PATCH] Incorrect MSI interrupt type name
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1163488977.4311.52.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 14 Nov 2006 15:22:57 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/interrupts shows "<NULL>" for MSI interrupt type name on
my ia64 machine.

Below patch against 2.6.19-rc5-mm1 fixes it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.19-rc5-mm1/arch/ia64/kernel/msi_ia64.c	2006-11-14 14:16:12.000000000 +0800
+++ linux-2.6.19-rc5-mm1_fix/arch/ia64/kernel/msi_ia64.c	2006-11-14 15:08:37.000000000 +0800
@@ -115,7 +115,7 @@ static int ia64_msi_retrigger_irq(unsign
  * Generic ops used on most IA64 platforms.
  */
 static struct irq_chip ia64_msi_chip = {
-	.name		= "PCI-MSI",
+	.typename	= "PCI-MSI",
 	.mask		= mask_msi_irq,
 	.unmask		= unmask_msi_irq,
 	.ack		= ia64_ack_msi_irq,
