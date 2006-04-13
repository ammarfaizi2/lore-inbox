Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWDMQyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDMQyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWDMQyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:54:06 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:13544 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751042AbWDMQyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:54:05 -0400
Date: Thu, 13 Apr 2006 18:53:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 2/4] Make mtdblock_ro unconditionally readonly
Message-ID: <20060413165355.GF30574@wohnheim.fh-wedel.de>
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060413165153.GD30574@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mtdblock_ro is by definition readonly.  Remove the silly checks.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/mtdblock_ro.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- mtd_type/drivers/mtd/mtdblock_ro.c~mtdblock_ro	2006-04-13 17:56:54.000000000 +0200
+++ mtd_type/drivers/mtd/mtdblock_ro.c	2006-04-13 17:57:31.000000000 +0200
@@ -45,9 +45,7 @@ static void mtdblock_add_mtd(struct mtd_
 	dev->blksize = 512;
 	dev->size = mtd->size >> 9;
 	dev->tr = tr;
-	if ((mtd->flags & (MTD_CLEAR_BITS|MTD_SET_BITS|MTD_WRITEABLE)) !=
-	    (MTD_CLEAR_BITS|MTD_SET_BITS|MTD_WRITEABLE))
-		dev->readonly = 1;
+	dev->readonly = 1;
 
 	add_mtd_blktrans_dev(dev);
 }
