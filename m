Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVJQRoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVJQRoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVJQRoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:44:37 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:62824 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751064AbVJQRog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:44:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jVQe1ncLXFnvExVKJCjJRULr0klbQYAaQVwt/E5ZcBO9RmhhurAQqjH1NU3TA2TAnYyqqxqtTTFRDqJ8Khsis2o/FsLT9ohLQzl7akgeKxBT3JeKJAa4RpE0m3DlhLSpHQA2ct76fSH/z0myEp1iT3uXzTdYMV6BhCCOFHeUBO8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix small compile warning in hpt366
Date: Mon, 17 Oct 2005 19:47:31 +0200
User-Agent: KMail/1.8.2
Cc: Andre Hedrick <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171947.31961.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch below to; 
a) Fix a compile warning :
   drivers/ide/pci/hpt366.c:1293: warning: `Return' with a value, in function returning void
b) Add explicit printk loglevels to two printk's.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/ide/pci/hpt366.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc4-mm1-orig/drivers/ide/pci/hpt366.c	2005-10-17 12:00:36.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/ide/pci/hpt366.c	2005-10-17 19:40:50.000000000 +0200
@@ -1284,13 +1284,13 @@ static void __devinit hpt37x_clocking(id
 					info->speed = fifty_base_hpt370a;
 				else
 					info->speed = fifty_base_hpt370a;
-				printk("HPT37X: using 50MHz internal PLL\n");
+				printk(KERN_DEBUG "HPT37X: using 50MHz internal PLL\n");
 				goto init_hpt37X_done;
 			}
 		}
 		if (!pci_get_drvdata(dev)) {
-			printk("No Clock Stabilization!!!\n");
-			return -1;
+			printk(KERN_WARNING "No Clock Stabilization!!!\n");
+			return;
 		}
 pll_recal:
 		if (adjust & 1)
