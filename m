Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWCIXHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWCIXHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWCIXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:07:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750781AbWCIXGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:06:55 -0500
Date: Fri, 10 Mar 2006 00:06:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: maintainers@chelsio.com
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] chelsio/espi.c:tricn_init(): remove dead code
Message-ID: <20060309230653.GK21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted these two unused variables.

Please check whether this patch is correct or whether they should be 
used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/chelsio/espi.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- linux-2.6.16-rc5-mm3-full/drivers/net/chelsio/espi.c.old	2006-03-09 23:19:54.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/net/chelsio/espi.c	2006-03-09 23:20:35.000000000 +0100
@@ -87,15 +87,9 @@
 static int tricn_init(adapter_t *adapter)
 {
 	int     i               = 0;
-	int     sme             = 1;
 	int     stat            = 0;
 	int     timeout         = 0;
 	int     is_ready        = 0;
-	int     dynamic_deskew  = 0;
-
-	if (dynamic_deskew)
-		sme = 0;
-
 
 	/* 1 */
 	timeout=1000;
@@ -113,11 +107,9 @@
 	}
 
 	/* 2 */
-	if (sme) {
-		tricn_write(adapter, 0, 0, 0, TRICN_CNFG, 0x81);
-		tricn_write(adapter, 0, 1, 0, TRICN_CNFG, 0x81);
-		tricn_write(adapter, 0, 2, 0, TRICN_CNFG, 0x81);
-	}
+	tricn_write(adapter, 0, 0, 0, TRICN_CNFG, 0x81);
+	tricn_write(adapter, 0, 1, 0, TRICN_CNFG, 0x81);
+	tricn_write(adapter, 0, 2, 0, TRICN_CNFG, 0x81);
 	for (i=1; i<= 8; i++) tricn_write(adapter, 0, 0, i, TRICN_CNFG, 0xf1);
 	for (i=1; i<= 2; i++) tricn_write(adapter, 0, 1, i, TRICN_CNFG, 0xf1);
 	for (i=1; i<= 3; i++) tricn_write(adapter, 0, 2, i, TRICN_CNFG, 0xe1);

