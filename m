Return-Path: <linux-kernel-owner+w=401wt.eu-S964980AbXADQMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbXADQMM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbXADQMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:12:12 -0500
Received: from il.qumranet.com ([62.219.232.206]:49217 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964980AbXADQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:12:10 -0500
Subject: [PATCH 23/33] KVM: MMU: If an empty shadow page is not empty,
	report more info
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:12:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161207.5219B250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -305,12 +305,16 @@ static void rmap_write_protect(struct kv
 
 static int is_empty_shadow_page(hpa_t page_hpa)
 {
-	u32 *pos;
-	u32 *end;
-	for (pos = __va(page_hpa), end = pos + PAGE_SIZE / sizeof(u32);
+	u64 *pos;
+	u64 *end;
+
+	for (pos = __va(page_hpa), end = pos + PAGE_SIZE / sizeof(u64);
 		      pos != end; pos++)
-		if (*pos != 0)
+		if (*pos != 0) {
+			printk(KERN_ERR "%s: %p %llx\n", __FUNCTION__,
+			       pos, *pos);
 			return 0;
+		}
 	return 1;
 }
 
