Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWJFJ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWJFJ04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWJFJ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:26:56 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:54489 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751353AbWJFJ0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:26:40 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] IRQ: Fix build breakage with CONFIG_HARDIRQS_SW_RESEND=y
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Fri, 06 Oct 2006 11:27:41 +0200
Message-Id: <1160126862512-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

resend_irqs() in kernel/irq/resend.c shouldn't pass regs to
desc->handle_irq() anymore.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 kernel/irq/resend.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 35f10f7..5bfeaed 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -38,7 +38,7 @@ static void resend_irqs(unsigned long ar
 		clear_bit(irq, irqs_resend);
 		desc = irq_desc + irq;
 		local_irq_disable();
-		desc->handle_irq(irq, desc, NULL);
+		desc->handle_irq(irq, desc);
 		local_irq_enable();
 	}
 }
-- 
1.4.1.1

