Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273008AbRIISOD>; Sun, 9 Sep 2001 14:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273009AbRIISNy>; Sun, 9 Sep 2001 14:13:54 -0400
Received: from aboukir-101-1-1-maz.adsl.nerim.net ([62.4.18.26]:28897 "EHLO
	wild-wind.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S273008AbRIISNq>; Sun, 9 Sep 2001 14:13:46 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Missing exports in genhd.c in 2.4.10-pre
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 09 Sep 2001 20:13:52 +0200
Message-ID: <wrplmjodyfz.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please find attached a small patch (against 2.4.10-pre6) which adds
missing EXPORT_SYMBOLs to genhd.c. Without it, modules such as
sd_mod.o are unable to load...

        M.

--- vanilla/linux/drivers/block/genhd.c	Sun Sep  9 20:03:21 2001
+++ linux/drivers/block/genhd.c	Sun Sep  9 19:58:12 2001
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/blk.h>
 #include <linux/init.h>
-
+#include <linux/module.h>
 
 struct gendisk *gendisk_head;
 
@@ -133,3 +133,8 @@
 }
 
 __initcall(device_init);
+
+EXPORT_SYMBOL(add_gendisk);
+EXPORT_SYMBOL(del_gendisk);
+EXPORT_SYMBOL(get_gendisk);
+

-- 
Places change, faces change. Life is so very strange.
