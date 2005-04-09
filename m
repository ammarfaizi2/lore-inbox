Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVDIXAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVDIXAv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDIXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:00:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54534 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261401AbVDIXAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:00:36 -0400
Date: Sun, 10 Apr 2005 01:00:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ewrk3.c: remove dead code
Message-ID: <20050409230034.GN3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ewrk3.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

--- linux-2.6.12-rc2-mm2-full/drivers/net/ewrk3.c.old	2005-04-09 22:03:49.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/net/ewrk3.c	2005-04-09 22:04:15.000000000 +0200
@@ -1308,15 +1308,9 @@ static int __init eisa_probe(struct net_
 	if (ioaddr < 0x1000)
 		goto out;
 
-	if (ioaddr == 0) {	/* Autoprobing */
-		iobase = EISA_SLOT_INC;		/* Get the first slot address */
-		i = 1;
-		maxSlots = MAX_EISA_SLOTS;
-	} else {		/* Probe a specific location */
-		iobase = ioaddr;
-		i = (ioaddr >> 12);
-		maxSlots = i + 1;
-	}
+	iobase = ioaddr;
+	i = (ioaddr >> 12);
+	maxSlots = i + 1;
 
 	for (i = 1; (i < maxSlots) && (dev != NULL); i++, iobase += EISA_SLOT_INC) {
 		if (EISA_signature(name, EISA_ID) == 0) {

