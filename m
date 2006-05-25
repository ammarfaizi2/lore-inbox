Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWEYAI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWEYAI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEYAI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:08:27 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:30067 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932080AbWEYAI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:08:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=tH04lv6YwcgfabxeZ0+JfcSNa2CgHhqOourTXXMQifzX7r8HUbNfp978tpBDESEh6Ymg+vkWJ9YnSo7ab1Ox8ypc3t4dx8Ti+HOvb0SHz+XvfX/iZrPDPpZhuDMYWjkozy/glSzu+zqJZig/LJuh6bE3kFods2T8rTBAztaB8kY=
Message-ID: <4474F6A6.1000006@gmail.com>
Date: Wed, 24 May 2006 20:13:26 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: samuel@sortiz.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irda: missing allocation result check in irlap_change_speed()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The skb allocation may fail, which can result in a NULL pointer
dereference in irlap_queue_xmit().

Coverity CID: 434.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/net/irda/irlap.c b/net/irda/irlap.c
index 7029618..a165286 100644
--- a/net/irda/irlap.c
+++ b/net/irda/irlap.c
@@ -884,7 +884,8 @@ static void irlap_change_speed(struct ir
 	if (now) {
 		/* Send down empty frame to trigger speed change */
 		skb = dev_alloc_skb(0);
-		irlap_queue_xmit(self, skb);
+		if (skb)
+			irlap_queue_xmit(self, skb);
 	}
 }
 


