Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVCVWKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVCVWKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVCVWIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:08:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2317 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262111AbVCVWFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:05:44 -0500
Date: Tue, 22 Mar 2005 23:05:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/net/wireless/airo.c: correct a wrong
Message-ID: <20050322220540.GS1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if
Reply-To: 

The Coverity checker correctly noted that this condition can't ever be 
fulfilled.

Can someone understanding this code check whether my guess what this 
should have been was right?

Or should the if get completely dropped?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c.old	2005-03-22 21:41:37.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c	2005-03-22 21:42:01.000000000 +0100
@@ -3440,9 +3440,6 @@
 	/* Make sure we got something */
 	if (rxd.rdy && rxd.valid == 0) {
 		len = rxd.len + 12;
-		if (len < 12 && len > 2048)
-			goto badrx;
-
 		skb = dev_alloc_skb(len);
 		if (!skb) {
 			ai->stats.rx_dropped++;

