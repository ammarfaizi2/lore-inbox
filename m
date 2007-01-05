Return-Path: <linux-kernel-owner+w=401wt.eu-S1161008AbXAEHys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbXAEHys (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbXAEHyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:54:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:39625 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161009AbXAEHyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:54:46 -0500
Subject: [PATCH 5/9] KVM: Don't set guest cr3 from vmx_vcpu_setup()
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:54:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075445.722EE250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It overwrites the right cr3 set from mmu setup.  Happens only with the test harness.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1027,8 +1027,6 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	vmcs_writel(GUEST_RIP, 0xfff0);
 	vmcs_writel(GUEST_RSP, 0);
 
-	vmcs_writel(GUEST_CR3, 0);
-
 	//todo: dr0 = dr1 = dr2 = dr3 = 0; dr6 = 0xffff0ff0
 	vmcs_writel(GUEST_DR7, 0x400);
 
