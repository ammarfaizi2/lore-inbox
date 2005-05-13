Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVEMTLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVEMTLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVEMTGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:06:13 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:743 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S262496AbVEMTES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:04:18 -0400
Date: Fri, 13 May 2005 21:04:15 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Jochen Karrer <j.karrer@lightmaze.com>
Subject: [PATCH] DM9000 network driver bugfix
Message-ID: <20050513190415.GA18358@metis.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two bugs in the dm9000 network driver:
- Don't read one byte too much in 8bit mode.
- release correct resource

Signed-off-by: Jochen Karrer <j.karrer@xxxxxxxxxxxxxxxx>
Signed-off-by: Sascha Hauer <s.hauer@xxxxxxxxxxxxxxxx>

diff -urN linux-2.6.12-rc4-mm1/drivers/net/dm9000.c linux-2.6.12-rc4-mm1-work/drivers/net/dm9000.c
--- linux-2.6.12-rc4-mm1/drivers/net/dm9000.c	2005-05-13 12:10:42.000000000 +0200
+++ linux-2.6.12-rc4-mm1-work/drivers/net/dm9000.c	2005-05-13 12:14:38.000000000 +0200
@@ -224,7 +224,7 @@
 
 static void dm9000_inblk_8bit(void __iomem *reg, void *data, int count)
 {
-	readsb(reg, data, count+1);
+	readsb(reg, data, count);
 }
 
 
@@ -364,7 +364,7 @@
 	}
 
 	if (db->addr_res != NULL) {
-		release_resource(db->data_req);
+		release_resource(db->addr_res);
 		kfree(db->addr_req);
 	}
 }

