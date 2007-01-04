Return-Path: <linux-kernel-owner+w=401wt.eu-S964962AbXADQLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbXADQLK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbXADQLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:11:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:49214 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964962AbXADQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:11:08 -0500
Subject: [PATCH 22/33] KVM: MMU: Ensure freed shadow pages are clean
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:11:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161107.45243250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -318,6 +318,7 @@ static void kvm_mmu_free_page(struct kvm
 {
 	struct kvm_mmu_page *page_head = page_header(page_hpa);
 
+	ASSERT(is_empty_shadow_page(page_hpa));
 	list_del(&page_head->link);
 	page_head->page_hpa = page_hpa;
 	list_add(&page_head->link, &vcpu->free_pages);
