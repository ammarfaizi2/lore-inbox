Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUH1OLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUH1OLM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 10:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUH1OLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 10:11:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:5513 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265971AbUH1OLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 10:11:10 -0400
Date: Sat, 28 Aug 2004 16:11:00 +0200 (MEST)
Message-Id: <200408281411.i7SEB0Uj029423@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre2] drivers/ide/pci/sc1200.c cast-as-lvalue fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for cast-as-lvalue in drivers/ide/pci/sc1200.c. Backport from 2.6.

/Mikael

--- linux-2.4.28-pre2/drivers/ide/pci/sc1200.c.~1~	2003-06-14 13:30:22.000000000 +0200
+++ linux-2.4.28-pre2/drivers/ide/pci/sc1200.c	2004-08-28 14:58:54.000000000 +0200
@@ -418,7 +418,7 @@
 			ss = kmalloc(sizeof(sc1200_saved_state_t), GFP_KERNEL);
 			if (ss == NULL)
 				return -ENOMEM;
-			(sc1200_saved_state_t *)hwif->config_data = ss;
+			hwif->config_data = (unsigned long)ss;
 		}
 		ss = (sc1200_saved_state_t *)hwif->config_data;
 		//
