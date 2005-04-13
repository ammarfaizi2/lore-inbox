Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263108AbVDMCUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVDMCUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbVDMCUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:20:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33297 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262634AbVDMCRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:17:42 -0400
Date: Wed, 13 Apr 2005 04:17:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/cs46xx.c: fix a check after use
Message-ID: <20050413021739.GS3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/sound/oss/cs46xx.c.old	2005-03-23 04:48:53.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/sound/oss/cs46xx.c	2005-03-23 04:49:31.000000000 +0100
@@ -3086,13 +3086,14 @@
  
 static void amp_hercules(struct cs_card *card, int change)
 {
-	int old=card->amplifier;
+	int old;
 	if(!card)
 	{
 		CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO 
 			"cs46xx: amp_hercules() called before initialized.\n"));
 		return;
 	}
+	old = card->amplifier;
 	card->amplifier+=change;
 	if( (card->amplifier && !old) && !(hercules_egpio_disable))
 	{

