Return-Path: <linux-kernel-owner+w=401wt.eu-S1751395AbWLLOxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWLLOxH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWLLOxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:53:06 -0500
Received: from il.qumranet.com ([62.219.232.206]:40521 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbWLLOxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:53:05 -0500
Subject: [PATCH] KVM: Re-fix vmx hardware_enable() on macbooks
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 12 Dec 2006 14:52:48 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Message-Id: <20061212145248.332AE2500B4@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This incremental patch fixes the macbook issue for real.

Signed-off-by: Avi Kivity <avi@qumranet.com>
Tested-by: Alex Larsson (sometimes testing helps)

------------------------------------------------------------------------
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -534,7 +534,7 @@ static __init void hardware_enable(void 
 	u64 old;
 
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
-	if ((old & 4) == 0)
+	if ((old & 5) != 5)
 		/* enable and lock */
 		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | 5);
 	write_cr4(read_cr4() | CR4_VMXE); /* FIXME: not cpu hotplug safe */
