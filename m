Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWIOPTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWIOPTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWIOPTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:19:17 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:10701 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751636AbWIOPTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:19:16 -0400
Date: Fri, 15 Sep 2006 17:19:31 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH] MTD: Fix bug in fixup_convert_atmel_pri
Message-ID: <20060915171931.2f38bca6@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The memset() in fixup_convert_atmel_pri is supposed to zero out
everything except the first 5 bytes in *extp, but it ends up zeroing
out something way outside the struct instead. Fix this potentially
dangerous code by casting the pointer to char * before doing
arithmetic.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc6-mm2/drivers/mtd/chips/cfi_cmdset_0002.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/drivers/mtd/chips/cfi_cmdset_0002.c	2006-09-15 14:39:22.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/mtd/chips/cfi_cmdset_0002.c	2006-09-15 14:39:40.000000000 +0200
@@ -175,7 +175,7 @@ static void fixup_convert_atmel_pri(stru
 	struct cfi_pri_atmel atmel_pri;
 
 	memcpy(&atmel_pri, extp, sizeof(atmel_pri));
-	memset(extp + 5, 0, sizeof(*extp) - 5);
+	memset((char *)extp + 5, 0, sizeof(*extp) - 5);
 
 	if (atmel_pri.Features & 0x02)
 		extp->EraseSuspend = 2;
