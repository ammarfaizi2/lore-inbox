Return-Path: <linux-kernel-owner+w=401wt.eu-S1030511AbXALE0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbXALE0y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbXALEYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXALEXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:53 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=ukEWQBjVBe8OwaIt+4rWrWZAK9pheb8Z68vqziTwo6UsYNoC1xHzTz/BghAtW8SV+hk8oozWLXbcrDIR6w9FCCYWl4vyjq5M0vqT27u0YTMKETW14cEFCf1UOZPyqtwFusMwdUXaVItYnVENNbs5Hrk8mSGoZLk4sjrK+JxpZgk=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:29 +0100
Message-Id: <20070112042729.28794.88151.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 13/19] hpt366: remove redundant check from init_dma_hpt366()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] hpt366: remove redundant check from init_dma_hpt366()

->init_dma() cannot be called with dmabase == 0
(see drivers/ide/setup-pci.c)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/hpt366.c |    3 ---
 1 file changed, 3 deletions(-)

Index: a/drivers/ide/pci/hpt366.c
===================================================================
--- a.orig/drivers/ide/pci/hpt366.c
+++ a/drivers/ide/pci/hpt366.c
@@ -1391,9 +1391,6 @@ static void __devinit init_dma_hpt366(id
 	u8 dma_new	= 0, dma_old	= 0;
 	unsigned long flags;
 
-	if (!dmabase)
-		return;
-		
 	dma_old = hwif->INB(dmabase + 2);
 
 	local_irq_save(flags);
