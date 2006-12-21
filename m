Return-Path: <linux-kernel-owner+w=401wt.eu-S1422882AbWLUJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWLUJsH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWLUJsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:48:07 -0500
Received: from il.qumranet.com ([62.219.232.206]:59784 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422882AbWLUJsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:48:06 -0500
Subject: [PATCH 3/5] KVM: Force real-mode cs limit to 64K
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 21 Dec 2006 09:48:04 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <458A57A4.9000807@qumranet.com>
In-Reply-To: <458A57A4.9000807@qumranet.com>
Message-Id: <20061221094804.E1B1F250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riepe <michael@mr511.de>

this allows opensolaris to boot on kvm/intel.

Signed-off-by: Michael Riepe <michael@mr511.de>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -726,6 +726,7 @@ static void enter_rmode(struct kvm_vcpu 
 	vmcs_write32(GUEST_SS_AR_BYTES, 0xf3);
 
 	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
+	vmcs_write32(GUEST_CS_LIMIT, 0xffff);
 	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
 
 	fix_rmode_seg(VCPU_SREG_ES, &vcpu->rmode.es);
