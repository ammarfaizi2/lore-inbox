Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWD2Klt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWD2Klt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 06:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWD2Klt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 06:41:49 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:29886 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750716AbWD2Klt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 06:41:49 -0400
From: Daniel Drake <dsd@gentoo.org>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: toralf.foerster@gmx.de
Subject: [PATCH] mtd: SC520CDP should depend on MTD_CONCAT
Message-Id: <20060429104144.4D7AC87EA56@zog.reactivated.net>
Date: Sat, 29 Apr 2006 11:41:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toralf Förster found a compile error when CONFIG_MTD_SC520CDP=y and
CONFIG_MTD_CONCAT=n:

drivers/built-in.o: In function `init_sc520cdp':
sc520cdp.c:(.init.text+0xb4de): undefined reference to `mtd_concat_create'
drivers/built-in.o: In function `cleanup_sc520cdp':
sc520cdp.c:(.exit.text+0x14bc): undefined reference to `mtd_concat_destroy'

This patch fixes it.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux-2.6.17-rc3-test/drivers/mtd/maps/Kconfig
===================================================================
--- linux-2.6.17-rc3-test.orig/drivers/mtd/maps/Kconfig
+++ linux-2.6.17-rc3-test/drivers/mtd/maps/Kconfig
@@ -78,7 +78,7 @@ config MTD_PNC2000
 
 config MTD_SC520CDP
 	tristate "CFI Flash device mapped on AMD SC520 CDP"
-	depends on X86 && MTD_CFI
+	depends on X86 && MTD_CFI && MTD_CONCAT
 	help
 	  The SC520 CDP board has two banks of CFI-compliant chips and one
 	  Dual-in-line JEDEC chip. This 'mapping' driver supports that
