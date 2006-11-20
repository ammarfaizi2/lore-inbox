Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965382AbWKTK1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbWKTK1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965693AbWKTK1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:27:22 -0500
Received: from il.qumranet.com ([62.219.232.206]:32474 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S965382AbWKTK1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:27:21 -0500
Subject: [PATCH 1/3] KVM: Handle rdmsr(MSR_EFER)
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 20 Nov 2006 10:27:20 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, kvm-devel@lists.sourceforge.net, yaniv.kamay@qumranet.com,
       linux-kernel@vger.kernel.org
References: <45617A00.5040303@qumranet.com>
In-Reply-To: <45617A00.5040303@qumranet.com>
Message-Id: <20061120102720.9B03025015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Kamay <yaniv@qumranet.com>

Allow guests to read the EFER msr.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -2323,6 +2323,9 @@ static int get_msr(struct kvm_vcpu *vcpu
 	case MSR_GS_BASE:
 		data = vmcs_readl(GUEST_GS_BASE);
 		break;
+	case MSR_EFER:
+		data = vcpu->shadow_efer;
+		break;
 #endif
 	case MSR_IA32_TIME_STAMP_COUNTER:
 		data = guest_read_tsc();
