Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVCXBQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVCXBQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVCXBQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:16:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262301AbVCXBQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:16:04 -0500
Date: Thu, 24 Mar 2005 02:15:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/telephony/ixj: fix a use after free
Message-ID: <20050324011558.GK1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a use after free found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/telephony/ixj.c.old	2005-03-23 03:40:55.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/telephony/ixj.c	2005-03-23 03:41:21.000000000 +0100
@@ -5946,10 +5946,10 @@ static int ixj_build_filter_cadence(IXJ 
 	j->cadence_f[lcp->filter].off3 = lcp->off3;
 	j->cadence_f[lcp->filter].off3min = 0;
 	j->cadence_f[lcp->filter].off3max = 0;
-	kfree(lcp);
 	if(ixjdebug & 0x0002) {
 		printk(KERN_INFO "Cadence %d loaded\n", lcp->filter);
 	}
+	kfree(lcp);
 	return 0;
 }
 

