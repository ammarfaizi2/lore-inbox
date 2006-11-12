Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753711AbWKLOCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbWKLOCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 09:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbWKLOCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 09:02:45 -0500
Received: from il.qumranet.com ([62.219.232.206]:56009 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1753565AbWKLOCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 09:02:45 -0500
Subject: [PATCH] KVM: Fix asm constraints for segment loads
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 12 Nov 2006 14:02:43 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bero@arklinux.org
Message-Id: <20061112140243.ADDA8A0001@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernhard Rosenkraenzer <bero@arklinux.org>

"g" is an invalid constraint for a segment register load, since it includes
immediate operands, which are illegal for segment moves.

Fix by specifying register or memory operands.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -154,12 +154,12 @@ static u16 read_ldt(void)
 
 static void load_fs(u16 sel)
 {
-	asm ("mov %0, %%fs" : : "g"(sel));
+	asm ("mov %0, %%fs" : : "rm"(sel));
 }
 
 static void load_gs(u16 sel)
 {
-	asm ("mov %0, %%gs" : : "g"(sel));
+	asm ("mov %0, %%gs" : : "rm"(sel));
 }
 
 #ifndef load_ldt
