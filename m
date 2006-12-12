Return-Path: <linux-kernel-owner+w=401wt.eu-S1751322AbWLLN7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWLLN7j (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWLLN7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:59:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:35424 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbWLLN7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:59:38 -0500
Subject: [PATCH 3/3] KVM: Fix vmx hardware_enable() on macbooks
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 12 Dec 2006 13:59:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457EB4ED.6020407@qumranet.com>
In-Reply-To: <457EB4ED.6020407@qumranet.com>
Message-Id: <20061212135937.991212500B4@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems macbooks set bit 2 but not bit 0, which is an "enabled but vmxon
will fault" setting.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -534,7 +534,7 @@ static __init void hardware_enable(void 
 	u64 old;
 
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
-	if ((old & 5) == 0)
+	if ((old & 4) == 0)
 		/* enable and lock */
 		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | 5);
 	write_cr4(read_cr4() | CR4_VMXE); /* FIXME: not cpu hotplug safe */
