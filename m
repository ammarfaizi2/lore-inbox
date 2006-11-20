Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965687AbWKTK2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965687AbWKTK2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965711AbWKTK2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:28:22 -0500
Received: from il.qumranet.com ([62.219.232.206]:33498 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S965687AbWKTK2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:28:21 -0500
Subject: [PATCH 2/3] KVM: Pass fs, gs segment bases to x86 emulator
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 20 Nov 2006 10:28:20 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, kvm-devel@lists.sourceforge.net, yaniv.kamay@qumranet.com,
       linux-kernel@vger.kernel.org
References: <45617A00.5040303@qumranet.com>
In-Reply-To: <45617A00.5040303@qumranet.com>
Message-Id: <20061120102820.A828825015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Kamay <yaniv@qumranet.com>

The x86-64 respects segment bases for fs and gs.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1907,17 +1907,16 @@ static int emulate_instruction(struct kv
 		emulate_ctxt.ds_base = 0;
 		emulate_ctxt.es_base = 0;
 		emulate_ctxt.ss_base = 0;
-		emulate_ctxt.gs_base = 0;
-		emulate_ctxt.fs_base = 0;
 	} else {
 		emulate_ctxt.cs_base = vmcs_readl(GUEST_CS_BASE);
 		emulate_ctxt.ds_base = vmcs_readl(GUEST_DS_BASE);
 		emulate_ctxt.es_base = vmcs_readl(GUEST_ES_BASE);
 		emulate_ctxt.ss_base = vmcs_readl(GUEST_SS_BASE);
-		emulate_ctxt.gs_base = vmcs_readl(GUEST_GS_BASE);
-		emulate_ctxt.fs_base = vmcs_readl(GUEST_FS_BASE);
 	}
 
+	emulate_ctxt.gs_base = vmcs_readl(GUEST_GS_BASE);
+	emulate_ctxt.fs_base = vmcs_readl(GUEST_FS_BASE);
+
 	vcpu->mmio_is_write = 0;
 	r = x86_emulate_memop(&emulate_ctxt, &emulate_ops);
 
