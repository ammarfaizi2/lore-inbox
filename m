Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWDMQxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWDMQxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWDMQxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:53:24 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:53223 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751031AbWDMQxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:53:23 -0400
Date: Thu, 13 Apr 2006 18:53:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 1/4] Simplify test for RAM devices
Message-ID: <20060413165314.GE30574@wohnheim.fh-wedel.de>
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060413165153.GD30574@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mtdblock is the only user of aggregate capabilities in mtd.  This is clearly
bogus and should be changed.  In particular, it tries to determine whether
the device in question is a piece of RAM.  For every single driver that fits
the current criteria, an easier test would be to check for the type being
MTD_RAM.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/mtdblock.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


--- mtd_type/drivers/mtd/mtdblock.c~mtdblock_ram_test	2006-04-13 18:03:41.000000000 +0200
+++ mtd_type/drivers/mtd/mtdblock.c	2006-04-13 18:19:19.000000000 +0200
@@ -288,8 +288,7 @@ static int mtdblock_open(struct mtd_blkt
 
 	mutex_init(&mtdblk->cache_mutex);
 	mtdblk->cache_state = STATE_EMPTY;
-	if ((mtdblk->mtd->flags & MTD_CAP_RAM) != MTD_CAP_RAM &&
-	    mtdblk->mtd->erasesize) {
+	if (mtdblk->mtd->type != MTD_RAM && mtdblk->mtd->erasesize) {
 		mtdblk->cache_size = mtdblk->mtd->erasesize;
 		mtdblk->cache_data = NULL;
 	}
