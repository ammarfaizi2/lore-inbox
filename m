Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSBIIsK>; Sat, 9 Feb 2002 03:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSBIIsA>; Sat, 9 Feb 2002 03:48:00 -0500
Received: from mtao3.east.cox.net ([68.1.17.242]:43204 "EHLO
	lakemtao03.mgt.cox.net") by vger.kernel.org with ESMTP
	id <S288752AbSBIIrp>; Sat, 9 Feb 2002 03:47:45 -0500
From: Junio Hamano <junkio@cox.net>
To: Jeff Garzik <linux-via@gtf.org>
CC: Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] drivers/sound/via82cxxx_audio.c (binutils .text.exit problem)
Message-Id: <20020209084715.MVGX6710.lakemtao03.mgt.cox.net@cox.net>
Date: Sat, 9 Feb 2002 03:47:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that via82cxxx audio driver in 2.4.18-pre9 still has
.text.exit problem with newer binutils.  I've found that the following
patch (by Andrew Morton <akpm@zip.com.au>) fixes the linkage problem.

--- 2.4.18-pre9-ac0-cd-c/drivers/sound/via82cxxx_audio.c~	Sat Feb  9 00:30:16 2002
+++ 2.4.18-pre9-ac0-cd-c/drivers/sound/via82cxxx_audio.c	Sat Feb  9 00:30:45 2002
@@ -365,7 +365,7 @@
 	name:		VIA_MODULE_NAME,
 	id_table:	via_pci_tbl,
 	probe:		via_init_one,
-	remove:		via_remove_one,
+	remove:		__devexit_p(via_remove_one),
 };
 
 
@@ -3271,7 +3271,7 @@
 }
 
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 	struct via_info *card;
 

