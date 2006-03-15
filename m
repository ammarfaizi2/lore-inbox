Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751992AbWCOQkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWCOQkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWCOQkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:40:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27667 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752143AbWCOQkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:40:16 -0500
Date: Wed, 15 Mar 2006 17:40:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] ieee80211_wx.c: remove dead code
Message-ID: <20060315164015.GZ13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since sec->key_sizes[] is an u8, len can't be < 0.

Spotted by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-full/net/ieee80211/ieee80211_wx.c.old	2006-03-14 03:01:43.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/net/ieee80211/ieee80211_wx.c	2006-03-14 03:02:02.000000000 +0100
@@ -505,7 +505,7 @@ int ieee80211_wx_get_encode(struct ieee8
 	len = sec->key_sizes[key];
 	memcpy(keybuf, sec->keys[key], len);
 
-	erq->length = (len >= 0 ? len : 0);
+	erq->length = len;
 	erq->flags |= IW_ENCODE_ENABLED;
 
 	if (ieee->open_wep)

