Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936375AbWK3Mfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936375AbWK3Mfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936349AbWK3Mft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:35:49 -0500
Received: from il.qumranet.com ([62.219.232.206]:3722 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S936390AbWK3MfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:35:02 -0500
Subject: [PATCH] KVM: Zero guest memory before use
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 30 Nov 2006 12:35:00 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Message-Id: <20061130123500.9440E25017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This prevents an information leak from the host to the vmm and the guest.

Signed-off-by: Avi Kivity <avi@qumranet.com>

diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/kvm_main.c /home/avi/kvm-release/kernel/kvm_main.c
--- linux-2.6/drivers/kvm/kvm_main.c	2006-11-30 10:59:57.000000000 +0200
+++ linux-2.6/drivers/kvm/kvm_main.c	2006-11-30 14:26:29.000000000 +0200
@@ -620,7 +620,8 @@
 
 		memset(new.phys_mem, 0, npages * sizeof(struct page *));
 		for (i = 0; i < npages; ++i) {
-			new.phys_mem[i] = alloc_page(GFP_HIGHUSER);
+			new.phys_mem[i] = alloc_page(GFP_HIGHUSER
+						     | __GFP_ZERO);
 			if (!new.phys_mem[i])
 				goto out_free;
 		}
