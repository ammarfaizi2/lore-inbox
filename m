Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWCJTK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWCJTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWCJTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:10:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15634 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752026AbWCJTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:10:27 -0500
Date: Fri, 10 Mar 2006 20:10:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jkmaline@cc.hut.fi
Cc: hostap@shmoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] hostap_ap.c:hostap_add_sta(): inconsequent NULL checking
Message-ID: <20060310191026.GS21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this inconsequent NULL checking 
(unconditionally dereferencing directly after checking for NULL
isn't a good idea).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/net/wireless/hostap/hostap_ap.c.old	2006-03-10 19:30:08.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/net/wireless/hostap/hostap_ap.c	2006-03-10 19:30:43.000000000 +0100
@@ -3141,7 +3141,7 @@ int hostap_add_sta(struct ap_data *ap, u
 	if (ret == 1) {
 		sta = ap_add_sta(ap, sta_addr);
 		if (!sta)
-			ret = -1;
+			return -1;
 		sta->flags = WLAN_STA_AUTH | WLAN_STA_ASSOC;
 		sta->ap = 1;
 		memset(sta->supported_rates, 0, sizeof(sta->supported_rates));

